Return-Path: <netdev+bounces-19546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360575B25E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D4A1C2123B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE9C18B1E;
	Thu, 20 Jul 2023 15:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5218B1B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:22:06 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C384B13E
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:22:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6864c144897so197273b3a.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1689866525; x=1690471325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jNhnR+ye5SEakvh+tGW6i8mQKb+NDXkkhU62vn/+c8=;
        b=eh5OTxF8ssTPMy9eN4Nln0Kvg4S0wZoft2ke4YL3WqLJstWote7jOp6Dk/6M2Y7SeT
         h3qS0ic62YlflNjqq/LynK9RdNAm/+ZFQE+zQgIB1HvRmIFLmjoawgRnl1wcEqKSGMWL
         q10NL06sl+Bq7jAvh3LzDmky1K+DzgYHyu91Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866525; x=1690471325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jNhnR+ye5SEakvh+tGW6i8mQKb+NDXkkhU62vn/+c8=;
        b=Ow7Q/GPTTVNZLCkfztNOb8dczTJNIRUqMC6Du2dXQunYpKFm2dja+b55N4pw+x5MV8
         y1zg4QpLmx7Mj/363cU82InKsUW91t6Z3eJpPceMh7OHSwsSBNMnuKWgVm2d8Zsro08p
         SbCXLQ9yqcx60b1L8i+iD659ZSeRn8j3EeQUEjw08vSp39DSSkYVtSkbS8j220NvTasF
         Tu3UZ7Hmw4Wz/uRvB7Is8W4/NviM/FcZ5Bnflx83agW6oIHNd1ZNPr90HICjQ40ueQmb
         h5opsosFZvEHednebFIHGM0ggNDDQG0dpAfbSx1ZTs1tveGMzqOpIS0OqA4Pvc75HjFk
         CZcA==
X-Gm-Message-State: ABy/qLazyFndgp2K3Dqnv7SBk89S1wwuYzyMRjIKKCdZwEt3Yu5lMSwP
	xYvbW6py2bzmiIcu9rjwL1RRc7CX7UPnM0+n7f13+w==
X-Google-Smtp-Source: APBJJlE4X/A4ZMOioySFAnqd/G3ycv8NyoRPzE5yjcSpeiSNUnhUyl95syR+9ELPrn/tFVkseHIGaEyFiVMv0WVPSJY=
X-Received: by 2002:a05:6a00:988:b0:686:2526:ee7d with SMTP id
 u8-20020a056a00098800b006862526ee7dmr3493442pfg.0.1689866525264; Thu, 20 Jul
 2023 08:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
 <20230720105042.64ea23f9@canb.auug.org.au> <20230719182439.7af84ccd@kernel.org>
 <20230720130003.6137c50f@canb.auug.org.au> <PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
 <20230719202435.636dcc3a@kernel.org> <20230720081430.1874b868@kernel.org>
In-Reply-To: <20230720081430.1874b868@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 20 Jul 2023 17:21:54 +0200
Message-ID: <CAJqdLron07dGuchjmPZcD6xe5af+qpgNMThz5G8=tR7n4=fU1A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, David Miller <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 5:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 19 Jul 2023 20:24:35 -0700 Jakub Kicinski wrote:
> > On Thu, 20 Jul 2023 03:17:37 +0000 Von Dentz, Luiz wrote:
> > > Sorry for not replying inline, outlook on android, we use scm_recv
> > > not scm_recv_unix, so Id assume that change would return the initial
> > > behavior, if it did not then it is not fixing anything.
> >
> > Ack, that's what it seems like to me as well.
> >
> > I fired up an allmodconfig build of linux-next. I should be able
> > to get to the bottom of this in ~20min :)
>
> I kicked it off and forgot about it.
> allmodconfig on 352ce39a8bbaec04 (next-20230719) builds just fine :S

Dear Jakub,

Thanks for checking!

As I can see linux-next tree contains both patches:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=
=3Dnext-20230719&qt=3Dgrep&q=3DForward+credentials+to+monitor

So, the fix is working, right?

Kind regards,
Alex

