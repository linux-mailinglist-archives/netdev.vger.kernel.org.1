Return-Path: <netdev+bounces-159618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74CA161B5
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 13:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE2B188616B
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1CB1DE88D;
	Sun, 19 Jan 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="foLLB4aw"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68DF19B59C;
	Sun, 19 Jan 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737290732; cv=none; b=IYzTmMLvjx1IBVNfxbkTl45JKo2GzAZKfLMbVWIHYrC0dd/2/TzXc0p6TeaBhMVI6FSUl/2t7v2LUpu/AV7GsXJXvbPgd4V+iUlqJYocAp62BipjzFSbCjma62947G3UgXY6Xt+8/YqbR9s/2OEI2wn7Z3dtiE7PXP+18bbzZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737290732; c=relaxed/simple;
	bh=x4wivaWf6I0ktW7jEoCYJP2pHiyBNHPzOASrFrJjkkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUdlvIh5iY+X/fV8eMlQKeGwI0DekJjy7L9IS9LcUIEaN2oP/mvqKaxbMK+sBvEk7C5eMZUPmz2iMU92DhXxWHqolmrGSt+CJC65Q77FxyitAcPOVZnoOuSF3Wq9Qz4q95Wju6lOxq50x6l76+hH32IR3W6XXDFvLmVTv5Mym3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=foLLB4aw; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1268360002;
	Sun, 19 Jan 2025 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737290722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtKwkP0oVsmhscsOb3Goor2ToIWReZv5BHVFBp9j69k=;
	b=foLLB4awRJdXZuFh9VGAwrTntAgDwyFI3k6Jlv2PLXdRVvlFIGNC4BU1w6yZLvY5X4ibbe
	ilJu1qvolvbT/6I1JpI60qU39aQivd2WHbHyVyu5i2mfgQgCQ0pWgIi+hHFFwTzWwYQVHf
	xm2rH9dVhcPhNqkv/QdxXUUTGUSpJqsS6vOugXtWR+YukB1z8B/TkCbooK2F3xvupR+ZEd
	Wno7Bb6yKvfEFYmrGnmQN6QkLclbmkW+ZwqGqfqTVLTxgs20TSUAaAFfZnx2wJeyUXXBGu
	TXHVBqjSnR+I9Tog0RG/aIdgzpbEyZWd4J9Pk+KVMk6F3vxFuA3hUZVVhtyHAQ==
Date: Sun, 19 Jan 2025 13:45:18 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <20250119134518.6c49d2ca@kmaincent-XPS-13-7390>
In-Reply-To: <20250117190720.1bb02d71@kernel.org>
References: <20250117173645.1107460-1-kory.maincent@bootlin.com>
	<CANn89i+PM5JLdN1meKH_moPe88F_=Nsb3in+g-ZK5tiH4PH5GA@mail.gmail.com>
	<20250117231659.31a4b7fa@kmaincent-XPS-13-7390>
	<20250117190720.1bb02d71@kernel.org>
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

On Fri, 17 Jan 2025 19:07:20 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 17 Jan 2025 23:16:59 +0100 Kory Maincent wrote:
> > > If not protected by RTNL, what prevents two threads from calling this
> > > function at the same time,
> > > thus attempting to kfree_rcu() the same pointer twice ?   =20
> >=20
> > I don't think this function can be called simultaneously from two threa=
ds,
> > if this were the case we would have already seen several issues with the
> > phydev pointer. But maybe I am wrong.
> >=20
> > The rcu_lock here is to prevent concurrent dev->hwprov pointer modifica=
tion
> > done under rtnl_lock in net/ethtool/tsconfig.c. =20
>=20
> I could also be wrong, but I don't recall being told that suspend path
> can't race with anything else. So I think ravb should probably take
> rtnl_lock or some such when its shutting itself down.. ?

Should we add an ASSERT_RTNL call in the phy_detach function? (Maybe
also in phy_attach to be consistent)
Even thought, I think it may raise lots of warning from other NIT drivers.
=20
> If I'm wrong I think we should mention this is from suspend and
> add Claudiu's stack trace to the commit msg.

Ack.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

