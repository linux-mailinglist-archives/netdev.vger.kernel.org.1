Return-Path: <netdev+bounces-35366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925F27A9128
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 05:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C67D1C208C9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 03:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469517E8;
	Thu, 21 Sep 2023 03:14:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8708217D9
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 03:14:27 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A418ED
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:14:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690d25b1dbdso389414b3a.2
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695266062; x=1695870862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+BaNOJZYFL82ZrRCsgRmaucSoZrWnuv1hua/TNuRDyQ=;
        b=jPPQDslCavIFjUYE4aT0LcIH98oEx+DrOojuGVE2K0lvep2Pq8TP+WjnD08GxdQ7Lx
         pSS63iE4RCvGg4II7lKkmZdeSnvPM1ZUL3/1+YrEJeRMEV3dk+Vl8Cn26RJUKJgxh37C
         LflYhC/dKaK2gp3zIO5dQ+26qX5dwxI5Wy3vg7prFdzLLnlxt8t1AqitBVYH8fATpLp1
         gNFb6b0Wgmm8W58L2pjZNySB3+y31lRgUDbNaD8RFr6iLWTenur1XDWOrP+3J8rlZZnD
         uqCZGdQFl9dmeUBOggERc8JBd7oR9mykR0Bsh6mNxu83P8yJ3lBiaibMZqtAd6WKysQf
         YxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266062; x=1695870862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BaNOJZYFL82ZrRCsgRmaucSoZrWnuv1hua/TNuRDyQ=;
        b=Rmv3o8d/IYZDnJNEx7AeccrGPPUYOzfVPZeraMQwla4f6n0eBmKycWQkwBcwD/wKC2
         02ouJLYLX9oCFzBChQc0qdR/MMnAmWU9eft/X/3dt3PMOd/bWzc7hRY/EcelyzOV3xn0
         XZotOVmMce7zTq4R6GABrkxXF3TyyWsC/ale751UTCggMwh7J8BReBSt6TZrVCEm1aZx
         d7nkRmeFtA0sH6ergOZ1gQRypFa84UJRGkYj703Fuu0GKw1Ca88nsx7ja52qdS6UQons
         48GyNMgxE8XaRSDeOKAlE3gJe+jxLFotgerpry1N96fiZDN3H9oVINV7Mx4SUQgxwwnR
         HvOg==
X-Gm-Message-State: AOJu0YynC+EpjNxI5nnt/H0TUVxHF4DqPWnouDCueCq0jMXnquliF1FX
	tJ8hkOsxTR57oeJt5wiNx2SMKIvTjM40rtDE
X-Google-Smtp-Source: AGHT+IG4LvtjU5fYK3eqv0a12uG7xR1uKRsUs3XJW/ljccQ0fsSumiMWHC/d/LjsuHqWAL/D6hfBUA==
X-Received: by 2002:a05:6a00:cc8:b0:682:4ef7:9b0b with SMTP id b8-20020a056a000cc800b006824ef79b0bmr5322192pfv.0.1695266062624;
        Wed, 20 Sep 2023 20:14:22 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bg2-20020a056a001f8200b0068fe76cdc62sm236032pfb.93.2023.09.20.20.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:14:20 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Thomas Haller <thaller@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Eric Dumazet <edumazet@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 0/2] IPv4: send notify when delete source address routes
Date: Thu, 21 Sep 2023 11:14:07 +0800
Message-ID: <20230921031409.514488-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After deleting an interface address, the relate perfer source address routes
are also deleted. But there is no notify for the route deleting, which makes
route daemons, or monitor like `ip monitor route` miss the routing changes
when delete src routes.

Run fib_tests.sh and all passed.

Tests passed: 203
Tests failed:   0

v3: Update patch description. Target to net as Nicolas suggested.
v2: Add a bit in fib_info to mark the deleted src route.

Hangbin Liu (2):
  fib: convert fib_nh_is_v6 and nh_updated to use a single bit
  ipv4/fib: send notify when delete source address routes

 include/net/ip_fib.h     | 5 +++--
 net/ipv4/fib_semantics.c | 3 ++-
 net/ipv4/fib_trie.c      | 4 ++++
 net/ipv4/nexthop.c       | 4 ++--
 4 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.41.0


