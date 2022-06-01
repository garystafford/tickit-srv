package com.tickit.venue;

import io.quarkus.hibernate.reactive.panache.common.runtime.ReactiveTransactional;
import io.smallrye.mutiny.Uni;
import org.jboss.resteasy.reactive.ResponseStatus;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("venues")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class VenueResource {

    @Inject
    VenueRepository venueRepository;

    @GET
    public Uni<List<VenueEntity>> list(
            @QueryParam("sort_by") String sortBy,
            @QueryParam("order_by") String orderBy,
            @QueryParam("page") int page,
            @QueryParam("size") int size
    ) {

        return venueRepository.listWithPaging(sortBy, orderBy, page, size);
    }

    @GET
    @Path("{id}")
    public Uni<VenueEntity> get(Integer id) {

        return VenueEntity.findById(id);
    }

    @POST
    @ResponseStatus(201)
    @ReactiveTransactional
    public Uni<VenueEntity> create(VenueEntity venue) {

        return VenueEntity.persist(venue).replaceWith(venue);
    }

    @PUT
    @Path("{id}")
    @ReactiveTransactional
    public Uni<VenueEntity> update(Integer id, VenueEntity venue) {

        return VenueEntity.<VenueEntity>findById(id).onItem().ifNotNull().invoke(
                entity -> {
                    entity.name = venue.name;
                    entity.city = venue.city;
                    entity.state = venue.state;
                    entity.seats = venue.seats;
                }
        );
    }

    @DELETE
    @Path("{id}")
    @ReactiveTransactional
    public Uni<Void> delete(Integer id) {

        return VenueEntity.deleteById(id).replaceWithVoid();
    }

    @GET
    @Path("/count")
    public Uni<Long> count() {

        return VenueEntity.count();
    }

}