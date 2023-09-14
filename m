Return-Path: <netdev+bounces-33850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93A57A0781
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A619B1F23B57
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E8F1D53B;
	Thu, 14 Sep 2023 14:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157D318E2A
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:37:25 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756D71A5
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:37:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-591138c0978so14657517b3.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694702244; x=1695307044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AOe+LtVTb/5I9/+mSs8VNs51qF0kN5VC6VZcJ5Dakm8=;
        b=OQ3KkTGdjgYePigVwyeCzKW2/ZggUsspYAg0AHIWpIA2FJ0uI04addRbJIpdLRoK1G
         1xXzD/KrXc40QchxjcdPeEIAHYJ3aIbefOxeKIFn+MqqeJTrfKKBSoXmdcWLP9P8yyt3
         xbY2j+I7y8tdnK/dZ2znBvWIZ9zVZ2rfckTycGbGop/lBaurQH6Lsw75O1Aa5KzsnNba
         7VM2qWW/of9IZy9emg2zkOciVMBafLBOXWhTuSfs5VISX+GAPgHBBjVZ2I8Z+6GC8BO6
         vE4iox7rNqHbNHB25u0gBj5f4B7qyGtmBiNy9M7JTAfze98JD4wnDONz3JR5TaBh0hLM
         GSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702244; x=1695307044;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOe+LtVTb/5I9/+mSs8VNs51qF0kN5VC6VZcJ5Dakm8=;
        b=YzqGJRR4m3ypzZE/LOabYkauk+sYfV9aZFNgfM6YzZxAp//I8RnwTsYGLIGBOd421F
         yHb4F8TE6lQ+rfHXm19QYYaLMFIp7fsUKZIcaf9EXNaii9kGmrqIrGx20vlnnJem288z
         dzmuhl7YxcJFTjbNBnaGSyYCtma65jWJp3nv0OMmKBc6AkuKWzx/pcyW+Qr5oaWvGTJo
         FzbHBCLP1K/bnGaW+gvyaYrDUT68uoEGuniueA2c5KIbkD9tlA9dPbBdA9OfY9Q4vzWf
         8pKqiynhu7TcrE0pMshicB8Sz/+E7ghG4Aheo61VZcrG0W2/BeRd3F6TbSVEpMrWeDfl
         Evgw==
X-Gm-Message-State: AOJu0Yx/JzwcE8ea0cWIaW9wfs/tI0o59duVhxneaY1j4+mWlDJeyO0A
	T5VA3QjYmwohXR9lcNRD8z0Gk6ADMXccUw==
X-Google-Smtp-Source: AGHT+IEjtj44xHv/N+O14+simMc0+r0qZjHjk9PwBxW/onUBILI4IhQEUyQ82Or9thd/U0M/VIZiCiLJDiG+gw==
X-Received: from aananthv.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:44a6])
 (user=aananthv job=sendgmr) by 2002:a81:ad0a:0:b0:59b:f863:6f60 with SMTP id
 l10-20020a81ad0a000000b0059bf8636f60mr31096ywh.4.1694702244702; Thu, 14 Sep
 2023 07:37:24 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:36:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914143621.3858667-1-aananthv@google.com>
Subject: [PATCH net-next v2 0/2] tcp: new TCP_INFO stats for RTO events
From: Aananth V <aananthv@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Aananth V <aananthv@google.com>
Content-Type: text/plain; charset="UTF-8"

The 2023 SIGCOMM paper "Improving Network Availability with Protective
ReRoute" has indicated Linux TCP's RTO-triggered txhash rehashing can
effectively reduce application disruption during outages. To better
measure the efficacy of this feature, this patch set adds three more
detailed stats during RTO recovery and exports via TCP_INFO.
Applications and monitoring systems can leverage this data to measure
the network path diversity and end-to-end repair latency during network
outages to improve their network infrastructure.

Patch 1 fixes a bug in TFO SYNACK that we encountered while testing
these new metrics.

Patch 2 adds the new metrics to tcp_sock and tcp_info.

v2: Addressed feedback from a check bot in patch 2 by removing the
inline keyword from the tcp_update_rto_time and tcp_update_rto_stats
functions. Changed a comment in include/net/tcp.h to fit under 80 words.

Aananth V (2):
  tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed
  tcp: new TCP_INFO stats for RTO events

 include/linux/tcp.h      |  8 ++++++++
 include/uapi/linux/tcp.h | 12 ++++++++++++
 net/ipv4/tcp.c           |  9 +++++++++
 net/ipv4/tcp_input.c     | 24 ++++++++++++++++++++----
 net/ipv4/tcp_minisocks.c |  4 ++++
 net/ipv4/tcp_timer.c     | 17 +++++++++++++++--
 6 files changed, 68 insertions(+), 6 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog


