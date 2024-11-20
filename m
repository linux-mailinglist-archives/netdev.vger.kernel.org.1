Return-Path: <netdev+bounces-146385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EA59D33B4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FDC284009
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F28015957D;
	Wed, 20 Nov 2024 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mWf0tfHM"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF715625A;
	Wed, 20 Nov 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084841; cv=none; b=NiK0n4gePljmY+9lOy3J2gXShuLbtZJtKQvK5EUJ1g4TLU6+USLlFLX3FasAtDN2Out03rjClu0agFBwnlKHjMLyh2uHq/RRsIkw6+ggQr5KzkKZ8HxDKzYddyCj13SvK+F3ciCMrRjZUuIMIGemW1Z2mIbW4AOqWcikQYbfcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084841; c=relaxed/simple;
	bh=qWez04eWlX1G3EtzCOVJ+TyPIxvM6199QFe3AFCQ7lg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7dblvqqSENWZdoPXJlPa0AJXcTJYDHP/lBC44F+0so9uznJ4KOgR+DKwKqU/Slv3CvyfG1AWuOgyRoqCzxR1fWNB+x7Mw8//f4TE3N6AsbiyA5Wx6e8Won1tcz+GuMeCDIsyMv/4JCTLrYJ84tF/P1JLmeIzFnTDT+Zf4E02GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mWf0tfHM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK6eBiB53657961, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732084811; bh=qWez04eWlX1G3EtzCOVJ+TyPIxvM6199QFe3AFCQ7lg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mWf0tfHMsAkxIneK4Y27ion8vqFAX7InjR9Z0djd+vUAR+MQFWVU5RJc/PJq3DVe3
	 yq2VLPopR8JAwv+CUIKJid5Zxlm2ax6HWgMnk/se0ilYUAd48SCh6W15UEuZZ+HJ2P
	 jNQZAPzkuyD9fG4kCJgCs1eU48S0Jj7oO5aEUpVbkqcM5JCB7yry1s81pQjT26l/Y9
	 fQ4R430IldJTveEssT7wd2oVkAkDdCDYaZ6eyxF/TymiQuTC1QT8AljPf4BUA/AW/2
	 /x4MnBMu7t1+Gzz+ou6u46XUVdRSDPHGijlseu+UnC9MaqbmZbbmezxQG+zf44Eki1
	 fEN8U3+XBeO/Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK6eBiB53657961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 14:40:11 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 14:40:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Nov 2024 14:40:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 20 Nov 2024 14:40:11 +0800
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
Thread-Index: AQHbOW+onFVGkA7F1Em9YFPvgneGQLK8bH2AgAHAitD//8pMgIABvurQ
Date: Wed, 20 Nov 2024 06:40:11 +0000
Message-ID: <e942273d5ee040dca511bd55c1204a1e@realtek.com>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
 <20241118040828.454861-3-justinlai0215@realtek.com>
 <ZzsugTPBgp9a70/F@localhost.localdomain>
 <5011ae11bd9b48c5bf8e1bf400aa5d13@realtek.com>
 <Zzx5t24M0DG0yUrt@localhost.localdomain>
In-Reply-To: <Zzx5t24M0DG0yUrt@localhost.localdomain>
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
> On Tue, Nov 19, 2024 at 07:23:12AM +0000, Justin Lai wrote:
> > >
> > > On Mon, Nov 18, 2024 at 12:08:26PM +0800, Justin Lai wrote:
>=20
> [...]
>=20
> > > >
> > > >
> > > ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
> > > >                                               supported);
> > > > -     cmd->base.speed =3D SPEED_5000;
> > > > +
> > > > +     switch (tp->hw_ver) {
> > > > +     case 0x00800000:
> > > > +     case 0x04000000:
> > > > +             cmd->base.speed =3D SPEED_5000;
> > > > +             break;
> > > > +     case 0x04800000:
> > > > +             cmd->base.speed =3D SPEED_10000;
> > > > +             break;
> > > > +     }
> > > > +
> > >
> > > Above you are adding the code introducing some magic numbers and in
> > > your last patch you are refactoring that newly added code.
> > > Would it be possible to avoid those intermediate results and prepare
> > > the final version of the fix in the series?
> >
> > We would still prefer to follow the "single patch, single purpose"
> > approach for this part. Other reviewers have also provided similar
> > feedback, so we would like to maintain the current approach.
> >
>=20
> I understand other reviewers' feedback because it's simply hard to review=
 the
> series with many intermediate changes in the same code.
> Moreover, in this case, those intermediate changes can be easily avoided =
by
> moving the patch #4 to the beginning of the series.
> But still - I have doubts if the patch #4 can go into the "net" tree sinc=
e it doesn't
> have any functional fixes.
>=20
> Thanks,
> Michal

Hi Michal,

Thank you for your response. I will integrate the addition of the hardware
version ID definitions into patch #1, as this will address both of your
concerns at once.

Justin

