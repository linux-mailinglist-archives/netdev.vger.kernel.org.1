Return-Path: <netdev+bounces-196830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FCAD6955
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768FB7A4F01
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 07:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56421771F;
	Thu, 12 Jun 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="F3mQFInM"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982F213252;
	Thu, 12 Jun 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714158; cv=none; b=CQQ9zzEHPrH+XL+b1FjczL9tg8HPSBDniGFuD6ktuq0BJoYT+L8jm+m46/Ry2g8ro5xf48oPEw1dG03lwirwF98E81Ehoz4z3spWEZlNkpxwx+ft/FO5M++Fc+JbH7xKvj+7aB1pi9Hn22KkCqz95JJ7SioMpBboUhM0anXHr8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714158; c=relaxed/simple;
	bh=Ejd1F3oztgT7GGOChLr0+rZvQgex8/guYbVeNSvcKcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pub72PX+lPlQyVjcj0wHvmF2vYJz8iXgkElZRC3o47tIr71JNbQbPNCra7GqbMVmbp3fKyIdxXOP5blx/aRs/jXjJ9+w3RmmKoLZHncaiy/baoCL/fjfwv2Vp3mM+r4YRzQpSTuvxyH17PzIeuK9TGYxCJambYbBhi/kqz59usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=F3mQFInM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55C7g6v652108225, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749714126; bh=tF8kdL/sLV4r3jnC1QAn5lYdwy8836T1xAuzL3QtTrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=F3mQFInM32qRDJ2O1+CahVhBoRYTiAnZPqUadwinQWp+ZatrIb85CkuU9mIZddRAf
	 Lu281peyb+iqR3JSGv50ANV/L1BXrZ0LYGIL0ZEwWvLeyUJxH66mdvwMbazXIpLWOp
	 tbjZ6Fopfkq2epZLZoGhw6T5ULJGv5b/IoRLfuOiwFC8qoZuG94gDuhXHG7P+vlINc
	 Qbm8h0CyYQMjJ63mQWduSA2BAUOT7e0H9Gpm/uDNn7xLXRapBkgyYSuyz0I8+hSaN/
	 fS3Dz4Wt7F5rpii6/dMasToOZfGUcb+D+qdT5SNcqWHf+7jU0XvLszq5LIUplwfxY9
	 8BDOwwPHhknQw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55C7g6v652108225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 15:42:06 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 15:42:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 12 Jun 2025 15:42:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 12 Jun 2025 15:42:05 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next] rtase: Refine the flexibility of Rx queue allocation
Thread-Topic: [PATCH net-next] rtase: Refine the flexibility of Rx queue
 allocation
Thread-Index: AQHb2e3LR3+Ghbehf0qGerDekzflKrP99LaAgAExx+A=
Date: Thu, 12 Jun 2025 07:42:05 +0000
Message-ID: <3553c84b61b24ebe99846136123062f5@realtek.com>
References: <20250610095518.6585-1-justinlai0215@realtek.com>
 <20250611142523.67e7d984@kernel.org>
In-Reply-To: <20250611142523.67e7d984@kernel.org>
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

> On Tue, 10 Jun 2025 17:55:18 +0800 Justin Lai wrote:
> > Refine the flexibility of Rx queue allocation by using alloc_etherdev_m=
qs.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 4d37217e9a14..c22dd573418a 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -2080,8 +2080,8 @@ static int rtase_init_board(struct pci_dev *pdev,
> struct net_device **dev_out,
> >       int ret =3D -ENOMEM;
> >
> >       /* dev zeroed in alloc_etherdev */
> > -     dev =3D alloc_etherdev_mq(sizeof(struct rtase_private),
> > -                             RTASE_FUNC_TXQ_NUM);
> > +     dev =3D alloc_etherdev_mqs(sizeof(struct rtase_private),
> > +                              RTASE_FUNC_TXQ_NUM,
> RTASE_FUNC_RXQ_NUM);
> >       if (!dev)
> >               goto err_out;
> >
>=20
> $ git grep RTASE_FUNC_.XQ_NUM
> drivers/net/ethernet/realtek/rtase/rtase.h:#define RTASE_FUNC_TXQ_NUM
> 1
> drivers/net/ethernet/realtek/rtase/rtase.h:#define RTASE_FUNC_RXQ_NUM
> 1
>=20
> This patch is a nop?
> --
> pw-bot: reject

Hi Jakub,

Sorry about this, but this patch needs to be abandoned for now. It's
currently non-functional, and we'll resubmit it in the future together
with changes that support user-configurable queue numbers.
=20
Thanks,
Justin

