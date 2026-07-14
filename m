Return-Path: <netdev+bounces-307388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UZ15K4DyVWqpwgAAu9opvQ
	(envelope-from <netdev+bounces-307388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:25:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6EC7525CF
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:25:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307388-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307388-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99AD5301AAB2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC62A3FAE0D;
	Tue, 14 Jul 2026 08:19:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089E3FADFD;
	Tue, 14 Jul 2026 08:19:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017163; cv=none; b=dDi/2eWxYayhobZSByUttfL7VGOMIPySVbtVH44RIW0rCYt/wm7AzMVb0nhsar0Nnole8+TEpii73mKO2yMg4I+QJM+0A3JaBtAHNOxjD+4s8g9tAU4W/eKMf5598wyxZY/TVlGWIIViG/4ClGjkn6FXGtjs2DfiMXdzWTISL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017163; c=relaxed/simple;
	bh=wwKTQi9cpPRih9483MgQ+Lfpv5eTWogqhsMzD1Mu8K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGZWZ4aUCyb3APuVj9/lK43O3oRQbRdfKY8BNKexmX1lAX8u5e7bCvwJnj2cOpLZhZ02ONRmpn/AIQx4PnvHeHQ8XTta3JedB9EkFgWJf3cAolKRwCevfrfv1SeGYu7VSNhGndxWUela1ikJgE7wKfYLKQCQph6ZFFG1YIFhV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 15561202203;
	Tue, 14 Jul 2026 10:19:10 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wjYM9-001jwl-39;
	Tue, 14 Jul 2026 10:19:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wjYM9-000000091z6-3Y9T;
	Tue, 14 Jul 2026 10:19:09 +0200
Date: Tue, 14 Jul 2026 10:19:09 +0200
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
Subject: Re: [PATCH net-next v7 2/4] net: pse-pd: add Realtek PSE MCU core
Message-ID: <alXw_QZfEEKQd5fr@pengutronix.de>
References: <20260712192251.1413279-1-jelonek.jonas@gmail.com>
 <20260712192251.1413279-3-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712192251.1413279-3-jelonek.jonas@gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-307388-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C6EC7525CF

On Sun, Jul 12, 2026 at 07:22:48PM +0000, Jonas Jelonek wrote:
> A range of managed Realtek-based PoE switches use a small microcontroller
> on the PCB to front the actual PSE silicon. The host CPU talks to that
> MCU over I2C/SMBus or UART using a fixed 12-byte request/response
> protocol with a trailing checksum; the PSE chips are managed by the MCU
> and are not accessed directly. Two generations of the protocol exist -
> both Realtek's - diverging in opcode numbering and a few response
> layouts; the driver handles this with a per-dialect opcode table and
> parser hooks for the responses that differ, selected by the compatible.
> The specific PSE chip behind the MCU is detected at runtime and only
> influences per-chip constants (power scaling and the per-port cap).
> 
> This core module implements the protocol, message framing, the dialect
> machinery and the pse_controller_ops glue, and exports a registration
> helper for transport modules. The I2C and UART transports that drive it
> follow in the next patches; the core (PSE_REALTEK_MCU) is selected
> automatically by those transports and is not user-selectable on its own.
> 
> The realtek-pse-mcu-* files and PSE_REALTEK_MCU* symbols match the
> realtek,pse-mcu-* compatibles (see the binding for the naming rationale).
> The two protocol generations - gen1 on older Broadcom-PSE boards, gen2 on
> Realtek's own PSE silicon - are both Realtek's, handled by the same shared
> core, each selecting its dialect via the compatible.
> 
> Power budgeting is left to the MCU firmware; the driver advertises
> PSE_BUDGET_EVAL_STRAT_DYNAMIC (controller-managed budget) accordingly.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

