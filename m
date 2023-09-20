Return-Path: <netdev+bounces-35294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E23977A8AA1
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8031F20D6B
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC611184;
	Wed, 20 Sep 2023 17:29:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9D1A5A8
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:29:53 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D0B9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:29:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cb845f2f2so955907b3.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695230989; x=1695835789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v0cGOgaxAkTIiyJiyeMB+nwEdZeSf89Aw2zfmBVg60U=;
        b=2BqP7gABzKbdnmdHppnwreDe3NMWDSwR8zSj1ozqXYOPySVDvJyK0IfMj+fUy3Bg6B
         grw5zW8T8uyWiujdBMSFmc9UOKITYXZQrIzhgTlu6VEwwr1sXeM3eG9Za3U9ToEkJyjE
         wvFLmh1CiibWOSB97kWMLFdJzLKIMzSUfmzsHXrSctW3RZ8lGDQj1PVLKmgkvCAHBxxX
         /HvhPRE6LXBorqo1bHUDt2GxVySaaCTVXalH4bLVmCGwz81NhhDeCZpo4isrCpMu9cxz
         bXfB/ryhjjQT67pKjqKsVz9hxXyod7S/gxsvqS/XBbaUbkm4tdVSc+UXGEL9gRtyM6WF
         gouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230989; x=1695835789;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0cGOgaxAkTIiyJiyeMB+nwEdZeSf89Aw2zfmBVg60U=;
        b=X7H68dKzMHVt2Ewa1mjq/mBm2Aa7YJIv7wWOJ37yGdnmT2fejhBCqFHL3e70gSsab5
         JNQ+vScYRuoW8Xy7V3iFSz9KEngP13BqEF75MxaxcpAul6A0/YaowbJWuYbgubGbk6+4
         IaqamaLgAOe3+etMtnuk5hK96Pg9il2cWFOVnmG051Z4YCE01kMugmzN+xVNoFdaTfYN
         fpna9pVAofjmGrx6blvqUCeDuRNlQc7Y/wOVr6OJKFS3oSLOB0OIWNSWHn8k8JA+E6sC
         QDimkmsyayoDZgt3PsY6e61X8r4D4NgHYPbHPuAudzHAOejbakko/RID1kpS3sfBSEfx
         Sq2g==
X-Gm-Message-State: AOJu0YxUk+KEu62TIN7nh8RHBuApPucTcJXwJ3BfZls4KBr4rYTrHOhY
	zpPEbntotVla+ozJDMhZgc/WvOFh7UQfRQ==
X-Google-Smtp-Source: AGHT+IFoQY/wNrJnYOQE10hgTR+R3hx1rAUHXUmPkYb/JV4WWOXXsUYlYmqH7VrQ9YxaeYMHEw4DEOGmRrGJIA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b228:0:b0:d74:93a1:70a2 with SMTP id
 i40-20020a25b228000000b00d7493a170a2mr40978ybj.5.1695230988823; Wed, 20 Sep
 2023 10:29:48 -0700 (PDT)
Date: Wed, 20 Sep 2023 17:29:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920172943.4135513-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] tcp: add tcp_delack_max()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

First patches are adding const qualifiers to four existing helpers.

Third patch adds a much needed companion feature to RTAX_RTO_MIN.

Eric Dumazet (3):
  net: constify sk_dst_get() and __sk_dst_get() argument
  tcp: constify tcp_rto_min() and tcp_rto_min_us() argument
  tcp: derive delack_max from rto_min

 include/net/sock.h    |  4 ++--
 include/net/tcp.h     |  6 ++++--
 net/ipv4/tcp.c        |  3 ++-
 net/ipv4/tcp_output.c | 16 +++++++++++++++-
 4 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog


