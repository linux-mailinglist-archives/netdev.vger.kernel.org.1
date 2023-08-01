Return-Path: <netdev+bounces-23106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082776ACC1
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9561C20D44
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C371FB42;
	Tue,  1 Aug 2023 09:17:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0041FB30
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:17:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB3635BB
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690881390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6K6y/X0lpa6BY0LxE0wc3D6uW028bWOkYEEOCtf5xMw=;
	b=F1iO+czbOWxnH131/1tV3T/VezJxXxn89wX4s7pqmQJXYnYoNqKMHJ6HQmbqQh1juUDSM8
	W6tLUjvmgz7mijSHc/2DPoDvxmpsKcoC1mFagfqUiIUCS4ZwXTeu2v2RkZM+5kXSP3tZrP
	kIgV9EjNvP8FDL5siss5x0fpQLz3/y4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-_lSTeZcSPoe6d8pVd7j_-A-1; Tue, 01 Aug 2023 05:16:29 -0400
X-MC-Unique: _lSTeZcSPoe6d8pVd7j_-A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40ec97d5b60so4608111cf.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 02:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690881388; x=1691486188;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K6y/X0lpa6BY0LxE0wc3D6uW028bWOkYEEOCtf5xMw=;
        b=h2ElRsS63JrBQfdhh6N1NGO7k0lTiUYvH9K7sDke6qfSl++lyaoERKfT3BZB7JLU6y
         UbH7hnd46FnagLAA0tID1W0Vf2b7uYxzThHljVE2vDa1cbJf/pa3fhEtuEk97CAqIkOz
         sVeDS5HUr2W7M1u32cG70GwNlESa3t0E3J2yN7cRqHYvxbWchPpr0tbGJqGHB3uItj9h
         OLvjvX9Hpzi+qsCgU1fZJ/0UhgSG3R3lMgXNcso/44SzqU7mpKRWIomwFpgC4Q9AOFbi
         MTdOboOBAjryzUze5TFBz4ilhCAZ/WMbj1YAVDUvFGKAreeCC1n5S0r2hynxNxdCbXVl
         nZsA==
X-Gm-Message-State: ABy/qLbk9SOzpXkZveoQPyXWthXgeyaCubpF60SpzWE3cJprFKvbKBI/
	XHolzGZFDCQJIVQFdV0QcprfOI0EXx7UAcehtjpZ2V3mqHLPQ/u+KjVaEarmv4d5mKiRZfl6dNz
	klOhh6Lhmfy3KmGqt
X-Received: by 2002:ac8:7d90:0:b0:40a:6359:2120 with SMTP id c16-20020ac87d90000000b0040a63592120mr11996448qtd.0.1690881388638;
        Tue, 01 Aug 2023 02:16:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFsAGqmtM1V8U+ivRkVF/ZXpfBg5no8ZWT/4ga3JgRoRvBVkRVKkW2MgFfc8tHkIojui6RpFQ==
X-Received: by 2002:ac8:7d90:0:b0:40a:6359:2120 with SMTP id c16-20020ac87d90000000b0040a63592120mr11996437qtd.0.1690881388400;
        Tue, 01 Aug 2023 02:16:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it. [146.241.225.251])
        by smtp.gmail.com with ESMTPSA id oo18-20020a05620a531200b007592f2016f4sm4009416qkn.110.2023.08.01.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:16:28 -0700 (PDT)
Message-ID: <9912df2897bed863ad541807354d49db95970668.camel@redhat.com>
Subject: Re: [PATCH v3 1/2] net: phy: at803x: fix the wol setting functions
From: Paolo Abeni <pabeni@redhat.com>
To: Leo Li <leoyang.li@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Luo Jie
	 <quic_luoj@quicinc.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>,  "David S . Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, David Bauer <mail@david-bauer.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Viorel Suman
 <viorel.suman@nxp.com>, Wei Fang <wei.fang@nxp.com>
Date: Tue, 01 Aug 2023 11:16:24 +0200
In-Reply-To: <AM0PR04MB6289323F6F93E197103A225D8F05A@AM0PR04MB6289.eurprd04.prod.outlook.com>
References: <20230728215320.31801-1-leoyang.li@nxp.com>
	 <20230728215320.31801-2-leoyang.li@nxp.com>
	 <8071d8c5-1da3-47a0-9da2-a64ee80db6e5@lunn.ch>
	 <AM0PR04MB6289323F6F93E197103A225D8F05A@AM0PR04MB6289.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-31 at 14:58 +0000, Leo Li wrote:
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Saturday, July 29, 2023 3:14 AM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: Heiner Kallweit <hkallweit1@gmail.com>; Russell King
> > <linux@armlinux.org.uk>; David S . Miller <davem@davemloft.net>; Jakub
> > Kicinski <kuba@kernel.org>; David Bauer <mail@david-bauer.net>;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Viorel Suman
> > <viorel.suman@nxp.com>; Wei Fang <wei.fang@nxp.com>
> > Subject: Re: [PATCH v3 1/2] net: phy: at803x: fix the wol setting funct=
ions
> >=20
> > On Fri, Jul 28, 2023 at 04:53:19PM -0500, Li Yang wrote:
> > > In commit 7beecaf7d507 ("net: phy: at803x: improve the WOL feature"),
> > > it seems not correct to use a wol_en bit in a 1588 Control Register
> > > which is only available on AR8031/AR8033(share the same phy_id) to
> > > determine if WoL is enabled.  Change it back to use
> > > AT803X_INTR_ENABLE_WOL for determining the WoL status which is
> > > applicable on all chips supporting wol. Also update the
> > > at803x_set_wol() function to only update the 1588 register on chips h=
aving
> > it.
> >=20
> > Do chips which do not have the 1588 register not have WoL? Or WoL
> > hardware is always enabled, but you still need to enable the interrupt.
>=20
> Some of them do and some don't, which is removed in the other patch
> from the series.  Since I don't find the register to enable it, I
> guess it always enabled.
>=20
> >=20
> > Have you tested on a range of PHY? It might be better to split this pat=
ch up a
> > bit. If it causes regressions, having smaller patches can make it easie=
r to find
> > which change broken it.
>=20
> No, I only have AR8035 to test with.  Changes for other chips are
> according to the datasheet.  It would be good if others having the
> hardware can test it too.

Adding Luo Jie for awareness.

@Luo Jie: do you have access to other chips handled by this driver
other then AR8035? could you please test this series:

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D770734

?

Thanks!

Paolo


