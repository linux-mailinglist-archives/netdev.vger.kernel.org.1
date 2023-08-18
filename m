Return-Path: <netdev+bounces-28844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5BD780FED
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0686928240C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36C419BB2;
	Fri, 18 Aug 2023 16:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796917AAC
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:10:58 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECFC35BB
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:10:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1344263a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692375056; x=1692979856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41qfF2rDjgnUSHUgG2/XWiGlbnndu7FcBrWK0wJOx5U=;
        b=sgLdpzWSEW85aFWZ9IqWqrtx8unXK7p+EIt+qUbpbcwLTvDO1gRQoTnYViNN4Kbujm
         tIQZBoQyvovRHDImY2vPhDXpYLXrlelJ1NlOQFOyL1z0M/ZgcTHLqt5T2cxhGPWE6HQ6
         V/Or1Lnr6/8xGkXFqbKyXP+Vn8YwRPBHCXeNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375056; x=1692979856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41qfF2rDjgnUSHUgG2/XWiGlbnndu7FcBrWK0wJOx5U=;
        b=U1FYEcT99gba0vgamApNhpMLz3N6s5+leA3a4LbQ1JtfvNS3XuugnzEF9I10e+A+tI
         go/7wkaxn+fyVmRDr1ildqZramTj/+3uoMcMs1+CpLmYpY5lH6JZDLO6BLPqzGySJcQz
         JIGwXTMtTWziG/HKpdV2nbAyimYVXVIkJB57v+J2VGzZ2ecktwJacaoHxCkdcJ4CrdRK
         piFHdI/cpvKsLE1ctDNXCnYM6NUnCOyzELFdUFFTfYpeksrw77Lq++Fz3MRA+S/tcS7b
         kcMs8PSSa4OIwNXD56q4cZmRLkSZl+12cxJR7Lzn9KYN1c9xJFwmJZTRXiKbANsEdwR7
         Dq5A==
X-Gm-Message-State: AOJu0Yw7QxQi2eBfKT+73pK2wFzLLLk6WOPfXWEbQaFzrLHWwJ66pC2S
	w8CGt4n7AXO8BvHpFXPaAc+tAooLaaBru8y+h0dObQ==
X-Google-Smtp-Source: AGHT+IEw2PzKZbmQLG51l1VNKzmJafq1ZnLchM0x2UwO8LQRZoqpGzbStf5i0pqWiTK3I22RJEhUrZ2ko3iSngM0WI8=
X-Received: by 2002:a05:6402:7c1:b0:523:22f6:e8a5 with SMTP id
 u1-20020a05640207c100b0052322f6e8a5mr2087451edy.39.1692375055993; Fri, 18 Aug
 2023 09:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1692326837.git.yan@cloudflare.com> <10b3dff2-7be4-ab98-e4a5-968ebb93c25f@iogearbox.net>
 <CAO3-PbqUczUxg42ECStsZnAybYKBY-hJePN=V-JbPvq-BS4cGA@mail.gmail.com> <61e79414-9290-736f-6a50-dfe1585dc2a7@iogearbox.net>
In-Reply-To: <61e79414-9290-736f-6a50-dfe1585dc2a7@iogearbox.net>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 18 Aug 2023 11:10:45 -0500
Message-ID: <CAO3-PbovC6Dd6B_OO6zSX8gd3NrtpfF0t1pYH1Obi3VoikY0KQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf 0/4] lwt: fix return values of BPF ops
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Graf <tgraf@suug.ch>, 
	Jordan Griege <jgriege@cloudflare.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 11:08=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 8/18/23 6:01 PM, Yan Zhai wrote:
> > On Fri, Aug 18, 2023 at 9:55=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> On 8/18/23 4:58 AM, Yan Zhai wrote:
> >>> lwt xmit hook does not expect positive return values in function
> >>> ip_finish_output2 and ip6_finish_output. However, BPF programs can
> >>> directly return positive statuses such like NET_XMIT_DROP, NET_RX_DRO=
P,
> >>> and etc to the caller. Such return values would make the kernel conti=
nue
> >>> processing already freed skbs and eventually panic.
> >>>
> >>> This set fixes the return values from BPF ops to unexpected continue
> >>> processing, checks strictly on the correct continue condition for
> >>> future proof. In addition, add missing selftests for BPF redirect
> >>> and reroute cases for BPF-CI.
> >>>
> >>> v5: https://lore.kernel.org/bpf/cover.1692153515.git.yan@cloudflare.c=
om/
> >>> v4: https://lore.kernel.org/bpf/ZMD1sFTW8SFiex+x@debian.debian/T/
> >>> v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.c=
om/
> >>> v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/
> >>> v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
> >>>
> >>> changes since v5:
> >>>    * fix BPF-CI failures due to missing config and busybox ping issue
> >>
> >> Series looks good, thanks! Given we're fairly close to merge window an=
d
> >> this has been broken for quite some time, I took this into bpf-next.
> >>
> > Thanks Daniel! Can you also queue this up for stable (or guide how I ca=
n do it)?
>
> Given the Fixes tags, it will be picked up automatically once it lands in
> Linus' tree.
>
Wonderful. Thank you!

> Thanks,
> Daniel

