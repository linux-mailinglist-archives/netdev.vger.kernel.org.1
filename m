Return-Path: <netdev+bounces-95850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F6C8C3A86
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 05:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5851C20D73
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B36B145B38;
	Mon, 13 May 2024 03:44:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3222F08;
	Mon, 13 May 2024 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715571859; cv=none; b=WrmJld3edVRpe5XkjS/xpXdOnZRw9BRZvlDKLMJ54a3qBboZXJPGMw+8oGoSXudr+2W5do5nXw+NcxW9ldzMHwu0sBjzEGVh6DWyiHZA61sRaFdu4bW+Sd2BOqX7YizRPhNqBrxghhjLdaagEcc9Wqzl+/04VuZ6mQv2OsBKZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715571859; c=relaxed/simple;
	bh=wGiZC2HBCgKBqxT3zraC65pPgnrqP9p/UeRv8YvsqWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jvYragaYdvO43W8g5zEkw8OrbRhoB2BC+tOZXEfEBfvLXXJVE6XQ18hQgOHvRAliK642dqrAaGkqsiXZSHQAJe82ZTRIKrb1ojIp6vGav/nYdqmci0d54UT9G8V2eL+fjsSTDINc6JZv7xJbVBrKCYIz7p/wbEQF6PJH15p6www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44D3hqX131129703, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44D3hqX131129703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 11:43:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 11:43:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 11:43:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 13 May 2024 11:43:52 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
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
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v18 06/13] rtase: Implement .ndo_start_xmit function
Thread-Topic: [PATCH net-next v18 06/13] rtase: Implement .ndo_start_xmit
 function
Thread-Index: AQHaoUVFS3AReltz50OiDSH+k5DKnbGQKQQAgARjhdA=
Date: Mon, 13 May 2024 03:43:52 +0000
Message-ID: <7f1ff93c4f7d4fc9bdefbb646c18acc1@realtek.com>
References: <20240508123945.201524-1-justinlai0215@realtek.com>
 <20240508123945.201524-7-justinlai0215@realtek.com>
 <1bb2d174-ccae-43e3-80ec-872b9a140fbe@lunn.ch>
In-Reply-To: <1bb2d174-ccae-43e3-80ec-872b9a140fbe@lunn.ch>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

>=20
> > +static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device
> > +*dev) {
> > +     u32 csum_cmd =3D 0;
> > +     u8 ip_protocol;
> > +
> > +     switch (vlan_get_protocol(skb)) {
> > +     case htons(ETH_P_IP):
> > +             csum_cmd =3D RTASE_TX_IPCS_C;
> > +             ip_protocol =3D ip_hdr(skb)->protocol;
> > +             break;
> > +
> > +     case htons(ETH_P_IPV6):
> > +             csum_cmd =3D RTASE_TX_IPV6F_C;
> > +             ip_protocol =3D ipv6_hdr(skb)->nexthdr;
> > +             break;
> > +
> > +     default:
> > +             ip_protocol =3D IPPROTO_RAW;
> > +             break;
> > +     }
> > +
> > +     if (ip_protocol =3D=3D IPPROTO_TCP)
> > +             csum_cmd |=3D RTASE_TX_TCPCS_C;
> > +     else if (ip_protocol =3D=3D IPPROTO_UDP)
> > +             csum_cmd |=3D RTASE_TX_UDPCS_C;
> > +     else
> > +             WARN_ON_ONCE(1);
>=20
> I'm not so sure about this WARN_ON_ONCE(). It looks like if i send a cust=
om
> packet which is not IPv4 or IPv6 it will fire. There are other protocols =
then IP.
> Connecting to an Ethernet switch using DSA tags would be a good example. =
So
> i don't think you want this warning.
>=20
>       Andrew

Hi Andrew,
The condition for entering this function is checksum_partial, which require=
s
hardware to help calculate the checksum, so protocols that are not supporte=
d
by the hardware will issue warn_on_once.

