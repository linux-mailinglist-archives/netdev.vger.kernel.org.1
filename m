Return-Path: <netdev+bounces-307390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8xXEC670VWplwwAAu9opvQ
	(envelope-from <netdev+bounces-307390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:34:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D0D752727
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:34:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307390-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307390-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 073EE300A5AD
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8470E3FADFD;
	Tue, 14 Jul 2026 08:34:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E0E2FD7D3;
	Tue, 14 Jul 2026 08:34:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018082; cv=none; b=O3mJeiqqW5DvV4sHgr68sABf4mAzbqSW/A4FSI1Bijb9BD1RDKc8QtlRjKowiLGfNOSrZ9pJ4jnitUmrM5WMJtZTzmZK6odQYBpAXVuFKx2oc9Os6LiDrvsHrtUVTHm5yrX3Q3Qb7br7/Z4y2Qlr5qXA4zRo0GdXRinW8PSDD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018082; c=relaxed/simple;
	bh=nAw5WXfDYrIiKxb6xntrpoofY6Sl50zOilEzOa/JhTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2NLhr6H17mhUW2VYN6CWK211VonSMNqsE9+GlRHUsIa7u9SbamnaJ0ttvNRnjPPbOdf4Zy6Yqt9PMCOwGLssjpFBh/gNnc59zlVzaStXlFQu8L3nymn/gFocFLolkO0caG+T1owj4+lqppVvTyMjiXDnPPEehHowA896UJSHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4D672201A03;
	Tue, 14 Jul 2026 10:34:27 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wjYax-001k2o-0k;
	Tue, 14 Jul 2026 10:34:27 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wjYax-000000092BP-0TJa;
	Tue, 14 Jul 2026 10:34:27 +0200
Date: Tue, 14 Jul 2026 10:34:27 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v7 3/4] net: pse-pd: realtek-pse-mcu: add I2C
 transport
Message-ID: <alX0kwfhFuxlJDdw@pengutronix.de>
References: <20260712192251.1413279-1-jelonek.jonas@gmail.com>
 <20260712192251.1413279-4-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712192251.1413279-4-jelonek.jonas@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	TAGGED_FROM(0.00)[bounces-307390-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pengutronix.de:from_mime,pengutronix.de:url,pengutronix.de:email,pengutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21D0D752727

On Sun, Jul 12, 2026 at 07:22:49PM +0000, Jonas Jelonek wrote:
> Add the I2C/SMBus transport for the Realtek PSE MCU core. It registers
> the MCU on an I2C bus and provides the send/recv callbacks the core
> uses to exchange the 12-byte frames.
> 
> The MCU firmware expects one of two framings on the I2C bus, and which one
> is part of the compatible: '-smbus' (reads carry a leading command byte
> and a repeated start) or raw '-i2c' (bare block writes and reads). The
> match data flags the raw-I2C case; SMBus is the default because that's
> what the majority of devices uses.
> 
> Because i2c_master_send()/i2c_master_recv() may DMA, the raw-I2C path
> bounces each frame through a heap buffer rather than the core's stack
> buffers; the SMBus path is unaffected.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

