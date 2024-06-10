Return-Path: <netdev+bounces-102194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9E6901CE3
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB811C20355
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D9E5FBB1;
	Mon, 10 Jun 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SilQ93qf"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06E23B0;
	Mon, 10 Jun 2024 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008032; cv=none; b=a8RyirUqLcIZwoMVrRcwwChoAgxZw7mdaDnq3fsi0eCJPyZhyGRZ52gwfCt8WnYso1Awk5rIbx1Pqw7cGf5ZB5n6J19/2j/YaED/ju9reU6G71gSOPM3j/qYbiMHKafApR2EOQe15lk4oNdI6Xor9POMmiPcW+yJ3p3chLZeAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008032; c=relaxed/simple;
	bh=peNE9WghVFJ53LTT04oeeh7PiP05qmSgztBlTCMdvRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7hUFOnOtgR8hsqfetF3MLfg/XXgkHxCNbOZUBqrAAqmNdUnkyg/x8FyYc06lmthM4goMoHhnmRe2vLD1XxxNpp7FP9XHYZhq4A4lJAEehXp7YsMbIhRPcWMmU1A3Vf3uG+kK1grft+kQVOTpApLLTvd/1/TIwHC3Rw33Kd3/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SilQ93qf; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E36FFF809;
	Mon, 10 Jun 2024 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718008021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cs5fBvfGnXv3uJdz7evFmMOBKnqDQNaZOnxPokg8sp0=;
	b=SilQ93qfnfOKuNQ4tSa8K9Me3P6SpCNiQPpS8qRYgPS67zKcJk/3IpDOBgBh75qB/Ds4jY
	pTxSR73ffkrwpnip2sqVhg6OTxktGi/INLNZhAnrnVN880TR/i5a9DUJ48f088/mIqvByC
	ZIZZRQ5zlNBO5bkQeFLeV4kHqo0Z2Evby+kukTXwgXFpogC3N90xDUb0cPSqI2/2d1wvEJ
	z3ecyW7wQaW3O8e+1ylVWY9PoeTay6ueM8Yj5EV44u77WqxWW+Lx2EkRByQZdmV8nfU53n
	Ltu5D2LtxsJKtQpfCZPsbRqYUkSCSQDUnszOKQQccys/ts58mBrIoGBmf6iQgQ==
Date: Mon, 10 Jun 2024 10:26:59 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next v2 1/8] net: pse-pd: Use EOPNOTSUPP error code
 instead of ENOTSUPP
Message-ID: <20240610102659.06a3bebf@kmaincent-XPS-13-7390>
In-Reply-To: <ZmaMwrnUx-sqabFs@pengutronix.de>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
	<20240607-feature_poe_power_cap-v2-1-c03c2deb83ab@bootlin.com>
	<ZmaMwrnUx-sqabFs@pengutronix.de>
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

On Mon, 10 Jun 2024 07:18:58 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Fri, Jun 07, 2024 at 09:30:18AM +0200, Kory Maincent wrote:
>  [...] =20
>=20
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
>=20
> This patch can go directly to net as fixes.

Ok, I will resend it to net.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

