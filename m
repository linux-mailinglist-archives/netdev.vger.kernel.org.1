Return-Path: <netdev+bounces-190934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40257AB95AF
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D729E7C98
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 05:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C676B221289;
	Fri, 16 May 2025 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cSQE3vOY"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD521C9F1
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374780; cv=none; b=joJTIXHJALsaVBGYMAMesJMooLp4PTb/NORUFw9oMnJKA8YGLFPfy/UV7W7lKyeci53SPY97rI+0x97gERHp7+U9Rf+EFMQrIM6wE72KcHyUIVp7IKGaawTfOHvxiWoFbI4uwQP3CajKrluArTMAqZx8RwVN3ych64HayVzcSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374780; c=relaxed/simple;
	bh=Ukg+IdUNBlaROdk+Ca04c6x9CC9dc6RR7ctVVC/57qU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsXXppjIAEeqIAU9U0XKvdgigcJnt+haC+w31HDmsY9wcGDoucm+0qrkYI72vS/ZqUewOsosB2KhaqX6Kb18zsJ1/nhRepz8/vR2nJR8yoP+XsmbfdWh2fCMu56dcQHfb1hJbDgKvRhz99Gj4t2cJWXAaEg1YmAl1wBPHYiVZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cSQE3vOY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G5q69D1435715, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747374726; bh=Ukg+IdUNBlaROdk+Ca04c6x9CC9dc6RR7ctVVC/57qU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cSQE3vOYQPyMYkx6PZR33CTC/Yk+1R6a+0JkLbprckjxpYD8spK4zOvgfF9+5yXQr
	 UUUSbqCcoCz2EfTbXMY4PxtsHeQl88XUzKq4wE0wZSy+HhQQSbAfTt1EuUUGKHbQ7p
	 BIow+aexrgkRJefBvedgx/Jt71ejc10n7ej2GvS2NvomluoqfI0u0+j8m8gIxtIw41
	 umpS3mRGD5yBgg9LRn0/OTIO+QPw8qMHIMowhnaGHZygC30PbVHc5mvhD8wCpt5ory
	 qFkza05v7+9kTKc+D4ygcFWrX8fVQp1msJIEeonozkJgX9+gcmiBklSB/IahnLNQub
	 lSdm3BuO1HYZg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G5q69D1435715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 13:52:06 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 13:52:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 May 2025 13:52:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 16 May 2025 13:52:06 +0800
From: Hau <hau@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] net: phy: realtek: add RTL8127-internal PHY
Thread-Topic: [PATCH net-next] net: phy: realtek: add RTL8127-internal PHY
Thread-Index: AQHbxUWGMiZCOE3eGE+7esCSx5Ce8bPTScOAgAF4ybA=
Date: Fri, 16 May 2025 05:52:06 +0000
Message-ID: <2e83251cfcc249a192f836ff5329e930@realtek.com>
References: <20250515030022.4499-1-hau@realtek.com>
 <300c4d31-6ea0-48f5-9baa-54e37bd9c092@lunn.ch>
In-Reply-To: <300c4d31-6ea0-48f5-9baa-54e37bd9c092@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
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
> External mail : This email originated from outside the organization. Do n=
ot
> reply, click links, or open attachments unless you recognize the sender a=
nd
> know the content is safe.
>=20
>=20
>=20
> On Thu, May 15, 2025 at 11:00:22AM +0800, ChunHao Lin wrote:
> > RTL8127-internal PHY is RTL8261C wihch is a integrated 10Gbps PHY with
> > ID 0x001cc890. It follows the code path of RTL8125/RTL8126 intrernal
> > NBase-T
>=20
> internal
>=20
> When you have fixed that, you can add Reviewed-by: Andrew Lunn
> <andrew@lunn.ch>
>=20
I will fix the typo. Thanks.

