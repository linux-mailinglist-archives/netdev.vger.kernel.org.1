Return-Path: <netdev+bounces-239243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 056FDC66335
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 22:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F50B35B654
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC80734C83A;
	Mon, 17 Nov 2025 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO3oIleE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8C934572B;
	Mon, 17 Nov 2025 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413649; cv=none; b=gfWxdbtfGmyn8O20vE03LtGFX2m8MT/TYNu7f9yJRl9QTLp1ofYlWGx/bPsqCB9EMeLJ6Vp6fhzDTo9NhrPmG6sGNV5B3ydsxwUICojtGoL8cWSLSDbe6C72opKA6ixfyvGFgnoFRmtILQ1sSyP5b7hAVWKUbU3YZ/tAQSWRdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413649; c=relaxed/simple;
	bh=IHLFkH6K9Kvf8w6LpSFiKStFMwSVlrlrGPFvM7EqgCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9JJPdBLu2rnEeLa5VZbRvCUfeVClUIX5kSKciBJMOMeMZ0xc99xdWgnaJ3YHP5drmrKbbVShL4A2U+pYZcWgTrbOKBunH/TiDu1ZAmepCDYvBk6faNzBPa7DEwDn1qKFz5DnaDrBDAF/pny1Bol1FjZzPZFpuH+lOM0dG0AEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO3oIleE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D62C2BCC6;
	Mon, 17 Nov 2025 21:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413647;
	bh=IHLFkH6K9Kvf8w6LpSFiKStFMwSVlrlrGPFvM7EqgCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pO3oIleETSJ0ZLNCiD2RfjnpQk7M2dWX4y4/U1XpofFhXPZwuSUe6IgGSsX6iKfya
	 Xl+YgOKlCR+LFKHmMr1tSx1PSQIV3HL583F6K8sCDiJ51wQW3ZndcLkeDLKa8QVi/Y
	 nIfduSOSEd9IVabHTMtXjtxBKExijEvcWM6fj4rNGulwK2Kt6u315RvP7RbOvcTBEU
	 IapbrUlyrk+IAO88+MI4zoCAcZTWBt/D620B7FFJlsUb75S75igyT1T3Wzh5mM4o/T
	 tYIzmZCulTI18WoR3Vhkr+Z59YuA5zUgakJNxlYC8LeXnoZXWXjs8yaaUpY+3LnaGp
	 pdUiJDYOwzGyA==
Date: Mon, 17 Nov 2025 21:07:19 +0000
From: Simon Horman <horms@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, pmohan@couthit.com, basharath@couthit.com,
	afd@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
	pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
	praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v5 1/3] net: ti: icssm-prueth: Adds helper
 functions to configure and maintain FDB
Message-ID: <aRuOh-O99Xwo1nG0@horms.kernel.org>
References: <20251113101229.675141-1-parvathi@couthit.com>
 <20251113101229.675141-2-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113101229.675141-2-parvathi@couthit.com>

On Thu, Nov 13, 2025 at 03:40:21PM +0530, Parvathi Pudi wrote:

...

