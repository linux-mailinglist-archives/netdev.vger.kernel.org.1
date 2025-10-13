Return-Path: <netdev+bounces-228694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ADDBD2582
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E58C24EF401
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720312FF15A;
	Mon, 13 Oct 2025 09:42:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAC2FE599
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348565; cv=none; b=j4DxhH8y7uYCoI9gswWA8pMz56/eHY42Hbd4cK/1aPXY8i4O8Je7xowvmTRK9xZD4DQsJFsb4G5gvA8an7D9maU7BxzBDyLI2Q0/90JXbWRUJ4p0Xi5CHHOQ7QXxzbgQ61g+dp0owTvE43x1EUfv4bGfGBLlH3YMlqPGuB1uLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348565; c=relaxed/simple;
	bh=EAN4sWBJ5u21afjmQCOH07b3iYnwg0JD2LI+Ap4oW6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mork6E6pKPvkpIAkPblIlS6xOlN/Da1myVlbOwsEDGgK+RzsUyO4A8O+cKZ5sFBPp5QNgy+L8PwXi3YGgxwOJxz+/r0IQke0RgT0OK9cPQbc1+MuXtWVQ5edTrUt1mGnZlzwPmSaDzwypbb6OZDjzKLM/YZD+Vn/oDE36nR8+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so8158443a12.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 02:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348562; x=1760953362;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTvGYqfZOznQ17hnioy7FCyX6Jv4eDMruKEwckMF/k4=;
        b=gy1lir6Zi+if0M+4jNT/Zyq0YD5jFq4C0u1AymBKIHEmokGmG3qudGiWKqLmikd6vA
         9Tk0o4g9FWInLxJ3s32kn9loLcIwOoW1n6bmWmV7w41NhNIPY/ois07EacKvIPVS9z3Y
         n7vkOVtfugzTc19cnA17uepvH4lvCyb6mAZaHn1aEPWzXzttBvxyixGEtn/UCbTPCCj1
         IjmKXDeLEVzo+9llPRJpkIKW/cq7rR+l3R4gvEhkaUkFjyYmQb4r4MGLbNL4XCfWg0aX
         SONXFqF7IyCSt6zWhNqqFW/JPwLOmDmJllCbx2mC7DDgq1Bvw8brQa5YD/QciTU+sT12
         2q6Q==
X-Gm-Message-State: AOJu0Yy712ZVNg8iNp3LXPXC7Syl94lpjZDTua1Tqm5OU2sM1Et3gf4Y
	4UUYpCThQt7XksmMvwXZZamhciZ6b76z28FQxinjTqT+IpyTyJoHYIVA
X-Gm-Gg: ASbGncsVME3Jl/ezAJ8BTyhROXKhwJ/i/dnR9DtSYdDUOuoYXcVwA1fgi3ztzfrrcDT
	/93KWji6qqlMRNtHCMKHH/assM8UCLGgXli7jc0zSZrl67PnF+sGHvvNOteDLx2EUCKol/XyudS
	YHfUzjvTCSB0qRJbe9DYtw5JgF+nQwNW3PYuf/cPrDzVVuygXIExOL+DRN0mXLaGHwe03DxzGgp
	8sjcjODJ0cjaEdOREKVAchG1K1E9MEBKq4Xe10vF16oFKBy1AgPHaiuac5NZnAJjZlkscSPduYE
	nTEFnwgjurDJ07lhOmSYtX0qxrMB4TSWYvclKd8OHCXHr1609VqZ2rMl+plx7pypTAhLJdH7lyW
	ulSPzkf29XyEZ9EBaJxeI2XX9CI5XxrEgVvjAKeHymZgmfls=
X-Google-Smtp-Source: AGHT+IFcI0cgPTqYWTOSyF+qub8t4bQnrQN0dIPm9yvFJr5D+T7COUZ+n8YwG9QqG0uQau0RjuCcuQ==
X-Received: by 2002:a17:907:3f1c:b0:b3e:26ae:7288 with SMTP id a640c23a62f3a-b50aa48e3b6mr2185548666b.8.1760348561519;
        Mon, 13 Oct 2025 02:42:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12978sm891499066b.44.2025.10.13.02.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:42:41 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 13 Oct 2025 02:42:29 -0700
Subject: [PATCH net] netpoll: Fix deadlock caused by memory allocation
 under spinlock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org>
X-B4-Tracking: v=1; b=H4sIAITJ7GgC/x3M4QpAMBQG0Fe5fb+t3EmxV5G05o5bGm2SkndXz
 gOcB0WySoGjB1kuLbonOOKKEFafFjE6wxFsbVuuuTFR7ynJeezbNnlvQt+zD2203HSoCEeWqPc
 fDkhyYnzfD3aHdDplAAAA
