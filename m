Return-Path: <netdev+bounces-167353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9759DA39DF9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E8A16FA8C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C8326A0E0;
	Tue, 18 Feb 2025 13:49:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE026A0A3;
	Tue, 18 Feb 2025 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886591; cv=none; b=IuLX/5RJK5P0NLd5jlJZASg+KlXvNWXpnCnz0wcQ59+uOfH3mK3W3jWqMKP6od8vmWzcSTu+P7SHMel9dLQz5h+RjxVVwGhnOjsbLHrv5fNuF2nHjuGrWZjKe54MrH/Ua6gULPCAtJSEdaYfT+nXa0+ttlVuYrY7xQf+N9NVs4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886591; c=relaxed/simple;
	bh=3pma+BrFPlIdrBIvQwZVmV7DCgLXxG/0rRTk4CsT/Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9MKFxQ8+KGlwmLfMwcnxc07D14ZBV+fUEgqCRSTwkYp2x2KJl9xKDTHwGtNl7j0ELWE4CFuTk/hurM05r4cf2odPE5xRX9mXu7ZpWcG5P8/Bt6JbpmGbR105qS2W/zIiGSTKJz+UCJ5vRMWhPjC4K08+boAUegPalvEHdsobhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso824935866b.3;
        Tue, 18 Feb 2025 05:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739886588; x=1740491388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0y+AufEj80dUW2NVFeJuaDteTVuYPqimU4ue0JsmwBc=;
        b=bfB90PydBgyO7Gsb63TrYBsLm0P7hTWDVBc7rFjX/q1wWlplNGfDrW6BUC2hI3f1b0
         ZwqyQbPkqpp2+py4LT8r1LUw44rZNcHhp1bobVly42kD4ZV8j4+Von2WIXaCAfGw85ih
         AC+PKdYljk49vNtnj3NJYPdh0QqBT2NnmItVMWpN1R88fs+rqwi9MzEg5mKNVOVwkKQG
         7wrE9soHyJNO38l/SdGEX1afL9dpsz4HF4gvrSWC2bpL5IKTMQFxM+Y24O9uhxDJzW7/
         7h7xI06lEM/Rt5JkMTXCCAqxX4ovVThN4VBPphiOx01lzDICxh4mXtqfYrWxi08MwU5y
         793Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBY7+l8rziehOfsLxmgTgRUVNdDyGffxjOdz71//ZGMn6pTER9y2ZfzkVzTGmY/XdaBM9MSws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVvq6BF2DFVxqxhtgIbMCch8DOarX9A58xV+y9eO05mo61WXy
	xy6NiLhaIAJ4S3BymeXbyZewpRRuAwz6ZxoieLPVcSvgbaGdZg9k
X-Gm-Gg: ASbGncvn9TBVQc64OUV+jdRZJtdZbzinCDMJUlaeo+dchoFxuv8uAsG80eYfLJaQS/i
	dwQkWHr7XxKACMJs88zQgSpGAqf7FkjM+HOejzw9RKtj2pzQ1aIvssLYesqRTXcr34pJOxu0j/Q
	iSs8IrOnQl+UdF1npuwI4MRiBvo+DMBfeKa4PVXQzCJwaQHrYStMuuzZKc/L9j9eaUIOCRrVdzl
	wqp377eH14VVyPccSKRRrf+rh98hj8iwOMFdnJdhOe2ua6pFDCUl51vvdJOLp71aIFumP9/yx1O
	Q8v4JKc=
X-Google-Smtp-Source: AGHT+IEi6UwppyMkniqfjSvEKR+7C3InD+bxzh/ilklPpMeKninV0CBSQVwhm/E2qXT9Aov0zuUWOQ==
X-Received: by 2002:a17:906:30ce:b0:abb:b1ae:173a with SMTP id a640c23a62f3a-abbb1ae2144mr416514566b.37.1739886587776;
        Tue, 18 Feb 2025 05:49:47 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9c9b653bsm367223366b.166.2025.02.18.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:49:46 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 18 Feb 2025 05:49:31 -0800
Subject: [PATCH net v5 2/2] arp: switch to dev_getbyhwaddr() in
 arp_req_set_public()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-arm_fix_selftest-v5-2-d3d6892db9e1@debian.org>
References: <20250218-arm_fix_selftest-v5-0-d3d6892db9e1@debian.org>
In-Reply-To: <20250218-arm_fix_selftest-v5-0-d3d6892db9e1@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, Breno Leitao <leitao@debian.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=leitao@debian.org;
 h=from:subject:message-id; bh=3pma+BrFPlIdrBIvQwZVmV7DCgLXxG/0rRTk4CsT/Hg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBntI/1een4gvNsw7R8w9kSbWdAt+MsYP60ZcMNq
 DF8kq4XAhGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7SP9QAKCRA1o5Of/Hh3
 beBuEACRLA6GAkOTy68MjNMSQrk4TZFLvg0i6s2IOb7Rmqq1rPZyCoGoWebGr1A21BT91FhX4Bd
 usQTj2M0PG3XyT55c2TKypgxxzJm0/PWprfshhBxkH275qUgsEECV+Zi7rZzWZ6vSxNm2LFj9I3
 rIdDE20RO9c3llIORT1X1BjBkMnwvTdtDzJGoHRsnJoqPOJEkOIH74jmXRRAykCSCZCyy93RjzE
 4Ss84JPQJ7vI4OdAxvsZLqNEeMdmqiQ/TzqbbGyJmlRWWsXDOz8o8O8V6n9X/9+dYd0NrzYNtpe
 m7Mo6KG70os9xd532hVvjt0hJdhpfsJ+6jHOr1aSkcZq+RcKZY20L+JbZVyF9FrirpyxV2r7XJd
 wSYgegjksrKYivPEcsb2ATNSsrdECx/xiRnq2zpFAebGhV0PQw+1SYuRpyWHMVzerwzoIWQAWH/
 nyj8P9aF41X909nhO6XVO6s0QqTP5ydMLa7ckKntQ7o4Ka8phb5mSyd2cCPeH2KFzs0B9STyDS3
 wOkY9cOnFHm0lByHlCQobFJKeRg+JzwSRw+74xud8kn5qcLjL5eAxNPFbHC8zFR8hm+6isK/hwc
 80AuaDAPuj7KcFqnCWBJ/KL/a9/TxqDEnvwBYuuctfc4GnF2atoippGu7g8SIlcffAMIRXg+eSw
 UN0CzMzuyjhBN2w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The arp_req_set_public() function is called with the rtnl lock held,
which provides enough synchronization protection. This makes the RCU
variant of dev_getbyhwaddr() unnecessary. Switch to using the simpler
dev_getbyhwaddr() function since we already have the required rtnl
locking.

This change helps maintain consistency in the networking code by using
the appropriate helper function for the existing locking context.

Fixes: 941666c2e3e0 ("net: RCU conversion of dev_getbyhwaddr() and arp_ioctl()")
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/arp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index f23a1ec6694cb2f1bd60f28faa357fcad83c165a..814300eee39de12b959caf225f65d9190594bba9 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1077,7 +1077,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
 
 	if (!dev && (r->arp_flags & ATF_COM)) {
-		dev = dev_getbyhwaddr_rcu(net, r->arp_ha.sa_family,
+		dev = dev_getbyhwaddr(net, r->arp_ha.sa_family,
 				      r->arp_ha.sa_data);
 		if (!dev)
 			return -ENODEV;

-- 
2.43.5


