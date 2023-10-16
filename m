Return-Path: <netdev+bounces-41240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B35B7CA485
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A046E1C208B8
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE1C1CAAF;
	Mon, 16 Oct 2023 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="SCMW4qsB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B71C28C
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:51:06 +0000 (UTC)
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7593AAD
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:51:05 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1697449863;
	bh=Aue6FRHQtr7/q0XtIPjhCJxMhIMs4iRbhLC8/ZjIHvk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=SCMW4qsBK90W9FzGE9nv3f9mp2B6CQQJFOt8b7LLpdKPHsMrlJCr2RUXnYmsba6Zi
	 U4FwNNg80ArGL20puubKTeo4kXv2KJa8NOmX2KM0eZk7h0z31nCPdfpvDvWe3rl4yL
	 TgRTofWuUAKgsGsRFhyTy4hOTVrT02F3/lMAWg/E=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH net 0/2] net/sched: sch_hfsc: safely allow 'rt' inner
 curves
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <CAM0EoMmLat0VGwN7f-ugk2UkDGDoFOwXT0ARubCmmGPX2X_QkQ@mail.gmail.com>
Date: Mon, 16 Oct 2023 11:50:47 +0200
Cc: netdev@vger.kernel.org,
 xiyou.wangcong@gmail.com,
 jiri@resnulli.us,
 davem@davemloft.net,
 edumazet@google.com,
 Jakub Kicinski <kuba@kernel.org>,
 pabeni@redhat.com,
 Pedro Tammela <pctammela@mojatatu.com>,
 Budimir Markovic <markovicbudimir@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2A4D49E-D62B-47BB-9025-BA4C02191406@flyingcircus.io>
References: <20231013151057.2611860-1-pctammela@mojatatu.com>
 <CAM0EoMmLat0VGwN7f-ugk2UkDGDoFOwXT0ARubCmmGPX2X_QkQ@mail.gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

> On 16. Oct 2023, at 11:48, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>=20
> For the series:
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>=20
> Christian, this should fix it for you but with a caveat: if you
> configure a "faulty" inner qdis to be rt it will "fixed" - meaning you
> can keep your scripts but when you dump you will see the "fixed"
> version instead of the "faulty" one.

Thanks a lot, this is absolutely fine for my situation!

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


