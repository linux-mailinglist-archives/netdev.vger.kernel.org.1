Return-Path: <netdev+bounces-27706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB6D77CEE3
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CEE1C20B3A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF514270;
	Tue, 15 Aug 2023 15:16:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF02134DB
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:16:25 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596541FD8
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:15:47 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FEfCCh022023;
	Tue, 15 Aug 2023 08:15:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=yafSjUepW0OZNCL9pbEfnPFvLvS4XlIkqerKjM9fR1Q=;
 b=QP+t8CHB+0IEPUT/+vDCV8Q1/E6bVl9F8HhdN9Mo/kZVi9en1HnpGUjYu1Q4wKYsygWQ
 6sx779C1PvMUhAqITUvwrYnh0cEd+RTz8bFU+Ofi1G/2+U0KIHHfw9N38IC+XC3jbWZm
 bubiU9F1t8qeKvnJZuUwJ3EUSPZh63RvcSbf2iGCGiwJIe+UCzyy/fIFtptcI+8UP5oA
 wyvdwC3kPKz8SOeOJLl9k84LAUKbagvScvEvUPu8ive5ajoafl8aYWLAGSq4w1xbNq+D
 vHFm+bu0Gutqant1RVmyWFNqpwHVINS9LFYpaT4nP2TxqLIFGEJ4zpltSLgoi8RxHNGZ 7A== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sfwt4e8dv-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 15 Aug 2023 08:15:20 -0700
Received: from snc-exopmbx201.TheFacebook.com (2620:10d:c085:21d::8) by
 snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 08:15:19 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server id
 15.1.2507.23; Tue, 15 Aug 2023 08:15:17 -0700
From: Vadim Fedorenko <vadfed@meta.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
        Bar Shapira <bshapira@nvidia.com>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Saeed Mahameed
	<saeedm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net] Revert "net/mlx5: Update cyclecounter shift value to improve ptp free running mode precision"
Date: Tue, 15 Aug 2023 08:15:07 -0700
Message-ID: <20230815151507.3028503-1-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c085:208::f]
X-Proofpoint-GUID: AraHPkHJaCBOp_J78Z0MP-c_LVLukk_8
X-Proofpoint-ORIG-GUID: AraHPkHJaCBOp_J78Z0MP-c_LVLukk_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vadim Fedorenko <vadim.fedorenko@linux.dev>

This reverts commit 6a40109275626267ebf413ceda81c64719b5c431.

There was an assumption in the original commit that all the devices
supported by mlx5 advertise 1GHz as an internal timer frequency.
Apparently at least ConnectX-4 Lx (MCX4431N-GCAN) provides 156.250Mhz
as an internal frequency and the original commit breaks PTP
synchronization on these cards.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 377372f0578a..3e504e7d24ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -39,7 +39,7 @@
 #include "clock.h"
 
 enum {
-	MLX5_CYCLES_SHIFT	= 31
+	MLX5_CYCLES_SHIFT	= 23
 };
 
 enum {
-- 
2.39.3


