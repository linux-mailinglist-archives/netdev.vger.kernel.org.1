Return-Path: <netdev+bounces-117100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C88D94CABD
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D916D1F22FC0
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 06:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F216D318;
	Fri,  9 Aug 2024 06:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GwxaG0qc"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6333CD1;
	Fri,  9 Aug 2024 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185860; cv=none; b=Z8131T7hCA+nOtDJJfovyA/97oeegbZFLvvP8rw2BarN2SW5wjL0WDjD6NTp6D+hU7/cS90cUkNuJnHZuAcs4cITrAhvLykDydeBtmpbC6Cgq2TvQttuekXmJNCLJasXK2KV26MBKZPKkn9gIgQtX3p4eqj2ZwJ9gR3fUYxJjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185860; c=relaxed/simple;
	bh=0O0vDtXRbJkaaRqix7Xy2L2eQM4DwG+mWtJ91knCEIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fCDOViZnH8k92vkjv9Uv0JoWb29kU3n1ILMRl5Txg+DfZIb9JmmkI6Xprn5KV0rHBWr2uha8a5lY6LLk7flH8rx8E5vYeBG1OpXzVnbnUXl3YfrA9qDUd7/ILbUzNYWXDZupAFA3gC2RFG+W6Bg6wu1BbqNgXFBmfyqVgPCxeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GwxaG0qc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4796hcncF478343, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723185818; bh=0O0vDtXRbJkaaRqix7Xy2L2eQM4DwG+mWtJ91knCEIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GwxaG0qcMFR8K/X1r+rhNfycAoH7pXX31FPsT6T2aql8ZAhsvpF7+WvzBiEiOqfnD
	 ncxy1z6LKyQYLJpAF65Pvn1ylVvtdkaRdeGP4ejXqPjIQQU/qu3lzxYo+It1mCb2D5
	 ElHFWse6etLGQCyQqa0pBGG+57Tq4Z0DeqlelKq+EIZzFh10HyQ9Sr7FPdS8a/Zf2f
	 0UK/D77A59cjXTrjOIuUqx4nOl1pDMUcZhiQvl8nbJPvTBCh3dw/AxsImNzigWarP0
	 Qph4kfpJ55KZr5b4QUra9hVN+VhUEQkJnq+CNo55fe00bMBwxWx/VWOSdoNdDrMyOU
	 Zwl6FkQLF6ndA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4796hcncF478343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 14:43:38 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 14:43:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Aug 2024 14:43:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 9 Aug 2024 14:43:39 +0800
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
        "jdamato@fastly.com" <jdamato@fastly.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v26 07/13] rtase: Implement a function to receive packets
Thread-Topic: [PATCH net-next v26 07/13] rtase: Implement a function to
 receive packets
Thread-Index: AQHa6HuwwZ+4plTmsUmDtMJWq0tmxbIdu1mAgADBvuA=
Date: Fri, 9 Aug 2024 06:43:38 +0000
Message-ID: <1f846891e9264b94bf00cb934dd83d2a@realtek.com>
References: <20240807033723.485207-1-justinlai0215@realtek.com>
	<20240807033723.485207-8-justinlai0215@realtek.com>
 <20240808200705.0e77147c@kernel.org>
In-Reply-To: <20240808200705.0e77147c@kernel.org>
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

> On Wed, 7 Aug 2024 11:37:17 +0800 Justin Lai wrote:
> > +static int rx_handler(struct rtase_ring *ring, int budget) {
> > +     union rtase_rx_desc *desc_base =3D ring->desc;
> > +     u32 pkt_size, cur_rx, delta, entry, status;
> > +     struct rtase_private *tp =3D ring->ivec->tp;
> > +     struct net_device *dev =3D tp->dev;
> > +     union rtase_rx_desc *desc;
> > +     struct sk_buff *skb;
> > +     int workdone =3D 0;
> > +
> > +     cur_rx =3D ring->cur_idx;
> > +     entry =3D cur_rx % RTASE_NUM_DESC;
> > +     desc =3D &desc_base[entry];
> > +
> > +     do {
> > +             /* make sure discriptor has been updated */
> > +             dma_rmb();
>=20
> I think I already asked, but this still makes no sense to me.
> dma barriers are between accesses to descriptors.
> dma_rmb() ensures ordering of two reads.
> Because modern CPUs can perform reads out of order.
> What two reads is this barrier ordering?
>=20
> Please read the doc on memory barriers relating to dma.
> I think this is in the wrong place.
>=20
> r8169 gets it right.

Thank you for your reply. I will modify it.

Thanks
Justin
>=20
> > +             status =3D le32_to_cpu(desc->desc_status.opts1);
> > +
> > +             if (status & RTASE_DESC_OWN)
> > +                     break;
> > +


