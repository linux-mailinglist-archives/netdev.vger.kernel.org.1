Return-Path: <netdev+bounces-16969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C974F99B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB6E1C20DAF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 21:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A11ED22;
	Tue, 11 Jul 2023 21:13:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5AB1EA8D
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 21:13:21 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0C4133
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:13:20 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bff27026cb0so7109920276.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689109999; x=1691701999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZ11FPvjWmG68Sreb5EybNYZB1Bg5yWnHJBskJ6i46E=;
        b=tZ+eY63CYLgW8EoAkvrLTCGnNywli8YYeaYmhQDMsBEUd88xg6Cy8/YpZYp74zHt5L
         Szm/9gPLa1MBUWQ7/C6to9cS77JLPxOPsiermh/RXbJ6ucR39AYp+oMdIrD32Ktw3SO5
         qX7grjZ1WxoUYkzmCl3xoJQ3MfQVI/fmsX8TQUaWdIluolwISuqwZd/aY1U9AJZyztG5
         TfjC3Th1g8OsWxX7mFoOVtGhTrEm8+gjggjzZ+3iPc9YyofgvU6rnmPzVAIX4d12Luab
         O58GNW0P1HhxPkWrVxYn+e3jNrPPuQlq7wLAzKgokfFtqzeZoYhnh5yt/jR/h/7xdzFI
         DsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109999; x=1691701999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZ11FPvjWmG68Sreb5EybNYZB1Bg5yWnHJBskJ6i46E=;
        b=B3iuU3z9L5693Pd2vUW4Rc+Vs1JP6DYUfRm1LGhHv2EEyhFmHvx72NIqED94BGjG50
         /22vqylSGRCJuhxNIQee38YOy/adXZbwjVaP+Us46mf+bgNBiTPYA7uBM3XfTHBc9E2x
         2bBmkbXlxwwoMaPHru5WFvjrWDh2cZruS0EJQCeFWbCKpV7ICzyvyNBSsZiBJTQPQMDg
         u1vJnHf2Ji1W1mY4AfH0hGa7LHvoFnDLTJxw6PL4ANKDUhfYr5xZ3y89Zzc3ueP1/IlO
         BMterVl5l0J0VzD+5BKSjGh9udDuV/Yw9/sSbcH5Qn9qjwxD5/yxPUvpR64rjqNN/D+o
         +Swg==
X-Gm-Message-State: ABy/qLYCCGtPWYxOQNPSxt3asAfB9XrQczpN4WoG3nS5WkTAFkCXWlVJ
	DODtWHNVQAXPhuGId3TkTcv9qWs9jY1GTDHIJ5d4eg==
X-Google-Smtp-Source: APBJJlEHM7rsVCN0MV/NNzz5b9tLE8L92pbCd+s9JXeYdhXGjwoDdWgKm0AKpsGtjxOmr6EIb9nQaBjtHEbBtjrq0r0=
X-Received: by 2002:a0d:f004:0:b0:577:bc0:2d55 with SMTP id
 z4-20020a0df004000000b005770bc02d55mr18354365ywe.33.1689109999457; Tue, 11
 Jul 2023 14:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711070809.3706238-1-idosch@nvidia.com>
In-Reply-To: <20230711070809.3706238-1-idosch@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Jul 2023 17:13:08 -0400
Message-ID: <CAM0EoMmo_96JkDzoS3GgnHxTCSiz5UnfkB6PYjEq01oMBU68wA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: flower: Ensure both minimum and maximum
 ports are specified
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, amritha.nambiar@intel.com, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 3:08=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> The kernel does not currently validate that both the minimum and maximum
> ports of a port range are specified. This can lead user space to think
> that a filter matching on a port range was successfully added, when in
> fact it was not. For example, with a patched (buggy) iproute2 that only
> sends the minimum port, the following commands do not return an error:
>
>  # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src=
_port 100-200 action pass
>
>  # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp dst=
_port 100-200 action pass
>
>  # tc filter show dev swp1 ingress
>  filter protocol ip pref 1 flower chain 0
>  filter protocol ip pref 1 flower chain 0 handle 0x1
>    eth_type ipv4
>    ip_proto udp
>    not_in_hw
>          action order 1: gact action pass
>           random type none pass val 0
>           index 1 ref 1 bind 1
>
>  filter protocol ip pref 1 flower chain 0 handle 0x2
>    eth_type ipv4
>    ip_proto udp
>    not_in_hw
>          action order 1: gact action pass
>           random type none pass val 0
>           index 2 ref 1 bind 1
>
> Fix by returning an error unless both ports are specified:
>
>  # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src=
_port 100-200 action pass
>  Error: Both min and max source ports must be specified.
>  We have an error talking to the kernel
>
>  # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp dst=
_port 100-200 action pass
>  Error: Both min and max destination ports must be specified.
>  We have an error talking to the kernel
>
> Fixes: 5c72299fba9d ("net: sched: cls_flower: Classify packets using port=
 ranges")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  net/sched/cls_flower.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 56065cc5a661..f2b0bc4142fe 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -812,6 +812,16 @@ static int fl_set_key_port_range(struct nlattr **tb,=
 struct fl_flow_key *key,
>                        TCA_FLOWER_KEY_PORT_SRC_MAX, &mask->tp_range.tp_ma=
x.src,
>                        TCA_FLOWER_UNSPEC, sizeof(key->tp_range.tp_max.src=
));
>
> +       if (mask->tp_range.tp_min.dst !=3D mask->tp_range.tp_max.dst) {
> +               NL_SET_ERR_MSG(extack,
> +                              "Both min and max destination ports must b=
e specified");
> +               return -EINVAL;
> +       }
> +       if (mask->tp_range.tp_min.src !=3D mask->tp_range.tp_max.src) {
> +               NL_SET_ERR_MSG(extack,
> +                              "Both min and max source ports must be spe=
cified");
> +               return -EINVAL;
> +       }
>         if (mask->tp_range.tp_min.dst && mask->tp_range.tp_max.dst &&
>             ntohs(key->tp_range.tp_max.dst) <=3D
>             ntohs(key->tp_range.tp_min.dst)) {
> --
> 2.40.1
>

