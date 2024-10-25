Return-Path: <netdev+bounces-139131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2C9B0597
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67395284715
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6252C1F7568;
	Fri, 25 Oct 2024 14:20:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441201FB8B3;
	Fri, 25 Oct 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866053; cv=none; b=Neut3yuDsj1qSyGbYT+fVMsqOu9JACOPkXLVnM97AIpcQEx0Jzo+54qhTHjiLcZ9hZlWRl3rf5jf0NuU4YeohWdRx89HHXBo+JMkyEQxg6NBHhdJd/yN2e3PRqtmuazFDQOB6ABwqYkG5oz4c64w+tdbEpVRD2AhuX8y34TV87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866053; c=relaxed/simple;
	bh=fLsTCSmGp67EjhEnnlAG78/AyL452S+1fsT8cfcmIoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDJ8bILx+I2lCbcYYekZfZTb9abZ0jOMdllLUvNMrplLTJ0Xxv8k68gdjAHRM/Er1FObZ+tmXfScrrcuPRLh0w/UtbEZeG4mXTmKNiVL4MV9CsSwmWCREVXwKUMY2jYFEBV795r8rU2+gdYnppi6G5vZvtvp6kQGN9mE8GOaCQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso289695066b.1;
        Fri, 25 Oct 2024 07:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866049; x=1730470849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pm3hvhV5IbmS7jee4bd/KcAJkIdb0heegZgnh5CQJLs=;
        b=rfvndUizzeYBHUldBVqMg4axYiLI/+H4Qq/fVo1MM54rNG6ItC0Q4YL1zperNHbsUw
         5ZgW/Q4LU88psfY4nTea6k17rc1WhiPfoiaRGXOD5tMLDLoIFMb1hb7Ad4zWl63DDsCF
         AMrIXy4TIfRYszu569Ica5cVVDBZGOoKmvwECmL/SBx2R2X6H875YMIGZNaWOFLKQs/K
         3GHt+8UfpQk5EN/HArsczmi2S3RCAM095sGSPEPLUE0YzsQz6BsO7KrlD5XyCUoXP68L
         8JxgF6teRsCylCLaSslZf+risyXCpOMUtzpJwk1Mj2/6lYfAC0QpnaxGpLAHUz5TQsLq
         Rq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/wDfDZsSIauO1xBjIqzn4YuVO/0gWrZ1dqP78npcig8xoTsXTKFKtUextQt9yrSLGdKv06Etz@vger.kernel.org, AJvYcCVBB69CNw/TJBnou4ArSdlDwZYCASEarEVD4E9P2Sts5Qbj3V6QZs7aDEDU6Pr/h3oQ6xJxqTf6CnJAVLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/82fLvm86smDHZkWrPcrXCuqxPw2qgLrun35nuo4bYTka3p5
	BYGvjJ0+/nbcMzPvRUZ41wUNi+mSzRkOWYGB9zAa/3tsbL597HE/
X-Google-Smtp-Source: AGHT+IFbKqmmKvRLqml79sWrH3UJ8TA84zhLsSg9Rz0Lm0QloNqbwms7CBZXT0VjobG/JIt+Wf6X+w==
X-Received: by 2002:a17:907:72ce:b0:a9a:b70:2a7c with SMTP id a640c23a62f3a-a9ad27386f2mr555322766b.25.1729866049488;
        Fri, 25 Oct 2024 07:20:49 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b32455a83sm76247066b.186.2024.10.25.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:20:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com,
	jiri@resnulli.us,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	aehkn@xenhub.one,
	Rik van Riel <riel@surriel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH net-next 3/3] net: netpoll: flush skb pool during cleanup
Date: Fri, 25 Oct 2024 07:20:20 -0700
Message-ID: <20241025142025.3558051-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025142025.3558051-1-leitao@debian.org>
References: <20241025142025.3558051-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netpoll subsystem maintains a pool of 32 pre-allocated SKBs per
instance, but these SKBs are not freed when the netpoll user is brought
down. This leads to memory waste as these buffers remain allocated but
unused.

Add skb_pool_flush() to properly clean up these SKBs when netconsole is
terminated, improving memory efficiency.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index c9a9e37e2d74..bf2064d689d5 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -656,6 +656,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 	/* last thing to do is link it to the net device structure */
 	rcu_assign_pointer(ndev->npinfo, npinfo);
+	skb_queue_head_init(&np->skb_pool);
 
 	return 0;
 
@@ -809,6 +810,22 @@ static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 	kfree(npinfo);
 }
 
+static void skb_pool_flush(struct netpoll *np)
+{
+	struct sk_buff_head *skb_pool;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	skb_pool = &np->skb_pool;
+
+	spin_lock_irqsave(&skb_pool->lock, flags);
+	while (skb_pool->qlen > 0) {
+		skb = __skb_dequeue(skb_pool);
+		kfree_skb(skb);
+	}
+	spin_unlock_irqrestore(&skb_pool->lock, flags);
+}
+
 void __netpoll_cleanup(struct netpoll *np)
 {
 	struct netpoll_info *npinfo;
@@ -828,6 +845,8 @@ void __netpoll_cleanup(struct netpoll *np)
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	} else
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+
+	skb_pool_flush(np);
 }
 EXPORT_SYMBOL_GPL(__netpoll_cleanup);
 
-- 
2.43.5


