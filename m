Return-Path: <netdev+bounces-234970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE27C2A629
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 08:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 192194EA371
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702FA2C0261;
	Mon,  3 Nov 2025 07:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603D2BE7B5;
	Mon,  3 Nov 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155871; cv=none; b=Cl68MwlRmTn/d5cBW3fGQ+Nw1PKTLfzwChno4NlHnJr+aFlAolUZlfbb19zWfbN/IZkMDOHh7fuD1+DLWupDEIZ8aFzv8SubvnZTxCnn8mZjLZEz/ecc3A2dwbpk2pDpHS2UwOa6e5EzkwwMBapxKb21jU1/SQl6jFAcNIkSPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155871; c=relaxed/simple;
	bh=mqtTEHnfdDj7ufOnIaA3taPobJloaDUr/In/jZdqmZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i1KqVCYzKoRl3nX5LzyTPZFOg3qsRJRwX6S10vjBX5eNyARkIuuZuSY6Jo51qqY/bje76OzuV16tlnDTvjbU5LhR366nNK0ZEHmQBAe+sOaY4MoR0xRid8pX4hFFyP6Yyp+mL8xwZNg4JX2skQYa54dyuxtpwsI6J7U7t85PDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202511031544212240;
        Mon, 03 Nov 2025 15:44:21 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Nov 2025 15:44:21 +0800
Received: from inspur.com (10.100.2.107) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 15:44:21 +0800
Received: from localhost.localdomain.com (unknown [10.94.13.117])
	by app3 (Coremail) with SMTP id awJkCsDw_vlUXQhp9sMJAA--.15676S4;
	Mon, 03 Nov 2025 15:44:21 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chu Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] virtio_net: Fix a typo error in virtio_net
Date: Mon, 3 Nov 2025 15:43:05 +0800
Message-ID: <20251103074305.4727-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: awJkCsDw_vlUXQhp9sMJAA--.15676S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKw4DZw45uw1fAr48GryDWrg_yoWfurc_uw
	1UZr43tws5Kr4Y9ay5Cw4rAFW5Ka1kWF4kGF9xK3ySkF98uF13WF9FvFyDGFZrX39Fyr1r
	GFsxGFn8A34fZjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
	W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRfcTQUUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?aGgYCpRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KRUjP8h4mBi1RxM9Ia5pGzwGWIFG12ndAMRSAp2L3HO3jalIbuAhB7ycZuhkKUFH9M9G
	hF5mfmemBa/tI1nkgFQ=
Content-Type: text/plain
tUid: 202511031544215cf76b7d677404249b6809f204a42c80
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix the spelling error of "separate".

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e8a179aaa49..1e6f5e650f11 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3760,7 +3760,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	 * (2) no user configuration.
 	 *
 	 * During rss command processing, device updates queue_pairs using rss.max_tx_vq. That is,
-	 * the device updates queue_pairs together with rss, so we can skip the sperate queue_pairs
+	 * the device updates queue_pairs together with rss, so we can skip the separate queue_pairs
 	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
 	 */
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
-- 
2.43.7


