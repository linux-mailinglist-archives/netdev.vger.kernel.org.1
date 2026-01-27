Return-Path: <netdev+bounces-253900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOoJCgjFeGmltAEAu9opvQ
	(envelope-from <netdev+bounces-253900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:00:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8599546D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64C0530071C5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BDB28506B;
	Tue, 27 Jan 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="chwXyPWs"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624D273D6D
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522434; cv=none; b=CPdFuInko16tPlLQkLm1bMWylCbcHLn4I2hn1sDJV08xv2oK7vqovQmYha/2Ndby+Cuf+5flhyae79xvNxloAdHqq0pVsjoYCL+ODZ7Xp566plf23p4lrQUutLSjOG8MiCn9NDXM0V8o8AAssXWJ2uUu3nGHH5neh65LZs7m7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522434; c=relaxed/simple;
	bh=/5FfgyAdosHdBT1b123g13uZi6IHnNn03tcX5V+ewtU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxZwoWxp0ASE5z7L+72tzI5D4IwxcOgINwLphZqqTEsGtpDVfEIhwz1S3NShA4LanBODyIlTWb1nWV7aQXI2nJcE5QJ7OlbYl7da5Bw2fm5BjTUu0gM4SrJtPW/hTOGDqWspuRbnciui2/+Pc4WvXWsKdYH+GIXMU00RWqp4NY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=chwXyPWs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 04D3A1A2A84;
	Tue, 27 Jan 2026 14:00:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CABC0606F5;
	Tue, 27 Jan 2026 14:00:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D74ED119A8647;
	Tue, 27 Jan 2026 15:00:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769522428; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4lr25nY6IL51iDXgjm6f6IhgJAGpDYmSPe/X2e4d0jw=;
	b=chwXyPWsLw2x3VIXhVoBBAfMA7/Xa6IDDfoYEDE/mXTJzmCFFurkwjDqhohiBgiUX/Wlyr
	43UfNZz7CmnWlw6gvvTSIwu4BnMcbF6knWSFqp2jKsKVCb3P1PeQNBo+l84F5WjXSPOIGM
	HxZv5Rkp+jy59EJoBHFtHuR5npB8iSq6OeP72c/hD4L1wpszMsZ04I03rjEoHe41Q7+Z/q
	Vz2rm03uLNglFWQsF1Ej5lMnBo/16yeH4KJyHPSSI3ITV5AiQSFca97P8RLn5TgXf5GLDG
	lDKD3Z1JPFaBjP+JgF/whHhoCUE4Zuc/cu5biWMA2l1tfMe5vD+6C53wYf8SLg==
Date: Tue, 27 Jan 2026 15:00:21 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org, Romain Gantois
 <romain.gantois@bootlin.com>, Daniel Golle <daniel@makrotopia.org>, Dimitri
 Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next 01/13] net: phy: phy_port: Correctly recompute
 the port's linkmodes
Message-ID: <20260127150021.110a0ddc@kmaincent-XPS-13-7390>
In-Reply-To: <20260127134202.8208-2-maxime.chevallier@bootlin.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
	<20260127134202.8208-2-maxime.chevallier@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253900-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Queue-Id: 9A8599546D
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 14:41:49 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> a PHY-driven phy_port contains a 'supported' field containing the
> linkmodes available on this port. This is populated based on :
>  - The PHY's reported features
>  - The DT representation of the connector
>  - The PHY's attach_mdi() callback
>=20
> As these different attrbutin methods work in conjunction, the helper

Typo here:           ^^^^^^^^^

> phy_port_update_supported() recomputes the final 'supported' value based
> on the populated mediums, linkmodes and pairs.
>=20
> However this recompute wasn't correctly implemented, and added more
> modes than necessary by or'ing the medium-specific modes to the existing
> support. Let's fix this and properly filter the modes.
>=20
> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

It is the only fix of the series, maybe you should send it standalone?
Else this seems ok to me.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

