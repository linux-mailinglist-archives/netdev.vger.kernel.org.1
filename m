Return-Path: <netdev+bounces-58076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC14814F63
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 19:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9281F218D8
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C75045C0C;
	Fri, 15 Dec 2023 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MZKKntE9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1541859
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1601152a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702663069; x=1703267869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UZHtlDWPN3SmkrNm13kChAIZmPJ4DOKn3X1vICjlSk=;
        b=MZKKntE9bSJtDu1M5YAaCBZCLFu/mDEFOoK3pEt3JhPwzXJ5+A3s2cEKk9g94D1G0P
         /alX7s1fLQC36jyDOPjV+gBYxguHrd1fMG81d51PUPlSJ1YdiUwjMS949HajmfJ3inoI
         67nI//YqlMnYeRBJkpdRmRPPhsOBt5S0Sev2NtlXAakSVmHTTYrR+WfdK7d0WrjGLcSi
         N7makUWaFCBMS5RYMh8CCIMWEt4PbDsrnnH+TYloU1ELI9pTrrwjj+VBAP5nMsd/i3Fz
         0Auv4QsU9+qzSzxelzxPFKIBzqp6w1E4nFeRcq9te8C9Uxiy80B3V9MA4kvqzsTxH7/H
         kAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702663069; x=1703267869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UZHtlDWPN3SmkrNm13kChAIZmPJ4DOKn3X1vICjlSk=;
        b=cqWFFsTQSSyEt4GGR/1ZOrjf8+Jvgi1iRX3CQ6ykp5JWj0zt1u1AHp/JgCEbRWkF3I
         7iSTLtmcn6EZdNAlN0bmelqrQzdBrbMjYNkfy4UUgvCKl4CIQu679WN0GrTR9JCAy7r7
         1eevTqr2V46QPRfg2g5TyEQrihgcn0RczGPVaZoNPn8H9lDDmK8zMRMUdBcAHJuFGasx
         hdphPWZO82E0CNXVUkqxSm4UYW45ptxsxeE260w3GHPNhxoKkMp/8Q7+sT43vfQxbqzl
         CTbrNaGMe3h14BmSBLsyjcfc4xKYiIbFtarY5GYpiJKmdjyht21iHdCAL6EYUl7ONRIs
         XCWw==
X-Gm-Message-State: AOJu0Yx/QqV7u4rhWnVf2+uI1MQikWl7sz5pk8o2vGvg56QnuiTvmxkh
	Spd0h6Kju4XWHmprYGCmEtXdS4jKgyAgpL4MxOc=
X-Google-Smtp-Source: AGHT+IHdJnSjh0pyGUbelhW81AtBDoxCBpyo/ns6LbKyUNATZdil9pNkbURSLG0x9AVA3m4ZJASRvA==
X-Received: by 2002:a17:90a:d70f:b0:28b:36f:f23b with SMTP id y15-20020a17090ad70f00b0028b036ff23bmr3966421pju.22.1702663069018;
        Fri, 15 Dec 2023 09:57:49 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id sm9-20020a17090b2e4900b0028b0848f0edsm711799pjb.9.2023.12.15.09.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 09:57:48 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	victor@mojatatu.com,
	martin@strongswan.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	lucien.xin@gmail.com,
	edwin.peer@broadcom.com,
	amcohen@nvidia.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 2/2] net: rtnl: use rcu_replace_pointer_rtnl in rtnl_unregister_*
Date: Fri, 15 Dec 2023 14:57:11 -0300
Message-Id: <20231215175711.323784-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215175711.323784-1-pctammela@mojatatu.com>
References: <20231215175711.323784-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of the rcu_replace_pointer_rtnl helper,
cleanup the rtnl_unregister_* functions to use the helper instead
of open coding it.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/core/rtnetlink.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 5e0ab4c08f72..94c4572512b8 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -342,8 +342,7 @@ int rtnl_unregister(int protocol, int msgtype)
 		return -ENOENT;
 	}
 
-	link = rtnl_dereference(tab[msgindex]);
-	RCU_INIT_POINTER(tab[msgindex], NULL);
+	link = rcu_replace_pointer_rtnl(tab[msgindex], NULL);
 	rtnl_unlock();
 
 	kfree_rcu(link, rcu);
@@ -368,18 +367,13 @@ void rtnl_unregister_all(int protocol)
 	BUG_ON(protocol < 0 || protocol > RTNL_FAMILY_MAX);
 
 	rtnl_lock();
-	tab = rtnl_dereference(rtnl_msg_handlers[protocol]);
+	tab = rcu_replace_pointer_rtnl(rtnl_msg_handlers[protocol], NULL);
 	if (!tab) {
 		rtnl_unlock();
 		return;
 	}
-	RCU_INIT_POINTER(rtnl_msg_handlers[protocol], NULL);
 	for (msgindex = 0; msgindex < RTM_NR_MSGTYPES; msgindex++) {
-		link = rtnl_dereference(tab[msgindex]);
-		if (!link)
-			continue;
-
-		RCU_INIT_POINTER(tab[msgindex], NULL);
+		link = rcu_replace_pointer_rtnl(tab[msgindex], NULL);
 		kfree_rcu(link, rcu);
 	}
 	rtnl_unlock();
-- 
2.40.1


