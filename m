Return-Path: <netdev+bounces-137000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C736E9A3E88
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874EF285D25
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8126AD9;
	Fri, 18 Oct 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZOE35CuN"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9F18EA2;
	Fri, 18 Oct 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255033; cv=none; b=ItVyWbWxsLS/kPmRFj2M6y+gu1BJKyBwB38MceU9OgHWowanGBgP9frXXxqd5pneGdx9ezbaPSI3ofunTCT7ZhyKMwvuc73Tpjkkkfy59RhT0/nacgtbubSdtK+YdIv2ss488lGj3SYzDGkW7bpHTNl1nfkhLZrkF68Nz5QoAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255033; c=relaxed/simple;
	bh=c9/xjTiiKXugCqvB0Ddy4FxGatdeqMUWidzZme3SiuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZkL/WvF+m7Ax6yfYmlw8FoUDvZsvjMmeR1TWktPop1R8vH2xrmAV2L7N1JJL36q9UazQw/0tptnMlg0bO3IDMvtOoLcfo2vJBh4Tba/yZHdUn4jijos6gYqawWCSKBPqzpoBuEbyrLV7j1NOd/Z0z2IZo03ggzARoqede9RiTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZOE35CuN; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76FC620003;
	Fri, 18 Oct 2024 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729255028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owtQChlN31AVdAEqlGbXxf4xAq96BDAy75fME/ifiAM=;
	b=ZOE35CuNqGn2xMLalISelfAuovirX3aKgmPj5A6bHOf6mP0bah1f6KXYWqj8i4hmgZzVmo
	5OxBdyu04SqU7VHFxpy6vmJTVS26SQm7DHjgm0ApICqzj7JkPrjyOz6gyJbVS9qpxChSMJ
	7L/P2uOTk9k+CWxIobrgpvj5Z+uwo0+pBl9WvYeDKdtnADCk2xogdt8XKZ1n0gCkBz6t3F
	k4d8/YHMwFw43SkGKIlWZzcAj21n0mDqfFrrPGgGAYmo8JI3H1JPNLFhu8ZNgK+W8ooFRM
	j0ynKfGTsl05UFR/aYEIm+02RmPkTUr0OOBJU4o8fMiB4vG/UbmfW5GTHgNRow==
Date: Fri, 18 Oct 2024 14:37:06 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kyle Swenson <kyle.swenson@est.tech>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, Dent Project
 <dentproject@linuxfoundation.org>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>
Subject: Re: [PATCH net-next 00/12] Add support for PSE port priority
Message-ID: <20241018143706.33d49872@kmaincent-XPS-13-7390>
In-Reply-To: <ZxH8wpm_kptHBFQG@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <ZwaLDW6sKcytVhYX@p620.local.tld>
 <20241009170400.3988b2ac@kmaincent-XPS-13-7390>
 <ZwbAYyciOcjt7q3e@est-xps15>
 <ZwdpQRRGst1Z0eQE@pengutronix.de>
 <20241015114352.2034b84a@kmaincent-XPS-13-7390>
 <20241017123557.68189d5b@kmaincent-XPS-13-7390>
 <ZxH8wpm_kptHBFQG@pengutronix.de>
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

On Fri, 18 Oct 2024 08:14:26 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Thu, Oct 17, 2024 at 12:35:57PM +0200, Kory Maincent wrote:
> > On Tue, 15 Oct 2024 11:43:52 +0200
> > Kory Maincent <kory.maincent@bootlin.com> wrote:
> >  =20
>  [...] =20
> > >=20
> > > Indeed we will have only static method for PSE controllers not suppor=
ting
> > > system power budget management like the TPS2388x or LTC426.
> > > Both method could be supported for "smart" PSE controller like PD692x=
0.
> > >=20
> > > Let's begin with the static method implementation in the PSE framewor=
k for
> > > now. It will need the power domain notion you have talked about. =20
> >=20
> > While developing the software support for port priority in static metho=
d, I
> > faced an issue.
> >=20
> > Supposing we are exceeding the power budget when we plug a new PD.
> > The port power should not be enabled directly or magic smoke will appea=
r.
> > So we have to separate the detection part to know the needs of the PD f=
rom
> > the power enable part.
> >=20
> > Currently the port power is enabled on the hardware automatically after=
 the
> > detection process. There is no way to separate power port process and
> > detection process with the PD692x0 controller and it could be done on t=
he
> > TPS23881 by configuring it to manual mode but: "The use of this mode is
> > intended for system diagnostic purposes only in the event that ports ca=
nnot
> > be powered in accordance with the IEEE 802.3bt standard from semiauto or
> > auto modes." Not sure we want that.
> >=20
> > So in fact the workaround you talked about above will be needed for the=
 two
> > PSE controllers. =20
>=20
> For the TPS23881, "9.1.1.2 Semiauto", seems to be exactly what we wont:
> "The port performs detection and classification (if valid detection
> occurs) continuously. Registers are updated each time a detection or
> classification occurs. The port power is not automatically turned on. A
> Power Enable command is required to turn on the port"

I tested reading the assigned class and not the requested class register so=
 I
thought it was not working but indeed it detects the class even if the port
power is off. That's what I was looking for, nice!
Just figured out also that calling pwoff is reseting detection, classificat=
ion,
power policy... So the port need to be setup again after a pwoff.
=20
> For PD692x0 controller, i'm not 100% sure. There is "4.3.5 Set Enable/Dis=
able
> Channels" command, "Sets individual port Enable (Delivering power
> enable) or Disable (Delivering power disable)."=20
>=20
> For my understanding, "Delivering power" is the state after
> classification. So, it is what we wont too.

On the PD692x0 there is also a requested class and power value but it stay =
"to
no class detected value" (0xc) if the port is not enabled.
It did not find a way to detect the class and keep port power off.
=20
> If, it works in both cases, it would be a more elegant way to go. THe
> controller do auto- detection and classification, what we should do in
> the software is do decide if the PD can be enabled based on
> classification results, priority and available budget.
>=20
> > > Both methods have their pros and cons. Since the dynamic method is not
> > > always desirable, and if there's no way to disable it in the PD692x0's
> > > firmware, one potential workaround could be handling the budget in
> > > software and dynamically setting per-port limits. For instance, with a
> > > total budget of 300W and unused ports, we could initially set 95W lim=
its
> > > per port. As high-priority PDs (e.g., three 95W devices) are powered,=
 we
> > > could dynamically reduce the power limit on the remaining ports to 15=
W,
> > > ensuring that no device exceeds that classification threshold. =20
> >=20
> > We would set port overcurrent limit for all unpowered ports when the po=
wer
> > budget available is less than max PI power 100W as you described.
> > If a new PD plugged exceed the overcurrent limit then it will raise an
> > interrupt and we could deal with the power budget to turn off low prior=
ity
> > ports at that time.  =20
>=20
> > Mmh in fact I could not know if the overcurrent event interrupt comes f=
rom a
> > newly plugged PD or not. =20
>=20
> Hm..  in case of PD692x0, may be using event counters?

Counters? I don't see how.

> > An option: When we get new PD device plug interrupt event, we wait the =
end
> > of classification time (Tpon 400ms) and read the interrupt states again=
 to
> > know if there is an overcurrent or not on the port. =20
>=20
> Let's try Semiauto mode for TPS23881 first, I assume it is designed
> exactly for this use case.

Yes,

> And then, test if PD692x0 supports a way to disable auto power delivery
> in the 4.3.5 command.

I don't have this 4.3.5 command. Are you refering to another document than =
the
communication protocol version 3.55 document?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

