Return-Path: <netdev+bounces-229361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FC7BDB189
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 21:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 726CD4E4430
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049BA2C375A;
	Tue, 14 Oct 2025 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UkjdMtAW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1EA2BE652;
	Tue, 14 Oct 2025 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470912; cv=none; b=A7QutjyJc3QMl1tFNbeahqiVI7bf3ew6eyB3ufvxOkvQNFDI2L0Lh1MG8SURIrNzeSkiXz1gQmDSFd5GDUd8ipxqhui/omLrRTpi+Qf/xNa5+cmMkKnpvhx4KOFapCq9qtbrOGc4lz+BWhveRL2X7dE2jy1H6nJQuss66BlOosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470912; c=relaxed/simple;
	bh=48s6HazsimmkxKz5dIDeugIQdXCtQs46JltMGufuiLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFs6Isj9UumWFbPjNbEpr+pyTMRNxTzDNsmdgwizkDupKv1rr1UGGXAP3Dx4uEAYtWmbN2qxrC1Mm8t2WBLXy6EoffJ0/FOWfz5tVQnmRYePS9ie8S7Zsjzog9nOEGaGCaUNT/JgZ9vh3n/HK16T3HnME1kOh9emaA84Mr2F8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UkjdMtAW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+J7CGWA+Rn0M9X0tPytaTQdkqtaZ1USzIfewvswO9Ac=; b=UkjdMtAWrq/Pyzg9TTmoVY6vWA
	xlVAnfh9JG6yIcEQku5IfrtOtRxgChhBlekd4mzHa6W3ACZNP7ufmRIy+3a03RwaZSF6MOdne/NlZ
	iBooVZq8+eJ8FwOG8AgM/23ynMjhrVw8DWOpZ7F8HLekXOs2ZEPpPqqoFQqb3/5SUzZY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8kty-00Awtc-2U; Tue, 14 Oct 2025 21:41:42 +0200
Date: Tue, 14 Oct 2025 21:41:42 +0200
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
Message-ID: <1e16ab86-ccc1-433a-a482-76d9ba567fb9@lunn.ch>
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

> +/* 4 bytes */
> +struct fdb_index_tbl_entry_t {
> +	/* Bucket Table index of first Bucket with this MAC address */
> +	u16 bucket_idx;
> +	u16 bucket_entries; /* Number of entries in this bucket */
> +};

Please drop the _t. That is normally used to indicate a type, but this
is actually a struct

> +void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth)
> +{
> +	struct fdb_tbl *t = prueth->fdb_tbl;
> +
> +	t->index_a = (struct fdb_index_array_t *)((__force const void *)
> +			prueth->mem[V2_1_FDB_TBL_LOC].va +
> +			V2_1_FDB_TBL_OFFSET);

You cast it to a const void * and then a non-const fdb_index_array_t *?


