Return-Path: <netdev+bounces-43062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E37D13E5
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E261C20AB1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02951EA66;
	Fri, 20 Oct 2023 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3yPymM6j"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DBC1CF9B
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 16:20:05 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F7C1A4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:20:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507c9305727so3480e87.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697818802; x=1698423602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFgpwKxJwpiltsg/qurEhmUre1y2LPCH4+cza9etRiY=;
        b=3yPymM6jxYEa7PPHWjXiD6hnodhOtzo1Y5phFwSH0sKT1nQYQPb3IM2yGJssGsI4ST
         cwY3/E/COg4AJ7UhB/szTOVIfR0/Xjq8XaskpF7R3pHdoyB8Lq9xPtQw39XTYyEnNPas
         VEJs0KTDGEAerOVw1OpSEn/68PLRVUyeV7472sqGATFR+5QZ1FrXepy/HxxozTMUCWdQ
         wFseoczT8YEpe5JqetcRUw0cA86eewCAoR+4WIAp8m0YQ93wOWcfSQmX2G2suJ9SDfsT
         l7hwaQVG41jFa1aHAf14gmJjX0QdMBaA62b6ai7WB9+Fo8H0+WkZS4+pvTCuJnZbY9Kg
         1Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818802; x=1698423602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFgpwKxJwpiltsg/qurEhmUre1y2LPCH4+cza9etRiY=;
        b=ge8+SYbzoSnECISes1+KwYdXk2zLGQ2exSs9ItmAUsUw+ogyzeMThuOvrRcR4m1qST
         WqoRyA7d6xgoNuKRMt9kv7Awe5xrqQJx+9u5yNGHozErKmOyeki54SjH+BKn3aunRSNy
         vOcomPUVPHvQZtsscUBsKrfZ+XEJJiI/crLgPz9Vu4XiMdZ044bHgSgIyPpxXgH4nGWZ
         416OnFI7ZHHpKDS7DthxHtMpmrjBKCCzg/Mcrk85PZgChq03DZ01L8GGVV17TUkIaC1A
         73y8dSOx1+waJ3LkUW/F0BKsLYnKTFHZQlxxNsJHeLmAQDG/prLVvUhFGr15hJRqwVm7
         Bo1Q==
X-Gm-Message-State: AOJu0YwAtcJil63b2cmmlKPjbBJPqK3+VMeN8WsSc+vcMCIxg1ShR9h9
	Mvf8iwUN3ImxPD4tcVpcJi9QyVwbb2O2JZCGUUizig==
X-Google-Smtp-Source: AGHT+IG2A5Q/LOwxc1RP0TeYAhfvCEKEu+p6VrGLTI32ysAKplEMCq/NuWhaJxsLt5+98P8wqQSR6qX2L0kLb+dFpv0=
X-Received: by 2002:ac2:58c7:0:b0:505:715f:d36b with SMTP id
 u7-20020ac258c7000000b00505715fd36bmr84036lfo.5.1697818801710; Fri, 20 Oct
 2023 09:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com> <CAK6E8=dZHwS3ULq2zxyBNcnff8z=8E+1W=SYQdOm8qjn5cQTAg@mail.gmail.com>
In-Reply-To: <CAK6E8=dZHwS3ULq2zxyBNcnff8z=8E+1W=SYQdOm8qjn5cQTAg@mail.gmail.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Fri, 20 Oct 2023 12:19:25 -0400
Message-ID: <CACSApvZkh_TvFd8G9uD_AMyJv=3NfdbszW7FeTjCexMnS6z1Pg@mail.gmail.com>
Subject: Re: [PATCH net-next 00/13] tcp: add optional usec resolution to TCP TS
To: Yuchung Cheng <ycheng@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kevin Yang <yyd@google.com>, Wei Wang <weiwan@google.com>, 
	Van Jacobson <vanj@google.com>, Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 12:11=E2=80=AFPM Yuchung Cheng <ycheng@google.com> =
