Return-Path: <netdev+bounces-25901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F7C7761F4
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0601C21289
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A0198B9;
	Wed,  9 Aug 2023 14:02:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36318C3E
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:02:42 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766731BFA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:02:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68706d67ed9so4895304b3a.2
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691589760; x=1692194560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=du20iG+IMRWJhg+5B/uM9dEYprGZcQpDcAfAuv79ob4=;
        b=Onl1FWHx9WbxFwpT/TTy8jxQ4JDAJwSG6gRekUtjLhRMVeladUba1Qyxn1tnqjtMz5
         bdoaZx3cLwu5bkgAgBhbMj6BZ42XPxaQyZ9u8Ez5r0KcxS8EMoyWRoFkmAFCbckF5FJQ
         KOHz+ftjj8enIrukupYnEOjSpdwy4fKwD4WSdo89qFylmjQgh/QdNKwN2JzzgZnKYTYQ
         VXRIUXPL2L44/LVBwwTwSSreNg9cBdA2hfuquqK63Jx7FmXL+bPIcBXUoWL4wlslADI9
         5bkfLE56N+mB/9B+22R32n1QQaHUM/iIsD2g0VAxD1e5ujO6p/xyOShUST7ck+bL3Phn
         WK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589760; x=1692194560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du20iG+IMRWJhg+5B/uM9dEYprGZcQpDcAfAuv79ob4=;
        b=RxPLSMva4TP5tVfPHzLN75q6ONwczXzSlIXU0l9xUBL3DtVTpWNC/hLBIHirR1crpc
         loe5i4NfkwEkqdRT70kwRv7FRV9Iz+afAI+X2Ni8rm+a1Hmt774mxnNZ3Yl6pntWCAiY
         v5UlrwLJh8BI3PRMOrWResRP1udXh9aqzu8I/crdLq0+aWiGWCYGCT6/bqUiYA5ZPmvT
         Z/TY0vg0o/uETfRKZzg98yrs1Wzn95G9Bo1XqWr/6Ecnrxvyt8M2gLqUbYUWsyDJjfuQ
         8D92hqoaIE/loVYZbwzeyAvak5XbpiG8M2baHRM18V+RUJJvAS7Dwm5sP5V7biPI9Mjx
         uGpA==
X-Gm-Message-State: AOJu0YwCH4ZBCd41epAeTE+Jpv2AyrmahUbIvshy0+CD7VLa8CLHssZH
	UPzWQU1z78GbNibQAHF+Fl7r5D590nW6eg==
X-Google-Smtp-Source: AGHT+IGp5Q/lvivpfbj3c6WOFpduYE1gscBnFgDsVVuox1Vr39vQX8sQJGeM876WqnQ6OfXeVEH5IQ==
X-Received: by 2002:a05:6a20:a114:b0:11e:7ced:3391 with SMTP id q20-20020a056a20a11400b0011e7ced3391mr2599215pzk.43.1691589759990;
        Wed, 09 Aug 2023 07:02:39 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q25-20020a62ae19000000b0064aea45b040sm9935674pff.168.2023.08.09.07.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:02:39 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/2] send notify when delete source address routes
Date: Wed,  9 Aug 2023 22:02:32 +0800
Message-Id: <20230809140234.3879929-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After deleting an interface address, the relate perfer source address routes
are also deleted. But there is no notify for the route deleting, which makes
route daemons like NetworkManager keep a wrong cache. Fix this by sending
notify when delete src routes.

Run fib_tests.sh and all passed.

Tests passed: 203
Tests failed:   0

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
2.38.1


