Return-Path: <netdev+bounces-225424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F5B9396B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149CC2A08A3
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0E92FF650;
	Mon, 22 Sep 2025 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2y+TLRap"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B4E253F07
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584042; cv=none; b=E5w/MzVO94xth+Sc9sJjK/ZqMgFL3NJxLfPn60Q9Jr07RIS+mPYiegagArSkx9txtW4MPlJcwmGbMyRQYsnBX9QFLOVay3LRw3J308AQf/ON/AjFzJPQJWO7liZz0TNSSk+EPMOgb25n0U33LOLofxKgKHGC0scoIeK2gVPvLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584042; c=relaxed/simple;
	bh=LhPuL9sG3C8zlI8IcIwj4dNxj3q1GjMeZApYiKxUmOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfFefVPUfQMzvlpG9AHIYTAfZo3hvGHpqr9sLuTRlUkqxghiNKKb+XAc6Th3EU1jgU9w2PR6zUO0E3O6JlCQhQb7OrUltPzoCwgNABW8upb3RdgFD/HJY29JgAOnMQtM52elIRi2rjFzuxflZ57xqDSX2DN5au/HtopzceyW/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2y+TLRap; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 221B1C01FAE;
	Mon, 22 Sep 2025 23:33:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDE2560635;
	Mon, 22 Sep 2025 23:33:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C406A102F1877;
	Tue, 23 Sep 2025 01:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758584036; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LhPuL9sG3C8zlI8IcIwj4dNxj3q1GjMeZApYiKxUmOo=;
	b=2y+TLRap1pN3HRdoKgD6Zk4og08A79Jne/wlePbE2xwEZ63s2OK2TBJ1q/GuzMb5XynQSv
	0fJTNL1FTuC8cSk+UrP9ndtsQl9gxHn1cWvIPlISQrPiBmOMc+qtgdsrpKSIVh9XB1v4xl
	lbyFPybQ+rdU8nmlG6P7QMucJzaPiZiMzWORdK7oh4v8RSA3Kat6X+LvIYOOgStylihgNS
	p5Q9wdGSoK8qs6Gqyb35TpwVDGtbx/z6V/RsDG5BvyXTujLR4cSdBweBQnwiz4fm9EYgDH
	CV0WAQXfXqeZEJtsu9LuiZlfTt8139tAGLEvbNOINYHs9fcfqkigIJ71s8sElg==
Date: Tue, 23 Sep 2025 01:33:48 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "Y.B. Lu"
 <yangbo.lu@nxp.com>, "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Frank Li <frank.li@nxp.com>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: enetc: use generic interfaces to get
 phc_index for ENETC v1
Message-ID: <20250923013348.62f44bba@kmaincent-XPS-13-7390>
In-Reply-To: <PAXPR04MB8510ABEC85E704D1289A0E098811A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250918074454.1742328-1-wei.fang@nxp.com>
	<20250918124823.t3xlzn7w2glzkhnx@skbuf>
	<20250919103232.6d668441@kmaincent-XPS-13-7390>
	<PAXPR04MB8510ABEC85E704D1289A0E098811A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 19 Sep 2025 08:48:57 +0000
Wei Fang <wei.fang@nxp.com> wrote:

> > > It looks like we have a problem and can't call pci_get_slot(), which
> > > sleeps on down_read(&pci_bus_sem), from ethtool_ops :: get_ts_info(),
> > > which can't sleep, as of commit 4c61d809cf60 ("net: ethtool: Fix
> > > suspicious rcu_dereference usage").
> > >
> > > K=C3=B6ry, do you have any comments or suggestions? Patch is here:
> > > =20
> > https://lore.kern/
> > el.org%2Fnetdev%2F20250918074454.1742328-1-wei.fang%40nxp.com%2F&d
> > ata=3D05%7C02%7Cwei.fang%40nxp.com%7Cca70608eb6c9487d98e108ddf7571
> > de6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63893867571474
> > 2481%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA
> > uMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
> > C%7C&sdata=3Dh6rMPPxArsYdoPOz95UZRU88Oz9IJ3sD6lRjqC5SHMU%3D&reser
> > ved=3D0
> >
> > This is annoying indeed. I don't know how this enetc drivers works but =
why
> > ts_info needs this pci_get_slot() call? It seems this call seems to not=
 be
> > used in ndo_hwtstamp_get/set while ts_info which does not need any hard=
ware
> > communication report only a list of capabilities.
> > =20
>=20
> The ENETC (MAC controller) and the PTP timer are separate devices, they
> are both PCIe devices, the PTP timer provides the PHC for ENETC to use, so
> enetc_get_ts_info() needs to get the phc_index of the PTP timer, so
> pci_get_slot() is called to get the pci_dev pointer of the PTP timer. I c=
an
> use pci_get_domain_bus_and_slot() to instead to fix this issue.
>=20
> I do not know whether it is a good idea to place the get_ts_info() callba=
ck
> within an atomic lock context. I also noticed that idpf driver also has t=
he
> same potential issue (idpf_get_ts_info()).

We can change the device providing the PTP (currently between MAC or PHY),
that's why we need to acquire the rcu lock to avoid any pointer change duri=
ng
the get_ts_info callback which could cause an use after free issue.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

