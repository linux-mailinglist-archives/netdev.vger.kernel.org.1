Return-Path: <netdev+bounces-43061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712FB7D13BC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 18:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25441C20D6B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1441E538;
	Fri, 20 Oct 2023 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIDMUUXm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC9171C6
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 16:11:25 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987F4114
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:11:23 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d81d09d883dso1045433276.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697818283; x=1698423083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vxwia8vyFgR381+A0ZfCl/572DJgjBavDomTJs7/CZ0=;
        b=oIDMUUXmtJ4aEvKRprxsLAS5eBwlMC+fnMU+5DfEb6xKwQY7Is30/qsE1iSijlYGOi
         Q4JfSH+xnCO3mmwO0M49jD8V7U4RsiIu/x0rIIV+DLs51HpwLtQC1/C6BLX73B7tUx7a
         G7iwxjiaADaUuNkUY6FTIpKIGw2Ey+UlUwnrk5BL46gFGFp0SJ6rCpqspebBaLnbxDAt
         eQaEZu2ATJFthM91XRPe0CUd9Bx5cF4xFTlyUJqPduV8McfBYfHz6w6ayb9M99G9OTOp
         JLMw+mTESTBxOtabPuJsKQe/NFYDvLJ7ohETL1LaO3roS9JmY8Ik2CpqomxLIHvK1B5y
         9WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818283; x=1698423083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vxwia8vyFgR381+A0ZfCl/572DJgjBavDomTJs7/CZ0=;
        b=b0kutZv+wLsz6Oj3m5K9Pezhv0L2O/DOnzRaBe48CUXaKrpv9TuzLpNsFOGzvhjLJB
         wMMMcrOlhGlNXI/qCO20UC1d5vrC+dl1FAiyqOOb/lUlLF2v7spR87FLhwtbtt1yZv1F
         8putdygbV8CY41QvqaU2KIGIVNyee7A7EoIsaC4cgSPNJI0CGE1/hrTZntEWLggxpq0j
         xGOciNtW3KBx+DzSCZXK1GYJAvRpiK9V9Ki8Y9bD2nbAZRVmMRsR/ax5V7G9fgd1HqZF
         lOjZ6qM3N9fnqQXBcp5AWHf4E38hfTSTCbIHaLv1f+6wKb0350Y5/aTdipETNlEghV+J
         JyCg==
X-Gm-Message-State: AOJu0YwkO7s+KTnIVSwRahK6WEM14cuVd+pgjrvgvMocX5YHQ8CkGcZ0
	2V5KwgBWF1TjCRfnctDaUUvX8+ulQof0dZ2xVsfvtw==
X-Google-Smtp-Source: AGHT+IENmkSmINZA+UTyd8hOGcxXuYHLey2Lzxo87W1wQzyFWR+TbxsDvl0TjzycXHLFe3/Id/cQtTq6Ba+eyjFRPe4=
X-Received: by 2002:a25:40c:0:b0:d89:4d9b:c492 with SMTP id
 12-20020a25040c000000b00d894d9bc492mr1943980ybe.22.1697818282427; Fri, 20 Oct
 2023 09:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
From: Yuchung Cheng <ycheng@google.com>
Date: Fri, 20 Oct 2023 09:10:46 -0700
Message-ID: <CAK6E8=dZHwS3ULq2zxyBNcnff8z=8E+1W=SYQdOm8qjn5cQTAg@mail.gmail.com>
Subject: Re: [PATCH net-next 00/13] tcp: add optional usec resolution to TCP TS
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 5:57=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> As discussed in various public places in 2016, Google adopted
> usec resolution in RFC 7323 TS values, at Van Jacobson suggestion.
>
> Goals were :
>
> 1) better observability of delays in networking stacks/fabrics.
>
> 2) better disambiguation of events based on TSval/ecr values.
>
> 3) building block for congestion control modules needing usec resolution.
>
> Back then we implemented a schem based on private SYN options
> to safely negotiate the feature.
>
> For upstream submission, we chose to use a much simpler route
> attribute because this feature is probably going to be used
> in private networks.
>
> ip route add 10/8 ... features tcp_usec_ts
>
> References:
>
> https://www.ietf.org/proceedings/97/slides/slides-97-tcpm-tcp-options-for=
-low-latency-00.pdf
> https://datatracker.ietf.org/doc/draft-wang-tcpm-low-latency-opt/
>
> First two patches are fixing old minor bugs and might be taken
> by stable teams (thanks to appropriate Fixes: tags)

Huge thanks to Eric for making this happen for real :-) an immediate
benefit is enabling TCP timestamp based undos (Eifel) for short RTT
transactions. This allows datacenter TCP to use more aggressive
timeout w/o worrying too much of spurious timeout cwnd effect

Acked-by: Yuchung Cheng <ycheng@google.com>


>
> Eric Dumazet (13):
>   chtls: fix tp->rcv_tstamp initialization
>   tcp: fix cookie_init_timestamp() overflows
>   tcp: add tcp_time_stamp_ms() helper
>   tcp: introduce tcp_clock_ms()
>   tcp: replace tcp_time_stamp_raw()
>   tcp: rename tcp_skb_timestamp()
>   tcp: move tcp_ns_to_ts() to net/ipv4/syncookies.c
>   tcp: rename tcp_time_stamp() to tcp_time_stamp_ts()
>   tcp: add tcp_rtt_tsopt_us()
>   tcp: add RTAX_FEATURE_TCP_USEC_TS
>   tcp: introduce TCP_PAWS_WRAP
>   tcp: add support for usec resolution in TCP TS values
>   tcp: add TCPI_OPT_USEC_TS
>
>  .../chelsio/inline_crypto/chtls/chtls_cm.c    |  2 +-
>  include/linux/tcp.h                           |  9 ++-
>  include/net/inet_timewait_sock.h              |  3 +-
>  include/net/tcp.h                             | 59 ++++++++++++++-----
>  include/uapi/linux/rtnetlink.h                | 18 +++---
>  include/uapi/linux/tcp.h                      |  1 +
>  net/ipv4/syncookies.c                         | 32 ++++++----
>  net/ipv4/tcp.c                                | 26 +++++---
>  net/ipv4/tcp_input.c                          | 52 ++++++++--------
>  net/ipv4/tcp_ipv4.c                           |  5 +-
>  net/ipv4/tcp_lp.c                             |  2 +-
>  net/ipv4/tcp_minisocks.c                      | 19 ++++--
>  net/ipv4/tcp_output.c                         | 14 +++--
>  net/ipv4/tcp_timer.c                          | 44 +++++++++-----
>  net/ipv6/tcp_ipv6.c                           |  5 +-
>  net/netfilter/nf_synproxy_core.c              |  2 +-
>  .../selftests/bpf/progs/xdp_synproxy_kern.c   |  4 +-
>  17 files changed, 193 insertions(+), 104 deletions(-)
>
> --
> 2.42.0.655.g421f12c284-goog
>

