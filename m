Return-Path: <netdev+bounces-261032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOhXCeQwn2lXZQQAu9opvQ
	(envelope-from <netdev+bounces-261032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:27:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF07819B86D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15B54302812F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7033E95A0;
	Wed, 25 Feb 2026 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HzYUjOyF"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9403C1998
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040388; cv=none; b=V/x6lsPrXxgg8zPfp45zQZShHQZkiwv2lXSm+IZKh9a6beecvgij1bwmgLnrhIR+yhrA9T3a2FQlO+4MzFik9ez/yItqSarwt5Hh1MsC0tr0WcK81fO536SBcUxbwIrfwVitBZprg3qPxwt+worWAoX5EtIeRntsWbAJ1xNxAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040388; c=relaxed/simple;
	bh=UmdTQClr1pULDmqMGb5f+LS5+AK8dDvtRsL+IlTAoHM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=FkqMqparLhcKcjc3Z0KNt+sBmLVGT1emRswSP4b/a82F19RKhHzcGgv7ymPTwgTdknGz7ASfteVu2svY1SVRx5zFMnQf6f8kZ6c7dvbnz2bCPx2EKUGmyVhDQha283i5dItxGFZU9lN9bffS9lvnf+vLCTWy9jD2vONKqN6PKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HzYUjOyF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4E3554E41120;
	Wed, 25 Feb 2026 17:26:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1DE7F5FDE6;
	Wed, 25 Feb 2026 17:26:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49B711036877D;
	Wed, 25 Feb 2026 18:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772040383; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m1vtsF3XMJo71wczcGDODMTs6FQu9Mm3AEjpc+6c3Ew=;
	b=HzYUjOyFn1yVjHTD1UrLPm22OMJ2EpetOFLIOkBs3IJvLDdD1682M81inR6KRawd7Z3edf
	ejaerzTiunaAGfNk30C6kE2/iZ7gPoE1HulfVxoMWRQQgIbKbfnpD+ytX07p9Ko1arYI+j
	JcPTDTReIzP3prLbW94qkDpEDZnW6R57IJIx2yh9Qi4hDWx4TMgbN9VJ3+Tbv+OTDWp1jA
	2VTn/+uVaDvVu92iJt6OqCu+G2aQoFaurWEMAhnhR1b1G1s3mmPG46Ejaz3Pl8NHip0i6Q
	fldc4aRbE07nTUh0gwbLP2kb56358K5MxkzKIbCY7KiFUIt+ZpdWquFq4Plpgw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Feb 2026 18:26:18 +0100
Message-Id: <DGO7VZMIEFXR.1XGID5EK3Y72A@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 1/5] net: cadence: macb: add EEE register definitions
 and capability flag
Cc: <andrew+netdev@lunn.ch>, <claudiu.beznea@tuxon.dev>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <nicolas.ferre@microchip.com>, <pabeni@redhat.com>,
 <linux@armlinux.org.uk>, <phil@raspberrypi.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260225091558.51157-1-nb@tipi-net.de>
 <20260225091558.51157-2-nb@tipi-net.de>
In-Reply-To: <20260225091558.51157-2-nb@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261032-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.973];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Queue-Id: AF07819B86D
X-Rspamd-Action: no action

Hello Nicolai,

On Wed Feb 25, 2026 at 10:15 AM CET, Nicolai Buchwitz wrote:
> Add register and bitfield definitions for the Cadence GEM MAC's
> IEEE 802.3az Energy Efficient Ethernet (EEE) support:

nit: could this patch be squashed into [3/5]?

> - LPI statistics counter registers (GEM_RXLPI, GEM_RXLPITIME,
>   GEM_TXLPI, GEM_TXLPITIME) at offsets 0x270-0x27c
> - TX LPI enable bitfield (GEM_TXLPIEN) in the NCR register (bit 19),
>   which directly asserts/deasserts LPI on the transmit path
> - MACB_CAPS_EEE capability flag to gate EEE support per platform
>
> These registers are present in all Cadence GEM revisions that support
> EEE (verified on SAMA5D2, SAME70, PIC32CZ, and RP1 variants).

Would the capability flag deserve to be added to any other compatible?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


