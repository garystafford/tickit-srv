package com.tickit.seller;

import io.quarkus.hibernate.reactive.panache.common.runtime.ReactiveTransactional;
import io.smallrye.mutiny.Uni;
import org.jboss.resteasy.reactive.ResponseStatus;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("sellers")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class SellerResource {

    @Inject
    SellerRepository sellerRepository;

    @GET
    public Uni<List<SellerEntity>> list(
            @QueryParam("sort_by") String sortBy,
            @QueryParam("order_by") String orderBy,
            @QueryParam("page") int page,
            @QueryParam("size") int size
    ) {

        return sellerRepository.listWithPaging(sortBy, orderBy, page, size);
    }

    @GET
    @Path("{id}")
    public Uni<SellerEntity> get(Integer id) {

        return SellerEntity.findById(id);
    }


    @POST
    @ResponseStatus(201)
    @ReactiveTransactional
    public Uni<SellerEntity> create(SellerEntity seller) {

        return SellerEntity.persist(seller).replaceWith(seller);
    }

    @PUT
    @Path("{id}")
    @ReactiveTransactional
    public Uni<SellerEntity> update(Integer id, SellerEntity seller) {

        return SellerEntity.<SellerEntity>findById(id).onItem().ifNotNull().invoke(
                entity -> {
                    entity.username = seller.username;
                    entity.firstName = seller.firstName;
                    entity.lastName = seller.lastName;
                    entity.city = seller.city;
                    entity.state = seller.state;
                    entity.email = seller.email;
                    entity.phone = seller.phone;
                    entity.taxIdNumber = seller.taxIdNumber;
                }
        );
    }

    @DELETE
    @Path("{id}")
    @ReactiveTransactional
    public Uni<Void> delete(Integer id) {

        return SellerEntity.deleteById(id).replaceWithVoid();
    }

    @GET
    @Path("/username/{username}")
    public Uni<List<SellerEntity>> getByUsername(String username) {

        return SellerEntity.list("username", username);
    }

    @GET
    @Path("/count")
    public Uni<Long> count() {

        return SellerEntity.count();
    }

}