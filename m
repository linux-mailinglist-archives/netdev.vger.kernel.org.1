Return-Path: <netdev+bounces-43100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EABFC7D1690
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258B51C20F7D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90AC2233C;
	Fri, 20 Oct 2023 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnZKZUwp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1891802E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 19:52:37 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97D1D52
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:52:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so386a12.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697831551; x=1698436351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSWDeA6cj4GbjOeiQsRECSOs7fXEzILOKhKiNyEQFfg=;
        b=bnZKZUwpuP7/iUP7WupqVpaZCs5Ck4YysrpU/Pr6LYTwH0GFiy+2Ynt8HfT6HRtC6M
         ymY5EcB+d5MhwVUgYj6syyKNtCh/k2eluS988zz8nEDe0jsaQ5JttwrWvvutBOY5ndpS
         fDikbVS2vpjQWgINBZKs2Ov3Ew8H/IrufcyUiMX0sTZRKkVAZFo0dceAZ7bH+XB/jBXk
         MO/APLqFjhSKO+kH0CG9uUD1W6dYn62keTOdOGhj2BI/wLIX7tcw+Ijnm5QIti700wSU
         uxgxgKoRY0W+Fg9J5j19+IihRpUf0Sr9b1M+BGi4cqD5YlVm4fgb4RnRtFnIpX9MPF8a
         Y4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697831551; x=1698436351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSWDeA6cj4GbjOeiQsRECSOs7fXEzILOKhKiNyEQFfg=;
        b=GlecH/XncrnY4kubcW2A2nGT6nLwzkmQZGGvstVh+whgLuX4b0PzGZeWlSnbjJb+n9
         8PvWJmx/D7/r0OiJWN63xFalIJc5C9jPLbNjq8e1EKi2Ne5iBw8RKjh6Ceo5kUjgRf3q
         YwfyuyIwdJYEBNZ3zMr0zXiiXAXWuMbNDfD5Uf5bGpYsDZbxkAdDE1LwuZgWKcPYWsYD
         yev0s4vAxnq8suwez8PbaLWRaNNf92AA7Uva/+OjSSqB90LfJOh3/15sqOndWRVO4Hvy
         J5M/pVM4LXgxriM4cADvbeQqdtkEAC/M1ilBuhYOvrJhe1IxTxL8w3iCWMC1hZ3Gjgie
         Hwkg==
X-Gm-Message-State: AOJu0Yy4pJp9KIY8kZJhSR8B8wQHtTN7a45c5jcIYulVefFR+Fn/417A
	IcRO3wRVfYC4DVMUNWmmyACrCRbDQpQBHo+mrKPb9w==
X-Google-Smtp-Source: AGHT+IHGyh2xVOVlGe60EMeCFm+QCMN2V7ofFQcGLzOeEt1UUciBn5flJkJP4ABhrqmhQ1KcSRqaYQ2AUgpN9O5g7jY=
X-Received: by 2002:a50:9f41:0:b0:53f:91cb:6904 with SMTP id
 b59-20020a509f41000000b0053f91cb6904mr204723edf.4.1697831549963; Fri, 20 Oct
 2023 12:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202310201422.a22b0999-oliver.sang@intel.com>
In-Reply-To: <202310201422.a22b0999-oliver.sang@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Oct 2023 21:52:16 +0200
Message-ID: <CANn89iKXU4Fj0oiBa6atA+fo7OtBTJ28EpEbu=5Li+gFbKk6gw@mail.gmail.com>
Subject: Re: [linux-next:master] [net_sched] 29f834aa32: kernel-selftests.net.so_txtime.sh.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Paolo Abeni <pabeni@redhat.com>, Dave Taht <dave.taht@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	netdev@vger.kernel.org, aubrey.li@linux.intel.com, yu.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 9:18=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "kernel-selftests.net.so_txtime.sh.fail" on:
>
> commit: 29f834aa326e659ed354c406056e94ea3d29706a ("net_sched: sch_fq: add=
 3 bands and WRR scheduling")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master e3b18f7200f45d66f7141136c25554ac1e82009=
b]
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-60acb023-1_20230329
> with following parameters:
>
>         group: net
>
>
>
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.0=
0GHz (Cascade Lake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202310201422.a22b0999-oliver.san=
g@intel.com
>
>
> besides, we also noticed kernel-selftests.net.cmsg_time.sh.fail which doe=
s not
> happen on parent.
>
> 5579ee462dfe7682 29f834aa326e659ed354c406056
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     kernel-selftests.net.cmsg_t=
ime.sh.fail
>            :6          100%           6:6     kernel-selftests.net.so_txt=
ime.sh.fail
>
>
>
> # timeout set to 1500
> # selftests: net: so_txtime.sh
> #
> # SO_TXTIME ipv4 clock monotonic
> # payload:a delay:296 expected:0 (us)
> #
> # SO_TXTIME ipv6 clock monotonic
> # payload:a delay:279 expected:0 (us)
> #
> # SO_TXTIME ipv6 clock monotonic
> # ./so_txtime: recv: timeout: Resource temporarily unavailable
> not ok 30 selftests: net: so_txtime.sh # exit=3D1
>
> ....
>
> # timeout set to 1500
> # selftests: net: cmsg_time.sh
> #   Case UDPv4  - TXTIME abs returned '', expected 'OK'
> # FAIL - 1/36 cases failed
> not ok 59 selftests: net: cmsg_time.sh # exit=3D1
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231020/202310201422.a22b0999-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

Silly me....

I will send this fix:

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 8eacdb54e72f4412af1834bfdb2c387d41516349..f6fd0de293e583ad6ba505060ce=
12c74f349a1a2
100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -651,7 +651,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 begin:
        head =3D fq_pband_head_select(pband);
        if (!head) {
-               while (++retry < FQ_BANDS) {
+               while (++retry <=3D FQ_BANDS) {
                        if (++q->band_nr =3D=3D FQ_BANDS)
                                q->band_nr =3D 0;
                        pband =3D &q->band_flows[q->band_nr];

Thanks !

