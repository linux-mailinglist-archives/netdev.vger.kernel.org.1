Return-Path: <netdev+bounces-133511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC1399625C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601D52822BB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412AC185923;
	Wed,  9 Oct 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mID/6cel"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6323178CC5;
	Wed,  9 Oct 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462336; cv=none; b=fGxPACfSEnDr++x3lAMquO07/F/z29jGbHZ03CyvArek1HiTkBNybQ/X+1z2QeCDK3wYxZJFT2GFGns5s+uH/DTCUKG6+eHycigYsfa0hueAOwp169NBPlpkrESQVE6tQferRR9XPHSa8HBMbbB7LtVfYnTioqKJJ3vAIj44AH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462336; c=relaxed/simple;
	bh=UxNnh2WzJ8CLTLei4znEPmYJnr+OQynZNUK60qagLRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgM3pYzomtNBeNYAfVUsi9023f7WsNBCtenLNgcxB7yix94xUuWdDPyjxWKC/BDmgBWqJWSz0JbsfnPjHOQXEBFN/59RGtmUTFFq3rVe1YE39Kv6MJheJ2Z2sYnW/jj/wpxkrtV6+JpOTqsbseNP3tLH35mqHs3+Dza/DXmlI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mID/6cel; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0711E20004;
	Wed,  9 Oct 2024 08:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728462331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZHV98coS7hPa6Orw7gMJo2fGrkTDHuf4Kv65CNkK/Y=;
	b=mID/6celJW3fnQf3g20HfFs4LLTrKAspxVdfjHEQRInXes6a03Dkj5a+piX2QNWiPJiy+E
	Y5NxGeDoF3kPKZsGxb+NMNnMI51lrdNnZeJ44aqdMysqcam2ULIrbP+jLbF1Wfj3G8yfGH
	OWLz1xuV+vSR4QXgqT4wU2+xfJUea5W3SSjy0IOqcPgZfu1k3CP1oe0MjDb5ziGFMj2Hnz
	gi/NGOs5PILuacyHdRfOX06lYNTN7WFVfQDPp1u0SIVPfmMpL0Z8DdIiXSngSLaqbSn5as
	YaXbqOqRuxzjxF8enim2PT7ms2d7dVbN6YZ3QPvlARvgeGiHa5N2x1WYFsZ8TA==
Date: Wed, 9 Oct 2024 10:25:26 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next 12/12] net: pse-pd: tps23881: Add support for
 PSE events and interrupts
Message-ID: <20241009102526.0db933f2@kmaincent-XPS-13-7390>
In-Reply-To: <ZwYv1qunWpqhC9IH@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-12-787054f74ed5@bootlin.com>
	<ZwYv1qunWpqhC9IH@pengutronix.de>
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

On Wed, 9 Oct 2024 09:25:10 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> > +
> > +	if (val & (TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_IFAULT << 8)) {
> > +		ret =3D i2c_smbus_read_word_data(client, TPS23881_REG_FAULT);
> > +		if (ret < 0)
> > +			return PSE_FAILED_RETRY;
> > +
> > +		val =3D (u16)(ret & 0xf0f);
> > +
> > +		/* Power cut detected, shutdown low priority port */
> > +		if (val && priv->oss)
> > +			tps23881_turn_off_low_prio(priv); =20
>=20
> Sorry, this is policy and even not the best one.
> The priority concept is related to the power budget, but this
> implementation will shutdown all low prios ports only if some
> port/channel has over-current event. It means, in case high prio port
> has over-current event, it will be not shut down.
> =20
> I'll propose not to add prio support for this chip right now, it will
> need more software infrastructure to handle it nearly in similar way as
> it is done by pd692x0.

Yes, I have expected some debate around this support.
I was not sure of the policy while developing it.
Ok, let's remove it for now.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

