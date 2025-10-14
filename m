Return-Path: <netdev+bounces-229382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC12BDB824
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 23:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BF43AF6FE
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 21:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E602E54B0;
	Tue, 14 Oct 2025 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T7hq7VxW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A812E8E11;
	Tue, 14 Oct 2025 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479098; cv=none; b=mn2Fml8p/Da87JCwVkC8Dm7LLh9U9nurfpdUaIwQOd4Zs+H2LwA9ILQjfsbEkSkFCE3Ivm0SJgmN8gwKnc1x9JVjwBdXXQolCMx+S7F3tq2CJOPnD8v82GT44QLnDz0yPjQuHLFmRwkwQLdbasmcGA5IMvYYfulmjl+3poZbXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479098; c=relaxed/simple;
	bh=MU32Uf17vhJNmgQ+q3c45nMjWHFPK0nmpNTytsj5ufY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K33ZVAnBRbFF347UJzqbudfJSgOoOhVmCwQiwiQo0Mh48Eb5MaPDimfzZzcnYMOGcHTVk4a+3GZAASt3/1v0AqSVqVAzhR2dYWcKYX0KsumnHs0SH5514Ml3AHNuGZdredWg5oX03VFBcBb4RqbLetpM/q+Q5Rh3iU4erWCQMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T7hq7VxW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XxnfDRKN9o/tjcf4e+ZHTtKwkTd93J07pUeKthYb3wQ=; b=T7hq7VxWOOfvkWkFQtmY0Wi8lC
	7cGsW2sWrEp7Besg9hJxrhHAmHGlNPU7c8OdSAPZ7WIOBSfsT6ywKvyJWn2JEpBCnOj+J+8OFIUhT
	T7RQnD/y1wjhUC7/IPOXi7IFJGczARkhsurkAGgFagHvjaRakqbZWLil8b9GKZbkSYH8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8n1w-00AxMX-4b; Tue, 14 Oct 2025 23:58:04 +0200
Date: Tue, 14 Oct 2025 23:58:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, pmohan@couthit.com, basharath@couthit.com,
	afd@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, pratheesh@ti.com,
	prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
	rogerq@ti.com, krishna@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v3 1/3] net: ti: icssm-prueth: Adds helper
 functions to configure and maintain FDB
Message-ID: <ff651c3d-108b-48f8-b69b-fb0b522edd4e@lunn.ch>
References: <20251014124018.1596900-1-parvathi@couthit.com>
 <20251014124018.1596900-2-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014124018.1596900-2-parvathi@couthit.com>

