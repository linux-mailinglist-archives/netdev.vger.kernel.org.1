Return-Path: <netdev+bounces-104385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FE90C48B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 09:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EE028337E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283AB13C3D2;
	Tue, 18 Jun 2024 07:28:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484DA13B596;
	Tue, 18 Jun 2024 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695738; cv=none; b=imVZfYZ6KhaBvyhT2gLMvTYuq1U8y/6fMbjuEGFDgG8jjyctIVIzPFd1F+SEfJp4StVoFhWeiOlHE5yfHCLg61MQZdjYj9+xAbB5fd+u2W7HZYeKeXr3wglJGgTfWGgCwouBHv4NapM6x9cCUeN1QnN+x61P/FGZjS5CgY2I+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695738; c=relaxed/simple;
	bh=qJirdEIAFM4Hjt8STJKfaHRB+2vC10MfFWAojXZjLSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N2oR4bzzo1nPQ5Os148tvZbitP3hGmW5gO6l/C4Ee7nihbr2/9XVdweYSlGQf6PDfV+Epf28VzD0GLWFntckRBH/XdDZyBBjnS1hQITUg0YwcSNqXf43aUpAJC2bm4fc5pv6jo1RLlpb/GgJMMpyli4GWKk62YVXo2K0BF2f64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45I7SDtaC178362, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45I7SDtaC178362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 15:28:13 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 15:28:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 18 Jun 2024 15:28:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 18 Jun 2024 15:28:13 +0800
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
Subject: RE: [PATCH net-next v20 10/13] rtase: Implement ethtool function
Thread-Topic: [PATCH net-next v20 10/13] rtase: Implement ethtool function
Thread-Index: AQHauLe4t8TnjFOscEGW3MirT25lzrHEW4aAgAC1QoCABoiNAIABjjwg
Date: Tue, 18 Jun 2024 07:28:13 +0000
Message-ID: <0dbefc7d70b4453c9a280a0a63a7c89b@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-11-justinlai0215@realtek.com>
	<20240612173505.095c4117@kernel.org>
	<82ea81963af9482aa45d0463a21956b5@realtek.com>
 <20240617081008.1ccb0888@kernel.org>
In-Reply-To: <20240617081008.1ccb0888@kernel.org>
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

> On Mon, 17 Jun 2024 06:54:59 +0000 Justin Lai wrote:
> > > Are you sure this is the correct statistic to report as?
> > > What's the definition of rx_missed in the datasheet?
> >
> > What we refer to as rx miss is the packets that can't be received becau=
se
> > the fifo in the MAC is full. We consider this a type of MAC error, iden=
tical
> > to the definition of FramesLostDueToIntMACRcvError.
>=20
> Is this a FIFO which silicon designers say can't overflow?
> Or it will overflow if the host is busy and doesn't pick up packets?
> If it's the latter I recommend using stats64::rx_missed_errors.
> That's the start we try to steer all NIC drivers towards for "host
> is too slow".

Our fifo falls under the second situation you mentioned, and we are
currently already using stats64::rx_missed_errors. Therefore, we will
remove the parts that use FramesLostDueToIntMACRcvError.

>=20
> > > Also is 16 bits enough for a packet counter at 5Gbps?
> > > Don't you have to periodically accumulate this counter so that it doe=
sn't
> wrap
> > > around?
> >
> > Indeed, this counter may wrap, but we don't need to accumulate it, beca=
use
> > an increase in the number of rx_miss largely indicates that the system
> > processing speed is not fast enough. Therefore, the size of this counte=
r
> > doesn't need to be too large.
>=20
> Are you basically saying that since its an error it only matters if
> its zero or not? It's not going to be a great experience for anyone
> trying to use this driver. You can read this counter periodically from
> a timer and accumulate a fuller value in the driver. There's even
> struct ethtool_coalesce::stats_block_coalesce_usecs if you want to let
> user configure the period.

As we've discussed, as long as this counter has a value, it can inform
the user that the host speed is too slow, and it will not affect other
transmission functions. Can we add this periodic reading function
after this patch version is merged?

