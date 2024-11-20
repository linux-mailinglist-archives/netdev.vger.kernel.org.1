Return-Path: <netdev+bounces-146386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3539D33B5
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183C4B22109
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C4B15A87C;
	Wed, 20 Nov 2024 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BdeiNzUv"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9DF1494BB;
	Wed, 20 Nov 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084841; cv=none; b=ByNO75A/eHYYJuHLIytpC4hivzKzZDWGqTwI5oIxHEh5YTwu8UhmMviPAAiOPHAsLUE5TMr59Aqxuf652JQeughMj9GoGlLbOwlBXEZRr8bGN5Wmqf8InS6PmTJlLwOnVwNP2OdrXADTgpuZG6Woj6wLzothsWq1p5Ytm8EEeec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084841; c=relaxed/simple;
	bh=BZzjiDkvhQN+jUgW934Cn4OrdBMymdX4EzltHm6qH84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmML4cHwNvbgOiE4bWfnSFGxmr7WtwzDeyJwScALgNhB3evZv95S0XWYaNiJmd7REwBUzl78YTQfNwvuQ0l5vOgUqiVTc8rQf8QVEpC2fxSXS0NDssLBN7S/9wseym5CSEcyjvuVi88736DNF65uj3VbW4+BHiCfwSwOYq3M2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BdeiNzUv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK6eEyI53658004, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732084814; bh=BZzjiDkvhQN+jUgW934Cn4OrdBMymdX4EzltHm6qH84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BdeiNzUvWEpu2qI+QAklybqaItJy2U6qybSE1bHQmcMbLdCYeUldlZ2W527m79tyn
	 nAynW015wdOsdCCHTqIM0Cfbn7VpvKrQCqmgbhSPglPWpzDd2CUcu42XI0C9i5F/uX
	 98AJP8DUgvu0/f9wrjvFQVF9WNeY3vX7gjGwxEHmkrp8c4lYFYphUrBeFSH3u3Vjoo
	 MsSzUTeAu2vbiKmNwdt1JyFQjxKwwJ/UtLWq349NIsySU2f8VSnHbaAni37CYg3q36
	 EQ6NbpV1IoU2s/c8nOm4zl8b4OOuLhmk7mALkOr1daX9xy/KMolh2sKnFm0DvH+1jZ
	 Ku2unFLy83tww==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK6eEyI53658004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 14:40:14 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 14:40:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Nov 2024 14:40:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 20 Nov 2024 14:40:14 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Michal Kubiak <michal.kubiak@intel.com>
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
Subject: RE: [PATCH net v4 4/4] rtase: Add defines for hardware version id
Thread-Topic: [PATCH net v4 4/4] rtase: Add defines for hardware version id
Thread-Index: AQHbOmmz7dq2YsqnAUuLJwzm4QTJDrK+MpAAgAGD0oA=
Date: Wed, 20 Nov 2024 06:40:14 +0000
Message-ID: <ab423b9a64c24bcb8702a04c089e3185@realtek.com>
References: <20241119095706.480752-1-justinlai0215@realtek.com>
 <20241119095706.480752-5-justinlai0215@realtek.com>
 <ZzytDBkUFWYjTTgU@localhost.localdomain>
In-Reply-To: <ZzytDBkUFWYjTTgU@localhost.localdomain>
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
> On Tue, Nov 19, 2024 at 05:57:06PM +0800, Justin Lai wrote:
> > Add defines for hardware version id.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase.h      |  5 ++++-
> >  drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h
> > b/drivers/net/ethernet/realtek/rtase/rtase.h
> > index 547c71937b01..4a4434869b10 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> > @@ -9,7 +9,10 @@
> >  #ifndef RTASE_H
> >  #define RTASE_H
> >
> > -#define RTASE_HW_VER_MASK 0x7C800000
> > +#define RTASE_HW_VER_MASK     0x7C800000
> > +#define RTASE_HW_VER_906X_7XA 0x00800000 #define
> > +RTASE_HW_VER_906X_7XC 0x04000000 #define
> RTASE_HW_VER_907XD_V1
> > +0x04800000
> >
> >  #define RTASE_RX_DMA_BURST_256       4
> >  #define RTASE_TX_DMA_BURST_UNLIMITED 7 diff --git
> > a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 26331a2b7b2d..1bfe5ef40c52 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -1720,11 +1720,11 @@ static int rtase_get_settings(struct net_device
> *dev,
> >                                               supported);
> >
> >       switch (tp->hw_ver) {
> > -     case 0x00800000:
> > -     case 0x04000000:
> > +     case RTASE_HW_VER_906X_7XA:
> > +     case RTASE_HW_VER_906X_7XC:
> >               cmd->base.speed =3D SPEED_5000;
> >               break;
> > -     case 0x04800000:
> > +     case RTASE_HW_VER_907XD_V1:
> >               cmd->base.speed =3D SPEED_10000;
> >               break;
> >       }
>=20
>=20
> This is new code added in the patch #2.
> I understand that you want to have those preprocessor definitions in a se=
parate
> patch, but why does this patch have to be the last one?
> If you had included this change before the patch #2, you would be able to=
 send
> the final version of the above code (with no intermediate changes).
>=20
> Thanks,
> Michal

Hi Michal,

Thank you for your suggestion. Upon further consideration, I also
agree that the addition of the hardware version ID definitions should
be included before patch #2.

Justin

