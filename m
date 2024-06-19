Return-Path: <netdev+bounces-104722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFB90E207
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 05:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23531F23A83
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFBE55897;
	Wed, 19 Jun 2024 03:40:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBE224D2;
	Wed, 19 Jun 2024 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768459; cv=none; b=BNi8Nfc6IGCoO9bgolFVB872vEYtSmWfwklyoeD5l5AJp/klRoNliOGSWfSRUo0SMvgtJbqLwnl6JirWHi8AkCcmf6ItxiRKvFQAhzWWFqPdpZjk9XE6K7xvn5UsqVH7631PO5qdfj6FMe+QobYPza3KL4K+6hnU8Zb23UpC4uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768459; c=relaxed/simple;
	bh=smx124TsvoGd+rE0yDwyDbvv+GbhbRqkfdzvbEQC/Ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hfwUWORn+IiVYiUI5eew5Zjoq2ne1l5X17m/l22TN29vz3a9XFz1YVYz6O3nIFpyp//5WilHHwXq2guQOfWGP5aRXricbvw098Ui8fE5Mqjj4TQN5IoXnKrO1dmwUUCgQLkZLd4H4zlbDiGWFRbwrFYNT/MjretkHzxmodCYzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45J3eNnfD1257487, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45J3eNnfD1257487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 11:40:23 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 11:40:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 19 Jun 2024 11:40:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 19 Jun 2024 11:40:23 +0800
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
Thread-Index: AQHauLe4t8TnjFOscEGW3MirT25lzrHEW4aAgAC1QoCABoiNAIABjjwg///3WQCAAWQUoA==
Date: Wed, 19 Jun 2024 03:40:23 +0000
Message-ID: <6e1e735cde474cb38b5ff4c6fa17c2c3@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-11-justinlai0215@realtek.com>
	<20240612173505.095c4117@kernel.org>
	<82ea81963af9482aa45d0463a21956b5@realtek.com>
	<20240617081008.1ccb0888@kernel.org>
	<0dbefc7d70b4453c9a280a0a63a7c89b@realtek.com>
 <20240618072430.4ff15980@kernel.org>
In-Reply-To: <20240618072430.4ff15980@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

>=20
> On Tue, 18 Jun 2024 07:28:13 +0000 Justin Lai wrote:
> > > Are you basically saying that since its an error it only matters if
> > > its zero or not? It's not going to be a great experience for anyone
> > > trying to use this driver. You can read this counter periodically
> > > from a timer and accumulate a fuller value in the driver. There's
> > > even struct ethtool_coalesce::stats_block_coalesce_usecs if you want
> > > to let user configure the period.
> >
> > As we've discussed, as long as this counter has a value, it can inform
> > the user that the host speed is too slow, and it will not affect other
> > transmission functions. Can we add this periodic reading function
> > after this patch version is merged?
>=20
> You'd have to remove reporting of all 16b packet statistics and 32b byte
> statistics completely for now, and then follow up adding them with the
> periodic overflow checks.

Thank you for your reply, I will remove the 16b packet statistics and 32b
byte statistics report in this version.

