Return-Path: <netdev+bounces-22560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBE776806A
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 17:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E6282307
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADF9171A4;
	Sat, 29 Jul 2023 15:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF0D134AF
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 15:50:25 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614C030F3
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 08:50:24 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso46511831fa.1
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20221208.gappssmtp.com; s=20221208; t=1690645822; x=1691250622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30y4dPv7gs7kNg9y3SZJ1cmeUrjIgllVXjlQ9SH5JtQ=;
        b=5Lsqgx2TivlD1ba+rbGHcxfOXRF8stCPajLQpjO5tfA7UyiSe9aUKO1qFzw2DNqyeR
         CEAXuAsBz13XK1U8n2fj6BUyH1+YgGW3+imZ4zrrVOgDkH4bKWoioKUIj5bEL1IrOPct
         HPgPjC7mPgsPL7LLBX5tR5UBsPhjs6/xTlv7kAZFNPqmLoyHmjQgmAowq03jqseouvPs
         kwYnDuC0PzNr5Gl8uas2dChik9VkXALbATlM6TTYQzCLhWpxCWFaQ6QI/XLH2ETjn1zd
         vfpNMbhYj+NJcMCmMh2V/VwW/YN3iVos7lxSubufod4oh07qC7cWcZy1pqBzToCsaUYP
         v+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690645822; x=1691250622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30y4dPv7gs7kNg9y3SZJ1cmeUrjIgllVXjlQ9SH5JtQ=;
        b=gffHnj+QhDqEE2EkFQXrTsumzgjuNXvs7F2aulFQx/DHX8+mJl6QrajoZJTkIWT/oh
         jVyIgz/iWzydR+LXwKLY1b5QJpKnW02Q9PUSOWtDj/v3CnLCg5Km+AZuPc4n3I2eQtOt
         S7UzQQjkqwkZ6tkHiaPNzJXKkYaJ4pOfMFOvlrps6mxKzvfl3Gk5QPTG+YOgpWSVPndn
         8up2ih2vBCBoCl1sZHd1s+CfFynnqlf3Fv4LGpULl2izCOOQhyx6gmT58eWwc8LbQIwG
         GkNkKVtHYDszm2bviPwsNOF4eDLKDNkM+I4viwhzvqHEKwGgxImxkVfPh7q8VO2Yt6/t
         Zj+g==
X-Gm-Message-State: ABy/qLYShwBDQQd3BkwmPyOLbhNCBrbZESO4QDk9rTu4W+KPuB7iYcif
	qom8YJlVUZDIXfYANfxBekaxFXrnRKrHB3tRlqgf3JC84jjAbeLGBSaw
X-Google-Smtp-Source: APBJJlHNXMCIOWoEMyRCNTYeOytfFeb3JIOX3E3eqybj8974jCbPJCc2Ps9upuf1+y7OIxU6XS32CX0Pbsj6ddz926M=
X-Received: by 2002:a05:6512:159b:b0:4fe:19ef:8794 with SMTP id
 bp27-20020a056512159b00b004fe19ef8794mr4077254lfb.28.1690645821882; Sat, 29
 Jul 2023 08:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230729123202.72406-1-jhs@mojatatu.com>
In-Reply-To: <20230729123202.72406-1-jhs@mojatatu.com>
From: M A Ramdhan <ramdhan@starlabs.sg>
Date: Sat, 29 Jul 2023 22:49:45 +0700
Message-ID: <CACSEBQS4w4ceHt4to98wmr-_ecN=-w=FTccgVSf3ydn36LdBFw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, sec@valis.email, billy@starlabs.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 7:32=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> From: valis <sec@valis.email>
>
> Three classifiers (cls_fw, cls_u32 and cls_route) always copy
> tcf_result struct into the new instance of the filter on update.
>
> This causes a problem when updating a filter bound to a class,
> as tcf_unbind_filter() is always called on the old instance in the
> success path, decreasing filter_cnt of the still referenced class
> and allowing it to be deleted, leading to a use-after-free.
>
> This patch set fixes this issue in all affected classifiers by no longer
> copying the tcf_result struct from the old filter.
>
> v1 -> v2:
>    - Resubmission and SOB by Jamal
>
> valis (3):
>   net/sched: cls_u32: No longer copy tcf_result on update to avoid
>     use-after-free
>   net/sched: cls_fw: No longer copy tcf_result on update to avoid
>     use-after-free
>   net/sched: cls_route: No longer copy tcf_result on update to avoid
>     use-after-free
>
>  net/sched/cls_fw.c    | 1 -
>  net/sched/cls_route.c | 1 -
>  net/sched/cls_u32.c   | 1 -
>  3 files changed, 3 deletions(-)
>
For the series,
Tested-by: M A Ramdhan <ramdhan@starlabs.sg>
Reviewed-by: M A Ramdhan <ramdhan@starlabs.sg>

> --
> 2.34.1

