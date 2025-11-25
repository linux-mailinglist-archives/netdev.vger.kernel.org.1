Return-Path: <netdev+bounces-241389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D6023C834C7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E46F34C5CA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC21FC110;
	Tue, 25 Nov 2025 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTSDPlS0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC881D6193;
	Tue, 25 Nov 2025 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764043405; cv=none; b=DRFu8hMsrLGY2AIGnLfrfeBSww3bMQiEcW3mktfqmnUzHTs6U390CTdJi0lfE4iHWcOFfPH6eGKYIByaf695hqGgwyGz6vCEDOkbYIBKZbZsH4AMoAv2rUdczxpgk7my3s5Vm+1hmA98rHDNx8jL52t620Te/JFxeR7agHQuBMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764043405; c=relaxed/simple;
	bh=XLBIfGui6Ncp8WpCQDz4sno0DUbqdodDsliQ475QYTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMsxp41k7VnK8Wp6pYCDzjzO27BrK+i0MRWxACxjxsrAs7XRPZECzsxroMq9WQrMPeppyIlEd8dNC5Ye1rIT16bd5bVOgcSx/5ZffHX5VmGNIe1ZE5F0Trqf8Mfo1imKBUH5WVYTAe1E+ALYclN8BVRNTvaNHf5Ebl0ap51IYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTSDPlS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B505EC116B1;
	Tue, 25 Nov 2025 04:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764043404;
	bh=XLBIfGui6Ncp8WpCQDz4sno0DUbqdodDsliQ475QYTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mTSDPlS0RW6oJGk4Qc0IkYPJzT3rXZ3axSV/X20y7OT7GKAyCg/AbCdQPSC/IdT55
	 HLJNlzncvEaegEXORF1v/86tNZ0WQlIV7MF2RlejCbWOhQJB6YYQfTiV3UIdpGtuKC
	 jAw88fXeTYRn55jjmMOcq7ixy6ncYm+WXUnneI7jJkmarcwM1TQHQuARgm7W68FtuZ
	 yAtb9XCkNsIoZgIKjrzZlSwza0PkYl/T0nQAL88JVVAHm34nGgtg7Wbqee2XBQ9qZ6
	 z1MdaxF4b+aw0yb5QDEfoYNOaY2o+K1CKqqFPyIKxyksCCM9fiZOizH2JMVIGg3kdn
	 bFVKjoN3yY11w==
Date: Mon, 24 Nov 2025 20:03:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 pmohan@couthit.com, basharath@couthit.com, afd@ti.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
 horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
 mohan@couthit.com
Subject: Re: [PATCH net-next v6 2/3] net: ti: icssm-prueth: Adds switchdev
 support for icssm_prueth driver
Message-ID: <20251124200322.615773bb@kernel.org>
In-Reply-To: <20251124135800.2219431-3-parvathi@couthit.com>
References: <20251124135800.2219431-1-parvathi@couthit.com>
	<20251124135800.2219431-3-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 19:25:11 +0530 Parvathi Pudi wrote:
> Subject: [PATCH net-next v6 2/3] net: ti: icssm-prueth: Adds switchdev support for icssm_prueth driver

Adds -> Add

> This patch adds support for offloading the RSTP switch feature to the

s/This patch adds/Add/

imperative mood, please..

> +static void icssm_prueth_sw_fdb_work(struct work_struct *work)
> +{
> +	struct icssm_prueth_sw_fdb_work *fdb_work =
> +		container_of(work, struct icssm_prueth_sw_fdb_work, work);
> +	struct prueth_emac *emac = fdb_work->emac;
> +
> +	rtnl_lock();
> +
> +	/* Interface is not up */
> +	if (!emac->prueth->fdb_tbl)
> +		goto free;
> +
> +	switch (fdb_work->event) {
> +	case FDB_LEARN:
> +		icssm_prueth_sw_insert_fdb_entry(emac, fdb_work->addr, 0);
> +		break;
> +	case FDB_PURGE:
> +		icssm_prueth_sw_do_purge_fdb(emac);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +free:
> +	rtnl_unlock();
> +	kfree(fdb_work);
> +	dev_put(emac->ndev);

please use netdev_put() and a netdev tracker

> +}
> +
> +int icssm_prueth_sw_learn_fdb(struct prueth_emac *emac, u8 *src_mac)
> +{
> +	struct icssm_prueth_sw_fdb_work *fdb_work;
> +
> +	fdb_work = kzalloc(sizeof(*fdb_work), GFP_ATOMIC);
> +	if (WARN_ON(!fdb_work))
> +		return -ENOMEM;
> +
> +	INIT_WORK(&fdb_work->work, icssm_prueth_sw_fdb_work);
> +
> +	fdb_work->event = FDB_LEARN;
> +	fdb_work->emac  = emac;
> +	ether_addr_copy(fdb_work->addr, src_mac);
> +
> +	dev_hold(emac->ndev);

same here.

This significantly helps debugging in case some code leaks a reference.
-- 
pw-bot: cr

