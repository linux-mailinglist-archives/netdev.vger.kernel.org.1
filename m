Return-Path: <netdev+bounces-124354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B49691A4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 05:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA21C22A34
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB161A2624;
	Tue,  3 Sep 2024 03:04:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054B2AD02;
	Tue,  3 Sep 2024 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725332654; cv=none; b=aE3yYFMG32rGgmUyZWSpdV33vGzAUFqBK3v9FPwe9obXRdLhoe45zyDdK53k7zhAAw/iRNyxZqoEzbw377/yjfEqYJmiNTVP+Qv0lov/+/uzvWRNJJnOZgiKev45/j6Gzdu0NnE/Ce+kAW6X2VoijD5+lr3vtLUOjncMOor8kmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725332654; c=relaxed/simple;
	bh=KHNqqdmeRAfr2Z0xi9CkijK+avYfSEoW0MUqG61Xf4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cpz4L55BoZ4bLuVZD1hafH15ab+AS1gBHFpWpzGj9gGDiMeG6eE/sqQBR7Jvu9s2yUI1sSthPuE6BVc3jYqmXonX6TQkEvDBPfq9kAE9Rt2XP/pZjgUA0OVL6uEsuNJqLnPnpSJzHokiN2TEu29UPD4xB0/axXH3jBHbZvNmmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAB3fqKofNZm0Hy1AA--.34405S2;
	Tue, 03 Sep 2024 11:04:08 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] ptp: ptp_idt82p33: Convert comma to semicolon
Date: Tue,  3 Sep 2024 11:03:02 +0800
Message-Id: <20240903030303.494089-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3fqKofNZm0Hy1AA--.34405S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47GrWUXw1DZFb_yoWDZrg_Xw
	nF9ay7Gw4DurnF93WIva45Xry0ya9Ygrs8WryDtF9rArsrAFy3tr97Jry7W3yFgrn5WF47
	Ja17Wr97CF9FgjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUUY0P3UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/ptp/ptp_idt82p33.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_idt82p33.c b/drivers/ptp/ptp_idt82p33.c
index 92bb42c43fb2..d5732490ed9d 100644
--- a/drivers/ptp/ptp_idt82p33.c
+++ b/drivers/ptp/ptp_idt82p33.c
@@ -1171,10 +1171,10 @@ static void idt82p33_caps_init(u32 index, struct ptp_clock_info *caps,
 	caps->owner = THIS_MODULE;
 	caps->max_adj = DCO_MAX_PPB;
 	caps->n_per_out = MAX_PER_OUT;
-	caps->n_ext_ts = MAX_PHC_PLL,
-	caps->n_pins = max_pins,
-	caps->adjphase = idt82p33_adjwritephase,
-	caps->getmaxphase = idt82p33_getmaxphase,
+	caps->n_ext_ts = MAX_PHC_PLL;
+	caps->n_pins = max_pins;
+	caps->adjphase = idt82p33_adjwritephase;
+	caps->getmaxphase = idt82p33_getmaxphase;
 	caps->adjfine = idt82p33_adjfine;
 	caps->adjtime = idt82p33_adjtime;
 	caps->gettime64 = idt82p33_gettime;
-- 
2.25.1


