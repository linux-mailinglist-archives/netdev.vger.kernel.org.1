Return-Path: <netdev+bounces-124556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A9F969FAC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253FA1F25342
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D001383A5;
	Tue,  3 Sep 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b="T8IavOfe"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ACE364BC;
	Tue,  3 Sep 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372084; cv=pass; b=NEiKFyPq1iEDJg7xnFJry7QmFstWZrZsvHjT+AiPC9UaGcm5D1sictIbjcNOp/f37Qyvz7s688w39hbcGv3jmG4wOYXWqwzK80AX6ZDZPna9GSM3o62tp/hazzABsZEKXhfc2pBC/mgEZzeO2z/47D8Mn3+/s2R0pUd3ju5vQGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372084; c=relaxed/simple;
	bh=DgKxU7ymeyfOn8smC+a1eI8FG8Ya+bjC3XbwIbFlPW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=heMtNGEA17mjfMXzZgkFz2HCgJbany7HnSv02fY41u6U1xOjcJaR/bKz4QHeW+m6KEIBJRHrqZVQEEGTCxnr9TQrVeSVlQHXTx8Xd0zjjbWOQPmxVuum2TZ75mlRy1Fju9uDxXYxhEAH2s7+iGGe6TqWmNHUex8O4KYCRxn9r14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b=T8IavOfe; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725372052; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jRDM+URDR9uwOmWNvoFX5gNWeDHB2mlFa8lxqT5+BqHKd5gH1/ET2RzteklqT6gUMllBtOnEKhbEXHgilyIoHCQS4o6rJtcpsAEDJ2jjzTs18whMloAbBjib3A4W+fKLOhoyQqDwCbMZuPHm31ElMQoPX9srIRJvbSnqQg3xsx8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725372052; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=B3X7/BScnuaQ5QIic6vas4I7lF55wl7Aex0QV6b1zjA=; 
	b=FtWnMeyyyw1il1g48Jw+eZyB+f1o+5udDFtzZAihGuvA/wvnbgrNKLAowasYLX3P8juVlvEYPeiEBXTRt6fR/PENQi3apZ5s4PRh4sJoFOQKydTT2SpIjFmWVtFhpZi2jXrx8hbE/bL3clhV0VqagEHKwj0Qzu71X+7kXMrb8qI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=martyn.welch@collabora.com;
	dmarc=pass header.from=<martyn.welch@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725372052;
	s=zohomail; d=collabora.com; i=martyn.welch@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=B3X7/BScnuaQ5QIic6vas4I7lF55wl7Aex0QV6b1zjA=;
	b=T8IavOfespJk1awZh/FhBdD7tDA9xoyNL+wYPwGUCA5+9q17wAaoCmpZwuKEWbhg
	1PvlP4tsy53JIKD+DvvQpIxrcobF1//jNwBd4xtncM/dmXtB/3Hb/fGWOBSlYlO7Ts9
	jTcpxM0PNYYam5SWT7OfDiCP4faZFAXHr+u2z4aM=
Received: by mx.zohomail.com with SMTPS id 1725372050874491.02003731810225;
	Tue, 3 Sep 2024 07:00:50 -0700 (PDT)
Message-ID: <c47861dae9d339b9033ed71c45160009a7464888.camel@collabora.com>
Subject: Re: [PATCH] net: enetc: Replace ifdef with IS_ENABLED
From: Martyn Welch <martyn.welch@collabora.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Claudiu Manoil	
 <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Sep 2024 15:00:47 +0100
In-Reply-To: <ecd830fe-28a8-4995-b4d3-fa4e5312b305@linux.dev>
References: <20240830175052.1463711-1-martyn.welch@collabora.com>
	 <ecd830fe-28a8-4995-b4d3-fa4e5312b305@linux.dev>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2024-09-02 at 10:21 +0100, Vadim Fedorenko wrote:
> On 30/08/2024 18:50, Martyn Welch wrote:
> > The enetc driver uses ifdefs when checking whether
> > CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This
> > works
> > if the driver is compiled in but fails if the driver is available
> > as a
> > kernel module. Replace the instances of ifdef with use of the
> > IS_ENABLED
> > macro, that will evaluate as true when this feature is built as a
> > kernel
> > module.
> >=20
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > ---
> > =C2=A0 drivers/net/ethernet/freescale/enetc/enetc.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
> > =C2=A0 drivers/net/ethernet/freescale/enetc/enetc.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> > =C2=A0 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 2 +-
> > =C2=A0 3 files changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 5c45f42232d3..276bc96dd1ef 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -977,7 +977,7 @@ static int enetc_refill_rx_ring(struct
> > enetc_bdr *rx_ring, const int buff_cnt)
> > =C2=A0=C2=A0	return j;
> > =C2=A0 }
> > =C2=A0=20
> > -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> > +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
> > =C2=A0 static void enetc_get_rx_tstamp(struct net_device *ndev,
> > =C2=A0=C2=A0				union enetc_rx_bd *rxbd,
> > =C2=A0=C2=A0				struct sk_buff *skb)
> > @@ -1041,7 +1041,7 @@ static void enetc_get_offloads(struct
> > enetc_bdr *rx_ring,
> > =C2=A0=C2=A0		__vlan_hwaccel_put_tag(skb, tpid,
> > le16_to_cpu(rxbd->r.vlan_opt));
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> > +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
> > =C2=A0=C2=A0	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
> > =C2=A0=C2=A0		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
>=20
> I believe IS_ENABLED can go directly to if statement and there should
> be
> no macros dances anymore. You can change these lines into
> 	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
> 	=C2=A0=C2=A0=C2=A0 priv->active_offloads & ENETC_F_RX_TSTAMP)
>=20
> The same applies to other spots in the patch.
>=20

Thanks, v2 on the way....

Martyn

