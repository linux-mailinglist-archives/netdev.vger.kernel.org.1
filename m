Return-Path: <netdev+bounces-234957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E95C2A349
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 07:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF39D3B1AA4
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 06:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83664296BC2;
	Mon,  3 Nov 2025 06:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAA296BBD;
	Mon,  3 Nov 2025 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151914; cv=none; b=s7HwiPItwcKZd+jPEmRLg3f9UU0/jx3kLSbDJrgTc1Qh6k85Yh5l4Iu5HUkrGpWULYyn5OKTT8SJicMy7z9eNzwjjNuBfEAokcW9Kzl4BpbzQgvDXfU2A81eYzcEuhJ+P5kuPhrkIG+pGUtAjP16Cnp2PJmlmOgPhhZM4KgMO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151914; c=relaxed/simple;
	bh=mqtTEHnfdDj7ufOnIaA3taPobJloaDUr/In/jZdqmZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3kpoePP96JcF3TGSCLT6A0gdAcfZk9YX54oeIcFTyMStRVVao43JIfqMfsXHjSRLP2pYG4XEB0C4lbZ9Lm/WoQNxbBxSNglVT/mNjwv2/22XdLOnuSg7mlBO/YaO/q79QLLra7nhCt68Pb7hPpmGluWGnprmZwdnimQlRP6NJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201616.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202511031438248582;
        Mon, 03 Nov 2025 14:38:24 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201616.home.langchao.com (10.100.2.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Nov 2025 14:38:23 +0800
Received: from inspur.com (10.100.2.107) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 14:38:23 +0800
Received: from localhost.com (unknown [10.94.13.117])
	by app3 (Coremail) with SMTP id awJkCsDwEPneTQhpgL0JAA--.13964S4;
	Mon, 03 Nov 2025 14:38:22 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <"mst@redhat.comjasowang@redhat.comxuanzhuo@linux.alibaba.comeperezma@redhat.comandrew+netdev@lunn.chdavem@davemloft.netedumazet@google.comkuba@kernel.orgpabeni"@redhat.com>
CC: <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
	<virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chu Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] virtio_net: Fix a typo error in virtio_net
Date: Mon, 3 Nov 2025 14:36:33 +0800
Message-ID: <20251103063633.4295-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: awJkCsDwEPneTQhpgL0JAA--.13964S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKw4DZw45uw1fAr48GryDWrg_yoWfurc_uw
	1UZr43tws5Kr4Y9ay5Cw4rAFW5Ka1kWF4kGF9xK3ySkF98uF13WF9FvFyDGFZrX39Fyr1r
	GFsxGFn8A34fZjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_
	GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjHmh7UUUUU==
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?DKTVVJRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KWEkofU1bJvebEtZkuG4YLrU+vTWs0UaMZjN3SDVnrRYNjwvvyPu2AsqKRdyaiTde6PO
	b7yM2pVqj+AYQqHbEW8=
Content-Type: text/plain
tUid: 202511031438248c7be716b006c143bcb8f91c6232ec2c
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


