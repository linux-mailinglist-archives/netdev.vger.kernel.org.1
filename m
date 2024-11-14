Return-Path: <netdev+bounces-144684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FDD9C81B1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 05:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99771F24B2F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8201E9093;
	Thu, 14 Nov 2024 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="J2O2JE1U"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B331E8826;
	Thu, 14 Nov 2024 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556935; cv=none; b=FhvHocbId/wkDue/UVzuJ4gv8/mHGJQBVonTIjFrFX4yBxLuKixhyyAfSmKaJ6CLnYFNEX9RQeWBQGAeD3qU/Pb68z8Op6HHQze+MmS8E/xSxzO1JNUXsahoKebbyVH+DT/hAJR10hzqU0URV911XGM0TDkNSt/8hx0ICaCTWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556935; c=relaxed/simple;
	bh=nvIRS4V/eJ9OZQFZXnx4Rw1NK+AEhY0HNae+ZIJEG1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hrXhbd9HSPm9AwGbnhFUKtUR6udC9nAHEMWxR4Nkbi7jDFtY/AgrzFdWWXsRV76siV29ppjkoRMonyrdXPACD8VRw3VbaX+56HlPDuPK3cO1jJ/x+CnsvbuTeMZCyj4VJEFz4RurQdjj/xEUDv01OukdquM8149y2POlP+GHvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=J2O2JE1U; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AE41YQP02408631, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731556894; bh=nvIRS4V/eJ9OZQFZXnx4Rw1NK+AEhY0HNae+ZIJEG1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=J2O2JE1U7H0wdwbrtXprGadbMg/jqhxVrIIP3c/03GeB6pwvVIoxBtTpsMldJRFWY
	 EZbTz77nTdFu4u0p6UwQwGj8RkaxUIHylFGTRC8nEIZ2c35M0mJgGAEi4YjWVsJbfk
	 1vMbjqY2urKRkSJs3VJKicn/k68AZ/hRIoQTulk+Tw/scAL3YlZJbFqIsk1TqzZLBm
	 m/B3fLXHrRDIhN3rJbixsJKgN8PtZeJt6ghxuTRtzdqm8oyu1rMqA/e7yfKUFu7nNR
	 gWoqWUrBltlt4ilkUiaAwBAfjnc/zourDb2xsFeP51YLWsPOMfx2OtBG0MLfSV2JQ1
	 LGrmnEWqSU2sQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AE41YQP02408631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 12:01:34 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 12:01:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Nov 2024 12:01:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 14 Nov 2024 12:01:34 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
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
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next 1/2] rtase: Add support for RTL907XD-VA PCIe port
Thread-Topic: [PATCH net-next 1/2] rtase: Add support for RTL907XD-VA PCIe
 port
Thread-Index: AQHbM+VARyWuRW3N/EuVbvpAX2WBlbKzJ6GAgAMCi6A=
Date: Thu, 14 Nov 2024 04:01:34 +0000
Message-ID: <b6a9d2049c744492bac90d62ccc6f2c7@realtek.com>
References: <20241111025532.291735-1-justinlai0215@realtek.com>
 <20241111025532.291735-2-justinlai0215@realtek.com>
 <20241112135709.GO4507@kernel.org>
In-Reply-To: <20241112135709.GO4507@kernel.org>
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
> On Mon, Nov 11, 2024 at 10:55:31AM +0800, Justin Lai wrote:
> > Add RTL907XD-VA hardware version and modify the speed reported by
> > .get_link_ksettings in ethtool_ops.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>=20
> Hi Justin,
>=20
> this seems to be doing several things:
>=20
> 1) Adding defines for existing values
> 2) Correcting the speed for RTL907XD-V1
> 3) Adding support for RTL907XD-VA
>=20
> I think these would be best handled as 3 patches.
> And I wonder if 2) is a bug fix for net rather than an enhancement for ne=
t-next.

