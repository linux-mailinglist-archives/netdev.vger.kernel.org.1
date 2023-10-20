Return-Path: <netdev+bounces-43065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F13E7D13FC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 18:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4971C20F12
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5D21EA80;
	Fri, 20 Oct 2023 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MP9Nijrj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D91D538
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 16:29:32 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C6FD57
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:29:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32db188e254so761214f8f.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697819367; x=1698424167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R2sOCCTir7Xw+JKgM+XdLzZ1DA4pt+bpUcx//aqhq4=;
        b=MP9NijrjT3nUCrCy4QyyZ0ca2pGjKADUZ/7PsUrxFDSkS5LEdVpzoyHqnyR7u7av/P
         DWDH0wM+sO4LQI7qEx8NvTqCiigXKv2iiSHFpioAGK2FAUa48QWOXrAWRV7m+Oc9RK3Q
         +5e68O5uVdKV8B2KAXAx0wn5qsqBGgCj3ozVh17yeZLcwkvGV644ZhPb/aVBrfEI0rvt
         cy/meutJpU4wG3pAJhPOhcGu9HJVc0euVtF/GKmqjPIoRZva7+Hm15nNpN0JDqMsUySw
         NdbaKfPscB7rnflqErVqEwLrdHC3babBS/vyo3Wmj9aPIWx0V/BcS/jRh++r6aXhLBte
         cbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819367; x=1698424167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R2sOCCTir7Xw+JKgM+XdLzZ1DA4pt+bpUcx//aqhq4=;
        b=EnWfWJkgtf7p64CCPSWmBQKn9lFq+L2Vnw7C0np16JYgm1Iu5LoDUK2bM1LEeGjQSG
         xOc5EzNiLmTOxTeeSNqGrLmQcBLYz8Lfkb1weLvVENb5dKPtZat99j0WcMZhZHXJSbr7
         YfztD6vY+RgbCuHF4WabOItI68WYX22ZAfRn5qX8IT0Xq8GMg0tFncd5Ph/BQSV3AMqG
         CiUJAVWXoYRkuJMTR4l5c3mVprfhG99Kbp1SETmXQPWTY/aMgaqiSooPBcQXYo+rBDot
         EHEMf+IZkymLSgrOvUqxSS5cSfvJOhpUipkBp9kvK5wdkRcw3qyPD3zy/vecVAzj2H7/
         Qr/g==
X-Gm-Message-State: AOJu0YwWrl5hoBgE0ifR39uc+KOzXkfCXFlcf0FhlDEpFGDDBc16CABc
	VfRuAftAsPgu5pVuaBbSzCcXARLSDCjI53wA93CIk3x/vFYmt0BWTJDaSafQ
X-Google-Smtp-Source: AGHT+IGVZEo+oNWIul83nw5KU2f2We1KdDcsvn1lS4gsZ/mwdIT9YliXjcCWO2VrCiGONN0czsB7LSHtZytrmNAkdvE=
X-Received: by 2002:adf:e10a:0:b0:319:867e:97d7 with SMTP id
 t10-20020adfe10a000000b00319867e97d7mr1968017wrz.52.1697819367061; Fri, 20
 Oct 2023 09:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com> <CAK6E8=dZHwS3ULq2zxyBNcnff8z=8E+1W=SYQdOm8qjn5cQTAg@mail.gmail.com>
 <CACSApvZkh_TvFd8G9uD_AMyJv=3NfdbszW7FeTjCexMnS6z1Pg@mail.gmail.com>
In-Reply-To: <CACSApvZkh_TvFd8G9uD_AMyJv=3NfdbszW7FeTjCexMnS6z1Pg@mail.gmail.com>
From: Kevin Yang <yyd@google.com>
Date: Fri, 20 Oct 2023 12:29:15 -0400
Message-ID: <CAPREpbZ8p-uEEot=temVGHd5QuDnuJhj7sARM+A6hv22TfkU5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 00/13] tcp: add optional usec resolution to TCP TS
To: Soheil Hassas Yeganeh <soheil@google.com>
Cc: Yuchung Cheng <ycheng@google.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, Wei Wang <weiwan@google.com>, 
	Van Jacobson <vanj@google.com>, Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eric, this nice feature has been beneficial to Google for so
many years and is finally happening upstream :)

Acked-by: Kevin Yang <yyd@google.com>


