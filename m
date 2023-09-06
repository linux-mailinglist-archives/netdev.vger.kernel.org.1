Return-Path: <netdev+bounces-32335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1B2794447
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 22:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A7F1C20A60
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 20:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B567E11C91;
	Wed,  6 Sep 2023 20:10:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCF10954
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 20:10:51 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453CB9E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 13:10:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c8cbf0a0dso23984297b3.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694031049; x=1694635849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yRZQAg6gcr1eC0o0X81WDrP9iXly0xSSsKh3yHFL4mA=;
        b=RneGW+XtjjPpq8RGq09RfrY4TiNxzaY42xd9ScLBDlhAGk2uC27kNNIb95dQVnvh2B
         I/YBDbCuKL7mW/ij/1TwBBdVI3wmJAijxWP8wDpX//CBEIICz4JG7BfQCtVf2kQgyjF8
         dbhefsc/PT6fB/SGCHeeh+RbbCGanORJ6ZvSztEdClK3Af1jyPd6HIue1WYVRXrpSL45
         HjpKayQCo4j/sPQ0udFSvYZFJ31VuG63XwMrksbb35gDLVNXVQJC4x81lG36ijILQU+J
         aFzQXDHCbZNSX5VGEuc/YcEpII8qz3o8aR3dYnsYmBv8/xRJ2/u/Dl7kercvQfrDLFJA
         aGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031049; x=1694635849;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRZQAg6gcr1eC0o0X81WDrP9iXly0xSSsKh3yHFL4mA=;
        b=kjGfxiohiuKQy20MTD2ucmGdc+Xk0+pAgHRulJNyTv4fJY6cD0rHfuMd+XRf1jdveQ
         azOreExeaz/myT3uyr0nqJdUtrlzwyh752NDSLDjogL8TCV2Rk29V0nI/1GxLC0qyWZ1
         7YZ4Gc4dhGRN9V3PoWmmUh76ZzULFD3NYGBNUYqWdwdsFCE7ficg2Cvp4ZWurwyzDegC
         wIrwNaaNdeNno+w1Z5RbyXxiHwkdxN7H+xfmKl3ge98juKYVQ2obfRakYW8OfV9ADZdJ
         LvAs+ry/XufsKCQSrS6Pc+kpPVKpDy2ylLtooaBPxM86BbgNsZ6sKH6elMcCWDMCCiNM
         9n9Q==
X-Gm-Message-State: AOJu0YxmBkNYsTyVJx4+LO3t5EBeP0s34K3aPsux109ULjTBgw2UqHWS
	2c0zOzSxklla8NmSMOHWcn9a2VQIfeFTow==
X-Google-Smtp-Source: AGHT+IEgsUZLkAZF4NE86NdmMFznzncVr0wv0fzE1b9uJ1K9mvPGnU1NhlGD8vlk35VBl8Co2VeqdP+LUAJrFQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:588:0:b0:d15:53b5:509f with SMTP id
 130-20020a250588000000b00d1553b5509fmr19212ybf.2.1694031049523; Wed, 06 Sep
 2023 13:10:49 -0700 (PDT)
Date: Wed,  6 Sep 2023 20:10:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906201046.463236-1-edumazet@google.com>
Subject: [RFC net-next 0/4] tcp: backlog processing optims
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

First patches are mostly preparing the ground for the last one.

Last patch of the series implements sort of ACK reduction
only for the cases a TCP receiver is under high stress,
which happens for high throughput flows.

This gives us a ~20% increase of single TCP flow (100Gbit -> 120Gbit)

Eric Dumazet (4):
  tcp: no longer release socket ownership in tcp_release_cb()
  net: sock_release_ownership() cleanup
  net: call prot->release_cb() when processing backlog
  tcp: defer regular ACK while processing socket backlog

 Documentation/networking/ip-sysctl.rst |  7 +++++++
 include/linux/tcp.h                    | 14 ++++++++------
 include/net/netns/ipv4.h               |  1 +
 include/net/sock.h                     |  9 ++++-----
 net/core/sock.c                        |  6 +++---
 net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
 net/ipv4/tcp_input.c                   |  8 ++++++++
 net/ipv4/tcp_ipv4.c                    |  1 +
 net/ipv4/tcp_output.c                  | 15 ++++-----------
 9 files changed, 45 insertions(+), 25 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog


