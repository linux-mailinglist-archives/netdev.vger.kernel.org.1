Return-Path: <netdev+bounces-115065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB194504B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB81B29951
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596A1B3748;
	Thu,  1 Aug 2024 16:14:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E01B4C23;
	Thu,  1 Aug 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528842; cv=none; b=bUNGektzgYYmAdhQ3uJ1kb2CJAltVnYmS7cUo0pPG0TdlnVl3ZdeA7lnhAM6y42OecHIYz8rbGZiOcrMIUyWTYHGKdv0PakBiRfjV/WlcAbYpcZ/PmzT3Xh4WMCfrgOFEThlGmcaX9jBdRs/VtvKOG4D+5auoRhtj1rU9NxT17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528842; c=relaxed/simple;
	bh=uC2BmUxRWsf0KsVLb+yZ2Q6rogj5W1+emqWqRBzGCbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPcilvnnWCkm0dX4Z5hgIMjqZlgoXiVZjDZSyQ6IDP6S9H3Cib09Zn1bo3t1KC1tdEIKUTI1hpS7le/Cg4+P3XUwnSXoHPBr3H5A7nNChf7/Elh4PtGThx55YcCHAM7PAVhHktcb9rKiWga+nznroXQkcfmKVYKt53rbtZ5mcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7ad02501c3so24674366b.2;
        Thu, 01 Aug 2024 09:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528837; x=1723133637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjhvO/EBhB/Q0GYaqqTWtDrqTWX0pPfpEEQqm+7VbP8=;
        b=sTsl/yFS3Qo0gI7uSEAdjnD8IV9rqcrIlX2mkG2bavTD61SJA+1OLYqqZZrAzKbuwm
         +jwB+A6Tjv+ZDiMU839nJJBT3IpSoKzLQnLQ8s5zDx6PtSMw84HpqHpkc+y5Y2LPJKua
         ekENzlXawJwoosSGTU4QAFT2vgpcKHwM4rubutkN8FcRZF0OyC5oxotWwLGER3zbwAUG
         EFNFt9Mwts8jmjuSwYn7S0MEONPY/d7q+kuqrlk+6T9/lFOGe+nr3ZphQ78Nigv5hSGQ
         AHRCByLuRbK8b0QNKq7nUn004wAgDNcYoDy5O+SxgBgon05Lvr9DPnShVJcAy4XcWBgQ
         UmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGm2v8J5XZD/MQd2ZYN5yhc1JUl3DPRDJUH+H2+QevKz8p5NwJqHqlvzDUoECaTccKwIVAFyFvjWppdLf/euNADvNbEJYTIg60DFSdcl121MH6agZhuZADzaB6CGsrLu81+NOc
X-Gm-Message-State: AOJu0Yy6ZHG3Rmik8pDOkFJDJ+qiifNzDgE0b539WFPsAo2+lz+09dKm
	fPhLhFcnrvd68k2a9QlZ0fb87oJCy2lOGSdjJWu93OEClbnvFqCv
X-Google-Smtp-Source: AGHT+IHayzcwog/gmPGLzBe0jVWIZGeY2SV8QM4SSOAok68Ua4v9QWwxo6FmbcadS72hKK5/M8z6ig==
X-Received: by 2002:a17:907:9689:b0:a7a:b839:8583 with SMTP id a640c23a62f3a-a7dc51c26e5mr45068366b.66.1722528836923;
        Thu, 01 Aug 2024 09:13:56 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de90sm913734866b.62.2024.08.01.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:13:56 -0700 (PDT)
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
Subject: [PATCH net-next 2/6] net: netpoll: extract core of netpoll_cleanup
Date: Thu,  1 Aug 2024 09:11:59 -0700
Message-ID: <20240801161213.2707132-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801161213.2707132-1-leitao@debian.org>
References: <20240801161213.2707132-1-leitao@debian.org>
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
2.43.0


