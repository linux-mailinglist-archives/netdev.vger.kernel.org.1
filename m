Return-Path: <netdev+bounces-233799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4702C18B20
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9A01C86B11
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3767030FF25;
	Wed, 29 Oct 2025 07:21:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8030FC12;
	Wed, 29 Oct 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722516; cv=none; b=hk39fhrFOYgdBkvWfYWNVhRn5e51GgVJAxLPGkxQe4249pJLny0RZmF/7pUZGgyTSfgM7riDXmtBMEdocULiDaBM5s7t/FBwvpMMdqOz92+oyoceF3wtkp7qvzY0QfInYN5Cbbx2JhWbhoM5bid3OZh5ddee6hg6pjozYpa2BIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722516; c=relaxed/simple;
	bh=sbpGRrS3bGxlkdNpjl2GSjJ8e9OBn9VI/Px/4Foe9do=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X09yV/Hw6XD0myOEtUCGcG9LRJJYC1UIEKzXE48zkwx3Lz0C/DCr744TH8K7Kw++ZUQhyQVsaCDUokVGbtjryta4ceno6+ZK7LZ4ziNPOv0rokS3nnmvUa3+EFzj06AKF7vpVP8KyzHDSGH2mWB+oHpEOFCau8YXADKq3+hgctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201619.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202510291521419705;
        Wed, 29 Oct 2025 15:21:41 +0800
Received: from jtjnmail201626.home.langchao.com (10.100.2.36) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 29 Oct 2025 15:21:39 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 jtjnmail201626.home.langchao.com (10.100.2.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 29 Oct 2025 15:21:39 +0800
Received: from inspur.com (10.100.2.113) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 29 Oct 2025 15:21:39 +0800
Received: from localhost.localdomain.com (unknown [10.94.19.60])
	by app9 (Coremail) with SMTP id cQJkCsDwlHiCwAFp5TgHAA--.5620S2;
	Wed, 29 Oct 2025 15:21:39 +0800 (CST)
From: Bo Liu <liubo03@inspur.com>
To: <ecree.xilinx@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
	<linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] sfc: Fix double word in comments
Date: Wed, 29 Oct 2025 15:21:31 +0800
Message-ID: <20251029072131.17892-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cQJkCsDwlHiCwAFp5TgHAA--.5620S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4DZF13Wr4DWrykAr15twb_yoWDGwc_C3
	sYgF1vga1jyF9rt3y2grWUZw12vwn8Xrn3ZFW7t34ftr9rWF15Jrs7Cr4xGw1DWw4UAF92
	9r17XF4fA34aqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGjg7UUUUU==
X-CM-SenderInfo: xolxu0iqt6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?wGQPBmLVRuiwy3Lqe5bb/wL3YD0Z3+qys2oM3YyJaJDj+48qHwuUARU7xYOAI0q1Re
	KIpXHRcRXlc8Cu07eTD/f+RnFgEhwHZY1GCVlt3dPFUTU3qnWib4AJttzNif5nUtmENQ/m
	7GVnSw1ZoFM5AiCEqoM=
Content-Type: text/plain
tUid: 20251029152141f06600ee6afcf59d2a6780407597b773
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Remove the repeated word "the" in comments.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/net/ethernet/sfc/mcdi_pcol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
index b9866e389e6d..e0415d08d862 100644
--- a/drivers/net/ethernet/sfc/mcdi_pcol.h
+++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
@@ -9560,7 +9560,7 @@
  * DMA synchronizaion. Always the last entry in the DMA buffer and set to the
  * same value as GENERATION_START. The host driver must compare the
  * GENERATION_START and GENERATION_END values to verify that the DMA buffer is
- * consistent upon copying the the DMA buffer. If they do not match, it means
+ * consistent upon copying the DMA buffer. If they do not match, it means
  * that new DMA transfer has started while the host driver was copying the DMA
  * buffer. In this case, the host driver must repeat the copy operation.
  */
-- 
2.31.1


