Return-Path: <netdev+bounces-146120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5059D20B4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF1B28134A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A700819340E;
	Tue, 19 Nov 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ct4ZUcMs"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03C153838;
	Tue, 19 Nov 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001011; cv=none; b=a2HVcwnKhfRu1+IPjRGcGxyEeFk+SeDuxOai6LXz365cfkmmuAgNObva6YpuqVkFl9oaicZ9+vgZlCL4O+kqVUAAnQCua4sgcEgBiaJ6kt8APsEDOyQUfImGpesiKhonR0OPZG62XJiebFymCRkNP9szYF3Myb1l+gQ8pz1Xt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001011; c=relaxed/simple;
	bh=scuIlwq/kV1lYiF/kV9ooYhAESG1tSivC2ter/dPZik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ADFgOX+6JYWMjuKM5sh1C1/Arcnb3oU8gha8hJNGD+4QpY4I9muNI66KOOjhc7dT7R0Vd0Bo5KfXfj1E59eV98MvOIh/TtGonL5DX98TkoxbAo6QDTpdkbVVPUFnt3mPhoWEGZgwwiIDHRbTSfqM85iJdQcwk13gTsZRem0CtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ct4ZUcMs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AJ7N2Uo82078250, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732000982; bh=scuIlwq/kV1lYiF/kV9ooYhAESG1tSivC2ter/dPZik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Ct4ZUcMsM9LlQCqSAWmqI22bbKEZuTn7XU77UH8t39lPVZ+0Z0EQ91efdHOtfp7z7
	 gFkbhPpPFfxOJUYGEyAeacBCIafjbqlJ2uRlL0ULzudPGxXpnSIZJ6m++TNfTyjT3/
	 dyK8whBR0Rzv1mZ0DMkDXv6v05KsVFtHprZ06BPVG2SI9gozBc+qW7k9bbNTPt/rOr
	 wKUd3TZzXu8f0qYtNXtutEXYTXIXYtht7J2yF/xKCykVJ7MHco1tnObZq4GXLkx5qU
	 hcyPJjkhRF/ealiOuuOi10PHp061VNcgCDfOnSLhB3rNNfh6s5Sdlan3rz6zKeIFiH
	 uBVnBNpinH0Rg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AJ7N2Uo82078250
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 15:23:02 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 15:23:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Nov 2024 15:23:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 19 Nov 2024 15:23:02 +0800
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
Subject: RE: [PATCH net v3 1/4] rtase: Refactor the rtase_check_mac_version_valid() function
Thread-Topic: [PATCH net v3 1/4] rtase: Refactor the
 rtase_check_mac_version_valid() function
Thread-Index: AQHbOW+ZJKRJLnMpGUieFBPGWK38ILK8aawAgAGS3AA=
Date: Tue, 19 Nov 2024 07:23:02 +0000
Message-ID: <b55ab4efb8e74ecda3ce5c3b4dca2b12@realtek.com>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
 <20241118040828.454861-2-justinlai0215@realtek.com>
 <ZzssJBOcb807PYSP@localhost.localdomain>
In-Reply-To: <ZzssJBOcb807PYSP@localhost.localdomain>
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

> On Mon, Nov 18, 2024 at 12:08:25PM +0800, Justin Lai wrote:
> > 1. Sets tp->hw_ver.
> > 2. Changes the return type from bool to int.
> > 3. Modify the error message for an invalid hardware version id.
>=20
> The commit message contains too many implementation details (that are qui=
te
> obvious after studying the code), but there is no information about the a=
ctual
> problem the patch is fixing.

Thank you for your feedback. I will make the necessary adjustments to the
commit message.
>=20
> >
> > Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this
> > module")
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase.h    |  2 ++
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 22 +++++++++++--------
> >  2 files changed, 15 insertions(+), 9 deletions(-)
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
> > index f8777b7663d3..0c19c5645d53 100644
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
> > -             known_ver =3D true;
> > +             ret =3D 0;
> >               break;
> >       }
> >
> > -     return known_ver;
> > +     return ret;
> >  }
> >
> >  static int rtase_init_board(struct pci_dev *pdev, struct net_device
> > **dev_out, @@ -2105,9 +2106,12 @@ static int rtase_init_one(struct
> pci_dev *pdev,
> >       tp->pdev =3D pdev;
> >
> >       /* identify chip attached to board */
> > -     if (!rtase_check_mac_version_valid(tp))
> > -             return dev_err_probe(&pdev->dev, -ENODEV,
> > -                                  "unknown chip version, contact
> rtase maintainers (see MAINTAINERS file)\n");
> > +     ret =3D rtase_check_mac_version_valid(tp);
> > +     if (ret !=3D 0) {
>=20
> Maybe "if (!ret)" would be more readable?

Since this function has several instances of this issue that need to be
addressed, I will create a separate patch to make the necessary
corrections.
>=20
> > +             dev_err(&pdev->dev,
> > +                     "unknown chip version: 0x%08x, contact rtase
> maintainers (see MAINTAINERS file)\n",
> > +                     tp->hw_ver);
> > +     }
>=20
> Also, is it OK to perform further initialization steps although we're get=
ting an
> error here? Could you please provide more details in the commit message?

In [PATCH net v3 3/4] rtase: Corrects error handling of the
rtase_check_mac_version_valid(), it can be observed how errors are
handled in case of an issue.
> >
> >       rtase_init_software_variable(pdev, tp);
> >       rtase_init_hardware(tp);
> > --
> > 2.34.1
> >
> >
>=20
> Thanks,
> Michal

