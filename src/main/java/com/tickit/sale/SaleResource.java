package com.tickit.sale;

import io.quarkus.hibernate.reactive.panache.common.runtime.ReactiveTransactional;
import io.smallrye.mutiny.Uni;
import org.jboss.resteasy.reactive.ResponseStatus;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("sales")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class SaleResource {

    @Inject
    SaleRepository saleRepository;

    @GET
    public Uni<List<SaleEntity>> list(
            @QueryParam("sort_by") String sortBy,
            @QueryParam("order_by") String orderBy,
            @QueryParam("page") int page,
            @QueryParam("size") int size
    ) {

        return saleRepository.listWithPaging(sortBy, orderBy, page, size);
    }

    @GET
    @Path("{id}")
    public Uni<SaleEntity> get(Integer id) {

        return SaleEntity.findById(id);
    }


    @POST
    @ResponseStatus(201)
    @ReactiveTransactional
    public Uni<SaleEntity> create(SaleEntity sale) {

        return SaleEntity.persist(sale).replaceWith(sale);
    }

    @PUT
    @Path("{id}")
    @ReactiveTransactional
    public Uni<SaleEntity> update(Integer id, SaleEntity sale) {

        return SaleEntity.<SaleEntity>findById(id).onItem().ifNotNull().invoke(
                entity -> {
                    entity.quantitySold = sale.quantitySold;
                    entity.pricePaid = sale.pricePaid;
                    entity.commission = sale.commission;
                    entity.saleTime = sale.saleTime;
                    entity.listing = sale.listing;
                    entity.buyer = sale.buyer;
                }
        );
    }

    @DELETE
    @Path("{id}")
    @ReactiveTransactional
    public Uni<Void> delete(Integer id) {

        return SaleEntity.deleteById(id).replaceWithVoid();
    }

    @GET
    @Path("/event/{id}")
    public Uni<List<SaleEntity>> getByEventId(Integer id) {

        return saleRepository.getByEventId(id);
    }

    @GET
    @Path("/listing/{id}")
    public Uni<List<SaleEntity>> getByListingId(Integer id) {

        return SaleEntity.list("listid", id);
    }

    @GET
    @Path("/buyer/{id}")
    public Uni<List<SaleEntity>> getByBuyerId(Integer id) {

        return SaleEntity.list("buyerid", id);
    }

    @GET
    @Path("/seller/{id}")
    public Uni<List<SaleEntity>> getBySellerId(Integer id) {

        return saleRepository.getBySellerId(id);
    }

    @GET
    @Path("/count")
    public Uni<Long> count() {

        return SaleEntity.count();
    }

}