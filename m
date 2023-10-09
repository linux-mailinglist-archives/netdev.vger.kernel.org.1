Return-Path: <netdev+bounces-39222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EB37BE580
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2128E1C20B3F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6023437C84;
	Mon,  9 Oct 2023 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="reegtI8/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4637C90
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:52:32 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97655131
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:52:24 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7a80a96dbso3849387b3.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696866743; x=1697471543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h3tvF9Aa+S+aWzN6tHoBixZGqS5pfUK27UfZ/4HscM=;
        b=reegtI8/fSFEhmh+ioXe3pjz2RLHA52cXT7dF2S/OmVOFmea59SfcT4LNnnna2884e
         Q2c/GwbLoweXWeNkmrcDyDT/8B0vinyGrbv8T7wgtjb2NFwdwHSTO+1rqArjbEOuzokt
         KT/MhwUvC3B1VVY90/MURcqnCyOn6tPwrnNShLvedNEwUggW3+08W4vy9bXVrv3dpyrG
         ogDwW0rGrlTXzveYU1R+vWhiNNvC2ZxivLKVbC0mKehfP78nqATG87wJqunZdqAp60zx
         XalMu2R4An46EuGIDxR38y6elZrASQ3lJXbz7S1/eq6fcAy8+SuRZ46UCbmHhXP+8xST
         7avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696866743; x=1697471543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3h3tvF9Aa+S+aWzN6tHoBixZGqS5pfUK27UfZ/4HscM=;
        b=g1X/35xJ734USkxnZmXJgnSORrajUF7T3SBhoXhCuThJ26Zq4KWaxjaW6Ws1OhvALn
         5sOPRckv3OO8DDTUWw7Oyl++NWM0XqHMftsfgFE6X9huNR/LwNv25brZurE0ZgMbLUE5
         Sqm8jzp7aH6YRLOEnVS1E4KoLRfx4L5irr3ciIWRjKCETV3vihSSvFLs4iyM7IDqMyti
         xLD55WcT5gdHAb3ySeetGbgCq7J3coyX9aQfGKowFnIOMBW7V4vSRhzpJWFPQKtOmTDj
         pvgEJIvplS+puTt8Weo9asTCU7jiWR7jCxLFjRf3KJOv5kHn5cP9iTD/orWdF14le7Hu
         wwxQ==
X-Gm-Message-State: AOJu0YyfQAS4aC0JWjhjXpxyp7iWxIyKT4Uve7eXn3bm8ZfeL85mgt+q
	seIV5yo84mTj0vuMHt01/Gamx+dC1uN2+9N/f654Aw==
X-Google-Smtp-Source: AGHT+IGypqjJw9TIRT94AAlV1oCjigzMKySzqiqVA3kXy30NxJsOcjOuhMztolc9Ql0zVxej7Jt5BmBfJN5wfs3eDBY=
X-Received: by 2002:a25:ad4a:0:b0:d85:ae0d:20eb with SMTP id
 l10-20020a25ad4a000000b00d85ae0d20ebmr7228084ybe.14.1696866742972; Mon, 09
 Oct 2023 08:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com> <20231004170120.1c80b3b4@kernel.org>
 <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
 <CAM0EoMkgUPF751LpEij4QjwsP_Z3qBMW_Nss67OVN1hxyN0mGQ@mail.gmail.com> <20231009063549.gcehavudj4gxz4oc@soft-dev3-1>
In-Reply-To: <20231009063549.gcehavudj4gxz4oc@soft-dev3-1>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Oct 2023 11:52:11 -0400
Message-ID: <CAM0EoMkYSs9oX+343OpkYbEFPPFcdEEaa92jnwmyzK2gqdKy2A@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Chengfeng Ye <dg573847474@gmail.com>, Jakub Kicinski <kuba@kernel.org>, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 2:36=E2=80=AFAM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The 10/05/2023 07:46, Jamal Hadi Salim wrote:
>
> Hi Jamal,
>
> > On Thu, Oct 5, 2023 at 5:01=E2=80=AFAM Chengfeng Ye <dg573847474@gmail.=
com> wrote:
> > >
> > > Hi Jakub,
> > >
> > > Thanks for the reply,
> > >
> > > I inspected the code a bit more, it seems that the TC action is calle=
d from
> > > tcf_proto_ops.classify() callback, which is called from Qdisc_ops enq=
ueue
> > > callback.
> > >
> > > Then Qdisc enqueue callback is from
> > >
> > > -> __dev_queue_xmit()
> > > -> __dev_xmit_skb()
> > > -> dev_qdisc_enqueue()
> > >
> > > inside the net core. It seems that this __dev_queue_xmit() callback i=
s
> > > typically called from BH context (e.g.,  NET_TX_SOFTIRQ) with BH
> > > already disabled, but sometimes also can from a work queue under
> > > process context, one case is the br_mrp_test_work_expired() inside
> > > net/bridge/br_mrp.c. Does it indicate that this TC action could also =
be
> > > called with BH enable? I am not a developer so really not sure about =
it,
> > > as the networking code is a bit long and complicated.
> >
> > net/bridge/br_mrp.c seems to need some love +Cc Horatiu Vultur
> > <horatiu.vultur@microchip.com>
> > Maybe that code needs to run in a tasklet?
> > In any case your patch is incorrect.
>
> I am currently out traveling and it would be a little bit hard for me to
> look at this right now. I can have a look after I come back in office
> around mid November.
> But I was wondering if this is stil an issue for MRP as Cong Wang
> pointed out, the function __dev_queue_xmit is already disabling the BH.

Yeah, sorry - should have read the code. Cong is right, there's
nothing for you to do.

cheers,
jamal

> >
> > cheers,
> > jamal
> >
>
> --
> /Horatiu

