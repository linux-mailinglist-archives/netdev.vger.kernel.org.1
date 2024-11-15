Return-Path: <netdev+bounces-145182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121EA9CD6C5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 06:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C9B2258A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 05:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787D217D354;
	Fri, 15 Nov 2024 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tx/6EBiT"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840781632DA;
	Fri, 15 Nov 2024 05:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650312; cv=none; b=juJLMtAMcLwAMYw8FNt1a6BPDeIfHXngYCoBlHU7fSLe5+X48ZsZfcU9m3D8kv6Z7YwZ6ywwzbF1cJ2GEaW7leX4idlnGq4kcu/02vF0aWrsODA5pYkAWlHEZvbFk6WNhqhbiprETRsdnEFXPlWtpEl17rvnZIZpKFnx9HOvo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650312; c=relaxed/simple;
	bh=VCCutfk2iGBCPuLDlRkfhLRgWuPJ6jrf85jhogNZpgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fw83VUzeQLRt6PhLujouCLaHYd3F9r0OTJGOa3Zdn21mWfneyVLGtwuJNOr0JmEdQpXTpU2IZdhw/zHD5nQJukQquSh4j1gcMORbQol6MEuFpXabOkIx6GniAnlBRa54ACxmzTRWPxp3hGAZsY54G1VitXbzEYftHuLgU2j1V/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tx/6EBiT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AF5vuzV7010575, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731650276; bh=VCCutfk2iGBCPuLDlRkfhLRgWuPJ6jrf85jhogNZpgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tx/6EBiTTZkgumKkyJVe/5zBR37mZOqnbf56/Z6gYUfge+zafo+Je5RjBcoiVcbJg
	 aj+Z8jFBSoXlLcKIkX6vlIGRenZExpMdsXkL0p+m59QF6FsVWGlhBd5pfyGvltec9p
	 LaokmD1pPRBWCFl1FkXH4d39Pjg8H2gRgxjYD0qN5kSBRC5uRdd0MyvSNyviIZW6PN
	 FS4mhYjSG+iKgR8kkXvnMmNL5vh5qGl1X9Bvy2egGSIvXPVIp8KMaBSwFp9eL8AwcM
	 tnEfbtzFuvoazvkXkibsQ0KhXyzgA0heMmumZEIPt5kj9rBw+HM4Qh14RodvhiL0Ps
	 rlXj3lYD3sSzQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AF5vuzV7010575
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 13:57:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 13:57:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Nov 2024 13:57:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 15 Nov 2024 13:57:55 +0800
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
Thread-Index: AQHbNoZ3TgKh3vcPZkulu1daZxQDq7K2Yz8AgAFzo0A=
Date: Fri, 15 Nov 2024 05:57:55 +0000
Message-ID: <baeeea41621c4b87a2a5152f72874556@realtek.com>
References: <20241114111443.375649-1-justinlai0215@realtek.com>
 <20241114111443.375649-2-justinlai0215@realtek.com>
 <2fac05ba-7766-4586-8676-e30f09cd2d09@lunn.ch>
In-Reply-To: <2fac05ba-7766-4586-8676-e30f09cd2d09@lunn.ch>
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
> On Thu, Nov 14, 2024 at 07:14:40PM +0800, Justin Lai wrote:
> > 1. Sets tp->hw_ver.
> > 2. Changes the return type from bool to int.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase.h    |  2 ++
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 21 +++++++++++--------
> >  2 files changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h
> > b/drivers/net/ethernet/realtek/rtase/rtase.h
> > index 583c33930f88..547c71937b01 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> > @@ -327,6 +327,8 @@ struct rtase_private {
> >       u16 int_nums;
> >       u16 tx_int_mit;
> >       u16 rx_int_mit;
> > +
> > +     u32 hw_ver;
> >  };
> >
> >  #define RTASE_LSO_64K 64000
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index f8777b7663d3..33808afd588d 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -1972,20 +1972,21 @@ static void rtase_init_software_variable(struct
> pci_dev *pdev,
> >       tp->dev->max_mtu =3D RTASE_MAX_JUMBO_SIZE;  }
> >
> > -static bool rtase_check_mac_version_valid(struct rtase_private *tp)
> > +static int rtase_check_mac_version_valid(struct rtase_private *tp)
> >  {
> > -     u32 hw_ver =3D rtase_r32(tp, RTASE_TX_CONFIG_0) &
> RTASE_HW_VER_MASK;
> > -     bool known_ver =3D false;
> > +     int ret =3D -ENODEV;
> >
> > -     switch (hw_ver) {
> > +     tp->hw_ver =3D rtase_r32(tp, RTASE_TX_CONFIG_0) &
> > + RTASE_HW_VER_MASK;
> > +
> > +     switch (tp->hw_ver) {
> >       case 0x00800000:
> >       case 0x04000000:
> >       case 0x04800000:
>=20
> Since these magic numbers are being used in more places, please add some
> #define with sensible names.

Ok, I will define these hardware version ID names.
>=20
> > -     if (!rtase_check_mac_version_valid(tp))
> > -             return dev_err_probe(&pdev->dev, -ENODEV,
> > -                                  "unknown chip version, contact
> rtase maintainers (see MAINTAINERS file)\n");
> > +     ret =3D rtase_check_mac_version_valid(tp);
> > +     if (ret !=3D 0) {
> > +             dev_err(&pdev->dev,
> > +                     "unknown chip version, contact rtase maintainers
> (see MAINTAINERS file)\n");
> > +     }
>=20
> Since you are changing this, maybe include the hw_ver?

Thank you for your suggestion, I will add hw_ver to the error message.
>=20
>         Andrew

