Return-Path: <netdev+bounces-29047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68B781763
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 06:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481281C20D05
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE7C81D;
	Sat, 19 Aug 2023 04:41:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD1EC2
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 04:41:04 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A6A7
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:41:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58ee4df08fbso23579857b3.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692420061; x=1693024861;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EpYChYXOjvd2watkZYFXcju4svHoI97I/pzEQepwfUg=;
        b=jk4zsY967POKQ0XA2OLsYWohSryyIo2Hs5lB2MTvDhGgizfkk5+T1ZPqtwY0TGskRO
         jNs2OeUeMCnHUrbLrSy2M2apzzbNCXHuFcdH9A62izLy4z4mdK/B8ziFN5kC3EqHfll+
         Xn3TWGkRlJXYoMNmmXfh0WvYkn/jcws3Ox5RO9TRpXT9QdK8jnmv5/5YwLBwOkWCQfuR
         1TKLc4apm+Ec8Tc1rfFGh239YgZtRaQu8kjzZGLYcvvCqUA+HktuVQG/OQn70HnztHx3
         uLjHG/aMRFq3v0KtVJ7f53rFoQJwBqCkyXYfG9Zqxr0+OAfxxOI6p/1zjVUz+7i/cnjV
         yEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692420061; x=1693024861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpYChYXOjvd2watkZYFXcju4svHoI97I/pzEQepwfUg=;
        b=mDrhZ6EqRrZX7TflzSI7nJ/UsFWJFfeHhhyG1a51defRHmWD5t3zMorllyArdUIw/V
         +ZwJQAlnPeVF1PdcRc6fr9i7cK/KLvmNECmm/8W7mslpEYDMCrhIrp5KfW5AugXdIKXo
         EjiMFPazCiy3T+I4GM0VgoVyKqY0gafmA+xEyfgOoaxfeAYH9zPRqTHzug6Y9AQM8KQD
         S95q72woB998vnf4ESZmPKrvgCqCJBBD/QPphy0LJojNAySBI7m8YDZMU1WoaceK85NY
         JamsJ24v6Tn1F+KMERXwQ5rrVtSWyeBe12YGxVlG9a2Qit9zQWYEDy9Yk7TsQYACqH57
         mcoA==
X-Gm-Message-State: AOJu0Yz32aslxZ607PoerCO99g/4SfzIhu1toQFp7YeQiZCvuJrq5PG8
	66AgRA6iBztdDj9CgUPEOuk5c813bwwCeA==
X-Google-Smtp-Source: AGHT+IH//UE+qzlKOt4XI+f5pUCROE3DCk7B8ViOjnh+uAHeCJWZ1IbMbsoq3XebyBv+lLBPLWG7yCahtRxC1w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ac0c:0:b0:d0c:1f08:5fef with SMTP id
 w12-20020a25ac0c000000b00d0c1f085fefmr9697ybi.12.1692420061450; Fri, 18 Aug
 2023 21:41:01 -0700 (PDT)
Date: Sat, 19 Aug 2023 04:40:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819044059.833749-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net: use DEV_STATS_xxx() helpers in virtio_net
 and l2tp_eth
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Inspired by another (minor) KCSAN syzbot report.
Both virtio_net and l2tp_eth can use DEV_STATS_xxx() helpers.

Eric Dumazet (3):
  net: add DEV_STATS_READ() helper
  virtio_net: avoid data-races on dev->stats fields
  net: l2tp_eth: use generic dev->stats fields

 drivers/net/macsec.c      |  6 +++---
 drivers/net/virtio_net.c  | 30 +++++++++++++++---------------
 include/linux/netdevice.h |  1 +
 net/l2tp/l2tp_eth.c       | 32 ++++++++++++--------------------
 4 files changed, 31 insertions(+), 38 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog


