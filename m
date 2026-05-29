Return-Path: <netdev+bounces-293035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNqpI2VGGWrHuAgAu9opvQ
	(envelope-from <netdev+bounces-293035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:55:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A4C5FEDAF
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BED8F30F093C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF193A3E78;
	Fri, 29 May 2026 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KjmIZrLW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1AE1C860A;
	Fri, 29 May 2026 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040810; cv=none; b=Gz5e2SET4MiGPr1YbGMmW1wcVflqTdaOhVEGrlSYYRTjMUwWq8vHn2BU4HdXmuei9wX9F1YWsmuDmY2qfyyL9jLuNvg9bMcDo4rkSZRCzfS2AwMKd6OsnMBQwxM92PdRtvu71gU6YKAjYzqeVc8w+dMsCMDcyVaYOscMvFtWles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040810; c=relaxed/simple;
	bh=HQYKgt8fOz7gmZSQMa2vpCxt+Zpzmx1pngyO8Rnp5w8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=lfh/bUKdNnjwxqJ1NixyAbocARKIWdz6xwswV227tpNfsseEa9NRHpPsAeFxk9uEvegLjdxFtwcgtRjeeG9g4u5avHNJPNoqsAEAni9ueHQ4G54rDtReEPrHaua0SUyBGLO4GScytZKgSZoXBpHVTesThMttNUehl+qt6qEOoQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KjmIZrLW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1545B1A3718;
	Fri, 29 May 2026 07:46:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC731601FA;
	Fri, 29 May 2026 07:46:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1F4D10888CC3;
	Fri, 29 May 2026 09:46:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780040806; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c024gKKjc1BP6uOHzo7JwDhVMobKmBODDZE59zQhr2g=;
	b=KjmIZrLWYMuBX5Ryi0sbKhJ6S0YIpXtTli22Qoe9K29ZjXJm+VJASuKQN5LUGreAwA3TZY
	58Q0hGSxsZmfypZBHd6JdJB6RJoUCdtZnZuitD4hGpbWe2+jBLG8LUsyoWnR9oWsedJ8Fa
	5lATLDUktJL7FNVjtB1eK9zHycaSx/is+nVhZhp/N0CBo6LCH/OIJomqKX88B8JWB7yPe1
	bmjk95lkXiDl/sTME/LvC9yhlJVIw1rZfdhqtC5vFHJNp1HKhYDO5VBziMEJ4wnPtJ8wRb
	aWeYjyirFWL5DeA3Kavh8LIBoRXNJjRcOZ2W69/WWZNRItY4xIJRBiPDeUFG4g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 09:46:40 +0200
Message-Id: <DIUZSUI8A5G2.E4D5YUXOWX95@bootlin.com>
Subject: Re: [PATCH net-next v2 3/3] net: macb: add TX stall watchdog to
 recover from lost TCOMP interrupts
Cc: <netdev@vger.kernel.org>, "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rpi-kernel@lists.infradead.org>
To: "Andrea della Porta" <andrea.porta@suse.com>, "Lukasz Raczylo"
 <lukasz@raczylo.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1777064117.git.lukasz@raczylo.com>
 <20260514215459.36109-1-lukasz@raczylo.com>
 <20260514215459.36109-4-lukasz@raczylo.com> <ahhom_0PJtqnXsv5@apocalypse>
In-Reply-To: <ahhom_0PJtqnXsv5@apocalypse>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293035-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F0A4C5FEDAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu May 28, 2026 at 6:08 PM CEST, Andrea della Porta wrote:
> Has this patch seen a V3 version? I guess the only thing it's needed
> is something like this:
>
> static void macb_tx_timeout(struct net_device *dev, unsigned int txqueue)
> {
>         struct macb *bp =3D netdev_priv(dev);
>         macb_tx_restart(&bp->queues[txqueue]);
> }
>
> and then setting .ndo_tx_timeout =3D macb_tx_timeout in macb_netdev_ops.

Agreed! (pointed out here, with more details)
https://lore.kernel.org/netdev/DIK002QFFNBY.31C3KUX2SQC6W@bootlin.com/

s/txqueue/q/ to respect the driver's traditions.

Sadly at91ether_netdev_ops cannot have macb_tx_timeout because code is
too different.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


