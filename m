Return-Path: <netdev+bounces-145184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF829CD71E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 07:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092981F21239
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 06:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AF317DFFD;
	Fri, 15 Nov 2024 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="sdViNGgR"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A1645;
	Fri, 15 Nov 2024 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652398; cv=none; b=TkwNIJmWkF8WN2UQU/XsXkfRtQRjYg+gNcsNDOobsOU//RXjmCAVb7y/wu9Ea8i6cR/KVXL67hLiydudymXie7DeratkNvJMqq+hgh2smdaPE2EkLEc8zrhMIga3+gQbYvlLvLa8E5tMglSqJQuil/crhdD35Lwc4nLGw6OpkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652398; c=relaxed/simple;
	bh=KGbCXoBZOcHJK+gVr+MJPUUaqUCYGQjLZ6iycOTgm+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AzInNOHzWCGoa/H53NKnI4P/QmnrOLa/3jHuW7lO2WpQ/U8orUKUfKaxpmhWbhVk58oVJ7pJVXDDaCh95EtLHuHia/bgJ5T835LlhdPEnOmnDT9rZ3zK9X+Pai4M3KWTobZgOl2LNDoySJh1Yyn2OL1kOlgcy/N1Y3/IpGX4WpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=sdViNGgR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AF6WsKiA056657, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731652374; bh=KGbCXoBZOcHJK+gVr+MJPUUaqUCYGQjLZ6iycOTgm+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sdViNGgRgVCAeyLGPw8h3JSNO+Sqlbvt8nEOVbY9us41zI0uq6YVuI3K2mzGfKvon
	 SX8etaSSaneVdHWODGDmNLYpr/pfZH5z7c8ZiE4fxupNus3e7My/VE2YZAngeVbjoI
	 rC7neCn5c69fHFdu0x1lO8tpvM49DKDs6ArIirFH6YzhvCyPKIui9P7TcAVRgsqnil
	 D6yAUea+DZZ8KxsraGqCeNpuoiBKug11xdD7FpG8uPcYn+d/DsKAX5zwrgg4ksaFWQ
	 Y8YUfjO4CTSkZBUCNcCPS/z7DMhGT7S1fNx7nVuUVl8Y/MQ9XSz8vVrqaJr/GbyzX1
	 /zHiJNYuZOalg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AF6WsKiA056657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:32:54 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 14:32:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Nov 2024 14:32:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 15 Nov 2024 14:32:54 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net 1/4] rtase: Refactor the rtase_check_mac_version_valid() function
Thread-Topic: [PATCH net 1/4] rtase: Refactor the
 rtase_check_mac_version_valid() function
Thread-Index: AQHbNoZ3TgKh3vcPZkulu1daZxQDq7K2Y9aAgAF+VRA=
Date: Fri, 15 Nov 2024 06:32:54 +0000
Message-ID: <78ffc49101b343338671650e5b5dcfcf@realtek.com>
References: <20241114111443.375649-1-justinlai0215@realtek.com>
 <20241114111443.375649-2-justinlai0215@realtek.com>
 <83569c8e-d4d0-4790-9df6-87b06872229d@lunn.ch>
In-Reply-To: <83569c8e-d4d0-4790-9df6-87b06872229d@lunn.ch>
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

>
>=20
> On Thu, Nov 14, 2024 at 07:14:40PM +0800, Justin Lai wrote:
> > 1. Sets tp->hw_ver.
> > 2. Changes the return type from bool to int.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>=20
> If you want these in net, you should add a Fixes: tag.
>=20
>     Andrew
>=20
Ok, I will do that.
> ---
> pw-bot: cr