wrote:
>
> On Fri, Oct 20, 2023 at 5:57=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > As discussed in various public places in 2016, Google adopted
> > usec resolution in RFC 7323 TS values, at Van Jacobson suggestion.
> >
> > Goals were :
> >
> > 1) better observability of delays in networking stacks/fabrics.
> >
> > 2) better disambiguation of events based on TSval/ecr values.
> >
> > 3) building block for congestion control modules needing usec resolutio=
n.
> >
> > Back then we implemented a schem based on private SYN options
> > to safely negotiate the feature.
> >
> > For upstream submission, we chose to use a much simpler route
> > attribute because this feature is probably going to be used
> > in private networks.
> >
> > ip route add 10/8 ... features tcp_usec_ts
> >
> > References:
> >
> > https://www.ietf.org/proceedings/97/slides/slides-97-tcpm-tcp-options-f=
or-low-latency-00.pdf
> > https://datatracker.ietf.org/doc/draft-wang-tcpm-low-latency-opt/
> >
> > First two patches are fixing old minor bugs and might be taken
> > by stable teams (thanks to appropriate Fixes: tags)
>
> Huge thanks to Eric for making this happen for real :-) an immediate
> benefit is enabling TCP timestamp based undos (Eifel) for short RTT
> transactions. This allows datacenter TCP to use more aggressive
> timeout w/o worrying too much of spurious timeout cwnd effect
>
> Acked-by: Yuchung Cheng <ycheng@google.com>

Thank you so much, Eric, for upstreaming the feature!  This is a major
milestone.

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

>
> >
> > Eric Dumazet (13):
> >   chtls: fix tp->rcv_tstamp initialization
> >   tcp: fix cookie_init_timestamp() overflows
> >   tcp: add tcp_time_stamp_ms() helper
> >   tcp: introduce tcp_clock_ms()
> >   tcp: replace tcp_time_stamp_raw()
> >   tcp: rename tcp_skb_timestamp()
> >   tcp: move tcp_ns_to_ts() to net/ipv4/syncookies.c
> >   tcp: rename tcp_time_stamp() to tcp_time_stamp_ts()
> >   tcp: add tcp_rtt_tsopt_us()
> >   tcp: add RTAX_FEATURE_TCP_USEC_TS
> >   tcp: introduce TCP_PAWS_WRAP
> >   tcp: add support for usec resolution in TCP TS values
> >   tcp: add TCPI_OPT_USEC_TS
> >
> >  .../chelsio/inline_crypto/chtls/chtls_cm.c    |  2 +-
> >  include/linux/tcp.h                           |  9 ++-
> >  include/net/inet_timewait_sock.h              |  3 +-
> >  include/net/tcp.h                             | 59 ++++++++++++++-----
> >  include/uapi/linux/rtnetlink.h                | 18 +++---
> >  include/uapi/linux/tcp.h                      |  1 +
> >  net/ipv4/syncookies.c                         | 32 ++++++----
> >  net/ipv4/tcp.c                                | 26 +++++---
> >  net/ipv4/tcp_input.c                          | 52 ++++++++--------
> >  net/ipv4/tcp_ipv4.c                           |  5 +-
> >  net/ipv4/tcp_lp.c                             |  2 +-
> >  net/ipv4/tcp_minisocks.c                      | 19 ++++--
> >  net/ipv4/tcp_output.c                         | 14 +++--
> >  net/ipv4/tcp_timer.c                          | 44 +++++++++-----
> >  net/ipv6/tcp_ipv6.c                           |  5 +-
> >  net/netfilter/nf_synproxy_core.c              |  2 +-
> >  .../selftests/bpf/progs/xdp_synproxy_kern.c   |  4 +-
> >  17 files changed, 193 insertions(+), 104 deletions(-)
> >
> > --
> > 2.42.0.655.g421f12c284-goog
> >

