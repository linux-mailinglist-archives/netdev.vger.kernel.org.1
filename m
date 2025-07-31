Return-Path: <netdev+bounces-211153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF1B16F0D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926D44E4D6A
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CE52BD595;
	Thu, 31 Jul 2025 09:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFFA1D63DD;
	Thu, 31 Jul 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955855; cv=none; b=sJWH9wOV5lu/HTRFjzFSa/b94pju88+OFoZXL45MvIXj3cCrRx6gYg5Po8ZsTyzt0LDEENpUYje9RaVw8yNt8CK+DBs0qFocmO3NDoHG2YJhfXdbd2sgvU90K/aW2Ywz6tqf6aoKDQKLmjD1GnaHcMA0nQF8xpEbBej/F6ExScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955855; c=relaxed/simple;
	bh=IT7WZL+si5He7mq4mj2zOeV6liA8QI4VawPHix9Uwmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EJ9d1zi1cA0BVRAjIplkc3jNfTDLbyto3WzTAsLA45zNaQgHjozfhbo10XAqcusWSvrnM/wuNHV0VGIJevM6VBzfuIetGVzw+wDfeHHUW0aJOEY0tsNnO+tjTtFM5oUZH93G76qR+QlwKKp+Xa8HX90t604ixLbQdZ1DQtxiwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af90fd52147so129579666b.3;
        Thu, 31 Jul 2025 02:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753955852; x=1754560652;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/ZMu34+dfDqJr70iyRbEwHfXPhMJ5Qmf33UpYcbmoo=;
        b=DlPX80Hs5FeewHHvExkEmd+EwoVPTQ5dbbkeBWsRDztjmmE8ljJR5poB1x1VFfDqFt
         7ZIyu2gauCIN9Kyrglr8MPVefRRWtsGHgnnmgdEz4nUTaTlQ8nUYlylIiR+K3BB4tnyN
         9DPyECtR+XUFuG87mHJMIofr4ll+RjPTfzGiHLtYXgLVRxy882yW32AhiL5ny2IgoUq+
         +VfEaPWHsilb1lGHvstmzmZDiBtcvRgc090VupjjornblIGcdI4KnXX2wWAYUclxu1vi
         HZqMWLcxCLbjF+w8lv9ooXuQdeBdlH8bxu9GiKwL9mcpbfIIbVLzIOADAJfUe+cEvr9s
         0qbg==
X-Forwarded-Encrypted: i=1; AJvYcCV1bM4mZCw8itlmzJtN3fjGh2zPzx/TxjKhDZs6UAdBNYagq24CrDSAlyd3XQzgBfcPdheytw644Mre3Ek=@vger.kernel.org, AJvYcCXacrg6+NXp5ARzph9H5OCoBc3oOLHmxDHsQhjoIIZP8CtV2nCOA/X5g8f0li2AlnBpHX2l7Tq0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuj9j5OUYNGs0hKrtGM94lRKuCI8EvG/MnZtHpvEF1x8mofi49
	DwGYof/PHiCXDIwCegGKbmYYkOg5T924ufVfZcx8luC3D1Z+BNsM1WtB
X-Gm-Gg: ASbGncuJwKE1y3ejPSvdScd02SpY5TaAN/PFFP1Z4ZVORxFMzRUEPQEwC1f53zWV3U0
	nj2olM+oWrhMqcGj4j73stRbdzb2ccD1cSW5CrItFdt4EAYQMlqH0M09vu65brj6bnqoYhlM8VC
	aBYhCh7ZPJPZRjMhkqPRHcf94BJV2FncNQNwF0R2ey1Cv39ph8mTVOOFQGM+kJ8H0sN3sRERhLV
	BLm5nQU0Da5rquBTJwBvEfpB1AeuRmnGD2M2ihBOlPy+o5baHZZOaSCvMp4d4+i2u4HDLkpngaK
	y+cCP2ttdlit5+6eGRIJUo6CetA8hboI4xsBK4plnEpAaxoBG+Yh5C4VhIIkwCQvyxgtMo7xRKP
	3QKXoZEQkgy8vJg==
X-Google-Smtp-Source: AGHT+IHDwS1JVl5cXBKnOS59wjRCq8XbXS0qqPh/VTauGUKlgaq/Hd0hJtKARbxzzFd4RBE4+Bq4Qg==
X-Received: by 2002:a17:907:7204:b0:ae3:ed38:8f63 with SMTP id a640c23a62f3a-af8fd6b45ccmr837277566b.14.1753955851359;
        Thu, 31 Jul 2025 02:57:31 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8992sm83409966b.91.2025.07.31.02.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:57:30 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 31 Jul 2025 02:57:18 -0700
