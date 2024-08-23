Return-Path: <netdev+bounces-121529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A60595D893
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6431C21A2D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4531925BF;
	Fri, 23 Aug 2024 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oNywLXGy"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7E142E9D;
	Fri, 23 Aug 2024 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448894; cv=none; b=lSf3MA3HAwgPyZfNmFkkHstPo/zU5wgDf3Z/W8SA9pvE/q/cJ5E6mMl5NSUhBvvkHGBNUveKHvO7yHMPtibStIxSRh0NOT/nlkqmbaoiWlXu1pcUZe5UlsSnkiWMJ6/x1jskT2ym8s/UI/5D+JThRL1WkBcPHiRQZbrJUmaYgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448894; c=relaxed/simple;
	bh=Hultl50UUJbQCUdgUDsM+qhzR2FfPnUO6mE5AxXdbDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhriYBdE5bYwru4G/wrQzAxT9cks9Q9NGZwQ3/JlTEnu5AoVuOO9N6M5XKv8v6tcm1p2V0F+UC5AoZbFdRkKj4nWPE6cE2canPbkQGU3HqmE6tBEC8Poe3IWD0zgAMjI8w02aE/hegCFr65im4xRhy9XNOKju+2Hs+Hr8vRZQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oNywLXGy; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E15BCE0003;
	Fri, 23 Aug 2024 21:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724448889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hultl50UUJbQCUdgUDsM+qhzR2FfPnUO6mE5AxXdbDw=;
	b=oNywLXGygpLucMoNcbVonNkG2twll/a/dc3LVBVnK4WnPxnWaLL7OUw/M1UuMH35sa4VMn
	jHMtf9iThTL+P3Dpapazq+p6hwYN+iriDfRkTMcoYAa673+owBNoo4Zg1VKTBuPLYbTbRQ
	rl0rOVuH1PPdKK72YzBx0CPSWJY0PbBEDnaknsJ2sdXqhXObBdcwNA6HR33yx1fKveTxKc
	z0dpSaxe3ROcHbxuZ5jpvO+/Fe4kTx4LC/3F8aF7dy57wm3Bv62Rm86RzM6HBL9vu0pOB8
	JK5Lc0/aUtZ7/9++jGljYlragZP8tUOc82aEXQpZ55zkhu5vHETG2R3UrVHewQ==
Date: Fri, 23 Aug 2024 23:34:46 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "thomas.petazzoni@bootlin.com"
 <thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net: pse-pd: tps23881: Support
 reset-gpios
Message-ID: <20240823233446.6a3662a1@kmaincent-XPS-13-7390>
In-Reply-To: <20240822220100.3030184-3-kyle.swenson@est.tech>
References: <20240822220100.3030184-1-kyle.swenson@est.tech>
	<20240822220100.3030184-3-kyle.swenson@est.tech>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 22 Aug 2024 22:01:22 +0000
Kyle Swenson <kyle.swenson@est.tech> wrote:

> The TPS23880/1 has an active-low reset pin that some boards connect to
> the SoC to control when the TPS23880 is pulled out of reset.
>=20
> Add support for this via a reset-gpios property in the DTS.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

