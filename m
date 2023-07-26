Return-Path: <netdev+bounces-21402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC4763833
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A388F281A69
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A312421D2B;
	Wed, 26 Jul 2023 13:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACBBA4F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:59:17 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1381982
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:59:16 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57045429f76so79851257b3.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690379955; x=1690984755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HngRKSWlhyuXeBPohNGKJYx7BRxoskl/80yyxs/+KnY=;
        b=inRTxRtUrR7SWPoBzqjsTRVPJW4k0i0iG7p192GmmcnPOub/DxNsetD5o7ctw8ulXm
         yulQupgdn8Uk8XXNee1l+bsTgB1guDqEPphTCnBNDsbfokhCgM9Ac6UDOGETyN6Iy0XP
         5Lix2kgm9MoN3vW6VTOpiqQwrIBZQakSw3NjL+IE7TREZzPZVdxbXKKCjTcaDN0gARnF
         3xlEQvoixAW7dvicFp1OvaoFlTJafpoNV3Yiy1b+cEUg15CzQcv5i6+A/Um+hZAkQJ5t
         ifnH9jE9zz8hGWfbUguT/SA4fQu/sUlzxYu3Fib72l2hueqLMTfZqhzxRwC8OA3UxCN5
         QmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379955; x=1690984755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HngRKSWlhyuXeBPohNGKJYx7BRxoskl/80yyxs/+KnY=;
        b=C8zgGl++DBayTW9sZtao2bEw/3sjdtKfa1aO2Mi5Yg8IE5g7ow0n7hfOvPgC2eKHhW
         ekNqT0JKJGYzQwX3GPPkB/4JIHL5j70Zj+W7SYtv/0xRHOULr/MWGn55W8EOxIjpbnVr
         3fD0O00G0iLlHhO7+KCnWN1CBLqD3bOgb+NBnylKqZtiO+iTtCyxWFWwRmMWJmHbN4QT
         oWpwhoRqxs52csE0IQpPTkJ247zpVNwOkJVMrnn+lxG0VvY2JYu3Zz5TZiZ8gLykxgIi
         D3aJ9/ulqX+u1W37qrdncO1amyg8chWlxz57MEBMbcWOvS2b0DL1ED7SVcgTrMCCVDWq
         4/Mw==
X-Gm-Message-State: ABy/qLZ5udy8AoZzPc4SUCt+uqWXNy8C3WKiYAT97heqFUhImj9CNV5h
	1ABebn6X7nZvcV3uswnv1kdh446hP7Tc/vv2U9ZrOw==
X-Google-Smtp-Source: APBJJlHuKHVF2brI5nNrQrBpu1ydpa3DbzZphveuMYk5ly3a/rv0dusVk4tqDztfqfCkwdEO9y3wJQrto6Bf8fR1hng=
X-Received: by 2002:a0d:f606:0:b0:562:1850:bbf0 with SMTP id
 g6-20020a0df606000000b005621850bbf0mr2191616ywf.21.1690379953895; Wed, 26 Jul
 2023 06:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721174856.3045-1-sec@valis.email> <8a707435884e18ccb92e1e91e474f7662d4f9365.camel@redhat.com>
 <CAEBa_SB6KCa787D3y4ozBczbHfZrsscBMmD9PS1RjcC=375jog@mail.gmail.com>
 <20230725130917.36658b63@kernel.org> <CAEBa_SASfBCb8TCS=qzNw90ZNE+wzADmY1_VtJiBnmixXgt6NQ@mail.gmail.com>
 <20230725150314.342181ee@kernel.org>
In-Reply-To: <20230725150314.342181ee@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 26 Jul 2023 09:59:02 -0400
Message-ID: <CAM0EoM=LiL-exVpP-sTT8rh=odFhu_eYY=ob6yMxQP5MGTU00w@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
To: Jakub Kicinski <kuba@kernel.org>
Cc: valis <sec@valis.email>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, pctammela@mojatatu.com, victor@mojatatu.com, 
	ramdhan@starlabs.sg, billy@starlabs.sg, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 6:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 25 Jul 2023 23:36:14 +0200 valis wrote:
> > On Tue, Jul 25, 2023 at 10:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > We don't know who you are. To my understanding the adjustment means
> > > that you are not obligated to use the name on your birth certificate
> > > but we need to know who you are.
> >
> > I could start a discussion about what makes a name valid, but I'm
> > pretty sure netdev is not the right place for it.
>
> Agreed, I CCed Greg KH to keep me honest, in case I'm outright
> incorrect. If it's a gray zone kinda answer I'm guessing that
> nobody here really wants to spend time discussing it.
>
> > > Why is it always "security" people who try act like this is some make
> > > believe metaverse. We're working on a real project with real licenses
> > > and real legal implications.
> > >
> > > Your S-o-b is pretty much meaningless. If a "real" person can vouch f=
or
> > > who you are or put their own S-o-b on your code that's fine.
> >
> > I posted my patches to this mailing list per maintainer's request and
> > according to the published rules of the patch submission process as I
> > understood them.
> > Sorry if I misinterpreted something and wasted anybody's time.
> >
> > I'm not going to resubmit the patches under a different name.
> >
> > Please feel free to use them if someone is willing to sign off on them.
>
> If Jamal or anyone else feels like they can vouch for the provenance
> of the code, I think that may be the best compromise.

I am more than happy to add my SoB - these are real issues being fixed
and this is not the first time that Valis identified and helped
resolve legit issues in tc.

cheers,
jamal

