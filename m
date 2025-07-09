Return-Path: <netdev+bounces-205209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32760AFDCAC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F586482007
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAA41C8631;
	Wed,  9 Jul 2025 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZJGLBA7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C619066D;
	Wed,  9 Jul 2025 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022870; cv=none; b=PZrvAQuN1U+NaAneQ7/d1TBVnGCwXGsmTDjFqoVUYu+2sLhn08u4pqJIdUiElo2Tl2YZzj4YVMZR+YGOtJ9meqBZBMyHhRDlrhYdqBsdyvwlMCnr8rwLS3UBZLjpQV8UIlYzGX8ie7T2p3g58xjFCen/ZF/vP97xCiryJWRqt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022870; c=relaxed/simple;
	bh=K1gtEVcxaVd2y4FMGLAeW2csYcsmmqWlWQd+W6jNQC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4PxXjYxajos9Rvuzn9Oe5wB1g7gpAa+dtJoakhTSW4Gu7vD2s7t9CYTN1/F8W7Pt8oglmwMCcLXOzyp3+Q9B6p2+koALt1plBOI28H1XyWWo41x2DDzsyQAhvQa+/z5qgDBuNuAqHw3Szp85/MC+veHhzDpPSgAaPqwijXL3nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZJGLBA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282BDC4CEED;
	Wed,  9 Jul 2025 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752022869;
	bh=K1gtEVcxaVd2y4FMGLAeW2csYcsmmqWlWQd+W6jNQC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LZJGLBA7gOIUXO/NWjGr7suEmwSrwlz17LMRANZmRa8WisuRO6amGUtqRa8bxE8Jj
	 B3mbjISZnBLf0eBNLoKDcDiLLUOGtGWaTi4cjRdX5v0oSlEZTAMu0qyHbCZqtlkbU7
	 sftbBIqDNNAcVRlBVhqBJeOJfKBOW/I15/3vtTZfcgBinn9x+YiAVJ3Vm7xij9rgLK
	 tpLFC7gaVV3fgQLJIw3Dfpwbk+MuA7+3HK/6j0HUXosPFdKWEnAPmd4/I4qrPYypZ+
	 Zley5r/mZUxpJ8lz34h+OcB0NWXOs+StSoVo6J80QB7qPZdsYcV1jgt1wSuYa4vwdO
	 fNEU0kuqVJWUQ==
Date: Tue, 8 Jul 2025 18:01:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ssantosh@kernel.org, richardcochran@gmail.com, s.hauer@pengutronix.de,
 m-karicheri2@ti.com, glaroque@baylibre.com, afd@ti.com,
 saikrishnag@marvell.com, m-malladi@ti.com, jacob.e.keller@intel.com,
 diogo.ivo@siemens.com, javier.carrasco.cruz@gmail.com, horms@kernel.org,
 s-anna@ti.com, basharath@couthit.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev, pratheesh@ti.com,
 prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v10 04/11] net: ti: prueth: Adds link
 detection, RX and TX support.
Message-ID: <20250708180107.7886ea41@kernel.org>
In-Reply-To: <20250702151756.1656470-5-parvathi@couthit.com>
References: <20250702140633.1612269-1-parvathi@couthit.com>
	<20250702151756.1656470-5-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 20:47:49 +0530 Parvathi Pudi wrote:
> +			if (emac->port_id) {
> +				regmap_update_bits
> +					(prueth->mii_rt,
> +					 PRUSS_MII_RT_TXCFG1,
> +					 PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_MASK,
> +					 delay);

Instead of breaking the lines up like this you should factor the code
out or find some other way to reduce the indentation.

> +	qid = icssm_prueth_get_tx_queue_id(emac->prueth, skb);
> +	ret = icssm_prueth_tx_enqueue(emac, skb, qid);
> +	if (ret) {
> +		if (ret != -ENOBUFS && netif_msg_tx_err(emac) &&
> +		    net_ratelimit())
> +			netdev_err(ndev, "packet queue failed: %d\n", ret);
> +		goto fail_tx;
> +	}

> +	if (ret == -ENOBUFS) {
> +		ret = NETDEV_TX_BUSY;


Something needs to stop the queue, right? Otherwise the stack will 
send the frame right back to the driver.

> +static inline void icssm_emac_finish_napi(struct prueth_emac *emac,
> +					  struct napi_struct *napi,
> +					  int irq)
> +{
> +	napi_complete(napi);
> +	enable_irq(irq);

This helper has a single caller, just put the two lines of code directly
there. And use napi_complete_done(), please.

