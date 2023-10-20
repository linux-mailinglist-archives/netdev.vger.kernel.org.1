Return-Path: <netdev+bounces-43087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D047D15ED
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 20:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780A32825F0
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901D1D6BE;
	Fri, 20 Oct 2023 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4tmyFOO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4618F74
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 18:42:02 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAAE114
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 11:42:00 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-457c7177a42so465544137.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697827320; x=1698432120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mz8cRirWbUk9y7q5BrLgqfbyUWDIhOOYJWU8Exrqr68=;
        b=v4tmyFOOsYDzw6SfNVtNKQY6CDrizMPxhRPOfUdrQcIc6LAw3vNVbRIperafUcZ8EO
         G9jy03k1eeLFSeUkTrsKsQCz0gR8yhi+SGRflX114I07ojxaD+4OB0OvIGX7uEFD/8sc
         Ts1PqAvCbwtRyfOd7NuTX9gnndlOefngp6lshuMbvfFfMSfUMGallh+FB0vMgI72FQCX
         dG/GW0aOndHQDu9LVWxAQ8f12idlj9oGUnABtdvmgEE6+Uur2UIaBeW4pV/b62N8+y4C
         y4CO3Rk4YA6cYIVUbNoNsp3a+lk6A2MyOq04P2ipGUP5oywYbVo6dJr3St4N/YGQ3/AG
         t2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827320; x=1698432120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mz8cRirWbUk9y7q5BrLgqfbyUWDIhOOYJWU8Exrqr68=;
        b=WLTayaeu5rAD4RVoKiN1U0RQ7GBUZ4+jv6Jv15LDZ/tDO7GPQBJCkqk6/o0gtffBQQ
         xRq1gc4+zb09dzGyR7hQs2BIlhIeaPj4gvVjN7BpPfZH9RS1VnHIrnnSO3ReaLwoo6vG
         VaR0ZUuWxPTDm04V7Uh3Fvds/jyAPFkZZTiEXw9A2WMQktKheK1x0EE4Cl6xtEBnR9aN
         1s500f50msvaAVfx9jTUOerl9PiK4IPeFebe3GSDm+0wH3mmUreBOiuOT4f2UuPvfoAk
         b1hapzDFB/I0o7VOxM5o0ymZs55jESWcYRDE+A//DSvwKudF+3XvZcMleVP7UZkVxnQI
         8j6g==
X-Gm-Message-State: AOJu0YybNWjK8NDgyStoVs+tsowE9fjRnW3XrpcXoVPNAXAjH0Av+eJg
	rcRoHEX2Es3KHL40MlahI7o1YdYu1Hq0NzIWYl8KKbliHM0qmK1/nKlMBg==
X-Google-Smtp-Source: AGHT+IFvUlN8cBlIukSVpyXX7zwgq2rUW/hsEMeBr7MzuL3vU9JuoGBbDJd+Q4LcBBQ4IiSwNnE/jUHZjw1tyCmuY9M=
X-Received: by 2002:a05:6102:2005:b0:44d:626b:94da with SMTP id
 p5-20020a056102200500b0044d626b94damr3028553vsr.32.1697827319811; Fri, 20 Oct
 2023 11:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 20 Oct 2023 14:41:42 -0400
Message-ID: <CADVnQymW05vi9nj3FBUEwCsZcqkEihXoMQrG7Oa-21Rv36Z9_Q@mail.gmail.com>
Subject: Re: [PATCH net-next 00/13] tcp: add optional usec resolution to TCP TS
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 8:57=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
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

Thanks for sending this upstream, Eric! Great to have this upstream.
+1 to the nice benefits mentioned by Yuchung and Van.

The whole patch series looks great to me.

Acked-by: Neal Cardwell <ncardwell@google.com>

thanks,
neal

