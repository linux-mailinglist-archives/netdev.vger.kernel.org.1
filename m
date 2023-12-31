Return-Path: <netdev+bounces-60663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7A2820C28
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 18:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868A9281A54
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666E8C1F;
	Sun, 31 Dec 2023 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zyva4fcy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0238F42
	for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ba9f24acf8so367877139f.2
        for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 09:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704043408; x=1704648208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CReOJix5PZ47ly1mbNRIjvx2TMQhxSi+iuVIC1P27U4=;
        b=zyva4fcy8s5q0VKMhFbU01xQ758TLaLM5DhI1or05P1jvrleIothPdHszAYIMvok5r
         Uur0OLt3d2AoJhubNjzmvJGVt0YZ7QXhwejGf7duRjZJdPf5H12PIAowI4n7at7Auihp
         M+48j5/pvGjR4hounDoX2Bi7wWdD+s102I/5F7MAJT1A+qPZOTr/s+ymKVxdAOxlJVf9
         yaAZ+PnFBcUBiQT62IX3bVNB1zJImzRVPeSwgdH+EVj1hKYVfGtURoVLyjYmIOu0M3I7
         BG2X/5UE+M/T/G1IeP/jYuHGUIj+ZuBnWTrJg6fwYwBL2Apet9vYP3KxjM/gEUeCoYmJ
         tsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704043408; x=1704648208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CReOJix5PZ47ly1mbNRIjvx2TMQhxSi+iuVIC1P27U4=;
        b=BhmZcewNHayaufJ9MvF+0qvTiLdJDGPVs6xrnc5Jp0/LYKje95ZkJnx80lXnwFULxO
         Mxq2HRBVMMQUDlTESa2+w/4n5aGkOvXxeM+xjtbyo5C7qJhRP3woBGbmqUZCyghFeRpk
         Wqfejxtlf660B2sVbuwh47wXfD6lvvjxQ4jYFytnFDp2RKwVUicybUjPH5nBw/GLo7i+
         4wekBLNqGMwh3hRbKgXovT6slvc0kI+aI2Vt0J+9hJgyO+xs/K1cQ6TKlhiJDRGZEBT1
         ObrVQ6k5xIWsDuU8piWu03/RrAGQKl5sKKqKoeCdX4m/ByOUaLc71PrDKFtGlRx2vaLV
         XO5A==
X-Gm-Message-State: AOJu0YwSZLOUywxBEmJrO+6nLS4LET5p/LpbwabX+TKn/1+tCkWZdwU8
	uWBMLfMwSRSIhUSv6KP8wbfLN5XBWOqw
X-Google-Smtp-Source: AGHT+IEwl4mvLLC9vLvWmX+FE4fovYD1G3S1NQq6emAIyQ+ZtUVIct9c8U2hWuC9PjMXGJe88jovuw==
X-Received: by 2002:a6b:6114:0:b0:7b9:c344:6e77 with SMTP id v20-20020a6b6114000000b007b9c3446e77mr19426515iob.8.1704043408609;
        Sun, 31 Dec 2023 09:23:28 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f])
        by smtp.gmail.com with ESMTPSA id g12-20020aa79dcc000000b006d9bf45436asm11389209pfq.48.2023.12.31.09.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 09:23:28 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: idosch@idosch.org,
	mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com,
	syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com,
	syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com,
	syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
Subject: [PATCH net-next v2 1/1] net/sched: We should only add appropriate qdiscs blocks to ports' xarray
Date: Sun, 31 Dec 2023 14:23:20 -0300
Message-ID: <20231231172320.245375-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should only add qdiscs to the blocks ports' xarray in ingress that
support ingress_block_set/get or in egress that support
egress_block_set/get.

Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reported-by: Ido Schimmel <idosch@nvidia.com>
Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
Tested-by: Ido Schimmel <idosch@nvidia.com>
Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
---
v1 -> v2:

- Remove newline between fixes tag and Signed-off-by tag
- Add Ido's Reported-by and Tested-by tags
- Add syzbot's Reported-and-tested-by tags

 net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 299086bb6205..426be81276f1 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
 	struct tcf_block *block;
 	int err;
 
-	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
-	if (block) {
-		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
-		if (err) {
-			NL_SET_ERR_MSG(extack,
-				       "ingress block dev insert failed");
-			return err;
+	if (sch->ops->ingress_block_get) {
+		block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
+		if (block) {
+			err = xa_insert(&block->ports, dev->ifindex, dev,
+					GFP_KERNEL);
+			if (err) {
+				NL_SET_ERR_MSG(extack,
+					       "ingress block dev insert failed");
+				return err;
+			}
 		}
 	}
 
-	block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
-	if (block) {
-		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
-		if (err) {
-			NL_SET_ERR_MSG(extack,
-				       "Egress block dev insert failed");
-			goto err_out;
+	if (sch->ops->egress_block_get) {
+		block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
+		if (block) {
+			err = xa_insert(&block->ports, dev->ifindex, dev,
+					GFP_KERNEL);
+			if (err) {
+				NL_SET_ERR_MSG(extack,
+					       "Egress block dev insert failed");
+				goto err_out;
+			}
 		}
 	}
 
-- 
2.25.1


