Return-Path: <netdev+bounces-106454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6179166C1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9922928CD17
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788D114D28C;
	Tue, 25 Jun 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VR7qrcUR"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F614A0BD;
	Tue, 25 Jun 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316771; cv=none; b=oOv6sT3zUajGsTCZl465lgl/BZzxNNs/7or/ua/69z4ppFBPYsvffKrUC/lLd2/ijgKD5kCLlZiW1hIzbP9ilazkbf7rRAOk/F5IMP4QmQeX6lmfwdBgDMu/BRV4Hf7jVblrqYpaaAohF9NgFtp6O+k+eDCqchpu5gdaU7YJ4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316771; c=relaxed/simple;
	bh=QahEkLu9TC7Ijt9CJgc7loymkbNQEbP54b1wEkKu14k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHwvmCTMIKiB2MY3V/Ovli2eEgK7C7+jSyQnSh9r9p5jL0YODU0FhyZ0ZpmbTMSpAX/yox4bh80+TaZLdO5AklOEoCrAkYmgxcqonff6PW1M2DIHMeQ6lhg1xOhW1wUYC6k2/nOcusc/ywbv9rKJBSAPJCct9UH7ZVC69Axewkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VR7qrcUR; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E78CF240008;
	Tue, 25 Jun 2024 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719316760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bymOF6q/GmNuK/4tr2qlAhNMY7OYSXYN+52K4/jUKz4=;
	b=VR7qrcUREdOYnveWozg5HRW4txUj8aV6OxBVLDVv5zFe34TYSp7r91HfgwVWFAQoWjHctd
	ybQ31jFGiro1WO3mNfSDxUscZ6IDXJGElPOSkeSMJgn/phaZsuEc2alKGgER5b6XtZQXZA
	wCrcAx5KVzYTujOxFY4y8el4n5OswhpNiTG8/jgJWe3GiEVuOVLqJch/NOFTzYcfzpzpWQ
	DMU4T+hMxyS6U36FbtzZ+VIBhIrbKXcSWlYqyGAbUzUyM5lzk6B5hAFwEMYZ2B8niQLk75
	czn68yC2CgoPRNn+SPL1lboPIsod8ZdEDFBYTBypQ5hIor5fbgwLRHdKk34EbQ==
Date: Tue, 25 Jun 2024 13:59:18 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <20240625135918.65f71c1e@kmaincent-XPS-13-7390>
In-Reply-To: <ZnqdDmvy0YLqk6Ih@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
	<20240614-feature_poe_power_cap-v3-1-a26784e78311@bootlin.com>
	<Zm15fP1Sudot33H5@pengutronix.de>
	<20240617154712.76fa490a@kmaincent-XPS-13-7390>
	<ZnCUrUm69gmbGWQq@pengutronix.de>
	<20240625111835.5ed3dff2@kmaincent-XPS-13-7390>
	<ZnqdDmvy0YLqk6Ih@pengutronix.de>
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

On Tue, 25 Jun 2024 12:33:50 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi K=C3=B6ry,
>=20
> On Tue, Jun 25, 2024 at 11:18:35AM +0200, Kory Maincent wrote:
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> >=20
> > In fact I can't test it, I have a splitter and an adjustable load, not a
> > splitter that can adjust it's own load. So I can't decrease the load of=
 the
> > splitter itself and reach this error condition. =20
>=20
> Hm.. how about this setup:
> ------>>-----x--------->>---- =20
> PSE          |-load      splitter
> ------>>-----x--------->>---- =20
>=20
> Attach the load directly to the ethernet line after PSE did
> classification with splitter. Then remove splitter. As long as load is
> high enough, PSE will not turn the port off. Then reduce load until it dr=
ops
> below the threshold.

That was a good idea but I can't managed do test it.
This is what I try:=20
                       /---ethernet cable---PD
PSE=3D=3D=3Dpassive splitter=3D+
                       \---barrel cable---load

The active PD is well powered with PoE negotiation but there is no voltage =
at
the barrel cable of the passive splitter so the load is useless. :/ Maybe
passive splitter works only with passive injector.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