Subject: [PATCH] mm/kmemleak: avoid deadlock by moving pr_warn() outside
 kmemleak_lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-kmemleak_lock-v1-1-728fd470198f@debian.org>
X-B4-Tracking: v=1; b=H4sIAP49i2gC/x3MWwqDMBQFwK1czreBaFJCs5UiEuypXuKLBKQg7
 r3QWcBcqCzKiigXCk+tum+I0jaCcU7bRKNvREFnu4cNrjV55bow5WHZx2w8rQ/eMYUn0QiOwo9
 +/9+rv+8fiSpraV8AAAA=
X-Change-ID: 20250731-kmemleak_lock-4e04743ea79e
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kuba@kernel.org, stable@kenrel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=leitao@debian.org;
 h=from:subject:message-id; bh=IT7WZL+si5He7mq4mj2zOeV6liA8QI4VawPHix9Uwmk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoiz4JTz9wQ0LLi6k6r0lLFiorWuKQhaEMAQ/+q
 r/kHLh8WaKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaIs+CQAKCRA1o5Of/Hh3
 bZMeD/9x9pPREt190983hCENkhsa6Phfwo0J3tQRaG2Ju9HghxMjvO52+wKBq2yoGBeHQnkPdzN
 tsCv1LzVCe/p+MQlbd4G8hqGAUiX5fi6XSUtCmnlXvPFbN+W869mgW3EfthighxDrk23e/mk0Cz
 pb3rZ92zDS94zmJw97L32m8Q73B537Ytmj8EP+UsKnYC/uscFFMaLIc66J25yTjtBPY3AS1RD//
 yTAcSsPCh1mTYPtu4jOse7QdrSAvgA9mutATtEqyD7+ofl4jYOa1NMl1zuyab+DrnsB0EqZSi0z
 Gil6xzz+b7WLbmSvdW+J7ulxmjNBVJ2iay5FVLZ3gsqR02nyRSmO3ofeWz9jqjiN+5Vf9Jhm2Qx
 ltKIA39iOdQdcZU8dL0Lng+BN50PzoD3VaXOtgPEpauqd60gJ/L8OQpSVgpyfjg5Dxv5r4mfAVO
 c81oB6xEXjc2kaQLlFJ6eRPNX+fLefwc//MvmUJQCneJOiKdArufGC+QqTJcCqgOyEE9Kg/q5wa
 ZRXAHNIwn0JpW2WfeE4tRhUq+WDi5mBzLDL36fTA2EAuV8dDXmd9iqaXOr5TwHPylHCi3qbcYvT
 s5W7nMHNyUV8gHbm7A1cyo3xgPVxcyJbQPWFc087/g0MoOvsESH+7fzLRcg1aEpPre/heqYv5D8
 uq3vALiHv9alnTg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When netpoll is enabled, calling pr_warn_once() while holding
kmemleak_lock in mem_pool_alloc() can cause a deadlock due to lock
inversion with the netconsole subsystem. This occurs because
pr_warn_once() may trigger netpoll, which eventually leads to
__alloc_skb() and back into kmemleak code, attempting to reacquire
kmemleak_lock.

This is the path for the deadlock.

mem_pool_alloc()
  -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
      -> pr_warn_once()
          -> netconsole subsystem
	     -> netpoll
	         -> __alloc_skb
		   -> __create_object
		     -> raw_spin_lock_irqsave(&kmemleak_lock, flags);

Fix this by setting a flag and issuing the pr_warn_once() after
kmemleak_lock is released.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Fixes: c5665868183fec ("mm: kmemleak: use the memory pool for early allocations")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/kmemleak.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 8d588e6853110..e0333455c7384 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -470,6 +470,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
+	bool warn = false;
 
 	/* try the slab allocator first */
 	if (object_cache) {
@@ -488,8 +489,10 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 	else if (mem_pool_free_count)
 		object = &mem_pool[--mem_pool_free_count];
 	else
-		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
+		warn = true;
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+	if (warn)
+		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
 
 	return object;
 }

---
base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
change-id: 20250731-kmemleak_lock-4e04743ea79e

Best regards,
--  
Breno Leitao <leitao@debian.org>