> +static u16 icssm_prueth_sw_fdb_find_open_slot(struct fdb_tbl *fdb_tbl)
> +{
> +	u8 flags;
> +	u16 i;
> +
> +	for (i = 0; i < FDB_MAC_TBL_MAX_ENTRIES; i++) {
> +		flags = readb(&fdb_tbl->mac_tbl_a->mac_tbl_entry[i].flags);
> +		if (!(flags & FLAG_ACTIVE))
> +			break;

Hi Parvathi, all,

If the condition above is never met....

> +	}
> +
> +	return i;

Then FDB_MAC_TBL_MAX_ENTRIES will be returned here.
Which is written to bkt_info->bucket_idx by
icssm_prueth_sw_insert_fdb_entry()...

> +}
> +
> +static int
> +icssm_prueth_sw_find_fdb_insert(struct fdb_tbl *fdb, struct prueth *prueth,
> +				struct fdb_index_tbl_entry __iomem *bkt_info,
> +				const u8 *mac, const u8 port)
> +{
> +	struct fdb_mac_tbl_array __iomem *mac_tbl = fdb->mac_tbl_a;
> +	struct fdb_mac_tbl_entry __iomem *e;
> +	u8 mac_from_hw[ETH_ALEN];
> +	u16 bucket_entries;
> +	u16 mac_tbl_idx;
> +	int i, ret;
> +	s8 cmp;
> +
> +	mac_tbl_idx = readw(&bkt_info->bucket_idx);

That value will be read here...

> +	bucket_entries = readw(&bkt_info->bucket_entries);
> +
> +	for (i = 0; i < bucket_entries; i++, mac_tbl_idx++) {
> +		e = &mac_tbl->mac_tbl_entry[mac_tbl_idx];

And used here, without any bounds checking.

But if mac_tbl_idx is FDB_MAC_TBL_MAX_ENTRIES then
the access to mac_tble_entry will overflow, as
it only has FDB_MAC_TBL_MAX_ENTRIES elements.

This, and most of my review points for this patch set were
flagged by Claude Code with https://github.com/masoncl/review-prompts/

...

> +static int icssm_prueth_sw_insert_fdb_entry(struct prueth_emac *emac,
> +					    const u8 *mac, u8 is_static)
> +{
> +	struct fdb_index_tbl_entry __iomem *bucket_info;
> +	struct fdb_mac_tbl_entry __iomem *mac_info;
> +	struct prueth *prueth = emac->prueth;
> +	struct prueth_emac *other_emac;
> +	enum prueth_port other_port_id;
> +	u8 hash_val, mac_tbl_idx;
> +	struct fdb_tbl *fdb;
> +	u8 flags;
> +	u16 val;
> +	s16 ret;
> +	int err;
> +
> +	fdb = prueth->fdb_tbl;
> +	other_port_id = (emac->port_id == PRUETH_PORT_MII0) ?
> +			 PRUETH_PORT_MII1 : PRUETH_PORT_MII0;
> +
> +	other_emac = prueth->emac[other_port_id - 1];
> +
> +	if (fdb->total_entries == FDB_MAC_TBL_MAX_ENTRIES)
> +		return -ENOMEM;

Access to total_entries outside of icssm_prueth_sw_fdb_spin_lock.
Seems racy here. Likewise for the similar check in
icssm_prueth_sw_delete_fdb_entry().

Flagged by Claude Code with https://github.com/masoncl/review-prompts/

> +
> +	if (ether_addr_equal(mac, emac->mac_addr) ||
> +	    ether_addr_equal(mac, other_emac->mac_addr)) {
> +		/* Don't insert fdb of own mac addr */
> +		return -EINVAL;
> +	}
> +
> +	/* Get the bucket that the mac belongs to */
> +	hash_val = icssm_prueth_sw_fdb_hash(mac);
> +	bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
> +
> +	if (!readw(&bucket_info->bucket_entries)) {
> +		mac_tbl_idx = icssm_prueth_sw_fdb_find_open_slot(fdb);
> +		writew(mac_tbl_idx, &bucket_info->bucket_idx);
> +	}
> +
> +	ret = icssm_prueth_sw_find_fdb_insert(fdb, prueth, bucket_info, mac,
> +					      emac->port_id - 1);
> +	if (ret < 0)
> +		/* mac is already in fdb table */
> +		return 0;
> +
> +	mac_tbl_idx = ret;
> +
> +	err = icssm_prueth_sw_fdb_spin_lock(fdb);
> +	if (err) {
> +		dev_err(prueth->dev, "PRU lock timeout %d\n", ret);
> +		return err;
> +	}
> +
> +	mac_info = icssm_prueth_sw_find_free_mac(prueth, bucket_info,
> +						 mac_tbl_idx, NULL,
> +						 mac);
> +	if (!mac_info) {
> +		/* Should not happen */
> +		dev_warn(prueth->dev, "OUT of FDB MEM\n");

This appears to leak icssm_prueth_sw_fdb_spin_lock.

Also flagged by Claude Code with https://github.com/masoncl/review-prompts/

> +		return -ENOMEM;
> +	}
> +
> +	memcpy_toio(mac_info->mac, mac, ETH_ALEN);
> +	writew(0, &mac_info->age);
> +	writeb(emac->port_id - 1, &mac_info->port);
> +
> +	flags = readb(&mac_info->flags);
> +	if (is_static)
> +		flags |= FLAG_IS_STATIC;
> +	else
> +		flags &= ~FLAG_IS_STATIC;
> +
> +	/* bit 1 - active */
> +	flags |= FLAG_ACTIVE;
> +	writeb(flags, &mac_info->flags);
> +
> +	val = readw(&bucket_info->bucket_entries);
> +	val++;
> +	writew(val, &bucket_info->bucket_entries);
> +
> +	fdb->total_entries++;
> +
> +	icssm_prueth_sw_fdb_spin_unlock(fdb);
> +
> +	dev_dbg(prueth->dev, "added fdb: %pM port=%d total_entries=%u\n",
> +		mac, emac->port_id, fdb->total_entries);

Less important, but I think the value of total_entries could
be out of date as it's accessed outside of the lock.
Perhaps it would be good to stash the value into a local variable while
the lock is still held?

Likewise in icssm_prueth_sw_delete_fdb_entry().

> +
> +	return 0;
> +}
> +
> +static int icssm_prueth_sw_delete_fdb_entry(struct prueth_emac *emac,
> +					    const u8 *mac, u8 is_static)
> +{
> +	struct fdb_index_tbl_entry __iomem *bucket_info;
> +	struct fdb_mac_tbl_entry __iomem *mac_info;
> +	struct fdb_mac_tbl_array __iomem *mt;
> +	u8 hash_val, mac_tbl_idx;
> +	u16 idx, entries, val;
> +	struct prueth *prueth;
> +	s16 ret, left, right;
> +	struct fdb_tbl *fdb;
> +	u8 flags;
> +	int err;
> +
> +	prueth = emac->prueth;
> +	fdb = prueth->fdb_tbl;
> +	mt = fdb->mac_tbl_a;
> +
> +	if (fdb->total_entries == 0)
> +		return 0;
> +
> +	/* Get the bucket that the mac belongs to */
> +	hash_val = icssm_prueth_sw_fdb_hash(mac);
> +	bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
> +
> +	ret = icssm_prueth_sw_fdb_search(mt, bucket_info, mac);
> +	if (ret < 0)
> +		return ret;
> +
> +	mac_tbl_idx = ret;
> +	mac_info = FDB_MAC_TBL_ENTRY(mac_tbl_idx);
> +
> +	err = icssm_prueth_sw_fdb_spin_lock(fdb);
> +	if (err) {
> +		dev_err(prueth->dev, "PRU lock timeout %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Shift all elements in bucket to the left. No need to
> +	 * update index table since only shifting within bucket.
> +	 */
> +	left = mac_tbl_idx;
> +	idx = readw(&bucket_info->bucket_idx);
> +	entries = readw(&bucket_info->bucket_entries);
> +	right = idx + entries - 1;
> +	icssm_prueth_sw_fdb_move_range_left(prueth, left, right);
> +
> +	/* Remove end of bucket from table */
> +	mac_info = FDB_MAC_TBL_ENTRY(right);
> +	flags = readb(&mac_info->flags);
> +	/* active = 0 */
> +	flags &= ~FLAG_ACTIVE;
> +	writeb(flags, &mac_info->flags);
> +	val = readw(&bucket_info->bucket_entries);
> +	val--;
> +	writew(val, &bucket_info->bucket_entries);
> +	fdb->total_entries--;
> +
> +	icssm_prueth_sw_fdb_spin_unlock(fdb);
> +
> +	dev_dbg(prueth->dev, "del fdb: %pM total_entries=%u\n",
> +		mac, fdb->total_entries);
> +
> +	return 0;
> +}

...

