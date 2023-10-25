Return-Path: <netdev+bounces-44192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92437D6E8E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62867281B3C
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0C28E3B;
	Wed, 25 Oct 2023 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOgbH8s0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622A250E6
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:18:55 +0000 (UTC)
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF86A3
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:18:53 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id 5614622812f47-3ae5ac8de14so9452053b6e.2
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698243533; x=1698848333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CDDOLHa3s2PSKghNoUT7/KCjsMxAs++9iZlRYegh8eM=;
        b=sOgbH8s0hBft76uVEWpI9EGduOTQM0BSdaiFXMJmyaBoG5mfL5DtGWN9sDin1fSeEq
         whue82ia62ifC+tfsfO6B0qA27E8KOVgreseme4VcfQQ39M8MVSp3YPvPpZsH2yPgEhd
         Z4Ee0fr3/V2rI7Fif3n606CM79e/rvbPumtzUuPeKl4pWmtGj5u/oIuCrAGCKT3JC3gi
         jOGH8nNzgd6J7hQJ+Ypu4j1i1+DwWmoS6fIyJehO9xEz6wrvjYT5SxaYlin5LccNaCJ1
         XME9IaSAW2B+XtDS3zfqA0EyY9YB4DLn5C7HUEocnP6wJJFP/mFGa4ZT5ZT2bT+lU3kX
         oS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698243533; x=1698848333;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDDOLHa3s2PSKghNoUT7/KCjsMxAs++9iZlRYegh8eM=;
        b=Yl4GQnKWhtM0cwHYLcTMcMAr1Ydg3CpAQe5XevP4M5mUtdTGAT0ScxB/CFGkXx615c
         /mStakSAtBi1P417byyYnpHX4FJmqXbI+U5XP5XFXiIH9MdBO07el88iYgKeHXA0H8TL
         hmtUoG60agwtXNOSJ4bERuYSeLpoNqIw8Msl8B4cDcPC+hBn3MPoho6LKzMjeFiC0Urn
         2Mh2vfeiaopcaZWxNWUnMQwVNNl+BVcu0lQ0e2LlRN0yzdL8MsRKCWdCQwU5YZSeASoV
         jYjUWuVdujZ8RXw23MHWclWCG6QDXs9pgKH7VGLYDkVoaDGWBU43mjtnN/BMjy+1Ld2O
         foMw==
X-Gm-Message-State: AOJu0YxuevxFEdqRyDyu5f6ZIpXTOjvHBtnArrmaV1eN55LPvmSEh0Me
	8v2gHYv4BxtPqbmD0NeSf9hVGYXT57IxzQ==
X-Google-Smtp-Source: AGHT+IGic+WW2MfFKpcROA4WVL0fe9LKFHDrYASuBE4vQ1QFGQkeCFx6+nYFLTvghPf7ixiH5VZamZNWtKhXLQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:5c1:0:b0:d9a:b957:116e with SMTP id
 184-20020a2505c1000000b00d9ab957116emr301476ybf.3.1698243038702; Wed, 25 Oct
 2023 07:10:38 -0700 (PDT)
Date: Wed, 25 Oct 2023 14:10:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025141037.3448203-1-edumazet@google.com>
Subject: [PATCH net] inet: shrink struct flowi_common
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, wenxu <wenxu@ucloud.cn>
Content-Type: text/plain; charset="UTF-8"

I am looking at syzbot reports triggering kernel stack overflows
involving a cascade of ipvlan devices.

We can save 8 bytes in struct flowi_common.

This patch alone will not fix the issue, but is a start.

Fixes: 24ba14406c5c ("route: Add multipath_hash in flowi_common to make user-define hash")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: wenxu <wenxu@ucloud.cn>
---
 include/net/flow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/flow.h b/include/net/flow.h
index 7f0adda3bf2fed28c53352d9021574b5eade2738..335bbc52171c10eb4b4b7e03a18eb8147902c6ac 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -40,8 +40,8 @@ struct flowi_common {
 #define FLOWI_FLAG_KNOWN_NH		0x02
 	__u32	flowic_secid;
 	kuid_t  flowic_uid;
-	struct flowi_tunnel flowic_tun_key;
 	__u32		flowic_multipath_hash;
+	struct flowi_tunnel flowic_tun_key;
 };
 
 union flowi_uli {
-- 
2.42.0.758.gaed0368e0e-goog


