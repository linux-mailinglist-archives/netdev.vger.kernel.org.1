Return-Path: <netdev+bounces-19974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC2575D109
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D831C217AD
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F5520F81;
	Fri, 21 Jul 2023 18:05:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CF1F199
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 18:05:10 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC62737
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:05:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fdddf92b05so3186354e87.3
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20221208.gappssmtp.com; s=20221208; t=1689962706; x=1690567506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVqNYL3XjzoPCIWJTZbuS6Fer0JH5qmcr31N1P6xHoc=;
        b=N2R+ND+jQta05sKQVyC2mIeJ6xT9o76WcJwLwjVtiedvWqMTsC//HprrYUEP/RhWT+
         i0xVJ42GGzW62Wr/rmuG4HmpVoW5QlZI4Ksng8tA/Z7xe8iiZUKnXj4zHlJP211zt6+P
         M4MlWadpPJLaD4lCj24psD+U0EZg6LlHNdT0eoVLnpAAnvvp2aaQa2EDtYsrlYsr3K7J
         c3rPItFjINlDXtZTCEml6/YYb84XUUycFnSrdRs15LkuF4r7kYZWgqbSVFaNjpNHi7bn
         eVMEzhOIiW80JWyonw8MR4qoH7SZqR/EatODeaFV6569NDZGIrHSmWzLsFKGGIQefB57
         uigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962706; x=1690567506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVqNYL3XjzoPCIWJTZbuS6Fer0JH5qmcr31N1P6xHoc=;
        b=c0Tr7/RCEXkpiiEw9lZVuf8HNqU745MAsMEg/RGpEVQ/0eNHICeZbexuahfzd1wtQz
         g3DDkM0GvdAUV7M4Qrpnp8QL1i5MNwR07k05ltXmK65zb+nTOnb1nnZTZFMMBbxsxFnH
         7UMYRLsJdW+s6twjT4Tg+CMEJmF9Z0wAAIP6xc8R3+5cZGmkGEIlPoYeUyP6mxnAjHi1
         RN8z87DsGxd98d3TUxLYwDH87ybVrjgiIOHBSfWXAEW35jJ7UD0dHDiCITF2HmCga+dr
         4Etp7DDK7J9pleA1q2h8KUrE/+ShG+C22XWtUULKBzglA8oaP235IePQNJUdnM9Ok7b9
         Yq3w==
X-Gm-Message-State: ABy/qLbbP7evzBzIB4yWch+EoOXKd+thhwbFiWtLdkd9g2p0RyfFFgTj
	YHMYX43W/lhPeqcmKob6xaHaYikGSNQhZLFMt/Hw
X-Google-Smtp-Source: APBJJlFkJR62U0G3MQVG800LCTtQMMHDhs6wNe6mfrwpehKQWJ53Tpc4BsVvPRyyJ+G17e6r1RCFcdFvSmewDJTjey8=
X-Received: by 2002:a05:6512:ac2:b0:4fb:9168:1fc7 with SMTP id
 n2-20020a0565120ac200b004fb91681fc7mr2071310lfu.51.1689962706070; Fri, 21 Jul
 2023 11:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721174856.3045-1-sec@valis.email> <20230721174856.3045-2-sec@valis.email>
In-Reply-To: <20230721174856.3045-2-sec@valis.email>
From: M A Ramdhan <ramdhan@starlabs.sg>
Date: Sat, 22 Jul 2023 01:04:29 +0700
Message-ID: <CACSEBQQdOJAX1yqDMLb_yQMpU2yoUShhS_pCSDndWepxfw3Rsw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/sched: cls_u32: No longer copy tcf_result on
 update to avoid use-after-free
To: valis <sec@valis.email>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pctammela@mojatatu.com, victor@mojatatu.com, 
	billy@starlabs.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 22, 2023 at 12:51=E2=80=AFAM valis <sec@valis.email> wrote:
>
> When u32_change() is called on an existing filter, the whole
> tcf_result struct is always copied into the new instance of the filter.
>
> This causes a problem when updating a filter bound to a class,
> as tcf_unbind_filter() is always called on the old instance in the
> success path, decreasing filter_cnt of the still referenced class
> and allowing it to be deleted, leading to a use-after-free.
>
> Fix this by no longer copying the tcf_result struct from the old filter.
>
> Fixes: de5df63228fc ("net: sched: cls_u32 changes to knode must appear at=
omic to readers")
> Reported-by: valis <sec@valis.email>
> Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
> Signed-off-by: valis <sec@valis.email>
> Cc: stable@vger.kernel.org
> ---
>  net/sched/cls_u32.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 5abf31e432ca..19aa60d1eea7 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -826,7 +826,6 @@ static struct tc_u_knode *u32_init_knode(struct net *=
net, struct tcf_proto *tp,
>
>         new->ifindex =3D n->ifindex;
>         new->fshift =3D n->fshift;
> -       new->res =3D n->res;
>         new->flags =3D n->flags;
>         RCU_INIT_POINTER(new->ht_down, ht);
>
> --
> 2.30.2
>
Hi,

We also thought it's also the correct fixes,
but we're not sure because it will always remove the already bound
qdisc class when we change the filter, even tho we never specify
the new TCA_U32_CLASSID in the new filter.

I also look at the implementation of cls_tcindex and cls_rsvp which still c=
opy
the old tcf_result, but don't call the tcf_unbind_filter when changing
the filter.

If it's the intended behaviour, then I'm good with this patch.

Thanks & Regards,
M A Ramdhan

