Return-Path: <netdev+bounces-103928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390D890A613
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAE11C259AB
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 06:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55697186299;
	Mon, 17 Jun 2024 06:45:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C431D53F;
	Mon, 17 Jun 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718606735; cv=none; b=d1iDnWyp8laoUSsWXK1cnTkodXWYk0H8zBFjQBZoPXUyDPyB3y/Wg0cR9BbQxjoHXf5gHqtfPi1SiS03vqiBevvNXulDAVZ3L14/kpW6I8XCVAmVaVs8UdPsX7IXaGLG2blUERIalgLL0wO7Jtr3/jWp5lLY3cPQf0GFzh0meEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718606735; c=relaxed/simple;
	bh=Ci0TzrlHfEibJnpi329gOLvQjHMs5moQmiEVYfUi4Qo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=An48FILRONwCoQBYwGURU+3aLt0s3/wHDgmt7Gbip2wnAuyAS4fOpQxTBenPz4WSsPPnT3fvtiLrLG3C5yY6R6jYluxjvqc7xvaGaG5KZppGuwqRY+8vb+frCs2u5pcvLqhHOscvJ1NmqWIvkBcW+Gc8E7BsuRtKm4HuREd44oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H6ithT72862320, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H6ithT72862320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:44:55 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 14:44:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Jun 2024 14:44:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 17 Jun 2024 14:44:56 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "rkannoth@marvell.com" <rkannoth@marvell.com>,
        "Ping-Ke
 Shih" <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v20 07/13] rtase: Implement a function to receive packets
Thread-Topic: [PATCH net-next v20 07/13] rtase: Implement a function to
 receive packets
Thread-Index: AQHauLd4tRuhQEAKAEKC1qb81QW9fbHEXcqAgAEXKfA=
Date: Mon, 17 Jun 2024 06:44:55 +0000
Message-ID: <5115e5398ce742718a24ec31a0beaff5@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-8-justinlai0215@realtek.com>
 <20240612174311.7bd028e1@kernel.org>
In-Reply-To: <20240612174311.7bd028e1@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Fri, 7 Jun 2024 16:43:15 +0800 Justin Lai wrote:
> > +static int rx_handler(struct rtase_ring *ring, int budget) {
> > +     const struct rtase_private *tp =3D ring->ivec->tp;
> > +     union rtase_rx_desc *desc_base =3D ring->desc;
> > +     u32 pkt_size, cur_rx, delta, entry, status;
> > +     struct net_device *dev =3D tp->dev;
> > +     union rtase_rx_desc *desc;
> > +     struct sk_buff *skb;
> > +     int workdone =3D 0;
> > +
> > +     cur_rx =3D ring->cur_idx;
> > +     entry =3D cur_rx % RTASE_NUM_DESC;
> > +     desc =3D &desc_base[entry];
> > +
> > +     do {
> > +             /* make sure discriptor has been updated */
> > +             rmb();
>=20
> Barriers are between things. What is this barrier between?

At the end of this do while loop, it fetches the next descriptor. This
barrier is mainly used between fetching the next descriptor and using
the next descriptor, to ensure that the content of the next descriptor is
completely fetched before using it.

>=20
> > +             status =3D le32_to_cpu(desc->desc_status.opts1);
> > +
> > +             if (status & RTASE_DESC_OWN)
> > +                     break;

