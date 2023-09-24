Return-Path: <netdev+bounces-36037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB777ACA55
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 17:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4E450281461
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A643ED28E;
	Sun, 24 Sep 2023 15:17:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3DD28B
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 15:17:41 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C008CE5F;
	Sun, 24 Sep 2023 08:17:28 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VsinOcr_1695568642;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsinOcr_1695568642)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 23:17:24 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: wintera@linux.ibm.com,
	schnelle@linux.ibm.com,
	gbayer@linux.ibm.com,
	pasic@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 11/18] net/smc: implement some unsupported operations of loopback
Date: Sun, 24 Sep 2023 23:16:46 +0800
Message-Id: <1695568613-125057-12-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Vlan operations are not supported currently since the need for vlan in
loopback does not seem to be strong.

Signal_event operation is not supported since no event now needs to be
processed by loopback device.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 610af99..4341803 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -75,6 +75,32 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 	return 0;
 }
 
+static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_set_vlan_required(struct smcd_dev *smcd)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_reset_vlan_required(struct smcd_dev *smcd)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
+			       u32 trigger_irq, u32 event_code, u64 info)
+{
+	return 0;
+}
+
 static int smc_lo_supports_v2(void)
 {
 	return SMC_LO_SUPPORTS_V2;
@@ -108,11 +134,11 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
 	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb		= NULL,
 	.unregister_dmb		= NULL,
-	.add_vlan_id		= NULL,
-	.del_vlan_id		= NULL,
-	.set_vlan_required	= NULL,
-	.reset_vlan_required	= NULL,
-	.signal_event		= NULL,
+	.add_vlan_id = smc_lo_add_vlan_id,
+	.del_vlan_id = smc_lo_del_vlan_id,
+	.set_vlan_required = smc_lo_set_vlan_required,
+	.reset_vlan_required = smc_lo_reset_vlan_required,
+	.signal_event = smc_lo_signal_event,
 	.move_data		= NULL,
 	.supports_v2 = smc_lo_supports_v2,
 	.get_system_eid = smc_lo_get_system_eid,
-- 
1.8.3.1


