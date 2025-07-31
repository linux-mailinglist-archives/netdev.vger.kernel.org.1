Return-Path: <netdev+bounces-211172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F3AB17000
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C745E7B70E9
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1B2BE63E;
	Thu, 31 Jul 2025 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="IfWXYmTd"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF92BE63A
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959377; cv=none; b=KMI81A1zo33YQDYIofuf/QGTx/BwGOrnDVOj24NpX9rtQSjDDpvVr/8xwE0N4OFHuOCaGpnDJIdDACI64yDpi1j1HZvOIZ2rDHGFcYJSzO9LkpS3GwcDic9iayE5mMMLAgCHFgOD38t2V5BgaxIteNJgp9K0d/QdvPGvq36Q2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959377; c=relaxed/simple;
	bh=Gwgnmzv4ubboh42Qb+JpdVuH69nmgA4/YAdMQxCwGuQ=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=T1JFP3knkb7fo4JkSyMpk6mJviR/wbVSMDfLbnp5s3BRFGe7jgfe+pSYYYftxroiDe154pVOvxbceH893S9WDu3GTCDTTWP242xdqGtRVdri9fcKqUDdHgd+qYzmU/g2h9cN/aIR/XTz+FYFmw7CBZYAhLlV76gzkFVcEoBuSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=IfWXYmTd; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753959341; x=1754564141;
	i=markus.stockhausen@gmx.de;
	bh=IB4PxUN8lePNZVeQXn4gC/b+Eu3tYIImfuGnVW2f0As=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IfWXYmTdfnc09YUyuRrBvQwon1cZG8DFU7xg+fNrNTuIICzYhSZ7hgjdTOH+Tsj4
	 tEAiwqDmxUZ48vSUU4xC0UyVoUNhct9LOvesZ+PYWdtKad+gAsLY9RE+nZEldJYf6
	 yklT+Uwwe/TBs6fC+U6pHPtsETuZD1HcpT6No1oGje1Q45/BKfYmDC3AvTEmih0ld
	 q0kTq9Qiuv/dAceuF7NdJzvtxRuvkvWYPyWAmyEns2hYEUt8tL8aSYA/FTJqlDJJU
	 dFRBqF6xUolk8nsgK2t1sq9v/uxBC6PB/KckuavjfNbDneRayqZPlm+01PLdlOGsv
	 TAVGO649uL4jY9Mreg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv2xO-1uPu3x1LpQ-014uph; Thu, 31
 Jul 2025 12:55:41 +0200
From: <markus.stockhausen@gmx.de>
To: "'Heiner Kallweit'" <hkallweit1@gmail.com>,
	<andrew@lunn.ch>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<michael@fossekall.de>,
	<daniel@makrotopia.org>,
	<netdev@vger.kernel.org>,
	<jan@3e8.eu>
References: <20250731054445.580474-1-markus.stockhausen@gmx.de> <d0e1c087-f701-402e-b842-3444fbce7f27@gmail.com>
In-Reply-To: <d0e1c087-f701-402e-b842-3444fbce7f27@gmail.com>
Subject: AW: [PATCH v2] net: phy: realtek: convert RTL8226-CG to c45 only
Date: Thu, 31 Jul 2025 12:55:40 +0200
Message-ID: <059901dc0209$a817de50$f8479af0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQFPCO6TL5FzOL/6Ie5b5z8UBtRI6QKWq+NCtVFFFcA=
X-Provags-ID: V03:K1:ElS6yjPyNWhop+3gqtsCIsnhqAw9CFEfCgNpELP1kQmOyhKP2SL
 Z4folTFdubRHbIfcG73oCZ7GVEIgJYNIyqGI1tfFQmsC5ub40afLafxq+iujdZUKKiiWHyE
 84It6XMt7nbi6RUau5ar+jfzXojx8doLwkh1hwUdUoyfzD/gQjmdFF2X3sR6o9fem7QUci/
 6S8c4qhRiY0NwPuqMpxmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tPYemmL22X4=;r7dZ5/rTCJuVlUHuDLkJUPRBXaA
 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
 8Vppop+pEPCSutoarydmdsS4gQ8oAojg=

Hi Heiner,

> Von: Heiner Kallweit <hkallweit1@gmail.com>=20
> Gesendet: Donnerstag, 31. Juli 2025 12:25
>
> On 31.07.2025 07:44, Markus Stockhausen wrote:
> > The RTL8226-CG can be found on devices like the Zyxel XGS1210-12.=20
> > These are driven by a Realtek RTL9302B SoC that has phy hardware=20
> > polling in the background. One must decide if a port is polled via =
c22 or c45.
> > Additionally the hardware disables MMD access in c22 mode. For=20
> > reference
>
> For my understanding: Which hardware disables c22 MMD access on =
RTL8226 how?
> RTL930x configures RTL8226 in a way that is doesn't accept c45 over =
c22 any longer?

sorry to be not clear about this. We have rtl9300 mdio driver
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree
/drivers/net/mdio/mdio-realtek-rtl9300.c?h=3Dv6.16

This must decide how its four smi busses are configured. Either c22=20
or c45. https://svanheule.net/realtek/longan/register/smi_glb_ctrl=20
So it does.

	/* Put the interfaces into C45 mode if required */
	glb_ctrl_mask =3D GENMASK(19, 16);
	for (i =3D 0; i < MAX_SMI_BUSSES; i++)
		if (priv->smi_bus_is_c45[i])
			glb_ctrl_val |=3D GLB_CTRL_INTF_SEL(i);
	...
	err =3D regmap_update_bits(regmap, SMI_GLB_CTRL,
				 glb_ctrl_mask, glb_ctrl_val);

As soon as this bit is set to one mode the bus will block most
accesses with the other mode. E.g. In c22 mode registers 13/14
are a dead end. So the only option for the bus is to limit access
like this.

	bus->name =3D "Realtek Switch MDIO Bus";
	if (priv->smi_bus_is_c45[mdio_bus]) {
		bus->read_c45 =3D rtl9300_mdio_read_c45;
		bus->write_c45 =3D  rtl9300_mdio_write_c45;
	} else {
		bus->read =3D rtl9300_mdio_read_c22;
		bus->write =3D rtl9300_mdio_write_c22;
	}

Markus


