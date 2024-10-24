Return-Path: <netdev+bounces-138720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D8E9AEA2C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590582813DC
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3175D1C8788;
	Thu, 24 Oct 2024 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aaC+z8Bx"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF95158A31;
	Thu, 24 Oct 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783090; cv=none; b=Gi5sVlykeQt2f8Ev1oPBwH3ygFwHOecFoRISTMujfzKfyaMRBN8kDvYP5pS2y9O983luXJBdhezwMxD/cdefvaOe0zlD12Fcx6FO4DBC4aB2x0ZExITSfSNEJuFBUdyrwLsPyFDeIYW2HS26efSnATtj3MoUsG81S+UtefyMa+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783090; c=relaxed/simple;
	bh=vfBgRDZICdBX7vrh3gWNdMs2YSr3+0qAdG2MPGNRhNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bca8sPa7Eu5vUuqZva/HJPtQCMIpS9Y4Atl1/9naNY3XmKcMRuz+JTBB8VBVV/1lI1Hr38eVI+7LmQVlg/afDuh5H8506f0KTRH8jOtCnJqt1Ix6RPuDhqbpr1q+whnWgBqdT1GHOCPLGVxcGO19wJ4LLcueiu1AD3ULJAkYt00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aaC+z8Bx; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB6B740006;
	Thu, 24 Oct 2024 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729783085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxtvD6UgMPlmvoiFhQH9u7TUGjdN67dBAYP00fGP+aY=;
	b=aaC+z8BxF4avkFVKeWLMEbY0mgSv+vWVLkuZQ9sliwVNLYISTUW0OmtyRpwspLo3lbllKO
	B6bJHNeO4MA0oFuX2xQb3se/97J8iqv4Kc4Mf6G1lsucixXPrkK43FiV4gbnXyIPVV35tb
	mUtgOuBgWonKp+GvSsOoyAAqEXK3IwWjcsRJ6TfOz4yXoQUXt92F4TlJBZQTqPcgCT3M8C
	gemG9wAbBcSVRZ79o3EshmhODXkpsc/mmNulfTxQXQWb8pQiBLqr7eOrz653FaJce9cuGV
	9I/A9uHDc16ZoAW+V3Pu6hTcIeb9FifcDkpwQ25Mv+s0EE7F0HxLkaX+BVefNQ==
Date: Thu, 24 Oct 2024 17:18:02 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, thomas.petazzoni@bootlin.com, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: networking: Add missing PHY_GET
 command in the message list
Message-ID: <20241024171802.4e0f0110@kmaincent-XPS-13-7390>
In-Reply-To: <20241024145223.GR1202098@kernel.org>
References: <20241023141559.100973-1-kory.maincent@bootlin.com>
	<20241024145223.GR1202098@kernel.org>
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

On Thu, 24 Oct 2024 15:52:23 +0100
Simon Horman <horms@kernel.org> wrote:

> On Wed, Oct 23, 2024 at 04:15:58PM +0200, Kory Maincent wrote:
> > ETHTOOL_MSG_PHY_GET/GET_REPLY/NTF is missing in the ethtool message lis=
t.
> > Add it to the ethool netlink documentation.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  Documentation/networking/ethtool-netlink.rst | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/Documentation/networking/ethtool-netlink.rst
> > b/Documentation/networking/ethtool-netlink.rst index
> > 295563e91082..70ecc3821007 100644 ---
> > a/Documentation/networking/ethtool-netlink.rst +++
> > b/Documentation/networking/ethtool-netlink.rst @@ -236,6 +236,7 @@
> > Userspace to kernel: ``ETHTOOL_MSG_MM_GET``                get MAC merge
> > layer state ``ETHTOOL_MSG_MM_SET``                set MAC merge layer
> > parameters ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``   flash transceiver modu=
le
> > firmware
> > +  ``ETHTOOL_MSG_PHY_GET``               get Ethernet PHY information
> >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  Kernel to userspace:
> > @@ -283,6 +284,8 @@ Kernel to userspace:
> >    ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
> >    ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
> >    ``ETHTOOL_MSG_MODULE_FW_FLASH_NTF``      transceiver module flash up=
dates
> > +  ``ETHTOOL_MSG_PHY_GET_REPLY``            Ethernet PHY information
> > +  ``ETHTOOL_MSG_PHY_NTF``                  Ethernet PHY information =20
>=20
> I wonder if ETHTOOL_MSG_PHY_NTF should be removed.
> It doesn't seem to be used anywhere.

We can't, as it is in the ethtool UAPI. Also I believe Maxime will use it on
later patch series. Maxime, you confirm?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

