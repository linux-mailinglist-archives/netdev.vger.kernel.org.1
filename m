Return-Path: <netdev+bounces-106748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 784F5917819
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32554281758
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 05:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF025143C49;
	Wed, 26 Jun 2024 05:28:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1813B78F;
	Wed, 26 Jun 2024 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379727; cv=none; b=f6haXMuVEcWuhNQNkFsy7RUebK5kgfHcvtKuhsgDUN4DYsZ/sP3kM60fsokvzpydQ6mMMwZWGlFKCz50FJuY12sa2Wfnt8mzrcs68fYC2FcQU2ymmrqzYXyHXDoRjLuC1q3zWAHjbQSsOvfPCVEQk9oRJqpa6a8iy5WmbfXshbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379727; c=relaxed/simple;
	bh=zLRst5U/dLmvEUbfJH9CcN41z0qbxMYggen2chbXKxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CS6nKTivs03+JeMXF6kbjc1uSmP9A8sXxFZcqvLNsTRFr6SdZzcci3eoKWO6SGIJz+IVL8lsf+xakehqMwj540gTTYMVvYuRACGMcBbw7N8hoz7eYlY5Ho/BZ3ftxuRgbs6zkeVBNLX9yxelhV/eKuUNb2GehhL2pjUl2rqIRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45Q5S89C01136783, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45Q5S89C01136783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 13:28:08 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 13:28:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 26 Jun 2024 13:28:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 26 Jun 2024 13:28:07 +0800
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
Subject: RE: [PATCH net-next v21 12/13] realtek: Update the Makefile and Kconfig in the realtek folder
Thread-Topic: [PATCH net-next v21 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Thread-Index: AQHaxgC74unetcPOEkWaER3yo/MGorHYuHIAgADOJDA=
Date: Wed, 26 Jun 2024 05:28:07 +0000
Message-ID: <f7748d20b5974d6188b690d935a85b29@realtek.com>
References: <20240624062821.6840-1-justinlai0215@realtek.com>
	<20240624062821.6840-13-justinlai0215@realtek.com>
 <20240625180758.069a9d4f@kernel.org>
In-Reply-To: <20240625180758.069a9d4f@kernel.org>
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

>=20
> On Mon, 24 Jun 2024 14:28:20 +0800 Justin Lai wrote:
> > diff --git a/drivers/net/ethernet/realtek/Makefile
> > b/drivers/net/ethernet/realtek/Makefile
> > index 635491d8826e..046adf503ff4 100644
> > --- a/drivers/net/ethernet/realtek/Makefile
> > +++ b/drivers/net/ethernet/realtek/Makefile
> > @@ -9,3 +9,4 @@ obj-$(CONFIG_ATP) +=3D atp.o  r8169-y +=3D r8169_main.o
> > r8169_firmware.o r8169_phy_config.o
> >  r8169-$(CONFIG_R8169_LEDS) +=3D r8169_leds.o
> >  obj-$(CONFIG_R8169) +=3D r8169.o
> > +obj-$(CONFIG_RTASE) +=3D rtase/
>=20
> sparse points out:
>=20
> drivers/net/ethernet/realtek/rtase/rtase_main.c:1668:32: warning: cast to
> restricted __le64
> drivers/net/ethernet/realtek/rtase/rtase_main.c:1668:32: warning: cast fr=
om
> restricted __le32
> --
> pw-bot: cr

Sorry, I will modify it.

