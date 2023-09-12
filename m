Return-Path: <netdev+bounces-33245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4A79D205
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35CB1C20A7B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61A134AB;
	Tue, 12 Sep 2023 13:25:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E218037
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:25:23 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E40910CE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:25:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6556d05a55fso30229776d6.3
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694525122; x=1695129922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Saa5HhiVh3p1m1g1/EDeXj2pWbUYHMe4W4hpvtsBL8=;
        b=N/TJ04s0NZ8F6I6hkaIvnT8A/7525UNLxazn0gKPZHw6CC9jwL1AOHBlVCAKAvre6h
         kkXKJQohTx5G/9rtWVm7FlsRV+lfhZyvziqAXiaa+jmyxgUW3KgaNongNvmUu3r7bOu/
         7HBU0XVimeL2Y8kl0L1GmvLjbH+LDfIDLAoAIr2Mn8tKj6jfpH86G54PmnCPv29ygXtR
         XmHWVEreqZv2gR1MO/meU17BVkc5+it18c4WrQXLdRGQs5/mWBByqiQ1TXhm6k4p6ZDN
         /9Ab2XdRtlu6S/SWuN1LEzcYEIN/Cq9eYOpw7lsiRTIhI4azfzQO/U60pcV6FuI0e2QV
         kP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525122; x=1695129922;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Saa5HhiVh3p1m1g1/EDeXj2pWbUYHMe4W4hpvtsBL8=;
        b=gkCnH+ch9lHVABUMqcfppSCvqrJWY4Fq41Pwi/FsfJCAuIc97u0ktIfkI1lD7n0nsS
         jQ4joDOADABuOzIaIpEgGhT79qlMLPPmpA+7AD8xVTqXkYU9uLVFgNo9z2gpnOjGaMUV
         e9+QoSOByue5D1a65XkooeWq8nHvHWRD33QZXp7fVYXto+8cKpKHTH/BD5h9hGjbFG4o
         XGj2kNRPQ6lvgLknOC1NqEkQgybJSgnQCFLvy76bTMiioHm5i1vFOeuDGNyJgzkVVoOS
         QbRb/xdffpZO40fcW266QPL7PUy3qkkAZrwJFs37ubqU2R6P1Q91uW+Ofu9sCU1M4Q3e
         IzWQ==
X-Gm-Message-State: AOJu0Yyq1Tp/eqOHmiLtKKUUFEMTQVaITQSTOwSigX+o6wq9+TN6iURD
	xIFRUHVO3y5lykvlQNyYtz/oWH8lD2U=
X-Google-Smtp-Source: AGHT+IG7AhGh2UyjrzFzlS+Bjr9Mcwc2evg/1wqLzrOojug8wes4GddoYPgo1EH0XHNgV9BfpzTUNg==
X-Received: by 2002:a05:6214:5505:b0:63f:bf70:6796 with SMTP id mb5-20020a056214550500b0063fbf706796mr11501077qvb.58.1694525122397;
        Tue, 12 Sep 2023 06:25:22 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id g2-20020a0caac2000000b0064721cf1535sm3660164qvb.62.2023.09.12.06.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:25:22 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:25:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <650066c1d47b7_25e754294fd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
References: <20230912091730.1591459-1-edumazet@google.com>
Subject: Re: [PATCH net-next 00/10] udp: round of data-races fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> This series is inspired by multiple syzbot reports.
> 
> Many udp fields reads or writes are racy.
> 
> Add a proper udp->udp_flags and move there all
> flags needing atomic safety.
> 
> Also add missing READ_ONCE()/WRITE_ONCE() when
> lockless readers need access to specific fields.
> 
> Eric Dumazet (10):
>   udp: introduce udp->udp_flags
>   udp: move udp->no_check6_tx to udp->udp_flags
>   udp: move udp->no_check6_rx to udp->udp_flags
>   udp: move udp->gro_enabled to udp->udp_flags
>   udp: add missing WRITE_ONCE() around up->encap_rcv
>   udp: move udp->accept_udp_{l4|fraglist} to udp->udp_flags
>   udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO
>   udp: annotate data-races around udp->encap_type
>   udplite: remove UDPLITE_BIT
>   udplite: fix various data-races
> 
>  drivers/net/gtp.c          |  4 +--
>  include/linux/udp.h        | 66 ++++++++++++++++++++--------------
>  include/net/udp_tunnel.h   |  9 ++---
>  include/net/udplite.h      | 14 +++++---
>  net/ipv4/udp.c             | 74 +++++++++++++++++++-------------------
>  net/ipv4/udp_offload.c     |  4 +--
>  net/ipv4/udp_tunnel_core.c |  2 +-
>  net/ipv4/udplite.c         |  1 -
>  net/ipv4/xfrm4_input.c     |  4 +--
>  net/ipv6/udp.c             | 34 +++++++++---------
>  net/ipv6/udplite.c         |  1 -
>  net/ipv6/xfrm6_input.c     |  4 +--
>  net/l2tp/l2tp_core.c       |  6 ++--
>  13 files changed, 118 insertions(+), 105 deletions(-)

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

