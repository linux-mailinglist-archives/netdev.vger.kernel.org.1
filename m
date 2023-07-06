Return-Path: <netdev+bounces-15826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F6674A0A3
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 17:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2861C20D93
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D48A93D;
	Thu,  6 Jul 2023 15:15:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D6A934
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 15:15:24 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB95BFC
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 08:15:22 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401d1d967beso347851cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688656522; x=1691248522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpGpAQmib7AieXYXfdYPBfo4tIvs1dISWNbtWLrUCAY=;
        b=oC2TBHGb8oAglxzFT14s5CIpIcKC/IFDMbpHjYHxw9v9AyDaTWddlQVmMiKGJtPmws
         IHscHLJegfng58f66wj8cWchVzSj8ViztEI+jQrXO+OCC3lsfnwgiD9WDPpotBE+M4o3
         LM7MR4sSyH7YZc28myPgK16gPUINlBe6RP+vmfNSGV3HVl7jLGQVczYYLrN7xOdfyU3c
         JcaR5f7cppuABMJpBSpnA15C4TYSU+/Cv23WpA4lOdFCYvLGAA8MdOFmg30owXhZlZD4
         Aq4sEa+zWXK0VLUdROX1nndFh0wEi3910Jr+bpQAZzfY9RBR+mq3sYNxdRWa/v2sFaar
         fwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688656522; x=1691248522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpGpAQmib7AieXYXfdYPBfo4tIvs1dISWNbtWLrUCAY=;
        b=V/1HHlpiWShIZZVnk5CEwSDwhwles6Yw99H9styHoV+lGywRhRt50ubNr+GyUhLYq6
         8AWL5+qNCWAI0bxgEiTdPQb4Q08mVUQIJZjS6vEbQTYcb5jk2qk57fIZNMoeAliTb+LR
         RoChMAlD2v4gzZ0U51eL/cFJFB+MsPBi3NP+17rDjxc8zG6J0xsyMI+/yb+BUTpFLhSI
         0YXBRYA7GZrKu8FPIivVu2FHcUBkBJ5MFqnGlQvtbWsIFAft3d3PQ3ooivPhuQmPkr1X
         FGv64u7rgSmfGWJcm3ZLARS3bJt+jlVvYsweRUKKv5/NjFVsc1BQqJFc1IBOsrOZm0qZ
         87Aw==
X-Gm-Message-State: ABy/qLYy07rLWrd8ioMDcksH/corO3A5TbLKpAVVOoqyJVGDbf4EhRRP
	qVB3RjZZgIF/YwTfB+iiK/A5RhnAPLFC43pmXu9O0A==
X-Google-Smtp-Source: APBJJlE9iPSDPc1pW6w/jtSKNjtYqKZQbBBhgLPVa21AEZrhjqN2Byoo0hl6J4OQRV8rl5BqD7MRDK146OAiZqkA7vw=
X-Received: by 2002:a05:622a:100a:b0:403:96e3:4745 with SMTP id
 d10-20020a05622a100a00b0040396e34745mr16015qte.20.1688656521581; Thu, 06 Jul
 2023 08:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <381c0507-ecba-f536-7c7d-c92cf454d4e0@huawei.com>
In-Reply-To: <381c0507-ecba-f536-7c7d-c92cf454d4e0@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jul 2023 17:15:10 +0200
Message-ID: <CANn89iLrVzT38P_uVCwQKFYVeQeSTOsaeA7T57KnThKgrAsYiQ@mail.gmail.com>
Subject: Re: [Question] WARNING: refcount bug in addrconf_ifdown
To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	hannes@stressinduktion.org, fbl@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 3:06=E2=80=AFPM Ziyang Xuan (William)
<william.xuanziyang@huawei.com> wrote:
>
> Hello all,
>
> We got the following WARNING several times in our ci:
>
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 3 PID: 9 at lib/refcount.c:28 refcount_warn_saturate+0x210/=
0x330
> ...
> Call trace:
>  refcount_warn_saturate+0x210/0x330
>  addrconf_ifdown.isra.0+0x1be8/0x1e10
>  addrconf_notify+0xa8/0xcf0
>  raw_notifier_call_chain+0x90/0x10c
>  call_netdevice_notifiers_info+0x9c/0x15c
>  unregister_netdevice_many+0x3e4/0x980
>  default_device_exit_batch+0x24c/0x2a0
>  ops_exit_list+0xcc/0xe4
>  cleanup_net+0x2b8/0x550
>  process_one_work+0x478/0xb54
>  worker_thread+0x120/0x95c
>  kthread+0x20c/0x25c
>  ret_from_fork+0x10/0x18
>
> The code where the problem occurred is as follows:
>
> static int addrconf_ifdown(struct net_device *dev, bool unregister)
> {
>         ...
>
>         /* Last: Shot the device (if unregistered) */
>         if (unregister) {
>                 addrconf_sysctl_unregister(idev);
>                 neigh_parms_release(&nd_tbl, idev->nd_parms);
>                 neigh_ifdown(&nd_tbl, dev);
>                 in6_dev_put(idev); // WARNING here for idev->refcnt
>         }
>         return 0;
> }
>
> Because we enabled KASAN, and no UAF issues reported on idev. So I though=
t
> the last decrement of idev->refcnt must be by __in6_dev_put() which is ju=
st
> decrement no memory free for idev. And idev was not be freed.
>
> The functions that call __in6_dev_put() are addrconf_del_rs_timer(),
> mld_gq_stop_timer(), mld_ifc_stop_timer(), mld_dad_stop_timer(). They
> are all related to timer. I compared the mod_timer functions correspondin=
g
> to these functions. I found that addrconf_mod_rs_timer() is suspicious.
> Analyse as below:
>
> static void addrconf_mod_rs_timer(struct inet6_dev *idev,
>                                   unsigned long when)
> {
>         /* rs_timer is pending at time A, condition not established, no i=
n6_dev_hold() */
>         if (!timer_pending(&idev->rs_timer))
>                 in6_dev_hold(idev);
>
>         /* rs_timer is not pending when do the following at time B.
>          * rs_timer callback addrconf_rs_timer() will be executed later,
>          * and in6_dev_put() will be executed in addrconf_rs_timer(),
>          * but this is wrong. idev->refcnt has been decreased more one.
>          */
>         mod_timer(&idev->rs_timer, jiffies + when);
> }
>
> The following implementation for addrconf_mod_rs_timer() is more reasonab=
le,
> and avoid the above potential problem.
>
> static void addrconf_mod_rs_timer(struct inet6_dev *idev,
>                                   unsigned long when)
> {
>         if (!mod_timer(&idev->rs_timer, jiffies + when))
>                 in6_dev_hold(idev);
> }
>
> Because the problem is low probability, and I could not reproduce until n=
ow.
> I am not entirely sure that the problem is the cause of my analysis.
>
> Do you think my analysis is reasonable? And do you have more ideas for th=
e problem?
>
> Welcome to give me feedback. Thank you for your help!

I think this makes a lot of sense,

A similar issue was fixed in commit f8a894b218138 ("ipv6: fix calling
in6_ifa_hold incorrectly for dad work")

Please send a formal patch ?

Thanks !

