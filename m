Return-Path: <netdev+bounces-97284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB98CA7F3
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 08:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2DDB20FD0
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 06:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010E23F8F1;
	Tue, 21 May 2024 06:20:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEF219ED;
	Tue, 21 May 2024 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716272445; cv=none; b=fnI8/BsAxSsPYwSyAjkEnJj0HYi2OFCPJVsq08NZ99u38XiGhJW9dCpktopv8CWsoyW02xfrhDcieUvstG0nCVI1HT4NWHIVgTMlijyodyxQSBzXHPrkfSUIv1zFBcCtYd6IFCUhgrHXyS8yyoJay7JlsqxfivAEesu+LkLvGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716272445; c=relaxed/simple;
	bh=Xh6d491DDdpGmslXz15RAaeZh0mydbiKq45shHXbaTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=sbm5sORVLPgi0ZIODmy2O1zTm3uCcz4hyyIO8LkEABkTeC1bloIlZCqRp7/vO/bry3VXfGbLpM5xmqYdaDvjozUpP5fV80H+JMtJq4Xdz9d7flA4BGv3KPbvyexM4RMheLfkSo73HOBZoHxI5Dda2AG0JGmaieDmzqhtKhqXZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44L6K43t82253130, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44L6K43t82253130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 14:20:04 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 14:20:04 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 21 May 2024 14:20:04 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266]) by
 RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266%2]) with mapi id
 15.01.2507.035; Tue, 21 May 2024 14:20:04 +0800
From: Larry Chiu <larry.chiu@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>, Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org" <horms@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: RE: [PATCH net-next v19 01/13] rtase: Add pci table supported in this module
Thread-Topic: [PATCH net-next v19 01/13] rtase: Add pci table supported in
 this module
Thread-Index: AQHaqC9Rjgvgl8xidUGsWwGzPtgZ5LGa66SAgAZDQWCAAA0PoA==
Date: Tue, 21 May 2024 06:20:04 +0000
Message-ID: <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-2-justinlai0215@realtek.com>
 <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch> 
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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


>> + *  Below is a simplified block diagram of the chip and its relevant in=
terfaces.
>> + *
>> + *               *************************
>> + *               *                       *
>> + *               *  CPU network device   *
>> + *               *                       *
>> + *               *   +-------------+     *
>> + *               *   |  PCIE Host  |     *
>> + *               ***********++************
>> + *                          ||
>> + *                         PCIE
>> + *                          ||
>> + *      ********************++**********************
>> + *      *            | PCIE Endpoint |             *
>> + *      *            +---------------+             *
>> + *      *                | GMAC |                  *
>> + *      *                +--++--+  Realtek         *
>> + *      *                   ||     RTL90xx Series  *
>> + *      *                   ||                     *
>> + *      *     +-------------++----------------+    *
>> + *      *     |           | MAC |             |    *
>> + *      *     |           +-----+             |    *
>> + *      *     |                               |    *
>> + *      *     |     Ethernet Switch Core      |    *
>> + *      *     |                               |    *
>> + *      *     |   +-----+           +-----+   |    *
>> + *      *     |   | MAC |...........| MAC |   |    *
>> + *      *     +---+-----+-----------+-----+---+    *
>> + *      *         | PHY |...........| PHY |        *
>> + *      *         +--++-+           +--++-+        *
>> + *      *************||****************||***********
>> + *
>> + *  The block of the Realtek RTL90xx series is our entire chip=20
>> + architecture,
>> + *  the GMAC is connected to the switch core, and there is no PHY in be=
tween.
>
>Given this architecture, this driver cannot be used unless there is a swit=
ch driver as well. This driver is nearly ready to be merged. So what are yo=
ur plans for the switch driver? Do you have a first version you can post? T=
hat will reassure us you do plan to release a switch driver, and not use a =
SDK in userspace.
>
>        Andrew

Hi Andrew,
This GMAC is configured after the switch is boot-up and does not require a =
switch driver to work.

