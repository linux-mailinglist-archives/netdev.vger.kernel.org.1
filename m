Return-Path: <netdev+bounces-307387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /xCsNXPxVWpQwgAAu9opvQ
	(envelope-from <netdev+bounces-307387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:21:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF4975251B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:21:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307387-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307387-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22F8F3046EEF
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1953F8899;
	Tue, 14 Jul 2026 08:15:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3903F8222;
	Tue, 14 Jul 2026 08:15:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016920; cv=none; b=WWjUgltCnLBTeYPdTtHfL4A7kTHsHJCe7Q8R8gf5y3X6hEnGuxAfLXmGZ1ZA/JQdLnHr7a2+PVKbOQs9gRhJ3RWpI0ClFxSwzl65KRAbT8VuPPgVC7xAJEDGMEGZy9lJal7stwlDZWZJ9tWAmZbqnpPUT3qsBuRGpmsB+8fnNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016920; c=relaxed/simple;
	bh=0upYgGRQu/B38VZchdINsyPj9F703eh+hxbl8OvmROw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWCWwP3QMLBjChRfo3S00WW6hyageafoaY8l3oDShxNFigna2l8w0RfLfUbz0MvVCz949U27m0UYn/b9i2CBR940jDjlhcV1fxY2rkKAwe0Ssb8VR0mh7/m/XL7wWSoGFxqIj94+KZJBPW9P5Xo2OKte4KoIGWicNrNk6w6wGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A5EFF2021FF;
	Tue, 14 Jul 2026 10:15:08 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wjYIG-001jwQ-1u;
	Tue, 14 Jul 2026 10:15:08 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wjYIG-000000091xV-2055;
	Tue, 14 Jul 2026 10:15:08 +0200
Date: Tue, 14 Jul 2026 10:15:08 +0200
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
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v7 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
Message-ID: <alXwDEZsXY90Wh0N@pengutronix.de>
References: <20260712192251.1413279-1-jelonek.jonas@gmail.com>
 <20260712192251.1413279-2-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712192251.1413279-2-jelonek.jonas@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	TAGGED_FROM(0.00)[bounces-307387-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:conor.dooley@microchip.com,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:from_mime,pengutronix.de:url,pengutronix.de:email,pengutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EF4975251B

On Sun, Jul 12, 2026 at 07:22:47PM +0000, Jonas Jelonek wrote:
> Add a binding for the microcontroller (MCU) that fronts the PSE silicon
> on a range of managed Realtek-based switches. The host talks only to the
> MCU, over I2C/SMBus or UART, using a fixed message-based protocol; the
> PSE chips behind it never appear on the bus.
> 
> The device is the MCU together with its Realtek firmware: the firmware
> and its host protocol are what the binding describes, not the
> general-purpose microcontroller they run on. The PSE silicon behind the
> MCU (Realtek or Broadcom) is reported by the MCU and detected at runtime,
> so it is not described here - hence the 'realtek' vendor prefix.
> 
> Two protocol generations exist, both Realtek's, selected by the
> compatible: gen1 on older boards (fronting Broadcom PSE silicon) and gen2,
> the altered protocol used with Realtek's own PSE silicon. On an I2C
> attachment the framing the MCU firmware expects is part of the compatible
> as well - '-smbus' or raw '-i2c'; a UART attachment carries no framing
> suffix, as the transport is given by the parent serial node.
> 
> Each board additionally carries a device-specific compatible that falls
> back to one of the protocol compatibles above. Drivers bind on the
> protocol compatible; the device-specific string identifies the board and
> reserves a place for a future per-board quirk without having to retrofit
> device trees already in the field.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de> 

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

