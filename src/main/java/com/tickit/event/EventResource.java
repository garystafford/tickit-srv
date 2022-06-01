package com.tickit.event;

import io.quarkus.hibernate.reactive.panache.common.runtime.ReactiveTransactional;
import io.smallrye.mutiny.Uni;
import org.jboss.resteasy.reactive.ResponseStatus;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("events")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class EventResource {

    @Inject
    EventRepository eventRepository;

    @GET
    public Uni<List<EventEntity>> list(
            @QueryParam("sort_by") String sortBy,
            @QueryParam("order_by") String orderBy,
            @QueryParam("page") int page,
            @QueryParam("size") int size
    ) {

        return eventRepository.listWithPaging(sortBy, orderBy, page, size);
    }

    @GET
    @Path("{id}")
    public Uni<EventEntity> get(Integer id) {

        return EventEntity.findById(id);
    }


    @POST
    @ResponseStatus(201)
    @ReactiveTransactional
    public Uni<EventEntity> create(EventEntity event) {

        return EventEntity.persist(event).replaceWith(event);
    }

    @PUT
    @Path("{id}")
    @ReactiveTransactional
    public Uni<EventEntity> update(Integer id, EventEntity event) {

        return EventEntity.<EventEntity>findById(id).onItem().ifNotNull().invoke(
                entity -> {
                    entity.name = event.name;
                    entity.startTime = event.startTime;
                    entity.category = event.category;
                    entity.venue = event.venue;
                }
        );
    }

    @DELETE
    @Path("{id}")
    @ReactiveTransactional
    public Uni<Void> delete(Integer id) {

        return EventEntity.deleteById(id).replaceWithVoid();
    }

    @GET
    @Path("/category/{id}")
    public Uni<List<EventEntity>> searchByCategoryId(
            @QueryParam("category") Integer id) {

        return EventEntity.list("catid", id);
    }

    @GET
    @Path("/venue/{id}")
    public Uni<List<EventEntity>> searchByVenueId(Integer id) {

        return EventEntity.list("venueid", id);
    }

    @GET
    @Path("/count")
    public Uni<Long> count() {

        return EventEntity.count();
    }

}