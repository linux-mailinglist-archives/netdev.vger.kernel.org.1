Return-Path: <netdev+bounces-146121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DF59D20B7
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F512829BA
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E218A950;
	Tue, 19 Nov 2024 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DbeVjr6D"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433A19A2A2;
	Tue, 19 Nov 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001015; cv=none; b=iQo0TOfI77kK2u0YnGNaPcIdcfyMfU7X1SUcMPgur3/4hojCP5liG1rJybbYu+JJe3FBgKwWkRbJnMOzXL5P/MLj9URQHFjL+m/WZyWUwABuXBMbS5hPquRPgyHulSdhNNOo+6MTtdI+jZkYyclgWKIuM0m0JYnwpEI9Tsw7cUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001015; c=relaxed/simple;
	bh=ziixdU99Q4PZvkImLs/iiEML+XfAttdDdVqZLiO5+ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m26PMQkVOVQ9fmJhA3kZ1ZhnKFdFxnCNxLlxd2ltbEPa95ey97+erChUeA4k8IhISFmO5X4DiNHNbg/8TgKNysn5S3Ds1n1F8AHVAnQdVRGYXkZvOic1WmyBzb6+wXp/GLIgwWt2qVylVkR0dlW2RcU165StN84htHcwOG1yg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DbeVjr6D; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AJ7NCSZ02078732, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732000992; bh=ziixdU99Q4PZvkImLs/iiEML+XfAttdDdVqZLiO5+ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DbeVjr6DOxA48lAMs64tMgr7aaFTwlCh4rftUvrslhFlR70a9neL8xi3sWWzE/7S5
	 DDNy2t+UcB6HCXntUY7gpjKMAkauWkA2F0TPw+DF+ONliIpsGe1KDGx/0GE1aHDtgW
	 f9tyfIcuSj4LeztDBcoA6mSEDyDb+S5P60DFOe46Fyec8UYN7WhaARm3aQaJp7VO3j
	 IJU/RxKLlzmZjsG9Q7Ar/GNWfF/iiwc/ApazwppQm/PEenj0VwqytqXiWDDj/UVwoS
	 8ASVWW66HGiaXdn1GpgNnyIxqd4UrBg94w1C1PYTgvP5VzWV5D9cxcgDo2Xklk9C+w
	 xCRIs4Hv4LGNw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AJ7NCSZ02078732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 15:23:12 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 15:23:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Nov 2024 15:23:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 19 Nov 2024 15:23:12 +0800
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
Subject: RE: [PATCH net v3 2/4] rtase: Correct the speed for RTL907XD-V1
Thread-Topic: [PATCH net v3 2/4] rtase: Correct the speed for RTL907XD-V1
Thread-Index: AQHbOW+onFVGkA7F1Em9YFPvgneGQLK8bH2AgAHAitA=
Date: Tue, 19 Nov 2024 07:23:12 +0000
Message-ID: <5011ae11bd9b48c5bf8e1bf400aa5d13@realtek.com>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
 <20241118040828.454861-3-justinlai0215@realtek.com>
 <ZzsugTPBgp9a70/F@localhost.localdomain>
In-Reply-To: <ZzsugTPBgp9a70/F@localhost.localdomain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
> On Mon, Nov 18, 2024 at 12:08:26PM +0800, Justin Lai wrote:
> > Correct the speed for RTL907XD-V1.
> >
>=20
> Please add more details about the problem the patch is fixing.

Ok, I will make the necessary changes to the commit message.
>=20
> > Fixes: dd7f17c40fd1 ("rtase: Implement ethtool function")
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase_main.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 0c19c5645d53..5b8012987ea6 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -1714,10 +1714,21 @@ static int rtase_get_settings(struct net_device
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
> > +     case 0x00800000:
> > +     case 0x04000000:
> > +             cmd->base.speed =3D SPEED_5000;
> > +             break;
> > +     case 0x04800000:
> > +             cmd->base.speed =3D SPEED_10000;
> > +             break;
> > +     }
> > +
>=20
> Above you are adding the code introducing some magic numbers and in your
> last patch you are refactoring that newly added code.
> Would it be possible to avoid those intermediate results and prepare the =
final
> version of the fix in the series?

We would still prefer to follow the "single patch, single purpose"
approach for this part. Other reviewers have also provided similar
feedback, so we would like to maintain the current approach.
>=20
> >       cmd->base.duplex =3D DUPLEX_FULL;
> >       cmd->base.port =3D PORT_MII;
> >       cmd->base.autoneg =3D AUTONEG_DISABLE;
> > --
> > 2.34.1
> >
> >
>=20
> Thanks,
> Michal

