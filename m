Return-Path: <netdev+bounces-30825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D407892EE
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 03:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D5D2819AD
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0266385;
	Sat, 26 Aug 2023 01:21:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42837F
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 01:21:29 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E9D212B
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:21:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c0c6d4d650so12721925ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20221208.gappssmtp.com; s=20221208; t=1693012888; x=1693617688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ln8V9k0rRAhr6XrGjbtxwTzjhCtFBJCGaH+v0PgMKkI=;
        b=T3fkv9JH5omc1s405Zrau2UQ0D/aPI+e92ckhECj058j5YddaRRbV8g4IY08mpgphx
         3ssBI3a83iq8a7s/zlC2KfH+S3zFeSNhwXYAS76HxDg6s+Xh2VmcF4HrLQIDwXMgWHUg
         PLyFHugqtVnV3phdEG18i/aJI0TwRTsrGAGd6tNEkl2tYIVftFgG5CRXL5Ll3bdpW7aJ
         yPxC+hl7K/uRRGoSE7+O9hn4A1FDkFPx6kd7CsMmeEolu/OsSWje82IVHv+hYtNSyHQ1
         DUyqG3AgXrIQOuaAbCYlXIOq9YONx43mzN3p21+KkIDrMVymKsMlw1svQjYDEA4ylFwf
         K1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693012888; x=1693617688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ln8V9k0rRAhr6XrGjbtxwTzjhCtFBJCGaH+v0PgMKkI=;
        b=arfr1mRnJPga9+Oydq3DaJKJpzKCnOOFtCimM0520UOSqTXy6TR8xMVDWu6WR4/oTf
         HJlWxLkkor6yKDuRaR602t4IxEllBZJTwZF1PNIWtWeMsWHuNeGXt+dWN6ktxH9Oc4ob
         zk428ffEIW8SBaMiytGxfy2G6dvnHo/K7trrUfe0uwVzyaH34ONfpzyna8B7otmxoVlQ
         6EyxJuvdCe4UqmRDQCgOIxVufBWFrOBl1/AJ8SrNqPsiD9coWF/XkzvmVuVaSnx3u06d
         GMFokYpOlW66gyV145cWZJJWAs35sJ4CJaoe4gd1P7PGFB1T46KAbfjsVfryEccX2zFl
         5NHw==
X-Gm-Message-State: AOJu0YzaQgVbPwF02iQ4nxhNYTnpPLPy7H0vVUXNQsrOJ32oXJkQrvmP
	e7/K/7mjWR25h5o+jLY1jlNt8g==
X-Google-Smtp-Source: AGHT+IHGVSMUqi7K77x5XGraTtGeoL8N9PsXgYS0TULPaZ9W2WIF0fHWVGi+1bRQOFCjgpptxUElrA==
X-Received: by 2002:a17:902:ea0f:b0:1b8:1bac:3782 with SMTP id s15-20020a170902ea0f00b001b81bac3782mr23334978plg.6.1693012887963;
        Fri, 25 Aug 2023 18:21:27 -0700 (PDT)
Received: from localhost (fwdproxy-prn-004.fbsv.net. [2a03:2880:ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902ee5300b001bf20c806adsm2428085plo.50.2023.08.25.18.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 18:21:27 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC RESEND 00/11] Zero copy network RX using io_uring
Date: Fri, 25 Aug 2023 18:19:43 -0700
Message-Id: <20230826011954.1801099-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Wei <davidhwei@meta.com>

This patchset is a proposal that adds zero copy network RX to io_uring.
With it, userspace can register a region of host memory for receiving
data directly from a NIC using DMA, without needing a kernel to user
copy.

Software support is added to the Broadcom BNXT driver. Hardware support
for receive flow steering and header splitting is required.

On the userspace side, a sample server is added in this branch of
liburing:
https://github.com/spikeh/liburing/tree/zcrx2

Build liburing as normal, and run examples/zcrx. Then, set flow steering
rules using ethtool. A sample shell script is included in
examples/zcrx_flow.sh, but you need to change the source IP. Finally,
connect a client using e.g. netcat and send data.

This patchset + userspace code was tested on an Intel Xeon Platinum
8321HC CPU and Broadcom BCM57504 NIC.

Early benchmarks using this prototype, with iperf3 as a load generator,
showed a ~50% reduction in overall system memory bandwidth as measured
using perf counters. Note that DDIO must be disabled on Intel systems.

Mina et al. from Google and Kuba are collaborating on a similar proposal
to ZC from NIC to devmem. There are many shared functionality in netdev
that we can collaborate on e.g.:
* Page pool memory provider backend and resource registration
* Page pool refcounted iov/buf representation and lifecycle
* Setting receive flow steering

As mentioned earlier, this is an early prototype. It is brittle, some
functionality is missing and there's little optimisation. We're looking
for feedback on the overall approach and points of collaboration in
netdev.
* No copy fallback, if payload ends up in linear part of skb then the
  code will not work
* No way to pin an RX queue to a specific CPU
* Only one ifq, one pool region, on RX queue...

This patchset is based on the work by Jonathan Lemon
<jonathan.lemon@gmail.com>:
https://lore.kernel.org/io-uring/20221108050521.3198458-1-jonathan.lemon@gmail.com/

David Wei (11):
  io_uring: add interface queue
  io_uring: add mmap support for shared ifq ringbuffers
  netdev: add XDP_SETUP_ZC_RX command
  io_uring: setup ZC for an RX queue when registering an ifq
  io_uring: add ZC buf and pool
  io_uring: add ZC pool API
  skbuff: add SKBFL_FIXED_FRAG and skb_fixed()
  io_uring: allocate a uarg for freeing zero copy skbs
  io_uring: delay ZC pool destruction
  netdev/bnxt: add data pool and use it in BNXT driver
  io_uring: add io_recvzc request

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  59 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   3 +
 include/linux/io_uring.h                      |  31 +
 include/linux/io_uring_types.h                |   6 +
 include/linux/netdevice.h                     |  11 +
 include/linux/skbuff.h                        |  10 +-
 include/net/data_pool.h                       |  96 +++
 include/uapi/linux/io_uring.h                 |  53 ++
 io_uring/Makefile                             |   3 +-
 io_uring/io_uring.c                           |  13 +
 io_uring/kbuf.c                               |  30 +
 io_uring/kbuf.h                               |   5 +
 io_uring/net.c                                |  83 +-
 io_uring/opdef.c                              |  16 +
 io_uring/zc_rx.c                              | 723 ++++++++++++++++++
 io_uring/zc_rx.h                              |  42 +
 17 files changed, 1168 insertions(+), 20 deletions(-)
 create mode 100644 include/net/data_pool.h
 create mode 100644 io_uring/zc_rx.c
 create mode 100644 io_uring/zc_rx.h

-- 
2.39.3


