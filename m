Return-Path: <netdev+bounces-164697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AECA2EC00
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB5E3A4B4A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D581F91F3;
	Mon, 10 Feb 2025 11:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3711F76B3;
	Mon, 10 Feb 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188589; cv=none; b=eMC0Ym13Z/m7/guSBQzEs6LzeGZjVHl3Ny1PI+TkEsE7h4xR41c1UyFKtLhRP3Dk740vnbZfCzbrxszjX20GopFDk5zNMuj5fmHzZSKGsSOlASxGuAu+GU1uyGBRrecuJiVic1htUZ6YMkqS4Xdb/1u1tmsnmU0svo3ymrAczFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188589; c=relaxed/simple;
	bh=yd5ec2CLDNzLfC0/a2RFUqinpthomFfOpRSaGwmcrrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1HCy/1XkaceIURzXDKTbuHgOb/wAW2Fj0qCR0SAO+MOQNIq9COuPbVZ2if4f/bobV05LMV54pymVpXTArwKEuIh4j/ZOTEc1UXcEO0gCSMFgYEcddhgH/ptLHzvlhZKc2YF4wvhhrHPJ72IR8IgJWqgCUwwY9EJ+CJKE7Mt+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab795ebaa02so462012066b.1;
        Mon, 10 Feb 2025 03:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739188586; x=1739793386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI/lDFVmS/BsIQbF1RPHtUBxGNsz3ryz5oSTt2+aUfw=;
        b=Z5HqSC44ktVaNwz+v8DAunM0wIGPdoKo7yPl3V4IuDQ4CyjiLr2y41zxwUvS/nfmgn
         L2nTlL5ngdbaYmslkgYhsYxt6rqJIu4ncOai7s5oOhtUlJvcg5030+yBvqQlwJLm7xZc
         vACLg0YJP4RaVkYA7/AbRkiUf/qlgr9SPjK5Zc6TZbxiDm5uvWk798MmFH5efTOmOmf0
         Zyq7T4+/m5EvfC78vdaGCwmVY0mX0zapV38ienfQ9VA1cyI1oAfz/UAFQiIa/Z9N/hxf
         /yR0sAsiEROQnBNrxcHNxHjpaLRy3UwlLUTzOts8T2OvkNg4B/OPDI2etexqYfbRk4z3
         zXng==
X-Forwarded-Encrypted: i=1; AJvYcCU3qGLqolQC9T6Zr/5zkMD1xraL7PUGkc7EV9uNyqWv3WKbT9gF8+3O6JKBbXNn+2wIxvPAPJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6yTGeqSfvji0fJwfWvotsYdBSFQWMKMiNiu3oLeoW9tUqjMY
	eTqVPbCMJuiCMPdKqBphUDOxbnnpndoPEeIN80GSoylu8/FEiYNM
X-Gm-Gg: ASbGncu6HWHiqRX47JOz9gIz6yuS2CDWa8SVVk4tpmRq/dOAQ2jaOJASCaI//+1V8QF
	ojok47JQzyOThUr/L5URbgh2EtfTcS+8oUHOuLpmUaZUi1ElzLcN5TeU9m6EWj+yjpi5SkoX2F8
	K8G2E3PqLmedpIcVLyZAkFvdghe0dRwYpAumT8W/+G17a7EieTtr8Ty0nT0aYlLnA/dILOU1WAM
	E7hAm9W8z84VSYyRbjjA5JtB1QYCPf5x0LXhJpau1b0WtEAKRc+qvGHsiCC0xeyerF0ctoi69dl
	ViUCjw==
X-Google-Smtp-Source: AGHT+IEUg+BSqOqF0aVD9imzRdFKX4FyYTsl26E7udlk0pqLHjQK9IFr88desyFG0skz+MX0Q5UxVA==
X-Received: by 2002:a17:907:72d5:b0:ab6:8bc1:9b5a with SMTP id a640c23a62f3a-ab789c49492mr1562380966b.41.1739188585515;
        Mon, 10 Feb 2025 03:56:25 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7736439bbsm848232766b.162.2025.02.10.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:56:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 10 Feb 2025 03:56:13 -0800
Subject: [PATCH net-next v2 1/2] net: document return value of
 dev_getbyhwaddr_rcu()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-arm_fix_selftest-v2-1-ba84b5bc58c8@debian.org>
References: <20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org>
In-Reply-To: <20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=leitao@debian.org;
 h=from:subject:message-id; bh=yd5ec2CLDNzLfC0/a2RFUqinpthomFfOpRSaGwmcrrg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnqelloQdo9lkAQ3XqxZjt8TdMsyq1/vNI1DGUU
 jUotBv262iJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6npZQAKCRA1o5Of/Hh3
 bR+WD/9aLq/QZ+ctGMx9jDvh0AAKnC6LTEd1CFmvXLEFOAdb3Z2M8xt6B60BdWdQWjdblYh+aaR
 CA6w6utmIIpoaMTm3+JQNpnFPOTRAWihmxfhN1bqSJTxl26KlCudNRtf1H6lOGWuqvNxIr+3PQM
 BqZYoByLRyK0nOGbNLVjvPfYv6uhHPRK3E70w1s66P4GqIpdhwd0WrDEQ0zLLk+UGMy6P/P/p9p
 85TxbxWMS4ysvS9sB2qincu07Y99lqQq8yUkexxZu6q0hf0Qx9jKGsSUMqu7scgDcBWI2rXF2ni
 FnYhQLeamD0Ez+GW0LSg/VzLNiPyZYbnFnmnF+BKuLTp5YiwucrdmaSGNVl8sgzPKhs7I4YS62I
 5XKMq+VoM8tExPkSxrOwQRGumTYB+RlJSZimafV8Z++ETG1zC3Yd8rJmIRjFlpejPsjnIYepK1K
 gth662Wv2REvtInOn8RkMMX+/hzRBAccI0a+GiDnlEOQXy72shi2qYO2f2sroC0uKqxnrfJW4D5
 fVzHnz4M+upIqW6Vp4hPMZeaQO8+9KZ+d8IjzKt/p3BPX5PJk1HZ44Su9kWE9u+2D7RKAmuygXA
 WXwCldhQNZJsO+yaGQKp+2jv9EWPXblsFch0lrXLxAdANv0RQETmWeYb2ozU1d4J8wVhbCbSMx+
 LIravQGQy/c2bwg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add missing return value documentation in the kernel-doc comment for
dev_getbyhwaddr_rcu(), clarifying that it returns either a pointer to
net_device or NULL if no matching device is found.

This fix a warning found in NIPA[1]:

	net/core/dev.c:1141: warning: No description found for return value of 'dev_getbyhwaddr_rcu'

[1] Link: https://netdev.bots.linux.dev/static/nipa/931564/13964899/kdoc/summary
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c41d1e1cbf62e0c5778c472cdb947b6f140f6064..c7e726f81406ece98801441dce3d683c8e0c9d99 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1133,8 +1133,8 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
  *	The returned device has not had its ref count increased
  *	and the caller must therefore be careful about locking
  *
+ *	Return: pointer to the net_device, or NULL if not found
  */
-
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 				       const char *ha)
 {

-- 
2.43.5


