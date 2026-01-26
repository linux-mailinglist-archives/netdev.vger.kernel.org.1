Return-Path: <netdev+bounces-253527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKwdJ6COd2m9hgEAu9opvQ
	(envelope-from <netdev+bounces-253527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:56:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A778A602
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1C9F3006111
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C991340DA3;
	Mon, 26 Jan 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8hgMWPK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA133F372;
	Mon, 26 Jan 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442972; cv=none; b=Nh6rEglSrXCaBfCQRF0c7QyS1NNM4TlypbQHy4PkPtr8MH9SaY0or0gwzka8LiM9IFpygCaeZlgGVSV1dRmKD/1fVwtZ1O724SSQKNftZftrLgJxOBEFZV0/reS1bn2Bcr9ewR93XaG+1XOQJlau6wNbgkOvDf0wbi0GBxR1Iug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442972; c=relaxed/simple;
	bh=7/aeyfQtaJSIsXchqJiGqOehU/fzfZn6+vm2KL1iZoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyxJS1DYFWS45UKKeYD7dVBXl1r28WnXsUIYmHIo7w24kkViczj0LRQI+vULW7oZmLVgEbSvvJs236n2R3BnToDr6/qWpbqbXBA0BQva444hcDdyyPl99PHXHSQPDrGNWGHUV7V4JJ1Pee7AL+HsvV3oixrHO1ongZATY1EnGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8hgMWPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8F4C116C6;
	Mon, 26 Jan 2026 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769442972;
	bh=7/aeyfQtaJSIsXchqJiGqOehU/fzfZn6+vm2KL1iZoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8hgMWPKImkrEDgACqf9lx2wx3jXj2pfz0BIbMCjZpuv5BXV2UhMAfZ2EXH6MYJlc
	 F9Vi0WG+ooul9T5W/hF6exXjmkDm/ZK94Ex0hS5BVGlbNyk7vPZlvtqQCHLlOzobrk
	 /zVb8XzWQEZ6aNEz7fV4gC6XmKeYpo8nWpAnTDDYZaRCKNCwNHHvhY9HB4TmQYNSCJ
	 bK+QC6GoMEzmrXxAVdCmgLHMClm8EG+XzqiyoJDBYrzK7rRhv8u3ZQ/P3IWJyxoFFl
	 MG+YCZslifbkGQXXcmP+JxMSRMW4y+jLAXHTV1lfrZ8Pii4vd913Mqz5GIT9pPbn06
	 f1crFbp0K3vMQ==
Date: Mon, 26 Jan 2026 15:56:07 +0000
From: Simon Horman <horms@kernel.org>
To: zilin@seu.edu.cn
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, jianhao.xu@seu.edu.cn,
	kuba@kernel.org, kory.maincent@bootlin.com,
	marco.crivellari@suse.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	edumazet@google.com, pabeni@redhat.com
Subject: Re: [net,v2,1/2] net: liquidio: Fix off-by-one error in
 setup_nic_devices() cleanup
Message-ID: <aXeOl5D7BR-xnEgm@horms.kernel.org>
References: <20260124124205.102499-2-zilin@seu.edu.cn>
 <20260126155039.1391193-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126155039.1391193-1-horms@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253527-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43A778A602
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 03:50:39PM +0000, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: liquidio: Fix off-by-one error in setup_nic_devices() cleanup
> 
> This patch changes the cleanup loop from while(i--) to do{}while(i--)
> to ensure that when a device fails to initialize, it gets cleaned up
> along with all previously initialized devices.
> 
> > diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > index 0732440eeacd..3ba2806f5d1e 100644
> > --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > @@ -3765,11 +3765,11 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
> >
> >  setup_nic_dev_free:
> >
> > -	while (i--) {
> > +	do {
> >  		dev_err(&octeon_dev->pci_dev->dev,
> >  			"NIC ifidx:%d Setup failed\n", i);
> >  		liquidio_destroy_nic_device(octeon_dev, i);
> > -	}
> > +	} while (i--);
> 
> In lio_main.c, setup_nic_devices() can also reach setup_nic_dev_free from
> the devlink_alloc() failure path after the main for loop completes. At that
> point i equals ifcount (the loop counter has been incremented past the last
> valid device).
> 
> With the do-while change, the first iteration will call
> liquidio_destroy_nic_device(octeon_dev, ifcount) for a device index that
> was never initialized. The function has a guard for NULL netdev so it will
> not crash, but it will print a spurious error message about a device that
> never existed.
> 
> The fix works correctly for failures within the loop (which is the case
> described in the commit message), but is there a way to handle the
> post-loop devlink_alloc() failure case without printing the spurious
> error message?

Sorry for not realising this when I made this suggestion in
my review of v1.

Also, I would suggest splitting this patch in two: one patch
per driver.