Ok, I'll try to break down the patch into more detailed parts to=20
make it clearer.
>=20
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase.h    | 10 +++++--
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 26 ++++++++++++++-----
> >  2 files changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h
> > b/drivers/net/ethernet/realtek/rtase/rtase.h
> > index 583c33930f88..2bbfcad613ab 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> > @@ -9,7 +9,11 @@
> >  #ifndef RTASE_H
> >  #define RTASE_H
> >
> > -#define RTASE_HW_VER_MASK 0x7C800000
> > +#define RTASE_HW_VER_MASK     0x7C800000
> > +#define RTASE_HW_VER_906X_7XA 0x00800000 #define
> > +RTASE_HW_VER_906X_7XC 0x04000000 #define
> RTASE_HW_VER_907XD_V1
> > +0x04800000 #define RTASE_HW_VER_907XD_VA 0x08000000
> >
> >  #define RTASE_RX_DMA_BURST_256       4
> >  #define RTASE_TX_DMA_BURST_UNLIMITED 7 @@ -170,7 +174,7 @@
> enum
> > rtase_registers {
> >       RTASE_INT_MITI_TX =3D 0x0A00,
> >       RTASE_INT_MITI_RX =3D 0x0A80,
> >
> > -     RTASE_VLAN_ENTRY_0     =3D 0xAC80,
> > +     RTASE_VLAN_ENTRY_0 =3D 0xAC80,
>=20
> This change doesn't seem related to the rest of the patch.

I'll separate this into an additional patch and upload it.
>=20
> >  };
> >
> >  enum rtase_desc_status_bit {
> > @@ -327,6 +331,8 @@ struct rtase_private {
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
> > index f8777b7663d3..73ebdf0bc376 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -1714,10 +1714,22 @@ static int rtase_get_settings(struct net_device
> *dev,
> >                             struct ethtool_link_ksettings *cmd)  {
> >       u32 supported =3D SUPPORTED_MII | SUPPORTED_Pause |
> > SUPPORTED_Asym_Pause;
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> >
> >
> ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
> >                                               supported);
> > -     cmd->base.speed =3D SPEED_5000;
> > +
> > +     switch (tp->hw_ver) {
> > +     case RTASE_HW_VER_906X_7XA:
> > +     case RTASE_HW_VER_906X_7XC:
> > +             cmd->base.speed =3D SPEED_5000;
> > +             break;
> > +     case RTASE_HW_VER_907XD_V1:
> > +     case RTASE_HW_VER_907XD_VA:
> > +             cmd->base.speed =3D SPEED_10000;
> > +             break;
> > +     }
> > +
> >       cmd->base.duplex =3D DUPLEX_FULL;
> >       cmd->base.port =3D PORT_MII;
> >       cmd->base.autoneg =3D AUTONEG_DISABLE;
>=20
> > @@ -1974,13 +1986,15 @@ static void
> > rtase_init_software_variable(struct pci_dev *pdev,
> >
> >  static bool rtase_check_mac_version_valid(struct rtase_private *tp)
> > {
> > -     u32 hw_ver =3D rtase_r32(tp, RTASE_TX_CONFIG_0) &
> RTASE_HW_VER_MASK;
> >       bool known_ver =3D false;
> >
> > -     switch (hw_ver) {
> > -     case 0x00800000:
> > -     case 0x04000000:
> > -     case 0x04800000:
> > +     tp->hw_ver =3D rtase_r32(tp, RTASE_TX_CONFIG_0) &
> > + RTASE_HW_VER_MASK;
>=20
> Now that this is setting tp->hw_ver perhaps the name of the function shou=
ld be
> changed? Perhaps rtase_set_mac_version() ? Perhaps a single patch can be
> created that reworks this function, preparing for other work, by:
>=20
> * Changes the name of the function
> * Sets tp->hw_ver
> * Changes the return type from bool to int
>   (as is currently done as part of patch 2/2)

This function is not simply used to set tp->hw_ver. Its primary purpose
is to validate the MAC version. Since hw_ver is also used elsewhere, it
is stored in tp->hw_ver. Therefore, I don't believe the function name
needs to be changed. However, I will group the remaining two items into
a separate patch and include it in this patch set.
>=20
> Although a refactor, perhaps that could be part of a series for net that =
also
> includes two more patches that depend on it and:
>=20
> * Correct the speed for RTL907XD-V1
> * Corrects error handling in the case where the version is invalid
>   (as is currently done as part of patch 2/2)

Thank you for your valuable suggestions. I will upload the three patches
as discussed to the net.
>=20
> And then any remaning enhancements can be addressed as follow-up patches
> for net-next.

Ok, I will do that.
>=20
>=20
> > +
> > +     switch (tp->hw_ver) {
> > +     case RTASE_HW_VER_906X_7XA:
> > +     case RTASE_HW_VER_906X_7XC:
> > +     case RTASE_HW_VER_907XD_V1:
> > +     case RTASE_HW_VER_907XD_VA:
> >               known_ver =3D true;
> >               break;
> >       }
> > --
> > 2.34.1
> >

