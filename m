Return-Path: <netdev+bounces-253526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPezFt6Nd2m9hgEAu9opvQ
	(envelope-from <netdev+bounces-253526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:53:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7F18A570
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B74183016806
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB5340A70;
	Mon, 26 Jan 2026 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhjPgplP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6627322FF22;
	Mon, 26 Jan 2026 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442777; cv=none; b=SdD/R/gMu1I33exbWRLIG1oooO4FtaL/hUIhMiJDf2+UXLOC94AOD6NxlIEtFCl4zBsXXUHcjDHvGn3l+oTKA1sP9fvguA7CXIIFA1m34Qj3r/XX0IvAMe7rt1pPoT3MbusghloWdM7cV8T2b2bV+dvnQ1MYhKRVBibe9JdpW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442777; c=relaxed/simple;
	bh=cBy8EwyJMtNkdI+C/ke9fBHu1htl+60yczc9jY4zN34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVzGhtNzV/hB0z47B4vgO9bCfd3VA0C8FvBuCOD11UM1Q7yDTpkJGts6klI3Iq090PXCW4rrSKqNpSi0l/G5ROmXDX2ddY/3baZsCYIFzTs/HjOmWn8osZ90ltespdwulvTafUOAsgYXYJeOOt4IvivNDiCBqTXKJo6oHMip/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhjPgplP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B914C116C6;
	Mon, 26 Jan 2026 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769442777;
	bh=cBy8EwyJMtNkdI+C/ke9fBHu1htl+60yczc9jY4zN34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhjPgplPaQg9wN2/9eV9wzq26j513KhG/T6SS0GfhK8iJ0TlRHm10wZlgeMaaXOJG
	 EAyRfhvxeoohlTkamObRXUp6Ynj4FoJtei3lTuaPui32Cw82yb7hr4maoVViHuffee
	 Tlf2SlJieNs/zZ5bVrI1Kx/05t5ee92fp0SlzvRSko6CYje/jOvZSwqCFWjWxrPH+B
	 /uGtMwVAOhdcg2BWsiKvB7Txin+DlnWCK+ZyNxkqtzF0hveb9Q8YbbONuDjRhG4Qyo
	 UcJ9xSd7gf//RnahxNDuPXi2QHL2KXopdzo6uFP0yu/kg1lNw81ZiHv8Ze2Z9Xyqdd
	 oWRGrlBTASm+Q==
Date: Mon, 26 Jan 2026 15:52:52 +0000
From: Simon Horman <horms@kernel.org>
To: zilin@seu.edu.cn
Cc: vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net,
	kory.maincent@bootlin.com, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
	pabeni@redhat.com, marco.crivellari@suse.com
Subject: Re: [net,v2,2/2] net: liquidio: Initialize netdev pointer before
 queue setup
Message-ID: <aXeN1EsGgr_YQi8s@horms.kernel.org>
References: <20260124124205.102499-3-zilin@seu.edu.cn>
 <20260126154941.1391119-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126154941.1391119-1-horms@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253526-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: CA7F18A570
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 03:49:41PM +0000, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: liquidio: Initialize netdev pointer before queue setup
> 
> This patch moves the initialization of lio and props structures earlier
> in setup_nic_devices() so that props->netdev is set before calling
> netif_set_real_num_rx_queues() and netif_set_real_num_tx_queues(). The
> intent is to fix a memory leak where the allocated netdev would not be
> freed if queue setup fails.
> 
> > diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > index 3ba2806f5d1e..2383f0173a54 100644
> > --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > @@ -3505,6 +3505,16 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
> >  		 */
> >  		netdev->netdev_ops = &lionetdevops;
> >
> > +		lio = GET_LIO(netdev);
> > +
> > +		memset(lio, 0, sizeof(struct lio));
> > +
> > +		lio->ifidx = ifidx_or_pfnum;
> > +
> > +		props = &octeon_dev->props[i];
> > +		props->gmxport = resp->cfg_info.linfo.gmxport;
> > +		props->netdev = netdev;
> 
> Moving this initialization earlier fixes the memory leak, but now if
> netif_set_real_num_rx_queues() or netif_set_real_num_tx_queues() fails
> below, the cleanup path in liquidio_destroy_nic_device() will proceed
> further than before since props->netdev is no longer NULL.
> 
> Previously, when queue setup failed, liquidio_destroy_nic_device() would
> return early at the "if (!netdev)" check. Now it continues and calls
> cleanup_rx_oom_poll_fn().
> 
> In cleanup_rx_oom_poll_fn() (lio_core.c), the code does:
> 
>     struct lio *lio = GET_LIO(netdev);
>     struct octeon_device *oct = lio->oct_dev;
>     ...
>     for (q_no = 0; q_no < oct->num_oqs; q_no++) {
> 
> Since lio->oct_dev is not assigned until much later in setup_nic_devices()
> (around line 3602), it will be NULL after the memset above. Would this
> cause a NULL pointer dereference when cleanup_rx_oom_poll_fn() tries to
> access oct->num_oqs?
> 
> > +
> >  		retval = netif_set_real_num_rx_queues(netdev, num_oqueues);
> >  		if (retval) {
> >  			dev_err(&octeon_dev->pci_dev->dev,
> 
> [ ... ]

Strangely the AI review did not pick this up for v1.
(And neither did I.)

