Return-Path: <netdev+bounces-43014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3CA7D0FFD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75876281BA4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D318E33;
	Fri, 20 Oct 2023 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRP7RHNe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F910A12
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:57:52 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76A7AB
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7e4745acdso14211977b3.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806670; x=1698411470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aHa4DtT1PlNOzzJDH3ABKFnZ2iLwqUUCPMBAwifRhP0=;
        b=YRP7RHNeESLXlnsmKJR3LGJqoIagodKhgFBnAxU7z2C+mraTgYKE1qIFpTvv0IB2QU
         DjAs5q7O5H5x1KJqpKKL3C6wTXdxCPYbem4EGfp1E8xbRkFHKiE1nwARUDG2JdStjiui
         gJoJKA54/q+wa0tk18pMWYZVCgzQrQ0mgy5g8UPg/7hNv/Gc0jG35JsFThqV9nCh2aoe
         UoUKFswr82nT+pI59LT45LEL3Ps/3EDdSxEjzZxroscr0XzCbdEwZsMT97h1pmZQEgxi
         u+UsSZ6NexpfKe+QhaaFUpoQ1gu2Pklnrx8/Ky6ZDBKXwGnIuBjM50eA5tlJaQJ07C77
         UJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806670; x=1698411470;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHa4DtT1PlNOzzJDH3ABKFnZ2iLwqUUCPMBAwifRhP0=;
        b=atEKgouHyY6bpP+ehGaoBEyIGeTtvtpBCxc1kmz/Ij+XdMXX4y+L2M6slYwWqdp0cU
         kY9cn8L6/fO0PCDGC4OGb2EM48A78ZsV0Dx0lxFxTux+PIHITrxP4mqnf0wAAojenBJR
         niIh6jdlK2G+5t2g53hg+2LCMYPCfRFzpZPY/tzA9jZWtGVhBMuNpdwZvecGbJp+/3sy
         LUsBjw/H7TH4P5Igr7BA6cfX2tDtTWO0AKwlfEPagYUF76hDiVCAdAIJIo1TprK367mr
         hGtp1kscKIejMzaURNsxXD8CNe/5wDEkCCAtJH6AhHuyGYovq37ZELAV2uim+DYuMq9Z
         /ldQ==
X-Gm-Message-State: AOJu0Yyw/MD+HUWcQo/O1fmZCXhOXl2Uwd16QnrKRZqDzqI9PeV3za7R
	5lMIW0wg2U262tuW1I7v75naTjaRejDkpw==
X-Google-Smtp-Source: AGHT+IH/SEam0bwJnqPIIOlavq1RpW95EghX7lb1tHtKX4jXdZyBS9pi0Db7vTSKXDa9wIsvM8y5+zShZRKiPg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:40c:0:b0:d9c:c8c:123 with SMTP id
 12-20020a25040c000000b00d9c0c8c0123mr33182ybe.13.1697806670022; Fri, 20 Oct
 2023 05:57:50 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-1-edumazet@google.com>
Subject: [PATCH net-next 00/13] tcp: add optional usec resolution to TCP TS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

As discussed in various public places in 2016, Google adopted
usec resolution in RFC 7323 TS values, at Van Jacobson suggestion.

Goals were :

1) better observability of delays in networking stacks/fabrics.

2) better disambiguation of events based on TSval/ecr values.

3) building block for congestion control modules needing usec resolution.

Back then we implemented a schem based on private SYN options
to safely negotiate the feature.

For upstream submission, we chose to use a much simpler route
attribute because this feature is probably going to be used
in private networks.

ip route add 10/8 ... features tcp_usec_ts

References:

https://www.ietf.org/proceedings/97/slides/slides-97-tcpm-tcp-options-for-low-latency-00.pdf
https://datatracker.ietf.org/doc/draft-wang-tcpm-low-latency-opt/

First two patches are fixing old minor bugs and might be taken
by stable teams (thanks to appropriate Fixes: tags)

Eric Dumazet (13):
  chtls: fix tp->rcv_tstamp initialization
  tcp: fix cookie_init_timestamp() overflows
  tcp: add tcp_time_stamp_ms() helper
  tcp: introduce tcp_clock_ms()
  tcp: replace tcp_time_stamp_raw()
  tcp: rename tcp_skb_timestamp()
  tcp: move tcp_ns_to_ts() to net/ipv4/syncookies.c
  tcp: rename tcp_time_stamp() to tcp_time_stamp_ts()
  tcp: add tcp_rtt_tsopt_us()
  tcp: add RTAX_FEATURE_TCP_USEC_TS
  tcp: introduce TCP_PAWS_WRAP
  tcp: add support for usec resolution in TCP TS values
  tcp: add TCPI_OPT_USEC_TS

 .../chelsio/inline_crypto/chtls/chtls_cm.c    |  2 +-
 include/linux/tcp.h                           |  9 ++-
 include/net/inet_timewait_sock.h              |  3 +-
 include/net/tcp.h                             | 59 ++++++++++++++-----
 include/uapi/linux/rtnetlink.h                | 18 +++---
 include/uapi/linux/tcp.h                      |  1 +
 net/ipv4/syncookies.c                         | 32 ++++++----
 net/ipv4/tcp.c                                | 26 +++++---
 net/ipv4/tcp_input.c                          | 52 ++++++++--------
 net/ipv4/tcp_ipv4.c                           |  5 +-
 net/ipv4/tcp_lp.c                             |  2 +-
 net/ipv4/tcp_minisocks.c                      | 19 ++++--
 net/ipv4/tcp_output.c                         | 14 +++--
 net/ipv4/tcp_timer.c                          | 44 +++++++++-----
 net/ipv6/tcp_ipv6.c                           |  5 +-
 net/netfilter/nf_synproxy_core.c              |  2 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |  4 +-
 17 files changed, 193 insertions(+), 104 deletions(-)

-- 
2.42.0.655.g421f12c284-goog


