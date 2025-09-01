Return-Path: <netdev+bounces-218932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B41B3F076
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E157AA687
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6942797A9;
	Mon,  1 Sep 2025 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkriPSBD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDDFB67F;
	Mon,  1 Sep 2025 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756762069; cv=none; b=ItlzXn4YUS9EYHplq7q6U4pNrRMiMG1XKkUQQtlb7zaKs/sDV/aCoM4xC7Ub1CYEwELE6u2vlUgcUKaM9RSSj2uC6E8yDpN4zVpwohbuEJdx0h6cKOGvc52iRIZdjBYaDubhcWzsBgvNJXAsbbomOthThgRlpNWeMHcoCVb6rVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756762069; c=relaxed/simple;
	bh=rjepzkjxlPEQO8AJJenxxd9xqBBdjEOhVPFBaP1Xmo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhtONE/duHsHYw4OkYHp1cP1bQLklWb2x/iFCpmNXANPWj/NTSbHprZB8MWYj5B/Bz9nmTCSBAHM4PHa//LXr4jfYaEsYSjs+1eFzfpYlNoUec7ZTT1pZq331VlGlqG3St1HhVCU0KdbMlXdEt5dqWvvm12OfqRlgoAyO9mV7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkriPSBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C129C4CEF0;
	Mon,  1 Sep 2025 21:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756762068;
	bh=rjepzkjxlPEQO8AJJenxxd9xqBBdjEOhVPFBaP1Xmo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PkriPSBDnNd+FnGFNk+WYvT5SvyvH5i9auminlCxEUpEbdIKNJXoENKdXSI2vJ9Pz
	 KcXNp/UcfMD1QXRuvqeDmC/oADmmFPGBOaHBGskhDf/PZ/6EUa4EdYrx1b2O2pa9w/
	 Mn/mXboZ20KeqcHl6fUq9g/lw9cCrjQhDFQJREzqBKiBbSaryoO0uiIN+Xkdgf2Mt3
	 wlTg54zOzbeE1CtPc1DJ/q9P4fD6e73OGVfSeak1o7B1fMZXw8SPO8d4qqB5OIjnTx
	 7VSvlNpG5X6li9dzIrT3Yo2EgXra/+royI0ASu0VFEPmqE/RbqPCbRMnSbH4ru8aud
	 XoaTWp/FSVSCA==
Date: Mon, 1 Sep 2025 14:27:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, Vikas Gupta
 <vikas.gupta@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [v5, net-next 2/9] bng_en: Add initial support for CP and NQ
 rings
Message-ID: <20250901142747.6e6f8bfd@kernel.org>
In-Reply-To: <20250828184547.242496-3-bhargava.marreddy@broadcom.com>
References: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
	<20250828184547.242496-3-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 18:45:40 +0000 Bhargava Marreddy wrote:
> Allocate CP and NQ related data structures and add support to
> associate NQ and CQ rings. Also, add the association of NQ, NAPI,
> and interrupts.

> +static int bnge_alloc_nq_desc_arr(struct bnge_nq_ring_info *nqr, int n)
> +{
> +	nqr->desc_ring = kcalloc(n, sizeof(*nqr->desc_ring), GFP_KERNEL);
> +	if (!nqr->desc_ring)
> +		return -ENOMEM;
> +
> +	nqr->desc_mapping = kcalloc(n, sizeof(*nqr->desc_mapping), GFP_KERNEL);
> +	if (!nqr->desc_mapping)
> +		return -ENOMEM;

Please add appropriate local unwind in all functions. If the function
fails it should undo its partial updates. The assumptions about unwind
somewhere deep in the call stack made it hard to work with bnxt.

> +static int alloc_one_cp_ring(struct bnge_net *bn,
> +			     struct bnge_cp_ring_info *cpr)
> +{
> +	struct bnge_ring_mem_info *rmem;
> +	struct bnge_ring_struct *ring;
> +	struct bnge_dev *bd = bn->bd;
> +	int rc;
> +
> +	rc = bnge_alloc_cp_desc_arr(cpr, bn->cp_nr_pages);
> +	if (rc) {
> +		bnge_free_cp_desc_arr(cpr);
> +		return -ENOMEM;
> +	}
> +	ring = &cpr->ring_struct;
> +	rmem = &ring->ring_mem;
> +	rmem->nr_pages = bn->cp_nr_pages;
> +	rmem->page_size = HW_CMPD_RING_SIZE;
> +	rmem->pg_arr = (void **)cpr->desc_ring;
> +	rmem->dma_arr = cpr->desc_mapping;
> +	rmem->flags = BNGE_RMEM_RING_PTE_FLAG;
> +	rc = bnge_alloc_ring(bd, rmem);
> +	if (rc) {
> +		bnge_free_ring(bd, rmem);
> +		bnge_free_cp_desc_arr(cpr);

use a goto ladder for centralized error handling, per kernel coding
style

> +	}
> +
> +	return rc;
> +}

> +static int bnge_set_real_num_queues(struct bnge_net *bn)
> +{
> +	struct net_device *dev = bn->netdev;
> +	struct bnge_dev *bd = bn->bd;
> +	int rc;
> +
> +	rc = netif_set_real_num_tx_queues(dev, bd->tx_nr_rings);
> +	if (rc)
> +		return rc;
> +
> +	return netif_set_real_num_rx_queues(dev, bd->rx_nr_rings);
> +}

 netif_set_real_num_queues() exists

> +static int bnge_setup_interrupts(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +
> +	if (!bd->irq_tbl) {
> +		if (bnge_alloc_irqs(bd))
> +			return -ENODEV;
> +	}
> +
> +	bnge_setup_msix(bn);
> +
> +	return bnge_set_real_num_queues(bn);
> +}
> +
> +static int bnge_request_irq(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i, rc;
> +
> +	rc = bnge_setup_interrupts(bn);
> +	if (rc) {
> +		netdev_err(bn->netdev, "bnge_setup_interrupts err: %d\n", rc);
> +		return rc;
> +	}
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		int map_idx = bnge_cp_num_to_irq_num(bn, i);
> +		struct bnge_irq *irq = &bd->irq_tbl[map_idx];
> +
> +		rc = request_irq(irq->vector, irq->handler, 0, irq->name,
> +				 bn->bnapi[i]);
> +		if (rc)
> +			break;
> +
> +		netif_napi_set_irq_locked(&bn->bnapi[i]->napi, irq->vector);

Are you netdev-locked here? I don't see the driver either requesting ops
lock or implementing any API which enables netdev-lock.
-- 
pw-bot: cr

