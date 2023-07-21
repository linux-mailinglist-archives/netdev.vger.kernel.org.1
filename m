Return-Path: <netdev+bounces-20001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173475D545
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1A41C216C1
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECB822F17;
	Fri, 21 Jul 2023 19:56:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134620FA0
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:56:30 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4D171A
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:56:29 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-579ef51428eso25862627b3.2
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689969389; x=1690574189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WvGq0MYBWXaNr+el50jQy906imQ6eE05h3UFyIJnR0=;
        b=xaZgLXHxXDY/D9efXYW4S2fipcQqU8WCRvdtq+VH3+HREfgjTveyPIY0/0HURIvOmW
         aGwk1TiUqH52SufsxfnU57gUDQAvjE5hA58iMyRfikJVRqLwT0gfhK070pdEuS6Z5mX4
         /A+wpcfBwH3c1VrF09R3D2KjjU/dAx62EUF+ZbKOY11zaT0nUgt8nS80J7Uvz0SRhhsF
         6k6NQfagAUEsGhA4zhO60aNbTshZ3G3XgL4NL8Xr/MEWlhNmQDRcrk9rSGGuf7Ja76Jd
         Gz2UCQr94qgeGgLZkGiYTSyzDnXs7rMinI8VcKnY7Uc9lIn4dvrjJKgkPrIGp39ttupk
         tPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689969389; x=1690574189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WvGq0MYBWXaNr+el50jQy906imQ6eE05h3UFyIJnR0=;
        b=JvTc4R9ab1ZW6llN+3xhMUYPIEZZTqRriuahWirhXmV6oH2WBjCQ47VJDDBK47lcO2
         mDWxDbrwRNTXi/fqhDXFao0SnC9NLviEwZkPBGS4Dmg8PlGCi/yV8/CIP2cx53J4JtgY
         1UGIRtsODNCNNu82UTZ0GV6KDzsq8J8IzBXj4tYn+he58OBZjozctEpMUcLJXljPmfFB
         hx3a98EqPkb7ihAGPOnox/atecb+WEtm8hrLv5M9/O2jtGoW6whO6uRhU+mRyuzUa2lM
         0diqs6LKRZ4UE952pufRSyqUeY9PlKgSSO/T98C8SLap0cm+xbzo3plE3QV0+ovo2YKV
         CGYw==
X-Gm-Message-State: ABy/qLbJyzw3X6lDc8tqpdceJFtDm0QcJ7F74PT3Lw2Pd5QkY2BsA27u
	kE3XUSTFDYRShL+NGtH12fjjiu8fuc3zCgTuUaBZuA==
X-Google-Smtp-Source: APBJJlFndBSOJMgmxXs7gmzGM/CdpZEnGJwU1TKBBQ55vf0xfW2enpkQy88qJphd2zx+4cS0RRxmIFuWXLSoLdsReOM=
X-Received: by 2002:a0d:c8c1:0:b0:56d:9b15:72a with SMTP id
 k184-20020a0dc8c1000000b0056d9b15072amr1007691ywd.33.1689969389023; Fri, 21
 Jul 2023 12:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721174856.3045-1-sec@valis.email> <9a51c82f-6884-4853-8e8a-3796c9051ca8@mojatatu.com>
In-Reply-To: <9a51c82f-6884-4853-8e8a-3796c9051ca8@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 21 Jul 2023 15:56:17 -0400
Message-ID: <CAM0EoMkVVdHjU1aUxmjN7ah_iE2Beuwgf4r6ddxCWN5d77t-=A@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: valis <sec@valis.email>, netdev@vger.kernel.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, victor@mojatatu.com, ramdhan@starlabs.sg, 
	billy@starlabs.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 3:00=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> On 21/07/2023 14:48, valis wrote:
> > Three classifiers (cls_fw, cls_u32 and cls_route) always copy
> > tcf_result struct into the new instance of the filter on update.
> >
> > This causes a problem when updating a filter bound to a class,
> > as tcf_unbind_filter() is always called on the old instance in the
> > success path, decreasing filter_cnt of the still referenced class
> > and allowing it to be deleted, leading to a use-after-free.
> >
> > This patch set fixes this issue in all affected classifiers by no longe=
r
> > copying the tcf_result struct from the old filter.
> >
> > valis (3):
> >    net/sched: cls_u32: No longer copy tcf_result on update to avoid
> >      use-after-free
> >    net/sched: cls_fw: No longer copy tcf_result on update to avoid
> >      use-after-free
> >    net/sched: cls_route: No longer copy tcf_result on update to avoid
> >      use-after-free
> >
> >   net/sched/cls_fw.c    | 1 -
> >   net/sched/cls_route.c | 1 -
> >   net/sched/cls_u32.c   | 1 -
> >   3 files changed, 3 deletions(-)
> >
>
> For the series,
>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> Tested-by: Pedro Tammela <pctammela@mojatatu.com>

For the series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

