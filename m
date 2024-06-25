Return-Path: <netdev+bounces-106417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956FC91622B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85191C20852
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A052014901B;
	Tue, 25 Jun 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jkcgxjnk"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100D1487D4;
	Tue, 25 Jun 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307121; cv=none; b=EnjTAcPQYTahj6eFm54YE0isgY+yHf/bUB63yC9wl9G+2VXmV6+l99C2cFQ7qtRoIqe139mx3thWcWo787co6yZlKGGiI99TdrgPkSHKRHKJd1AYdgk2+LId1liXbGpPPejUPf3DyLAl6docqZfIGHFODx1+1oUsFcY0iEV3PVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307121; c=relaxed/simple;
	bh=1xqAQHWbzICfxgNx7YwCU+Aj1fsEs+QoGFjs4+S6ZSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sovhVsp8dviM7oN83IbGzZ+qU4ENtlmDCXoiK11FC5B/BDRJ3YAACwHPoU9I9O6O28aVPgm2O/amgXc5DIf+cJpUYz6RNrpV/HEfgsxNYzNOxtEqKWM3J0frjkjfDvGXs+bDzVMXhnFZ/dYlCeVHfe7VUkIDGp3N8B8soexGP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jkcgxjnk; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E18F60010;
	Tue, 25 Jun 2024 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719307117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xqAQHWbzICfxgNx7YwCU+Aj1fsEs+QoGFjs4+S6ZSo=;
	b=Jkcgxjnk7MmbVkny6C4cpqPx3YuY6VrucIDcP64sDg0S6U60207gwPwCJd6AWD7toluPYf
	azkURzKWCbDOiIIHYdBt3484d67+KJqcFqcTRu4iEGPeu8EZnsO6jYCYFqfvw2CIakm6Ex
	UkuLe2clkkexMtP6ik7O5OJHzh5ec3W4lZZKQ4UqdLGOefyWbxef2iqv5Z/atWspnXOF4O
	UIevRwNitYqgumXfupmAkZw8q2mkfU4KZlR3EF/t/J9EYTrPlkh5CaSXh3bFnWEFaESQlh
	rkFzG2zdBKhSClaBzJylED/dCtBKcp9dZKPsI6n/8v+P8yo1nVaNMld7Dz8Jzw==
Date: Tue, 25 Jun 2024 11:18:35 +0200
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
Message-ID: <20240625111835.5ed3dff2@kmaincent-XPS-13-7390>
In-Reply-To: <ZnCUrUm69gmbGWQq@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
	<20240614-feature_poe_power_cap-v3-1-a26784e78311@bootlin.com>
	<Zm15fP1Sudot33H5@pengutronix.de>
	<20240617154712.76fa490a@kmaincent-XPS-13-7390>
	<ZnCUrUm69gmbGWQq@pengutronix.de>
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

Hello Oleksij,

On Mon, 17 Jun 2024 21:55:25 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

>=20
> > > The difference between open and underload is probably:
> > > - open: Iport =3D 0, detection state
> > > - underload: Iport < Imin (or Ihold?), Iport can be 0. related to
> > > powered/MPS state. =20
> >=20
> > Should I put it under MPS substate then? =20
>=20
> If my understand is correct, then yes. Can you test it? Do you have PD
> with adjustable load?

In fact I can't test it, I have a splitter and an adjustable load, not a
splitter that can adjust it's own load. So I can't decrease the load of the
splitter itself and reach this error condition.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

