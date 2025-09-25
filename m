Return-Path: <netdev+bounces-226424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6C5BA0090
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26DB189D5C6
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9DA2DCC08;
	Thu, 25 Sep 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nxJd77l5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A12DBF5E;
	Thu, 25 Sep 2025 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810831; cv=none; b=t6/k9pH2Y4vVhyV2gfU+JHeiPGxsPNIFYm+9faMjw1x+JKu7/MfT+DvOyfoYiffonPpCPKTBP+zV5bCalTTW1HNBYMHMtQ+qGq+y6rgrtpVOb7sX5yY1whH772sV08Hu0zlqwDqgO3ID7skqWSI/puRhjm5qsIzEInGFYAaBUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810831; c=relaxed/simple;
	bh=/DR/u5etjpFCcgysgk01aZ/Bib5XibYpmOsNM+o0xLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb+FJrJotArRPcXrRWt5H89IouM7QOZ7bY/LciC7MQvzzC6+5wJdrngU1C/cI/OqDtlsS0wtoQLCK+yNT3iSSQs8c2ARntzAaR2jGr0+Y6Ub8+iflO57OAFgckIo1g1KVKLAszffkrJulO/8ZaBDOoUpP1qYfhF76XPfvjCygV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nxJd77l5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HTdc+5XjoLirKBt3ethpIIBo+vHjglYjK+kcoXPxeLY=; b=nxJd77l5fQBCkfr0N5hryU63O3
	jA9+TLurVpNTJ3v6Da6K8YjXd50UXpqhomuJFg4dyxqoQIZoGhXkzTPHW/d1sGNg//cwuzaF2QTVC
	PkIuoYl3MNITuzoFUYCM7W/+9r9b573D4odm4+02hwxx76f0GCghN6gqM66WQx9T7K3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v1n2S-009Tak-9J; Thu, 25 Sep 2025 16:33:40 +0200
Date: Thu, 25 Sep 2025 16:33:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, pmohan@couthit.com, basharath@couthit.com,
	afd@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, pratheesh@ti.com,
	prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
	rogerq@ti.com, krishna@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next 1/3] net: ti: icssm-prueth: Adds helper
 functions to configure and maintain FDB
Message-ID: <02f2c50f-31f6-4d4a-9cbe-5f77d1d60706@lunn.ch>
References: <20250925141246.3433603-1-parvathi@couthit.com>
 <20250925141246.3433603-2-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925141246.3433603-2-parvathi@couthit.com>

> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019-2021 Texas Instruments Incorporated - https://www.ti.com */
> +#ifndef __NET_TI_PRUSS_FDB_TBL_H
> +#define __NET_TI_PRUSS_FDB_TBL_H
> +
> +#include <linux/kernel.h>
> +#include <linux/debugfs.h>
> +#include "icssm_prueth.h"
> +
> +#define ETHER_ADDR_LEN 6

Please use ETH_ALEN everywhere.

> +static void icssm_prueth_sw_fdb_spin_lock(struct fdb_tbl *fdb_tbl)
> +{
> +	/* Take the host lock */
> +	writeb(1, (u8 __iomem *)&fdb_tbl->locks->host_lock);
> +
> +	/* Wait for the PRUs to release their locks */
> +	while (readb((u8 __iomem *)&fdb_tbl->locks->pru_locks))
> +		;

Don't use endless loops. What happens if the firmware crashed. Please
use something from iopoll.h and handle -ETIMEDOUT.

> +static void icssm_mac_copy(u8 *dst, const u8 *src)
> +{
> +	u8 i;
> +
> +	for (i = 0; i < ETHER_ADDR_LEN; i++) {
> +		*(dst) = *(src);
> +		dst++;
> +		src++;
> +	}
> +}

There is a kernel helper for this.

> +
> +static s8 icssm_mac_cmp(const u8 *mac_a, const u8 *mac_b)
> +{
> +	s8  ret = 0, i;
> +
> +	for (i = 0; i < ETHER_ADDR_LEN; i++) {
> +		if (mac_a[i] == mac_b[i])
> +			continue;
> +
> +		ret = mac_a[i] < mac_b[i] ? -1 : 1;
> +		break;
> +	}
> +
> +	return ret;
> +}

I suspect there is also a helper for this. Please don't reinvent what
the kernel already has.

> +static s16
> +icssm_prueth_sw_fdb_find_bucket_insert_point(struct fdb_tbl *fdb,
> +					     struct fdb_index_tbl_entry_t
> +					     *bkt_info,
> +					     const u8 *mac, const u8 port)
> +{
> +	struct fdb_mac_tbl_array_t *mac_tbl = fdb->mac_tbl_a;
> +	struct fdb_mac_tbl_entry_t *e;
> +	u8 mac_tbl_idx;
> +	s8 cmp;
> +	int i;
> +
> +	mac_tbl_idx = bkt_info->bucket_idx;
> +
> +	for (i = 0; i < bkt_info->bucket_entries; i++, mac_tbl_idx++) {
> +		e = &mac_tbl->mac_tbl_entry[mac_tbl_idx];
> +		cmp = icssm_mac_cmp(mac, e->mac);
> +		if (cmp < 0) {
> +			return mac_tbl_idx;
> +		} else if (cmp == 0) {
> +			if (e->port != port) {
> +				/* MAC is already in FDB, only port is
> +				 * different. So just update the port.
> +				 * Note: total_entries and bucket_entries
> +				 * remain the same.
> +				 */
> +				icssm_prueth_sw_fdb_spin_lock(fdb);
> +				e->port = port;
> +				icssm_prueth_sw_fdb_spin_unlock(fdb);
> +			}
> +
> +			/* MAC and port are the same, touch the fdb */
> +			e->age = 0;
> +			return -1;

Returning values like this can result in bugs. It is better to use a
real error code, just in case this ever makes it way back to
userspace.

	Andrew

