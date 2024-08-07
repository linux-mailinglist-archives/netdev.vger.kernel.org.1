Return-Path: <netdev+bounces-116380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5057894A409
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054D6281454
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F711D1F42;
	Wed,  7 Aug 2024 09:17:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8971C8245;
	Wed,  7 Aug 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022244; cv=none; b=NMb/4rGeaL27/aoQwfcd8w1g61Qgvt41WEkdcl7VgcasO0O2/xIA/Jm61I/tbWLvOfE3DoncteBrJTsh8cQ3ZR4iUUXfii5TOVdBwziKXbUL2tSV+fnbkpGUMqb5UrsO6aZ+838woUO8NJQzPuySNGihFBM3uurib+AkNbOyeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022244; c=relaxed/simple;
	bh=21NE45D05kd+63ejuqgp1rSDb0fTwjxyjDDlDLdKAD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhO0eASw/DbPshTKf0DylCdsW3aGy5QO8lcljuyFCn0sB+U3pXKcozcgJwho7opAzMgiiMLXbJYTk54x45x+0bUSq8wkdaDXbfFbqiZUlh9yw5AW78Ko2ETs/RVcZdDKbBLtr82Dea8Jv5vGFz4NYL81gWNWlCDA4Cj4Kq5flkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so181618866b.3;
        Wed, 07 Aug 2024 02:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022237; x=1723627037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oetxee9IMfZJjcpz+QqY4cG+Xmvizi5jKcfwfQxazyM=;
        b=YN5QMKlCsBnSuOpgJ77oBHz6SGUB0HrYrhL/IhN9m+ET7QKiiA+Qac6gTQC7NkiWoE
         eGvJPdWjqehga0ucRZW76fZOkcPYkiP9Cpje9ReDEq4DDKKJgDRWiOyu9R3fKBWzn+xA
         al6eIxYd5OY4IQq0PFFZZyC3+bFBstetNKMU2gB6cpetkYJUpE2MOR6p/2KwXSvzDYa/
         7wMz8h3cvkFhTMpJ3CuqGIpIUPZpHjvMNVHLQztX+7HfXXgAt1iRr1FcUxgYF0KaMaVs
         ZL1CRzz5b92ySAO7645MwwIGNKOdEvV6yGxVbQajGrf+mJAtZfZfmbzeIfsix+CodNXv
         ZJXg==
X-Forwarded-Encrypted: i=1; AJvYcCWwkSCHatIUUIgLr/VuQ+Vsu0dIbcRKVCRTjYl1W0BfW6er0UPY5JEAzFLKtvbRikmAtZC3n6jU5bO3Vn1oB7fs5vXcw5ZMhCfsuSUxmKkrk7gm8Gl/yb/IVh//qSuUQ55LvZmF
X-Gm-Message-State: AOJu0Yzg0Eh07MPzd2gyrnKR7KYykr9DVto84HXGZgM1EbzoUjO1BgZm
	vszty8arc1ajToFx4lLHW2XPam7rXRtZElrVff2jW4GpeGTrZZju
X-Google-Smtp-Source: AGHT+IFIx6xcc3ECTYqC11IKERlOkkDRxzouV5s7MOaC1Tc5K2guT+j6e59/hrFaENLXJ9Kql6qApA==
X-Received: by 2002:a17:907:7f15:b0:a7a:a3f7:389d with SMTP id a640c23a62f3a-a7dc4fae89emr1124999266b.31.1723022236981;
        Wed, 07 Aug 2024 02:17:16 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8d7fsm622601166b.219.2024.08.07.02.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:17:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thevlad@fb.com,
	thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	davej@codemonkey.org.uk
Subject: [PATCH net-next v2 1/5] net: netpoll: extract core of netpoll_cleanup
Date: Wed,  7 Aug 2024 02:16:47 -0700
Message-ID: <20240807091657.4191542-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240807091657.4191542-1-leitao@debian.org>
References: <20240807091657.4191542-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the core part of netpoll_cleanup(), so, it could be called from
a caller that has the rtnl lock already.

Netconsole uses this in a weird way right now:

	__netpoll_cleanup(&nt->np);
	spin_lock_irqsave(&target_list_lock, flags);
	netdev_put(nt->np.dev, &nt->np.dev_tracker);
	nt->np.dev = NULL;
	nt->enabled = false;

This will be replaced by do_netpoll_cleanup() as the locking situation
is overhauled.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index bd19c4b91e31..cd4e28db0cbd 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -64,6 +64,7 @@ int netpoll_setup(struct netpoll *np);
 void __netpoll_cleanup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
+void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 
 #ifdef CONFIG_NETPOLL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 55bcacf67df3..a58ea724790c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -853,14 +853,20 @@ void __netpoll_free(struct netpoll *np)
 }
 EXPORT_SYMBOL_GPL(__netpoll_free);
 
+void do_netpoll_cleanup(struct netpoll *np)
+{
+	__netpoll_cleanup(np);
+	netdev_put(np->dev, &np->dev_tracker);
+	np->dev = NULL;
+}
+EXPORT_SYMBOL(do_netpoll_cleanup);
+
 void netpoll_cleanup(struct netpoll *np)
 {
 	rtnl_lock();
 	if (!np->dev)
 		goto out;
-	__netpoll_cleanup(np);
-	netdev_put(np->dev, &np->dev_tracker);
-	np->dev = NULL;
+	do_netpoll_cleanup(np);
 out:
 	rtnl_unlock();
 }
-- 
2.43.5


