Return-Path: <netdev+bounces-118399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83AB951793
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F1C1F24288
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF01448E3;
	Wed, 14 Aug 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DxpdjdW6"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3F13BC26
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627287; cv=none; b=ejoH+IXUR4vRmk4hGmH7fB/Ny8bEKaNQkH+Z96s8SKWyVKHmWPiYkx4M2DtIWL5Riim1VqN0siKKJceehyfsgwzYvzfQugFm5T4gl8zEP5Q5eRmSTIa0+CEEWKc7ZnNlnRtFJV4U6scoMOHtxbRSXQGzDfHlBFuRLl717ndi+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627287; c=relaxed/simple;
	bh=AD04k68EGCHS+2N2Jj3XK/H0i3kvkx4lc5og0YKKCo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0JmMtELrUIwVTrkKxRgsx2Mj5sTZXHkQ673SD74/ffbZcz5v6cAY3UzfNoESwsQAzX+prJCCFsb8l+O4H++G4MaTZesePJv5XpDRR8gzBQT9DQEV4ipeMmw+9crj9oR2Aj7ehz0FkxiiJg45dxP+rppQG+zNY6fQaGUyHJUHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DxpdjdW6; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C05CC0005;
	Wed, 14 Aug 2024 09:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723627283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HOIP+bc4JRVpfm5f+xWWCMNYVamfNUhRMz6lFfTIWM=;
	b=DxpdjdW6FIujvJlqQXduNa3iF1HhRjYv7FIFIagQTAlOPfTrUuI6M5SLE28UtEtu2Hwyo7
	uCrbiIS+iCRJ/+GSRNAeyVxW9AGRJ8/AxNlCYe9rVqwE9lKPB0UCJzurWqWMYC9Wwy00Xd
	7nYWXBd/7QBsNcNmn/UpeXoZWfbL1iBIxRDd4LTP/Psh7ehl5CPaltpeNSXmr0vrdvhWXt
	wxwGw03SJY6EKFDYC+l7VWmd6RrVoOflGYqTGRHty9ABXkO9jAClVKYKcDt/a2gOSqmpzk
	63tgD6UVRW6aKbFrlBluMUH0L293MX/eUrw3CO4xhTQN2XsymRFdvux+FX3DLg==
Date: Wed, 14 Aug 2024 11:21:20 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kyle Swenson <kyle.swenson@est.tech>, "o.rempel@pengutronix.de"
 <o.rempel@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "thomas.petazzoni@bootlin.com"
 <thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: pse-pd: tps23881: Fix the device ID
 check
Message-ID: <20240814112120.7598c876@kmaincent-XPS-13-7390>
In-Reply-To: <20240812084159.79e5baf3@kernel.org>
References: <20240731154152.4020668-1-kyle.swenson@est.tech>
	<20240810234556.4e3e9442@kmaincent-XPS-13-7390>
	<20240812084159.79e5baf3@kernel.org>
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

On Mon, 12 Aug 2024 08:41:59 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sat, 10 Aug 2024 23:45:56 +0200 Kory Maincent wrote:
> > > The DEVID register contains two pieces of information: the device ID =
in
> > > the upper nibble, and the silicon revision number in the lower nibble.
> > > The driver should work fine with any silicon revision, so let's mask
> > > that out in the device ID check.
> > >=20
> > > Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller dri=
ver")
> > > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>   =20
> >=20
> > Hello Kyle,
> >=20
> > In net subsystem when you send a fix you should use net prefix instead
> > of net-next. Jakub, does Kyle have to send a new patch or can you deal =
with
> > it?
> >=20
> > Thanks for your fix!
> >=20
> > Reviewed-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Ah, I'm pretty sure I already applied this. kernel.org infra has been
> quite unreliable lately. Commit 89108cb5c285 ("net: pse-pd: tps23881:
> Fix the device ID check"), indeed in net.

Ah right, thanks! I didn't received the merged notification email.
Sorry for the useless noise!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

