Return-Path: <netdev+bounces-121530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D59A95D895
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7B11C21B2C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20651940B7;
	Fri, 23 Aug 2024 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QfUy3u6n"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA71BA296;
	Fri, 23 Aug 2024 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448909; cv=none; b=Pqrl4lWBRW/rVz+vNmx58f6TTJD3Lwrk2jygVfrMfgQgsqfiOyJNpWxO6VlSh46R3mm2PxyYAj3sAT7GewsPO4K2QoYv5ZdD6tmnpY8EBWdrZpr4zSu85ohzV5mS4Ca3fYAACEHr7+gEI8IfCM7PXgYxUr9nuT11Qq/8UiE4eSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448909; c=relaxed/simple;
	bh=d8CffSi+4SJNfqPnYWLq4ef6TH0Ej/uoHFg+U9+n9KI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRHjGdAmxwYXDwCU41J6kLgD8IHl2oXeDoN4kJPpvGVZhbInFBl+tTPXi1vp28JYGFfpocHn4YH94QACiPxlDy1A9j7SZWdfFMc4+blQ5c/Ab3kJrblI36zA3N3ZmXVtE76cDwFophlxTEwUMRn/xec2GCn3UL0GBp0kNX8Ep58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QfUy3u6n; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C159B1C0007;
	Fri, 23 Aug 2024 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724448905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQ64TiOpt76SWpWJuyOFeKHuAqg5Gc6IoqAAgchMM8w=;
	b=QfUy3u6nmI0PI58Kwg/EFCLkBgkH8f6Wv6tSNYUY2Dz2j566pzXO8bQsGrBRgMLjxhT2FO
	XBaQgpIPro3NKgUQQUxCVQhG09ooaDpetMdzr13gMvKGwcN9K17xIC6ADAcYHwoNw+gorF
	BNAOdrJ5qmE1wuGqnMWmnjnZD1w+FWhXchdmmhHGY0oNSiG8uobcO/01WLtnrGluBpQuZx
	hmut+dM+QvUqAQaOjkRK6evwFuUrAYh8yrSM+89nOd/FFBkXppn5U2mhg5kln2j2qXQoD6
	tazSJwf0hEIpi8l3MGQgdJGetxigaC7wZo06kip0yDrREHrpQYWKaTDMU1jhag==
Date: Fri, 23 Aug 2024 23:35:01 +0200
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
 <devicetree@vger.kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: pse: tps23881: add
 reset-gpios
Message-ID: <20240823233501.17d61f0e@kmaincent-XPS-13-7390>
In-Reply-To: <20240822220100.3030184-2-kyle.swenson@est.tech>
References: <20240822220100.3030184-1-kyle.swenson@est.tech>
	<20240822220100.3030184-2-kyle.swenson@est.tech>
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

On Thu, 22 Aug 2024 22:01:21 +0000
Kyle Swenson <kyle.swenson@est.tech> wrote:

> The TPS23881 has an active-low reset pin that can be connected to an
> SoC.  Document this with the device-tree binding.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

