Return-Path: <netdev+bounces-305434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CuYMFlrzTGrlsQEAu9opvQ
	(envelope-from <netdev+bounces-305434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 14:38:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 908AF71B6D6
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 14:38:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="4J ok4qZ";
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305434-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305434-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948AD313A809
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42972404BFE;
	Tue,  7 Jul 2026 12:27:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FE3F99FE;
	Tue,  7 Jul 2026 12:27:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427244; cv=none; b=jpeYYa3eZR3MXsEedUx09W7yElgrQHnhCeiKebfPx6CilMwD8PK8ElVNPTMZCyU+WFvbjVewlFTxgt2E0CFZxjzWFkxPOSS4YpVNHoXTKC6rFHfKBmsMBXy8ceU0CKlif5gJzBcBECB45nlFYyR39mH4f41hle25QGtuDZwbuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427244; c=relaxed/simple;
	bh=2DKRCY6Yc4S3DX9Pjz0yjgSyUaZ4g5g3XzjHNn6v0bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq1OqDeUzOIhPmK9CM7QJyEkImUtyBdBuA1Jdm4IfNte/ctB06gRIHdQBpKj1mwOIctuHtz6n/DcHl/ap18r2nVNatAtH+kYOy0jkdQOKeiyUdGwIAOfiIle6l5bQiPdBy8Tega9u6GbR1Xk23qKqXns44Z++82e0uaxzqsnN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4Jok4qZ2; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1nkGtrcQiWcU6y5rHCmOwkXl2B09jKLFjYM2ku6mbSU=; b=4J
	ok4qZ2h45gQOE5dxHgG2r89hQpJKi9q4bBe2vIrWcksBObTKbqhN4u7FOok3F+b8pP/ZIVyvRrdE1
	HH149yH/RplbUXomN28MpfGjlVmn8EYZidcTuXoAYk+unoOvY3uvtdjLtQ/V+iBIbP3lqKxj9wQHr
	jNAyWTBO6lQL6Vo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wh4dc-00B9mg-I6; Tue, 07 Jul 2026 14:10:56 +0200
Date: Tue, 7 Jul 2026 14:10:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
Message-ID: <2f07f731-0b97-4a23-8ccd-f01638fc1c7e@lunn.ch>
References: <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
 <12ec5246-4124-4edb-a5f8-f10c73b1fcb7@lunn.ch>
 <akwToZyYvHZPtdjV@monoceros>
 <96a77bc9-9804-43fb-acf0-b93574cd60f3@lunn.ch>
 <akynGw4TQimFiQST@monoceros>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akynGw4TQimFiQST@monoceros>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305434-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 908AF71B6D6

On Tue, Jul 07, 2026 at 09:15:35AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello Andrew,
> 
> On Mon, Jul 06, 2026 at 11:28:33PM +0200, Andrew Lunn wrote:
> > > That's exactly my thought, and there is commit ad428f5811bd
> > > ("mod_devicetable.h: Split into per subsystem headers") that is part of
> > > v7.2-rc2 and that does exactly that (apart from the filename).
> > 
> > Ah, O.K. net-next tends to great dragged along the -rcX versions. So
> > you can probably submit the networking changes in a weeks time. Just
> > make sure they apply to
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> 
> Note that while I created the patch under discussion on top of -rc2, the
> justification is also valid on -rc1 and the patch doesn't use the new
> headers, so it can be applied to the above repo already now.

Yes, our patchwork instance and its CI agree:

https://patchwork.kernel.org/project/netdevbpf/patch/ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com/


but i was actually meaning the patches which swaps to the broken out
header with only struct mdio_device_id. I assume that patch is the one
which really reduces the number of files which get recompiled on
unrelated changes. That patch can be submitted to netdev probably next
week.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

