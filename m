Return-Path: <netdev+bounces-47031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC97E7A8D
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A731C20BCA
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2D510A12;
	Fri, 10 Nov 2023 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WcN6uEqQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD34CA44
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:18:48 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9772BE05;
	Fri, 10 Nov 2023 01:18:44 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BEDE2FF803;
	Fri, 10 Nov 2023 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699607923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlHs147ceVaFirZwP9qhanL87eStUsCEVWoYX0Pd7Pw=;
	b=WcN6uEqQTLiAg07Mww8Xh5wguLtukWcC1ATSbprEnegZPropbKOUss8DiJHoGmsJvQBpEI
	zyoZrTY/WSNPOwcVUyEApnCxqYU3O1WpHqBni9wTioYN8nNwT50hm6ooD0A/P0ZiuSz2zW
	+tUJlWFOymHBmdii+dH/kzSUpysOob9N6ugznEBd1m/GXe2TXP+QPtwlWWyPJtCrKR+qvL
	JeMA+j07lGMHEPap/tJo4LYlAt8zDwy/HK7eDPcr6GzATnFKEA5/5BMifUEOclER4I+2YJ
	iC/sI4oItUB8DxR9KMjus/qAjn/R8eCtHEE0czSfgbXJZB5ZqTBtHmH/rK6jAw==
Date: Fri, 10 Nov 2023 10:18:41 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy
 support
Message-ID: <20231110101841.27aba547@fedora>
In-Reply-To: <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
	<20231108113445.24825-2-quic_luoj@quicinc.com>
	<20231108131250.66d1c236@fedora>
	<423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
	<20231109101618.009efb45@fedora>
	<0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 10 Nov 2023 16:53:39 +0800
Jie Luo <quic_luoj@quicinc.com> wrote:

> On 11/9/2023 5:16 PM, Maxime Chevallier wrote:
> > Hello,
> >=20
> > On Thu, 9 Nov 2023 16:32:36 +0800
> > Jie Luo <quic_luoj@quicinc.com> wrote:
> >=20
> > [...]
> >  =20
> >>> What I understand from this is that this PHY can be used either as a
> >>> switch, in which case port 4 would be connected to the host interface
> >>> at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
> >>> speed would be limited to 1G per-port, is that correct ? =20
> >>
> >> When the PHY works on the interface mode QUSGMII for quad-phy, all 4
> >> PHYs can support to the max link speed 2.5G, actually the PHY can
> >> support to max link speed 2.5G for all supported interface modes
> >> including qusgmii and sgmii. =20
> >=20
> > I'm a bit confused then, as the USGMII spec says that Quad USGMII really
> > is for quad 10/100/1000 speeds, using 10b/8b encoding.
> >=20
> > Aren't you using the USXGMII mode instead, which can convey 4 x 2.5Gbps
> >   with 66b/64b encoding ?
> >=20
> > Thanks,
> >=20
> > Maxime =20
>=20
> Hi Maxime,
> Yes, for quad PHY mode, it is using 66b/64 encoding.
>=20
> it seems that PHY_INTERFACE_MODE_USXGMII is for single port,
> so i take the interface name PHY_INTERFACE_MODE_QUSGMII for
> quad PHYs here.

I see, when I added the QUSGMII mode I wrongly stated that it came from
the USXGMII spec where it really comes from USGMII, my bad.

> can we apply PHY_INTERFACE_MODE_USXGMII to quad PHYs in this
> case(qca8084 quad PHY mode)?

=46rom what I can see, the USXGMII mode in the kernel is used as the
single-port 10G mode of usxgmii. You might need to create a new mode
for quad usxgmii at 10G, the spec calls it 10G-QXGMII I think, but as
the spec defines quite a lot of modes, should we define all of them or
rely on some other parameters to select the actual mode ?

Andrew, Heiner, Russell, what do you think ?

Maxime

> Thanks,
> Jie.


