Return-Path: <netdev+bounces-270743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIfaJWqvwWnUUgQAu9opvQ
	(envelope-from <netdev+bounces-270743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:23:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E352FDB51
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8050B300C7C9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229E3783C8;
	Mon, 23 Mar 2026 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg+H7au1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A43603F7
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301027; cv=none; b=JJJtPdRjYWjXy5XiJYPDhJnCRBEoOlFlj6KeQcI8urUwJI45z97gOdLJZUnD03mmzQcyceWOIxdYc9VI83zffEA0jQiqxHoLEpc/bqd+VzOdPPZHnrAjBvO1xoI8yHRTWfMC/uqfptdyfky5M0z3VfJqGI6pvgkHaNDyJvhTKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301027; c=relaxed/simple;
	bh=8ov8jG8Q2BKX/gGixQkvTUqG8FPDZ0Y0JjSPvpemQe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tr35XZuREx2oIauTJ/JtCPcFlJz1ATCBYgGqca6LmSXPmHLRAzZv4fakulqOsEl8shm3TgXmon/4DpBwipV3egGIR3USxlXlHc7iVveusfr296BegRgCpbrzt2PYXv5/8L1hRLqYw3iI1FcKGAfnGxOqK6i0OG/cb5T7N1ddjfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg+H7au1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2A9C4CEF7;
	Mon, 23 Mar 2026 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774301027;
	bh=8ov8jG8Q2BKX/gGixQkvTUqG8FPDZ0Y0JjSPvpemQe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mg+H7au1WJmufSPsBMqE9eKAW3+nKd4Sv0rGG0O6GyTLXSjEf1MkvCAwlv/7TmPeN
	 2EONc1H7pHnSmASmp3FL6n3h/zII5W0AMAMhFmDuhaH9z1KI+/UPS9ICcOEB9he8iI
	 21zGzuWtc67Y9eHw9z6yureFZi3uDzsapGuE3wqLX+P4Cl4fka9cs9XsVRjWI1A3RB
	 jwYMvOJ9DzUx7g62wxrZmy1P2aAYuiJJwnCiiIxPUQNGUI62xD1PZkcM8eTswWczzl
	 Tm/w6gF3jdXPx3Y9NRF7IR/60bwLSCT/1vOrFjtudZX2xIu/vd1BNxT17NU/+3WaKM
	 6vltCIUbCLXlQ==
Date: Mon, 23 Mar 2026 14:23:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adriano Vero <litaliano00.contact@gmail.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: broadcom: b44: Add missing dma_mapping_error in
 b44_start_xmit
Message-ID: <20260323142340.13fded29@kernel.org>
In-Reply-To: <20260323180913.188434-1-litaliano00.contact@gmail.com>
References: <20260323180913.188434-1-litaliano00.contact@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270743-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91E352FDB51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 19:09:13 +0100 Adriano Vero wrote:
> The b44 driver calls dma_map_single() in the transmit path but fails to
> check the return value for errors using dma_mapping_error().

You say it doesn't use dma_mapping_error() ..

> If the DMA
> mapping fails under memory pressure, it can lead to memory corruption.
> 
> Add the missing check, drop the skb, and return NETDEV_TX_OK to prevent
> ring corruption.

> --- a/drivers/net/ethernet/broadcom/b44.c
> +++ b/drivers/net/ethernet/broadcom/b44.c
> @@ -964,8 +964,14 @@ static netdev_tx_t b44_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	}
>  
>  	mapping = dma_map_single(bp->sdev->dma_dev, skb->data, len, DMA_TO_DEVICE);
> -	if (dma_mapping_error(bp->sdev->dma_dev, mapping) || mapping + len > DMA_BIT_MASK(30)) {

.. and yet this line clearly contains the check.

Please explain what you mean and do not post a v2 until some reviewer
requests that you do so.

> -		struct sk_buff *bounce_skb;
> +    
> +    if (dma_mapping_error(bp->sdev->dma_dev, mapping)) {
> +        dev_kfree_skb_any(skb);
> +        return NETDEV_TX_OK;
> +    }
> +
> +    if (mapping + len > DMA_BIT_MASK(30)) {
> +        struct sk_buff *bounce_skb;
>  
>  		/* Chip can't handle DMA to/from >1GB, use bounce buffer */
>  		if (!dma_mapping_error(bp->sdev->dma_dev, mapping))


