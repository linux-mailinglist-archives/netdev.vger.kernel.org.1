Return-Path: <netdev+bounces-19246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE3975A090
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5DD1C2116F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD022EF6;
	Wed, 19 Jul 2023 21:29:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA522EF5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:04 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91921FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so73328276.2
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802142; x=1690406942;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CsuZaU5WnHUAnwYv3MMg+hlemr7ZCoxsrr+nIPGmz0k=;
        b=6X3INKB0OTc5Wh+PKJPG+lWr+SJnqWFCZlrKxRjH9uWHu2/crZIeuET4rBiVSNnVb6
         mZrKpIhpHaqCHv4Ex9RNweg1M7Qp/eK8bhvBZRyUGMBRMdRgaRWrYKKLvzkXHnD0epP9
         wxtvgQai1NkK+T+OYPl7w3qrqesoNrpX7lC8PZmQYdhYeSUncpPZ/C42d9Mb8JZxNGe4
         oivxqW7nLJgN+r2xd4lHSX08sMgfqs2RsLLo+3xodSRpc6X556TW/C1isE3iYdi9mema
         jarc5V50a+0jxPUehBWbvcRMyoqv6tznSnmydNUqXfOIvlIBNIdGY/Rb0IuevplqbNOF
         uzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802142; x=1690406942;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CsuZaU5WnHUAnwYv3MMg+hlemr7ZCoxsrr+nIPGmz0k=;
        b=bXiTvvCTJ0owAOB2NLONIn2D7jzv9uBbe8jsaPFDmuoz2RiR+yiF1b3TUuxofqxRRi
         hEoMCvrQRuw8s9GWAPvI5GgEX4chMgN2ZB/g6jcEDZtoT1w2mEH56hs5j4HLgx1hZslk
         4ooKsPlwllrUjq+tZqYuoI++iN9lvn9CCGT3ZUwg/ZLb5H3M5X4uAcW/4GY3O2btfvls
         ayVU7jy06tmLDE7Y/6nrvobUcQWOW5OOVyC8kOkORfOnWYJRnZf3OIGpGiaVgD7HAaO2
         y7UoqcbVdkJssBNkpGPCP1Mc312j3UmZm8syCSTLfx9fO4EhZxeCl0R1+8U7TLEHkvIX
         MC3w==
X-Gm-Message-State: ABy/qLZnZ5t/2C26EseopwDL+JAck6oBxhN/2FGGiUN6a80ywdKDY3Qw
	C/M0W4mdyhe4Y6lIm6S4aOVwLx4ABAvLmw==
X-Google-Smtp-Source: APBJJlEdW0Iz7kQIi+AGD7nMOhHanUFVuUHAYjfnOax7VHWJpWtGgVPEpK9nxd9fcq6zK6Br2rLcGiKfv6/RYw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2416:0:b0:c5d:2380:23d6 with SMTP id
 k22-20020a252416000000b00c5d238023d6mr30236ybk.7.1689802142222; Wed, 19 Jul
 2023 14:29:02 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-1-edumazet@google.com>
Subject: [PATCH net 00/11] tcp: add missing annotations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series was inspired by one syzbot (KCSAN) report.

do_tcp_getsockopt() does not lock the socket, we need to
annotate most of the reads there (and other places as well).

This is a first round, another series will come later.

Eric Dumazet (11):
  tcp: annotate data-races around tp->tcp_tx_delay
  tcp: annotate data-races around tp->tsoffset
  tcp: annotate data-races around tp->keepalive_time
  tcp: annotate data-races around tp->keepalive_intvl
  tcp: annotate data-races around tp->keepalive_probes
  tcp: annotate data-races around icsk->icsk_syn_retries
  tcp: annotate data-races around tp->linger2
  tcp: annotate data-races around rskq_defer_accept
  tcp: annotate data-races around tp->notsent_lowat
  tcp: annotate data-races around icsk->icsk_user_timeout
  tcp: annotate data-races around fastopenq.max_qlen

 include/linux/tcp.h             |  2 +-
 include/net/tcp.h               | 31 ++++++++++++++----
 net/ipv4/inet_connection_sock.c |  2 +-
 net/ipv4/tcp.c                  | 57 +++++++++++++++++----------------
 net/ipv4/tcp_fastopen.c         |  6 ++--
 net/ipv4/tcp_ipv4.c             |  5 +--
 6 files changed, 63 insertions(+), 40 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog


