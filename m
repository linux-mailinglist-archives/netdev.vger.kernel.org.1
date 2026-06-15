Return-Path: <netdev+bounces-299668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sjI/Ls+PMGrGUQUAu9opvQ
	(envelope-from <netdev+bounces-299668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:50:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD368AA7F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:50:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299668-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299668-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30E893019FED
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451A6332EC8;
	Mon, 15 Jun 2026 23:50:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68B211A14;
	Mon, 15 Jun 2026 23:50:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567436; cv=none; b=RqZ5pBE1KYHYgkQSCPjntVKqna1GHFgleVtMT/05pC8bdiCDpQjhxO9ZYaUvSb4/xdhCJJSE+dsKFKi66ALu+DqedMlqbWnNe3X2YKt3D/JhTdgIbd9N+Px1uq1kqu64OaH2djSU2ZxP2Z3yy1RWIx4Nd/FPd/9caDiTgPBK+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567436; c=relaxed/simple;
	bh=zarUAXzA1VjzaAP4jkMzfGD1W8Ao9hpAZEzZHEjGZfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1PWAMKqmGzVNQzxit5UAu9J6EdkgcwUrFvcGlbZaDtNdaz/Ab0YGVJTrKn82MtRxGktpxN6DPUULeoO22l7pY0oOs6tiP6XhhG/sHeQ3t19nrsPt+RuNGpOx6MF4eNwKVZcVCeS1AnxvgMUIEGSs+tveEbeP98cE5FtyN1i5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wZH4U-000000006lY-2qLk;
	Mon, 15 Jun 2026 23:50:26 +0000
Date: Tue, 16 Jun 2026 00:50:22 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: pse-pd: add bindings
 for Realtek/Broadcom PSE MCU
Message-ID: <ajCPvreGRnamixW0@makrotopia.org>
References: <20260612132944.460646-1-jelonek.jonas@gmail.com>
 <20260612132944.460646-2-jelonek.jonas@gmail.com>
 <20260615212959.GA1679454-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615212959.GA1679454-robh@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299668-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:jelonek.jonas@gmail.com,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,makrotopia.org:mid,makrotopia.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CDD368AA7F

On Mon, Jun 15, 2026 at 04:29:59PM -0500, Rob Herring wrote:
> On Fri, Jun 12, 2026 at 01:29:41PM +0000, Jonas Jelonek wrote:
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - realtek,pse-mcu-rtk
> 
> The "rtk" feels redundant.
> 
> > +      - realtek,pse-mcu-bcm
> 
> "brcm" is the standard vendor prefix, so use that instead of "bcm". 
> Though who defined the protocol in this case? Realtek or Broadcom? In 
> the latter case, I'd argue that "brcm" should be the vendor prefix.

The microcontroller firmware, and hence the protocol, is designed
by RealTek in both cases. However, they chose to design two incmpatible
protocol dialects based on the features of the PSE(s) connected to the
MCU.