> +void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth)
> +{
> +	struct fdb_tbl *t = prueth->fdb_tbl;
> +
> +	t->index_a = (struct fdb_index_array_t *)((__force const void *)
> +			prueth->mem[V2_1_FDB_TBL_LOC].va +
> +			V2_1_FDB_TBL_OFFSET);

We have

> +#define V2_1_FDB_TBL_LOC          PRUETH_MEM_SHARED_RAM

and existing code like:

void __iomem *sram_base = prueth->mem[PRUETH_MEM_SHARED_RAM].va;

so it seems like

t->index_a = sram_base + V2_1_FDB_TBL_OFFSET;

with no needs for any casts, since sram_base is a void * so can be
assigned to any pointer type.

And there are lots of cascading defines like:

/* 4 queue descriptors for port 0 (host receive). 32 bytes */
#define HOST_QUEUE_DESC_OFFSET          (HOST_QUEUE_SIZE_ADDR + 16)

/* table offset for queue size:
 * 3 ports * 4 Queues * 1 byte offset = 12 bytes
 */
#define HOST_QUEUE_SIZE_ADDR            (HOST_QUEUE_OFFSET_ADDR + 8)
/* table offset for queue:
 * 4 Queues * 2 byte offset = 8 bytes
 */
#define HOST_QUEUE_OFFSET_ADDR          (HOST_QUEUE_DESCRIPTOR_OFFSET_ADDR + 8)
/* table offset for Host queue descriptors:
 * 1 ports * 4 Queues * 2 byte offset = 8 bytes
 */
#define HOST_QUEUE_DESCRIPTOR_OFFSET_ADDR       (HOST_Q4_RX_CONTEXT_OFFSET + 8)

allowing code like:

	sram = sram_base + HOST_QUEUE_SIZE_ADDR;
	sram = sram_base + HOST_Q1_RX_CONTEXT_OFFSET;
	sram = sram_base + HOST_QUEUE_OFFSET_ADDR;
	sram = sram_base + HOST_QUEUE_DESCRIPTOR_OFFSET_ADDR;
	sram = sram_base + HOST_QUEUE_DESC_OFFSET;

> +	t->mac_tbl_a = (struct fdb_mac_tbl_array_t *)((__force const void *)
> +			t->index_a + FDB_INDEX_TBL_MAX_ENTRIES *
> +			sizeof(struct fdb_index_tbl_entry_t));

So i think this could follow the same pattern, also allowing some of
these casts to be removed.

I just don't like casts, they suggest bad design.

> +static u8 icssm_pru_lock_done(struct fdb_tbl *fdb_tbl)
> +{
> +	return readb((u8 __iomem *)&fdb_tbl->locks->pru_locks);

And maybe the __iomem attribute can be added to struct, either per
member, or at the top level? It is all iomem, so we want sparse to be
able to check all accesses.

> +static int icssm_prueth_sw_fdb_spin_lock(struct fdb_tbl *fdb_tbl)
> +{
> +	u8 done;
> +	int ret;
> +
> +	/* Take the host lock */
> +	writeb(1, (u8 __iomem *)&fdb_tbl->locks->host_lock);
> +
> +	/* Wait for the PRUs to release their locks */
> +	ret = read_poll_timeout(icssm_pru_lock_done, done, done == 0,
> +				1, 10, false, fdb_tbl);
> +	if (ret)
> +		return -ETIMEDOUT;
> +
> +	return 0;

Documentation says:

 * Returns: 0 on success and -ETIMEDOUT upon a timeout.

So no need for the if statement.


> +static s16
> +icssm_prueth_sw_fdb_search(struct fdb_mac_tbl_array_t *mac_tbl,
> +			   struct fdb_index_tbl_entry_t *bucket_info,
> +			   const u8 *mac)
> +{
> +	u8 mac_tbl_idx = bucket_info->bucket_idx;
> +	int i;
> +
> +	for (i = 0; i < bucket_info->bucket_entries; i++, mac_tbl_idx++) {
> +		if (ether_addr_equal(mac,
> +				     mac_tbl->mac_tbl_entry[mac_tbl_idx].mac))
> +			return mac_tbl_idx;
> +	}
> +
> +	return -ENODATA;

It is traditional to return errno in an int. But i don't see why a s16
cannot be used.

> +icssm_prueth_sw_fdb_find_bucket_insert_point(struct fdb_tbl *fdb,
> +					     struct fdb_index_tbl_entry_t
> +					     *bkt_info,
> +					     const u8 *mac, const u8 port)
> +{
> +	struct fdb_mac_tbl_array_t *mac_tbl = fdb->mac_tbl_a;
> +	struct fdb_mac_tbl_entry_t *e;
> +	u8 mac_tbl_idx;
> +	int i, ret;
> +	s8 cmp;
> +
> +	mac_tbl_idx = bkt_info->bucket_idx;
> +
> +	for (i = 0; i < bkt_info->bucket_entries; i++, mac_tbl_idx++) {
> +		e = &mac_tbl->mac_tbl_entry[mac_tbl_idx];
> +		cmp = memcmp(mac, e->mac, ETH_ALEN);
> +		if (cmp < 0) {
> +			return mac_tbl_idx;
> +		} else if (cmp == 0) {
> +			if (e->port != port) {
> +				/* MAC is already in FDB, only port is
> +				 * different. So just update the port.
> +				 * Note: total_entries and bucket_entries
> +				 * remain the same.
> +				 */
> +				ret = icssm_prueth_sw_fdb_spin_lock(fdb);
> +				if (ret) {
> +					pr_err("PRU lock timeout\n");
> +					return -ETIMEDOUT;
> +				}

icssm_prueth_sw_fdb_spin_lock() returns an errno. Don't replace it.

Also, pr_err() is bad practice and probably checkpatch is telling you
this. Ideally you want to indicate which device has an error, so you
should be using dev_err(), or maybe netdev_err().

> +	if (left > 0) {
> +		hash_prev =
> +			icssm_prueth_sw_fdb_hash
> +			(FDB_MAC_TBL_ENTRY(left - 1)->mac);
> +	}

> +		empty_slot_idx =
> +			icssm_prueth_sw_fdb_check_empty_slot_right(mt, mti);

There are a couple of odd indentations like this. I wounder if it
makes sense to shorten the prefix? Do you really need all of
icssm_prueth_sw_fdb_ ?

	Andrew

