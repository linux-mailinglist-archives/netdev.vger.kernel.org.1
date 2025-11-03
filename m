Return-Path: <netdev+bounces-234956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129EEC2A246
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 07:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBF33A3E1C
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 06:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8106A2868AD;
	Mon,  3 Nov 2025 06:07:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208992A1C7;
	Mon,  3 Nov 2025 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150022; cv=none; b=nfSEWbTw6eYBvyXc2Y0W0Toti3HqLIpJJCG7t6TTmEmVcjcoxoo98xsO20YprYEk1bU33Gb2/hC5c9Pq+8q07a7MkWIhjmxzQnKbyq4Ek+rOZNAC/Y+Srv1XEPXGni5BsMF/Vvi3Agz4gA+DuThelmZXPo9ty9/XmvB3Q6TfqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150022; c=relaxed/simple;
	bh=RL7I2sVDsXvSV2eh80N/nVCcj43D61OOA35MTWaVuR0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pQZ91v3ESgfy44NlxWswIVN7oQeStpfCrqHAnvkqTblVIiREqyGTAow9XMqautY+OhtO74mDxUIeZN2mq02LBEHEtPKGyS0sSJghPZ7VV8eVQfdaiBQ4h2Fhzk5x7RsVOAmkID8onDn+12JZoYIEMc/WRDhgo5Q6Hw72tLxpQdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201617.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202511031406474531;
        Mon, 03 Nov 2025 14:06:47 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Nov 2025 14:06:47 +0800
Received: from inspur.com (10.100.2.107) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 14:06:47 +0800
Received: from localhost.com (unknown [10.94.13.117])
	by app3 (Coremail) with SMTP id awJkCsDw3fh2RghpRboJAA--.11961S4;
	Mon, 03 Nov 2025 14:06:47 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <pablo@netfilter.org>, <laforge@gnumonks.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <osmocom-net-gprs@lists.osmocom.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chu Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] gtp: Fix a typo error for size
Date: Mon, 3 Nov 2025 14:05:04 +0800
Message-ID: <20251103060504.3524-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: awJkCsDw3fh2RghpRboJAA--.11961S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZrykKFyUCFW8ZryxCrWDCFg_yoWxCFgEk3
	4xZFWxX3WUGFyvyw17ur4Y9ryak3W8ZF4kuw1IgrZxA345Za1Dur97uF97Xan8Cr4UJFy3
	CFnxXryUZ34YqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?XyNJupRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+Kd002PUJ0c/jQWv7cO1ektgJ30b0MeiTb5cNH1w8ExGK1nHqxZ4+VdrBkvIbSUEPrEtB
	VrlxhN96MEJ7s9QwWAU=
Content-Type: text/plain
tUid: 20251103140648c88674082191d03c82b124efa3dea5eb
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix the spelling error of "size".

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/net/gtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 5cb59d72bc82..4213c3b2d532 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -633,7 +633,7 @@ static void gtp1u_build_echo_msg(struct gtp1_header_long *hdr, __u8 msg_type)
 	hdr->tid = 0;
 
 	/* seq, npdu and next should be counted to the length of the GTP packet
-	 * that's why szie of gtp1_header should be subtracted,
+	 * that's why size of gtp1_header should be subtracted,
 	 * not size of gtp1_header_long.
 	 */
 
-- 
2.43.7