X-Change-ID: 20251013-fix_netpoll_aa-c991ac5f2138
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, gustavold@gmail.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2358; i=leitao@debian.org;
 h=from:subject:message-id; bh=EAN4sWBJ5u21afjmQCOH07b3iYnwg0JD2LI+Ap4oW6k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo7MmQ6bZzDnyeA7HSB+mYJwjwJrnCAoiQRk57X
 fyT4riR3CSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaOzJkAAKCRA1o5Of/Hh3
 bW6pD/4p6l9yBt+uGrcfQ6NLqvt5xASPh7iCV4JaBKLV8uV09l3b2HdgUaomSNb9/tCBtBAerhq
 +uS7iLu/wJ32EsGFNUl3RWZ1CAN5mnh7uaLSmQ2BxGoyOBPQsUQEo+HyHyZwAwfMwr7GbT0aYtH
 cTriHZSpvoNTCm5y4EQFaRLMVYPUKarz30D8gV86sQCdCEf5HQGm23iVnc+Z3N96HCHs3R0VOuP
 SBz/z8V6Gvd/4c1XHS9SX3JzMM7JnVxw5PyStVeuSkcRFF3030vZM8V/uR5e2sKaVHFr6iZK3vt
 4E0fCtGil6BpxOLNeTR43ICtloqDK5ZPTUaafiK8UnzyfIQjidmLiLf//lWcG7RdobVqh+HySqh
 i1cxo63VNT7Vs0XGday/DSS4Ig7hMi9hwNw9I7BK+0mmbNRdxK533i8pZjHI2tSCR/kYinJROUh
 X7UljsCDnnJsOLNhzKocXaFFfXZ1LsNTkCnz0gnwEZqfysTENWdlTdkxNNa8g5ACfzMMG1kLJZ4
 ul/aah9w+h72WTQUTtxZxIQiT0yz5UyRzOu/KZNl/EDlqV/VZNVEl1q5Du8QCcjqWIEPJeP6PfY
 zk7qJP7fvtWW1LhuG10SBnnFhKoUY7kCaTHfunCo39W/6Pjl9fXc21btEMfWCxCctjXnEvGxbuy
 bbi0swQEe3e87Ew==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a AA deadlock in refill_skbs() where memory allocation while holding
skb_pool->lock can trigger a recursive lock acquisition attempt.

The deadlock scenario occurs when the system is under severe memory
pressure:

1. refill_skbs() acquires skb_pool->lock (spinlock)
2. alloc_skb() is called while holding the lock
3. Memory allocator fails and calls slab_out_of_memory()
4. This triggers printk() for the OOM warning
5. The console output path calls netpoll_send_udp()
6. netpoll_send_udp() attempts to acquire the same skb_pool->lock
7. Deadlock: the lock is already held by the same CPU

Call stack:
  refill_skbs()
    spin_lock_irqsave(&skb_pool->lock)    <- lock acquired
    __alloc_skb()
      kmem_cache_alloc_node_noprof()
        slab_out_of_memory()
          printk()
            console_flush_all()
              netpoll_send_udp()
                skb_dequeue()
                  spin_lock_irqsave()     <- deadlock attempt

Refactor refill_skbs() to never allocate memory while holding
the spinlock.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
---
 net/core/netpoll.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 60a05d3b7c249..788cec4d527f8 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -232,14 +232,26 @@ static void refill_skbs(struct netpoll *np)
 
 	skb_pool = &np->skb_pool;
 
-	spin_lock_irqsave(&skb_pool->lock, flags);
-	while (skb_pool->qlen < MAX_SKBS) {
+	while (1) {
+		spin_lock_irqsave(&skb_pool->lock, flags);
+		if (skb_pool->qlen >= MAX_SKBS)
+			goto unlock;
+		spin_unlock_irqrestore(&skb_pool->lock, flags);
+
 		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
 		if (!skb)
-			break;
+			return;
 
+		spin_lock_irqsave(&skb_pool->lock, flags);
+		if (skb_pool->qlen >= MAX_SKBS)
+			/* Discard if len got increased (TOCTOU) */
+			goto discard;
 		__skb_queue_tail(skb_pool, skb);
+		spin_unlock_irqrestore(&skb_pool->lock, flags);
 	}
+discard:
+	dev_kfree_skb_any(skb);
+unlock:
 	spin_unlock_irqrestore(&skb_pool->lock, flags);
 }
 

---
base-commit: 0b4b77eff5f8cd9be062783a1c1e198d46d0a753
change-id: 20251013-fix_netpoll_aa-c991ac5f2138

Best regards,
--  
Breno Leitao <leitao@debian.org>