On Fri, Oct 20, 2023 at 12:20=E2=80=AFPM Soheil Hassas Yeganeh
<soheil@google.com> wrote:
>
> On Fri, Oct 20, 2023 at 12:11=E2=80=AFPM Yuchung Cheng <ycheng@google.com=
> wrote:
> >
> > On Fri, Oct 20, 2023 at 5:57=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > As discussed in various public places in 2016, Google adopted
> > > usec resolution in RFC 7323 TS values, at Van Jacobson suggestion.
> > >
> > > Goals were :
> > >
> > > 1) better observability of delays in networking stacks/fabrics.
> > >
> > > 2) better disambiguation of events based on TSval/ecr values.
> > >
> > > 3) building block for congestion control modules needing usec resolut=
ion.
> > >
> > > Back then we implemented a schem based on private SYN options
> > > to safely negotiate the feature.
> > >
> > > For upstream submission, we chose to use a much simpler route
> > > attribute because this feature is probably going to be used
> > > in private networks.
> > >
> > > ip route add 10/8 ... features tcp_usec_ts
> > >
> > > References:
> > >
> > > https://www.ietf.org/proceedings/97/slides/slides-97-tcpm-tcp-options=
-for-low-latency-00.pdf
> > > https://datatracker.ietf.org/doc/draft-wang-tcpm-low-latency-opt/
> > >
> > > First two patches are fixing old minor bugs and might be taken
> > > by stable teams (thanks to appropriate Fixes: tags)
> >
> > Huge thanks to Eric for making this happen for real :-) an immediate
> > benefit is enabling TCP timestamp based undos (Eifel) for short RTT
> > transactions. This allows datacenter TCP to use more aggressive
> > timeout w/o worrying too much of spurious timeout cwnd effect
> >
> > Acked-by: Yuchung Cheng <ycheng@google.com>
>
> Thank you so much, Eric, for upstreaming the feature!  This is a major
> milestone.
>
> Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
>
> >
> > >
> > > Eric Dumazet (13):
> > >   chtls: fix tp->rcv_tstamp initialization
> > >   tcp: fix cookie_init_timestamp() overflows
> > >   tcp: add tcp_time_stamp_ms() helper
> > >   tcp: introduce tcp_clock_ms()
> > >   tcp: replace tcp_time_stamp_raw()
> > >   tcp: rename tcp_skb_timestamp()
> > >   tcp: move tcp_ns_to_ts() to net/ipv4/syncookies.c
> > >   tcp: rename tcp_time_stamp() to tcp_time_stamp_ts()
> > >   tcp: add tcp_rtt_tsopt_us()
> > >   tcp: add RTAX_FEATURE_TCP_USEC_TS
> > >   tcp: introduce TCP_PAWS_WRAP
> > >   tcp: add support for usec resolution in TCP TS values
> > >   tcp: add TCPI_OPT_USEC_TS
> > >
> > >  .../chelsio/inline_crypto/chtls/chtls_cm.c    |  2 +-
> > >  include/linux/tcp.h                           |  9 ++-
> > >  include/net/inet_timewait_sock.h              |  3 +-
> > >  include/net/tcp.h                             | 59 ++++++++++++++---=
--
> > >  include/uapi/linux/rtnetlink.h                | 18 +++---
> > >  include/uapi/linux/tcp.h                      |  1 +
> > >  net/ipv4/syncookies.c                         | 32 ++++++----
> > >  net/ipv4/tcp.c                                | 26 +++++---
> > >  net/ipv4/tcp_input.c                          | 52 ++++++++--------
> > >  net/ipv4/tcp_ipv4.c                           |  5 +-
> > >  net/ipv4/tcp_lp.c                             |  2 +-
> > >  net/ipv4/tcp_minisocks.c                      | 19 ++++--
> > >  net/ipv4/tcp_output.c                         | 14 +++--
> > >  net/ipv4/tcp_timer.c                          | 44 +++++++++-----
> > >  net/ipv6/tcp_ipv6.c                           |  5 +-
> > >  net/netfilter/nf_synproxy_core.c              |  2 +-
> > >  .../selftests/bpf/progs/xdp_synproxy_kern.c   |  4 +-
> > >  17 files changed, 193 insertions(+), 104 deletions(-)
> > >
> > > --
> > > 2.42.0.655.g421f12c284-goog
> > >

