Return-Path: <netdev+bounces-95361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E93D8C1F8D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7862F1C21697
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2954715F410;
	Fri, 10 May 2024 08:13:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156D15F40B;
	Fri, 10 May 2024 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328786; cv=none; b=opIimh3+rgHSTLtLTNEcoBC1k2TdWvHXCyXQBvQPyQFFhEKfgKS5L6hHNRN9mb+RI19PoPZeKy8/5lljFfnGG1nGOseOd0GYD6oXA6n091ILjbp3NleQMyTAnPmM23rrCLr8c2YfAXhagXDFjmUIz+hMAaEjcOhHlOVdt+4GZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328786; c=relaxed/simple;
	bh=TZfiS6lrEsk38Jd6m1IXLmMxfZu6DuG/Z0mv+clT1Q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b1cxLKf8ipPZKjYzFxUlkh1pMYqiXt0HAJ+o4jc8QhrvsxzLBQYleAsgcmYVKNWj5YbFS2Rb/PTr6tgmob7t8vPvcy19aUm6MtaZNv4QvuPTxVpZn87EA1asF7YilUX54TKXv5mVbNxEUeHtkEzp8yz9UZsdwzWCBnYOCx64GDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44A8CTnmC2567408, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44A8CTnmC2567408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 16:12:29 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 16:12:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 16:12:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 10 May 2024 16:12:28 +0800
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
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v18 10/13] rtase: Implement ethtool function
Thread-Topic: [PATCH net-next v18 10/13] rtase: Implement ethtool function
Thread-Index: AQHaoUWgPXTTB14VD0aoQIyqdMTInbGPTwiAgADR5MA=
Date: Fri, 10 May 2024 08:12:28 +0000
Message-ID: <b5c86321761f4d24921b3a4a1f02c694@realtek.com>
References: <20240508123945.201524-1-justinlai0215@realtek.com>
	<20240508123945.201524-11-justinlai0215@realtek.com>
 <20240509204047.149e226e@kernel.org>
In-Reply-To: <20240509204047.149e226e@kernel.org>
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

> On Wed, 8 May 2024 20:39:42 +0800 Justin Lai wrote:
> > +     data[0] =3D le64_to_cpu(counters->tx_packets);
> > +     data[1] =3D le64_to_cpu(counters->rx_packets);
> > +     data[2] =3D le64_to_cpu(counters->tx_errors);
> > +     data[3] =3D le32_to_cpu(counters->rx_errors);
> > +     data[4] =3D le16_to_cpu(counters->rx_missed);
> > +     data[5] =3D le16_to_cpu(counters->align_errors);
> > +     data[6] =3D le32_to_cpu(counters->tx_one_collision);
> > +     data[7] =3D le32_to_cpu(counters->tx_multi_collision);
> > +     data[8] =3D le64_to_cpu(counters->rx_unicast);
> > +     data[9] =3D le64_to_cpu(counters->rx_broadcast);
> > +     data[10] =3D le32_to_cpu(counters->rx_multicast);
> > +     data[11] =3D le16_to_cpu(counters->tx_aborted);
> > +     data[12] =3D le16_to_cpu(counters->tx_underun);
>=20
> Please limit stats you report in ethtool -S to just the stats for which p=
roper
> interfaces don't exist. Don't duplicate what's already reported via
> rtase_get_stats64(), also take a look at what can be reported via various
> *_stats members of struct ethtool_ops.

OK, I will check this part and modify it.

