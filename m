Return-Path: <netdev+bounces-134615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBFB99A73A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2E91C20B43
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF17194085;
	Fri, 11 Oct 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0+igw2Rz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706B19308A;
	Fri, 11 Oct 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659444; cv=none; b=Bf3fOjlad28pJI3yIjIGRctmS8kH6CC0sbB3B56P3rQf86gmljIzpjoimWk7V+iXOHpaoXwH3wvvZP7+4VQYFINBYTorMY43vt57a4SXn6V0m9AqKHU8SyX6+pDCq6wm/O9JVvTeSh/kQ1r5Rfs7CJI/BHKBUGywHkZFsBqTGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659444; c=relaxed/simple;
	bh=O3pN2LphdavFySd1d/Z3XXRUvezrporz6lH83zanGec=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 References:In-Reply-To; b=uZsTSzYEmvgiUQe9rKpdfb/p9+DP1lzFdDVqrUWrPrTLYIpUbi6ztE5W0oad0Xgu6Hlq4FoQx80uf8GsCPk/v7AGXXX61qoNB8NLGH6mAhImKrBPCzQyw7p2x6y1BhlzPryux3pKuDWoipcwv6Uv1iw5qVYK5LSCC8QgEsYWX14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0+igw2Rz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728659442; x=1760195442;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:subject:from:to:references:in-reply-to;
  bh=O3pN2LphdavFySd1d/Z3XXRUvezrporz6lH83zanGec=;
  b=0+igw2RzYFrTytKgWQVm4z2aj/9XUUG52g0x4LvHQDDelV8p7JD4ujgX
   yWnn6qjr43oTLRVeqKBvzeP0pvPEp1Ehe0ZIWsaqqC+dLkeyH5vqNIJGe
   jVoXH2zvlymH/ZKYH8O7rK+SxkQtfjL8nyClASTqm2bw24zsI2qFeOTwm
   CRc0BsXDhpltEJp5qeHZwTh6o4Xx+5dvo7BFSvm8zaW6kTpWD0q9vssFb
   vMfqX9p/83Rz+SOwmSqFhFm6LjQ+4Ej8VYgxYxslY01d7SmdZYYl2RJfR
   091fnd9SEyX7M95ObJzPgZlzkn4OwRP+j2zc04V/I0YbAOb+1az5FYO95
   A==;
X-CSE-ConnectionGUID: M4UEVG7FSLmebq4pEKbrKw==
X-CSE-MsgGUID: X2e24i8mSO2djMMbxEVwjQ==
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="200333377"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2024 08:10:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 11 Oct 2024 08:10:11 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 11 Oct 2024 08:10:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Oct 2024 17:10:08 +0200
Message-ID: <D4T2M90I0282.D2DYJ3EITRTH@microchip.com>
CC: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: microchip: vcap api: Fix memory leaks in
 vcap_api_encode_rule_test()
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>, Jinjie Ruan
	<ruanjinjie@huawei.com>
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20241010130231.3151896-1-ruanjinjie@huawei.com>
 <20241011102459.zxmegrcro2tv6b46@DEN-DL-M70577>
In-Reply-To: <20241011102459.zxmegrcro2tv6b46@DEN-DL-M70577>

On Fri Oct 11, 2024 at 12:24 PM CEST, Daniel Machon wrote:
> > Cc: stable@vger.kernel.org
> > Fixes: a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in=
 kunit test")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >  drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/dri=
vers/net/ethernet/microchip/vcap/vcap_api_kunit.c
> > index f2a5a36fdacd..7251121ab196 100644
> > --- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
> > +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
> > @@ -1444,6 +1444,8 @@ static void vcap_api_encode_rule_test(struct kuni=
t *test)
> >=20
> >         ret =3D vcap_del_rule(&test_vctrl, &test_netdev, id);
> >         KUNIT_EXPECT_EQ(test, 0, ret);
> > +
> > +       vcap_free_rule(rule);
> >  }
>
> Wait, should vcap_del_rule not handle the freeing of the rule?
> Maybe Emil can shed some light on this..
>
> /Daniel
>

No, this is a bug. I made the mistake of thinking that vcap_del_rule freed =
the
rule.

However, it frees an internal copy of the rule, which is made in vcap_add_r=
ule.
The local copy must still be freed. I reproduced the leak and the patch fix=
es
this.

/Emil

