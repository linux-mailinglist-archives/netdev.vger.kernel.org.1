Return-Path: <netdev+bounces-60494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D434D81F8FE
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 15:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2361F226EB
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 14:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6743882D;
	Thu, 28 Dec 2023 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xk2m73Yp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED598832
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3eb299e2eso28618575ad.2
        for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703772561; x=1704377361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLBXrgj2+ZEdpJjnut0HmHd/H1eVJSWfjAVeMtLO1Cw=;
        b=xk2m73Yp1ncnzCkneSqTrsws2Gx/nnMGG6RdZQRoOY1zNnjyvJiW/CzvJ9jTiTqNHu
         xPN331Ayi4sv+rOBKVgRgRfHyB094PLrxPFJQ+PP2rzIjg+10QYPrP8RugT0iu93J3h2
         orwhqjfr6R2FdSq1O4KkO7bi0RrbQkFTQolNcrJbdPdANjoGXCNGpwqoUAada+NfS+Sh
         GfD4W5IxOCecou324Sk9OXicJs8ZKRfBihH5cN69FAYbPo+vBrBSZVUZ0PhDTluoyyv2
         ceUC9vRQv9Ywfe+VsOT60ZuNEBVHIw54suh9jh/16+lgAMeD6ozaCE12SdtI2DiSibJA
         9O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703772561; x=1704377361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLBXrgj2+ZEdpJjnut0HmHd/H1eVJSWfjAVeMtLO1Cw=;
        b=Y1i7P4SgB/MVojsE3kIKeN+OO6DZwXTsviT1RSK7z/nOr4r+krjpvOCgiI9JFR4gTy
         1CYJhsx80FPMdZnfIeEVYWGhQQ9ztnB/aC8lrBc0Vb5FivPvCk3Uwy9+eD9vxIEA7b2N
         5vrRbZADdg48jhjcgp/xoNTOo7GF4/JQ45481u0yCIdkIwzwENtVc4lxQaiitFZuz7LM
         cmonjJ1CO8Ynf+LhA7NOaYAjDYAgYv+VuNjU2PuSaplXbtXahR2Z2TQpSforIK9zQsKS
         bzAUX29b89rvPBEA/nJTDdBFrf3JqGp9z9dHkL1JHpGpmrV2vn9U3qNOj5VcSg8lLtS2
         xexQ==
X-Gm-Message-State: AOJu0YxrdJx1nGIcbO6ihDpDB+2UjcgPUYQrejjvh3XfmGo/rDxo3bV/
	jAoNEMRYOVfvw+7Dmc9WAP68ZAJZ54kT
X-Google-Smtp-Source: AGHT+IGu6G30WAnS1mvkvwn2BdLMZURyPE8Mn7LrQVk0jm/K9FpRuy2FlEvAYAdHDTnWVSi7RoeJhw==
X-Received: by 2002:a17:902:fe01:b0:1d4:3132:bf13 with SMTP id g1-20020a170902fe0100b001d43132bf13mr3679870plj.16.1703772561342;
        Thu, 28 Dec 2023 06:09:21 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:89e9:266f:d30e:b731:7f4f])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001d491db286fsm1314223plb.282.2023.12.28.06.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 06:09:21 -0800 (PST)
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
	kernel@mojatatu.com
Subject: [PATCH net-next 1/1] net/sched: We should only add appropriate qdiscs blocks to ports' xarray
Date: Thu, 28 Dec 2023 11:09:09 -0300
Message-ID: <20231228140909.96711-1-victor@mojatatu.com>
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
---
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


