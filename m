Return-Path: <netdev+bounces-295996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B1CfNCpdI2qKrAEAu9opvQ
	(envelope-from <netdev+bounces-295996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:35:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D164BCF3
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:35:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="HbqdW/iM";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295996-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295996-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E868430297B8
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 23:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665533043C8;
	Fri,  5 Jun 2026 23:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34513D539;
	Fri,  5 Jun 2026 23:31:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702305; cv=none; b=AqwKt01p4b4564rc+M7dOxaZ7i+zN29gBa2Iaqtjm/81uQ8/LY1wFZKX/cRN3D/PyB8jeqTWg8r4byIUJIRR8VcsfNO9y5GG1nyjUONQf4IP6mlH8aTU9wtLY/myLdDJP109vppl+Xt4VMZ7EvkAFicm35Akvvot1aIthulk5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702305; c=relaxed/simple;
	bh=MJNZRYZnDAoxKg7rFdk0qEdbby3fYdqcg7YKA57sfbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JI6gjwXZuEX4SUIOjb6Wng/1+KcFeDbNBfrPOVqbPFD2v4CrfVaOsmAoz2Fg9oK8UVMW+g1wLJ/J9vc/CB1AM+5qUGdXaTg+FEUZaL+t/ijhcRdfv794wXPNz3MrltyZtCfvwhrvdZtkB0ToZ7QYoJCmEH3N4MlAmUnfKpNfeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbqdW/iM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0D71F00893;
	Fri,  5 Jun 2026 23:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702304;
	bh=oLXZ4dxKLlsro5u3LRhS9xqGSr/ldP8GeMc3rViWGbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HbqdW/iMraHdJeU2uK8Ig6R6ShP6dLu5x+FKlPMA16i1eoJHqCZOQwHl8DJT5m80V
	 4oECcK4yWm/zd5wcRpMqHm4XhllefuE+6BvXZFhEXGUxDl5WS2DyHJz5yjdb41tkNL
	 xyEo11bLHy1wMOO2NekIbA1qax8MI+rDFOmqNZu/MuhXrduKZK82b4d0Nw9SyI0VtJ
	 MWmjFWRKXy8ynAWCDQJCxVip1D8rdvje7gkQZq1vDcVaOFd2kswkwmXxGfwb4yT63/
	 SLsui756lKSJ0gBBKIvf1cNyAVeLJA8CV4Mg3BEnHXma4tvEGrALYXy7+izEbD+Oz6
	 5g9fBgoNar2zQ==
Date: Fri, 5 Jun 2026 16:31:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: Paolo Abeni <pabeni@redhat.com>, lawson.fidelio@gmail.com,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Tristram.Ha@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nb@tipi-net.de, fidelio.lawson@exotec.com
Subject: Re: [PATCH net-next v9 2/3] net: ethtool: add KSZ87xx low-loss
 cable PHY tunables
Message-ID: <20260605163142.4bbcf502@kernel.org>
In-Reply-To: <4098dafb-838e-4854-add6-cb3ce6668a70@nabladev.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-2-fdbbb15592cb@exotec.com>
	<20260604114119.170747-1-pabeni@redhat.com>
	<20260604193545.0a906598@kernel.org>
	<4098dafb-838e-4854-add6-cb3ce6668a70@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295996-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:marex@nabladev.com,m:pabeni@redhat.com,m:lawson.fidelio@gmail.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:Tristram.Ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:fidelio.lawson@exotec.com,m:lawsonfidelio@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,bootlin.com,kernel.org,armlinux.org.uk,vger.kernel.org,tipi-net.de,exotec.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C1D164BCF3

On Fri, 5 Jun 2026 05:16:54 +0200 Marek Vasut wrote:
> On 6/5/26 4:35 AM, Jakub Kicinski wrote:
> > On Thu,  4 Jun 2026 13:41:19 +0200 Paolo Abeni wrote:  
> >> [Severity: High]
> >> Is it intentional to enforce an 8-bit type constraint for bandwidth and DSP
> >> equalizer tunables?
> >>
> >> This heavily couples the global API to the 8-bit register layout of the
> >> KSZ87xx hardware without defining generic units like Hz for bandwidth.  
> > 
> > AFAIK this is the one comment from AI that survives scrutiny.
> > Seems unlikely we'd need more bits, but then again - why not.
> > u32 should be our default for integer values, u8 is more for
> > booleans.  
> 
> Why waste memory space if we are already sure the space would not be used.

Waste what memory? We are talking about a syscall argument effectively.

My point is that this is adding the arguments as u8 in
net/ethtool/ioctl.c, so as part of the global uAPI.

The driver can still store these as u8, since any value outside of that
range is invalid for ksz87xx, and the input is properly validated. 
But we shouldn't constrain the value "in transit", at the uAPI level.
Another driver may need a larger range (however unlikely that is).

