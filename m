Return-Path: <netdev+bounces-59015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAB7818F9E
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 19:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D190283E67
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AA738FB8;
	Tue, 19 Dec 2023 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1kvHr0Qp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432937D2C
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d337dc9697so39289825ad.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 10:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703009799; x=1703614599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE2dE+avZKQu1ovI8Yx7HL4OY5U2jvRAC1pzA1mP/qE=;
        b=1kvHr0QpsEd7tC1qNrYOMDwr9OanTPn03V27+c0qEeMOdviIvSqUrB+NF6Z699n2l5
         +F+jaeHn6u+kgEiD5yIZ0O9fNvi5r++6izTkbIPCsgxB8/m7SwAlNm1vSaTEMGduveu4
         /d0zPr2q7qpFLhOZfCYshVVKKSsdjMw6VHmhBhiNvL/Qdo7LCjn3rm1EBrgFObXEC70Q
         KPJiilL4z+CYyaSSA0EqryPxSwMyCHQa2I2Zh5NJThCyWDF9v+R4tV7JCnwjf4AQLd9A
         JcP3nVRo+v7oljyJywv47W8HJvKZ1cRLG+i7ZVnHrSurdM7mtf4ScTeGIveNejXdgRQI
         5uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009799; x=1703614599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE2dE+avZKQu1ovI8Yx7HL4OY5U2jvRAC1pzA1mP/qE=;
        b=f2xDQ9vharlEf2Cr0Vzv6WYBHLRGHY3XomS4E2vX3AD1N/5q0FLOHuuyvtGEUUH/LV
         nACerglZGvWfT6ObHoxeO9otk92ddzTaQo7fgc0azZjBJ5ipG3yVuOLP1ECBU4x9IXbZ
         LcJjhCFlyxDLT49gUec46H78/DyYdHlMtpSh/JvGAcLZTpzKCayJfEa8m1o9YuYRwRmd
         HCgtnALq/du4M5qioTIk2PzmeZWtrS8FoQaUHopiLkhDFn0Is3qLQIYggiEiAOJ/UQ6Q
         CkqHvwB3Ars4bN/yBlgRW+jXAljZXYqYB1wiyDpaTxS0eu6T7QXqjr/TAkoRi41I3YXp
         dbvQ==
X-Gm-Message-State: AOJu0YwkfrD6x6Ib9sKcYgpgI6FMa9qoMKaOOn2eyNmKBUlK/CZxypvW
	gxe4Q8cuN3ZtiAtMyM+R/Zib8w==
X-Google-Smtp-Source: AGHT+IHe07stwsjKfpaEe/sprsoZFPJKFmhi43GDYsQQR8NiBSAq0oMC9hnmVWgGvoKIIinJVB5Hww==
X-Received: by 2002:a17:903:22cd:b0:1d3:c08d:ba9d with SMTP id y13-20020a17090322cd00b001d3c08dba9dmr4387349plg.68.1703009799498;
        Tue, 19 Dec 2023 10:16:39 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b001d348571ccesm4372188plf.240.2023.12.19.10.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:16:39 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v8 2/5] net/sched: cls_api: Expose tc block to the datapath
Date: Tue, 19 Dec 2023 15:16:20 -0300
Message-ID: <20231219181623.3845083-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219181623.3845083-1-victor@mojatatu.com>
References: <20231219181623.3845083-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The datapath can now find the block of the port in which the packet arrived
at.

In the next patch we show a possible usage of this patch in a new
version of mirred that multicasts to all ports except for the port in
which the packet arrived on.

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/sch_generic.h | 2 ++
 net/sched/cls_api.c       | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 248692ec3697..3b2c5b03c4cc 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -485,6 +485,8 @@ struct tcf_block {
 	struct mutex proto_destroy_lock; /* Lock for proto_destroy hashtable. */
 };
 
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index);
+
 static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain *chain)
 {
 	return lockdep_is_held(&chain->filter_chain_lock);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 6020a32ecff2..618f68733012 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1011,12 +1011,13 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
 	return block;
 }
 
-static struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
 {
 	struct tcf_net *tn = net_generic(net, tcf_net_id);
 
 	return idr_find(&tn->idr, block_index);
 }
+EXPORT_SYMBOL(tcf_block_lookup);
 
 static struct tcf_block *tcf_block_refcnt_get(struct net *net, u32 block_index)
 {
-- 
2.25.1


