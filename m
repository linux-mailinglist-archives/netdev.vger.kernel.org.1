Return-Path: <netdev+bounces-294730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OryeBKYdIGplwAAAu9opvQ
	(envelope-from <netdev+bounces-294730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:27:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580706377D2
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:27:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=a42iGW0J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294730-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294730-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3444833216C8
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F446AEEA;
	Wed,  3 Jun 2026 12:06:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF846AF32;
	Wed,  3 Jun 2026 12:06:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488369; cv=none; b=HrDgRQDi2bqCowNTijQ1w1ORD1112IoV9UXFG9ZWFbzsjRNKoWiScEjhUChwZ5YYGTTerA94mk1sygTITu14uegqKHa8w/HrJss4PX6M8WxzQqzgr/D03P14/Dx5dg98DR9OFAu3/uCdMLYL1Z2+dBElnrNnaUF5MSiQ8Mbl/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488369; c=relaxed/simple;
	bh=NmbHAu3ennAhplnj1Fpl+AtY5FcQ1oI8xfGz2tyLEoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz7wYt1MFolsx2KHkyXlkZZqmml8gGLxyN/Yf1NGbPcrWjvMqDohTRgdwR/pB9tK4t6kIB0Ymr/i4/rE8ubWcP6SEVr4CrkbGFb/hZM0e5v6AAsdz1LhcNmdcQo/9zn/EuNUYmHUvsgePt1HBWQI9PYiXrStafdXYsUqUs/HV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a42iGW0J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881281F00893;
	Wed,  3 Jun 2026 12:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780488367;
	bh=SZjPOv/TL2eeyJ8ESJhG8XL+zmnlxOPUTLCatLVqHlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a42iGW0JUpcYV2qY/MmDEti2VM5i4sPIqbLHsIRFi/y2KjhHu8TmCQNTFGvDGr32v
	 6wRIvMROqZ6C0KgIfI+DeDzezHgazqtF2qD9k4fSu9hwYr6vL2fcoG18BytF5M3cU2
	 P68ddb6gMv7nIw7J/4+4DRrLXXbv6BQVKz/iarLRZU2ZBJGpEZ8WFAqVx5X7MZtjsR
	 bWKwnBt9Quu5/EEUTnPQS6ydUpItZc1VXaD88HdUaE5EdkQzXrmpeITiBe3yhDmNsy
	 rcrDh1Q73hicr2K7IuqmOLga+cU5VfatSYXOGmNUSovwuO5Gg115Oh1+KuHNFIvJ/t
	 q4EhDHH5l1zfg==
Date: Wed, 3 Jun 2026 13:06:03 +0100
From: Simon Horman <horms@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
	ecree.xilinx@gmail.com, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, baijiaju1990@gmail.com
Subject: Re: [PATCH] sfc: Use acquire/release for irq_soft_enabled
Message-ID: <20260603120603.GD3410996@horms.kernel.org>
References: <20260528092838.2099352-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528092838.2099352-1-hanguidong02@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294730-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:hanguidong02@gmail.com,m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:ecree.xilinx@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:baijiaju1990@gmail.com,m:ecreexilinx@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 580706377D2

On Thu, May 28, 2026 at 05:28:38PM +0800, Gui-Dong Han wrote:
> irq_soft_enabled is a lockless gate for interrupt handlers. When clear,
> handlers must only acknowledge interrupts and must not touch channel state.
> 
> Channel reallocation disables this gate, swaps and initializes channel
> pointers, frees old channels, and then enables the gate again. READ_ONCE()
> does not provide an acquire barrier, so an IRQ handler can observe the gate
> as enabled while still seeing stale channel pointers or channel state.
> 
> Use release stores when updating the gate and acquire loads in interrupt
> handlers before touching channels. Keep the existing smp_wmb() after gate
> updates, preserving the current ordering with event queue start and stop.
> 
> Add small helpers to document the ordering and avoid repeating barrier
> comments at every caller. Without the comments, checkpatch warns about
> memory barriers without comments.
> 
> Fixes: d829118705f8 ("sfc: Rework IRQ enable/disable")
> Fixes: 8127d661e77f ("sfc: Add support for Solarflare SFC9100 family")
> Fixes: 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into new sfc-falcon driver")
> Fixes: 51b35a454efd ("sfc: skeleton EF100 PF driver")
> Fixes: 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)")
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
>  drivers/net/ethernet/sfc/ef10.c               |  4 ++--
>  drivers/net/ethernet/sfc/ef100_nic.c          |  2 +-
>  drivers/net/ethernet/sfc/efx_channels.c       |  4 ++--
>  drivers/net/ethernet/sfc/falcon/efx.c         |  4 ++--
>  drivers/net/ethernet/sfc/falcon/falcon.c      |  2 +-
>  drivers/net/ethernet/sfc/falcon/farch.c       |  4 ++--
>  drivers/net/ethernet/sfc/falcon/net_driver.h  | 12 ++++++++++++
>  drivers/net/ethernet/sfc/net_driver.h         | 12 ++++++++++++
>  drivers/net/ethernet/sfc/siena/efx_channels.c |  4 ++--
>  drivers/net/ethernet/sfc/siena/farch.c        |  4 ++--
>  drivers/net/ethernet/sfc/siena/net_driver.h   | 12 ++++++++++++
>  11 files changed, 50 insertions(+), 14 deletions(-)

I'm not sure if it would be worth breaking this up, say on a per-driver
basis. My main thinking here is that it might assist in backporting.

But, OTOH, I wonder if this should be targeted at net-next without
the Fixes tag - can this manifest in an actual bug that effects users?

FTR, there is an Ai-generated review of this patch available on sashiko.dev.
However, I believe that all the issues flagged there are pre-existing and
can be examined in the context of possible follow-up. I do not believe they
should block progress of this patch.

Overall, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

