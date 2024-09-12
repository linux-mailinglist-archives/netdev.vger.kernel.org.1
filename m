Return-Path: <netdev+bounces-127746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4138976510
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1AC1C23153
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E607191F6E;
	Thu, 12 Sep 2024 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="albRcIbb"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A6126C16;
	Thu, 12 Sep 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131567; cv=none; b=hBpVRnWCirCt0xFrtPuyxcFE4NIpeamFdl5GzbHJ4OtMF4NIAB3s/g6arUuqsyNaCmWkHXNkuMNaRkjgt/LyBa5UwN7AbxH6/vAmeAsRubJZe/4y9Ce2oBGiECKGJosx4TaHQzum2EVFAxnD5YMm0cX3nFBYoyoRsjIPhzActs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131567; c=relaxed/simple;
	bh=0OGJJ5q1I2dFwFAloPPPGBlxWK5ysuNhqDO/ggWfpEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNoTPSxeIFSgh2rPPWdHFl0wtxnBSBew5gzJW74kc4d7/LqFMpIL64bbRaqjGquLfKXP6j6F3O5hKvLKcQFmrnJ2FwV0po4OEY/DbIBCOS41Ogk/gGmJLuBIb4qn75xkN/e4rw/bMVAcQagP7+LSzf1s7clkfvFM7R4Lkt3DSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=albRcIbb; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 290091BF216;
	Thu, 12 Sep 2024 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726131563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h41juF0fv68tfOkIEeNBFEnc3OaBWpW2TAzB82HoCMc=;
	b=albRcIbbmrRjds0mCszB3DsLpD2g6x0UCP4z9RiW0xtMaZZW9UoG6NV35qDyOiMkn6GhNR
	XzLlcY82zLKtvf7F6uVhF8doey6jnrioQ58L0rbtNz44IgWc+82/q6tiwCaaEZRpDAk6V/
	Oofy8OoVx8aTAUfztnsSsR2DJBZB9F8yg/kZzhfPvhBUGJ87xrZ+GF0nSAcBWeWxrc25rh
	EJACUwlzkMBe4QXM2AtUdj/zh6WRk9ammtr3SCm9r4O2Bd2aYLhn1LdLA/TXSBi9G2k/LB
	NIddFgZCvG9UB5cpXSbA1+BdNSI/iMpAtoTKOpokMU0IYPsKkVaA5tcaAYd8Iw==
Date: Thu, 12 Sep 2024 10:59:21 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Oleksij
 Rempel <o.rempel@pengutronix.de>, thomas.petazzoni@bootlin.com, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: networking: Fix missing PSE
 documentation issue
Message-ID: <20240912105921.3bf04996@kmaincent-XPS-13-7390>
In-Reply-To: <20240912080929.GD572255@kernel.org>
References: <20240911144711.693216-1-kory.maincent@bootlin.com>
	<20240912080929.GD572255@kernel.org>
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

On Thu, 12 Sep 2024 09:09:29 +0100
Simon Horman <horms@kernel.org> wrote:

> On Wed, Sep 11, 2024 at 04:47:11PM +0200, Kory Maincent wrote:
> > Fix a missing end of phrase in the documentation. It describes the
> > ETHTOOL_A_C33_PSE_ACTUAL_PW attribute, which was not fully explained.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  Documentation/networking/ethtool-netlink.rst | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/networking/ethtool-netlink.rst
> > b/Documentation/networking/ethtool-netlink.rst index
> > ba90457b8b2d..b1390878ba84 100644 ---
> > a/Documentation/networking/ethtool-netlink.rst +++
> > b/Documentation/networking/ethtool-netlink.rst @@ -1801,8 +1801,9 @@ the
> > PSE and the PD. This option is corresponding to ``IEEE 802.3-2022``
> > 30.9.1.1.8 aPSEPowerClassification.=20
> >  When set, the optional ``ETHTOOL_A_C33_PSE_ACTUAL_PW`` attribute ident=
ifies
> > -This option is corresponding to ``IEEE 802.3-2022`` 30.9.1.1.23
> > aPSEActualPower. -Actual power is reported in mW.
> > +the actual power drawn by the C33 PSE. This option is corresponding to=
 =20
>=20
> nit: While we are here, perhaps we can also update the grammar.
>=20
>      This attribute corresponds to...

Yes, indeed. Thanks.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

