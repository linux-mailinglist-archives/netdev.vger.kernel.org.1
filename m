Return-Path: <netdev+bounces-234954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC60C2A1A8
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 06:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6129B188E575
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 05:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869E28C871;
	Mon,  3 Nov 2025 05:55:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD8285CAE;
	Mon,  3 Nov 2025 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149316; cv=none; b=S/Rtj+0mm8sFW/L9uCeEzGwcGwWARAdMMlxMGyk+y7nHtKMgHa1oEUiLYg7ny8IF6rlMKpL1tCPUB5LZKiuM+F00Wilmzf7i/NgAjxT7CuRo99nKpNqVSFXko8x1D7tBX1YBbELw6u8x9DpK+ZhJ4MxzS1s2ERuUf+yLCG1jfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149316; c=relaxed/simple;
	bh=liBptfnPgamIoOT6mYW47OYRRBbzhoA8cwUTZwhASIA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I76T2bprANukuEqdYvq4tYGzgyXVYm5vSkZqbJkd/8QzLQqszbkl1U/dyxD4y/uWKO5QyHXVGNKgFqQCE0dz8BN/XnMaRW5af13BGoXAmAJ8qDNCZcjYlp39eoNI575akvvuLH+Qm2/QhGKS1/HJ7ZZCWbFiO1MH5dpQnSVQxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202511031355070850;
        Mon, 03 Nov 2025 13:55:07 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Nov 2025 13:55:06 +0800
Received: from inspur.com (10.100.2.107) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 13:55:06 +0800
Received: from localhost.localdomain.com (unknown [10.94.13.117])
	by app3 (Coremail) with SMTP id awJkCsDww_q6Qwhpt7gJAA--.15221S4;
	Mon, 03 Nov 2025 13:55:06 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH] veth: Fix a typo error in veth
Date: Mon, 3 Nov 2025 13:53:51 +0800
Message-ID: <20251103055351.3150-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: awJkCsDww_q6Qwhpt7gJAA--.15221S4
X-Coremail-Antispam: 1UD129KBjvdXoWrGrWfWw1xJF4furW5tryrJFb_yoWxWrX_CF
	W7WayxXr4YgFy7Kw4Y9r47AryYqw15WF4kCFZag3ya9ayUZF15Kry8ur1DJr1DurW7Ar1D
	Zr1ftr1DZ347KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr2-eDUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?QJfRO5RRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KbPV6ldG4k/ymFRhMsIeRH0J30b0MeiTb5cNH1w8ExGKCubaJNOkF2TflhkJRMm3MhDV
	m8yehC3jkbPFRTb8kU8=
Content-Type: text/plain
tUid: 202511031355076141a1b02f6d96e57b66e2194516eb9d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix a spellling error for resources

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e..87a63c4bee77 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1323,7 +1323,7 @@ static int veth_set_channels(struct net_device *dev,
 		if (peer)
 			netif_carrier_off(peer);
 
-		/* try to allocate new resurces, as needed*/
+		/* try to allocate new resources, as needed*/
 		err = veth_enable_range_safe(dev, old_rx_count, new_rx_count);
 		if (err)
 			goto out;
-- 
2.43.7


