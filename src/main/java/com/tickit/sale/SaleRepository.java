package com.tickit.sale;

import io.quarkus.hibernate.reactive.panache.PanacheRepositoryBase;
import io.quarkus.panache.common.Sort;
import io.smallrye.mutiny.Uni;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;
import java.util.Objects;

@ApplicationScoped
public class SaleRepository implements PanacheRepositoryBase<SaleEntity, Integer> {

    public Uni<List<SaleEntity>> listWithPaging(String sortBy, String orderBy, Integer page, Integer size) {

        if (page < 1) page = 1;
        if (size < 1) size = 5;
        page = page - 1; // zero-based
        if (sortBy == null) sortBy = "id";
        Sort.Direction direction = Sort.Direction.Ascending;
        if (Objects.equals(orderBy, "desc")) direction = Sort.Direction.Descending;

        return SaleEntity.findAll(Sort.by(sortBy).direction(direction)).page(page, size).list();
    }

    public Uni<List<SaleEntity>> getBySellerId(Integer id) {

        return SaleEntity.find("#SaleEntity.getBySellerId", id).list();
    }

    public Uni<List<SaleEntity>> getByEventId(Integer id) {

        return SaleEntity.find("#SaleEntity.getByEventId", id).list();
    }

}
