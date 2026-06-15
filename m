Return-Path: <netdev+bounces-299385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a9kBBXLIL2piGQUAu9opvQ
	(envelope-from <netdev+bounces-299385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:40:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BDC685213
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:40:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299385-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299385-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2223303282E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968C33DB319;
	Mon, 15 Jun 2026 09:39:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24B3D9680
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 09:39:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516385; cv=none; b=DRWTmrmVnVsfdXUUuFrr52DPqBzazx/y+G0/YzWQaBfF6IoVt+E4pFi/GnS3CHLkw/SMHByw/9WQshOb/20SQTwONlutyVR5nBQMcXSgCJBbyaP0JAPkQIH4eV09NYu3/aYLTRzqb5cYhDXwG2duyDxNlkNkEIRce8jlSaYHADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516385; c=relaxed/simple;
	bh=x75oxlQn2awWT9/NZxh+u45lCUQYq+UJ7N/Fuf4rw4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbthsr5Z9uYLoDZHyLtYE/wvtZg+DOnJts7/qFRm3iW3pPdmgJlvCUnZMectAG3xRjzSRDV102nczZfCO/CDX8Ht1fNJfJumku5Hpx34ddrs7o0eicrPyF3F4owK20OYNjbF9o9o1hq9RbNwz35yLCCGmg8j+XmzEyFwdw2Omvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wZ3mx-0008GM-Ey; Mon, 15 Jun 2026 11:39:27 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wZ3mu-002qHT-2Z;
	Mon, 15 Jun 2026 11:39:24 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wZ3mu-00000006HGh-2mTL;
	Mon, 15 Jun 2026 11:39:24 +0200
Date: Mon, 15 Jun 2026 11:39:24 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: jelonek.jonas@gmail.com, kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, bjorn@mork.no
Subject: Re: [PATCH net-next v2 2/2] net: pse-pd: add Realtek/Broadcom PSE
 MCU driver
Message-ID: <ai_ITHd_xxt7an4q@pengutronix.de>
References: <20260612132944.460646-3-jelonek.jonas@gmail.com>
 <20260615090733.739423-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615090733.739423-2-horms@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299385-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:jelonek.jonas@gmail.com,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,makrotopia.org,mork.no];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,pengutronix.de:mid,pengutronix.de:url,pengutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50BDC685213

Hi Jonas,

On Mon, Jun 15, 2026 at 10:07:33AM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

It probably sounds scary, but sashiko finds not all issues in one time.
Bigger patches and more different included frameworks - increase findings
probability a lot. With other words, it may more rounds than expected.

You may optimize it if you have access to some free or payed tokes,
by using sashik-cli with LLM of you choice as backend.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

