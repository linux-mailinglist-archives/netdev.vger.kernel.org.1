Return-Path: <netdev+bounces-265835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ0HLrtur2m6YQIAu9opvQ
	(envelope-from <netdev+bounces-265835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:07:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EEB2434F0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05EA9303EFB2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E452E8B67;
	Tue, 10 Mar 2026 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="g1HAkpn/"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC12DCF67;
	Tue, 10 Mar 2026 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104722; cv=none; b=AiKFSe+4d0PVvPkqAl6islxbezuxtd7OgmM/B7KDG0Y17HJWvUlg4c60/1i6hF8kPSLkkkcPyqw7bbIXpPP/ia2hYIkOcbjMzC64H+tyPv7MCAt//LiTmHabNlR4WjxIuWDikytEG0wOjrrfb+OyOXEvpiphFhQA3eunyS3hdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104722; c=relaxed/simple;
	bh=JI+zrssM2poQYt3Q/PQmB+LWGYXDv2SOXjEM5i2QT8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICr7VhdAfW28P3Tx0us+8tLlS3TCJZCli1JrxvTgDl40GlCH4XiyvjlpkVvzVF2ocE6OSXXPJRSubVIDkuw4eiDUtyCT5eepvb5y6tuNubGVNGz9yWE78oDzIvK8ID9tOEGyHW9lWwI+6Ikk9igeSExAyGbYy2uEFaTswgEDn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=g1HAkpn/; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IytfMJ2qVSxnwwGFOD+sjTnzoAxZ7/y0WCbSOE+d6Lw=;
	b=g1HAkpn/HgCZmR623CS14HsrfrxoNyBobe53az4mz1tQ3ErWBmmSQp3VWg+zwZB+Pvrrc/4Gn
	5Mfx2ECwT2lMeoJdWHLWYBupRAbL8yPtAoXOzw8XezPgiy9Hukg3Fq/aHTxZclZInDkfZSQ++Jn
	XCjvHqCZVnX7p+T5c8RG+nc=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fVFsy1VPDz1K9Cg;
	Tue, 10 Mar 2026 09:00:22 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6636640565;
	Tue, 10 Mar 2026 09:05:14 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 10 Mar 2026 09:05:13 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>
Subject: [PATCH net-next v03 5/9] hinic3: Add msg_send_lock for message sending concurrecy
Date: Tue, 10 Mar 2026 09:04:53 +0800
Message-ID: <d83f7f6eb4b5e94642a558fab75d61292c347e48.1773062356.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1773062356.git.zhuyikai1@h-partners.com>
References: <cover.1773062356.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Queue-Id: 62EEB2434F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265835-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:mid,h-partners.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email]
X-Rspamd-Action: no action

  As send_mbox_msg is invoked by 3 functions: hinic3_send_mbox_to_mgmt,
hinic3_response_mbox_to_mgmt and hinic3_send_mbox_to_mgmt_no_ack, only
hinic3_response_mbox_to_mgmt does not has mutex and the other two has
mbox->mbox_send_lock because their send actions are mutually exclusive.
  As hinic3_response_mbox_to_mgmt does not conflict with them in send
actions but in mailbox resources, add the new mutex(msg_send_lock) in
send_mbox_msg to ensure message concurrency.

  Besdies, in mbox_send_seg change FIELD_PREP to FIELD_GET in
MBOX_STATUS_FINISHED and MBOX_STATUS_SUCCESS to be more reasonable.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c | 9 +++++++--
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index c82370cf401d..51be726d9d2e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -51,9 +51,9 @@
 #define MBOX_WB_STATUS_NOT_FINISHED      0x00
 
 #define MBOX_STATUS_FINISHED(wb)  \
-	((FIELD_PREP(MBOX_WB_STATUS_MASK, (wb))) != MBOX_WB_STATUS_NOT_FINISHED)
+	((FIELD_GET(MBOX_WB_STATUS_MASK, (wb))) != MBOX_WB_STATUS_NOT_FINISHED)
 #define MBOX_STATUS_SUCCESS(wb)  \
-	((FIELD_PREP(MBOX_WB_STATUS_MASK, (wb))) ==  \
+	((FIELD_GET(MBOX_WB_STATUS_MASK, (wb))) ==  \
 	MBOX_WB_STATUS_FINISHED_SUCCESS)
 #define MBOX_STATUS_ERRCODE(wb)  \
 	((wb) & MBOX_WB_ERROR_CODE_MASK)
@@ -396,6 +396,7 @@ static int hinic3_mbox_pre_init(struct hinic3_hwdev *hwdev,
 {
 	mbox->hwdev = hwdev;
 	mutex_init(&mbox->mbox_send_lock);
+	mutex_init(&mbox->mbox_seg_send_lock);
 	spin_lock_init(&mbox->mbox_lock);
 
 	mbox->workq = create_singlethread_workqueue(HINIC3_MBOX_WQ_NAME);
@@ -723,6 +724,8 @@ static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
 	else
 		rsp_aeq_id = 0;
 
+	mutex_lock(&mbox->mbox_seg_send_lock);
+
 	if (dst_func == MBOX_MGMT_FUNC_ID &&
 	    !(hwdev->features[0] & MBOX_COMM_F_MBOX_SEGMENT)) {
 		err = mbox_prepare_dma_msg(mbox, ack_type, &dma_msg,
@@ -776,6 +779,8 @@ static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
 	}
 
 err_send:
+	mutex_unlock(&mbox->mbox_seg_send_lock);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
index e26f22d1d564..30de0c129503 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
@@ -114,6 +114,10 @@ struct hinic3_mbox {
 	struct hinic3_hwdev       *hwdev;
 	/* lock for send mbox message and ack message */
 	struct mutex              mbox_send_lock;
+	/* lock for send message transmission.
+	 * The lock hierarchy is mbox_send_lock -> mbox_seg_send_lock.
+	 */
+	struct mutex              mbox_seg_send_lock;
 	struct hinic3_send_mbox   send_mbox;
 	struct mbox_dma_queue     sync_msg_queue;
 	struct mbox_dma_queue     async_msg_queue;
-- 
2.43.0


