package com.tickit.listing;

import io.quarkus.hibernate.reactive.panache.common.runtime.ReactiveTransactional;
import io.smallrye.mutiny.Uni;
import org.jboss.resteasy.reactive.ResponseStatus;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("listings")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ListingResource {

    @Inject
    ListingRepository listingRepository;

    @GET
    public Uni<List<ListingEntity>> list(
            @QueryParam("sort_by") String sortBy,
            @QueryParam("order_by") String orderBy,
            @QueryParam("page") int page,
            @QueryParam("size") int size
    ) {

        return listingRepository.listWithPaging(sortBy, orderBy, page, size);
    }

    @GET
    @Path("{id}")
    public Uni<ListingEntity> get(Integer id) {

        return ListingEntity.findById(id);
    }


    @POST
    @ResponseStatus(201)
    @ReactiveTransactional
    public Uni<ListingEntity> create(ListingEntity listing) {

        return ListingEntity.persist(listing).replaceWith(listing);
    }

    @PUT
    @Path("{id}")
    @ReactiveTransactional
    public Uni<ListingEntity> update(Integer id, ListingEntity listing) {

        return ListingEntity.<ListingEntity>findById(id).onItem().ifNotNull().invoke(
                entity -> {
                    entity.numTickets = listing.numTickets;
                    entity.pricePerTicket = listing.pricePerTicket;
                    entity.totalPrice = listing.totalPrice;
                    entity.listTime = listing.listTime;
                    entity.event = listing.event;
                    entity.seller = listing.seller;
                }
        );
    }

    @DELETE
    @Path("{id}")
    @ReactiveTransactional
    public Uni<Void> delete(Integer id) {

        return ListingEntity.deleteById(id).replaceWithVoid();
    }

    @GET
    @Path("/event/{id}")
    public Uni<List<ListingEntity>> getByEventId(Integer id) {

        return ListingEntity.list("eventid", id);
    }

    @GET
    @Path("/seller/{id}")
    public Uni<List<ListingEntity>> getBySellerId(Integer id) {

        return ListingEntity.list("sellerid", id);
    }

    @GET
    @Path("/category/{id}")
    public Uni<List<ListingEntity>> getByCategoryId(Integer id) {

        return listingRepository.getByCategoryId(id);
    }

    @GET
    @Path("/venue/{id}")
    public Uni<List<ListingEntity>> getByVenueId(Integer id) {

        return listingRepository.getByVenueId(id);
    }

    @GET
    @Path("/count")
    public Uni<Long> count() {

        return ListingEntity.count();
    }

}