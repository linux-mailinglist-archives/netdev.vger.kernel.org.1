Return-Path: <netdev+bounces-39209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6CA7BE54A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135E91C2093B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62BF374DA;
	Mon,  9 Oct 2023 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="h7MdZNj8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DC374D3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:46:54 +0000 (UTC)
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2868E94;
	Mon,  9 Oct 2023 08:46:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1696866410;
	bh=HWvc+5ISlvs1/m94xDgJR6CaS7Jho5VmQgLxRGlMnBE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=h7MdZNj8/PpoAybfSgEqYnD9SMa0tPslsFT2g9vJsE7UBimkf4fGkR/QC0nXox1lc
	 xbzZpCDFSJIlB3ZejV1M5aC8HZJvDSZeTQyKDllAQau0ZbVz225e7roKxEpppKTRAj
	 wSlh2Kd7F+vfIjBr+AYy+iN9GIExyqYUtHFBqjw0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
Date: Mon, 9 Oct 2023 17:46:28 +0200
Cc: Jakub Kicinski <kuba@kernel.org>,
 markovicbudimir@gmail.com,
 stable@vger.kernel.org,
 netdev@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 davem@davemloft.net,
 edumazet@google.com,
 pabeni@redhat.com,
 Jamal Hadi Salim <jhs@mojatatu.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CBA18C8-51A4-443C-81D1-8D43B0F6AA76@flyingcircus.io>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
 <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
 <20231009080646.60ce9920@kernel.org>
 <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

> On 9. Oct 2023, at 17:31, Pedro Tammela <pctammela@mojatatu.com> =
wrote:
>=20
> We had a UAF with a very straight forward way to trigger it.
> Setting 'rt' as a parent is incorrect and the man page is explicit =
about it as it doesn't make sense 'qdisc wise'. Being able to set it has =
always been wrong unfortunately...

Well - this is a complex thing and even though I took care when setting =
it up I did not find this in the manpages sufficiently highlighted and =
built such a system: this has been running for more than a year, it did =
what I wanted AFAICT and upgrading a micro version broke it =
catastrophically.

The argument that this never should have been built, feels a bit like =
=E2=80=9Cthis has been written for 50 years in the basement of the =
office for planetary destruction on Alpha Centauri and earthlings had =
more than enough time to come and complain=E2=80=9D =E2=80=A6 ;)
=20
Hugs,
Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


