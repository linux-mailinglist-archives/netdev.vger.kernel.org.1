Return-Path: <netdev+bounces-298143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xF8jDDe4Kmr7vgMAu9opvQ
	(envelope-from <netdev+bounces-298143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:29:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C42667256C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:29:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298143-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298143-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E0D3079FFF
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B98405C50;
	Thu, 11 Jun 2026 13:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45873343884;
	Thu, 11 Jun 2026 13:29:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184545; cv=none; b=EFOCzHS5I6qJ9IddQQEp/LilQO/11M+K4BwbrXsVKY0wtlIctPzZU3nOFQvoRCSVK4lUN+R9jMwhMMnbxe7rbHXOy1pPYWdSnibDgHdWqsUyuGroNMZVgldijxotIbekMfAFXmUGRufFJM/XZlH5EaUTxOXKrscoqkLZMmMPC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184545; c=relaxed/simple;
	bh=FVcn/kRCRo3a4N/WqbzYiTwhDsTJExTTjC89rNIGJv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XevbqjQEk1oPR/jiA9LPUADILQkfbdxzrH8wN/9BQlXBZdOSkLOd5C5IBh+zjSJsE292vzmPFud8iLs/DCrYi3uUDXqv96IYwVdvpfCv4LJoFFDtpkHRvRQsnL+DB/1ozitxl6O6nJU6/FkRss/eIflUSe/cFcl6UUIJtmxqH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wXfSs-000000005EW-3Edp;
	Thu, 11 Jun 2026 13:28:58 +0000
Date: Thu, 11 Jun 2026 14:28:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/4] net: dsa: mxl862xx: move phylink stubs
 to mxl862xx-phylink.c
Message-ID: <aiq4GEDlCok3B2lT@makrotopia.org>
References: <f551d90bf2f6820ed6785f5f8e6548d4fc3bd598.1780968180.git.daniel@makrotopia.org>
 <20260611130750.575946-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611130750.575946-2-horms@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298143-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,makrotopia.org:mid,makrotopia.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C42667256C

On Thu, Jun 11, 2026 at 02:07:51PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c
> 
> Move the phylink MAC operations and get_caps callback from mxl862xx.c
> into a dedicated mxl862xx-phylink.c file. This prepares for the SerDes
> PCS implementation which adds substantial phylink/PCS code.
> 
> > diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> > index 2f22adedfbf67..a193f3c07d359 100644
> > --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> > +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> 
> [ ... ]
> 
> [Severity: Critical]
> This is a pre-existing issue, but the crc_err_work can execute after
> dsa_unregister_switch(), leading to a use-after-free of ds->dst and
> dsa_port structures.
> 
> In mxl862xx_remove(), dsa_unregister_switch() is called before the
> asynchronous crc_err_work is cancelled via mxl862xx_host_shutdown():
> 
> drivers/net/dsa/mxl862xx/mxl862xx.c:mxl862xx_remove() {
> 	...
> 	dsa_unregister_switch(ds);
> 
> 	mxl862xx_host_shutdown(priv);
> 	...
> }
> 
> dsa_unregister_switch() tears down the DSA tree, frees all dsa_port
> objects, and drops the reference to ds->dst.
> 
> If mxl862xx_crc_err_work_fn executes concurrently or after
> dsa_unregister_switch() has returned, it traverses already freed
> dsa_port entries:
> 
> drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_crc_err_work_fn() {
> 	...
> 	dsa_switch_for_each_cpu_port(dp, priv->ds)
> 		dev_close(dp->conduit);
> 	...
> }
> 
> Could this order in mxl862xx_remove() result in a use-after-free, and
> should mxl862xx_host_shutdown() be called before dsa_unregister_switch()?

To really address this a guard in mxl862xx_host_shutdown() will be
needed. I'd rather do this in a separate Fixes:-patch targetting 'net'
rather than in this series targetting 'net-next', right?

