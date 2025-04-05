Return-Path: <netdev+bounces-179432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0C5A7C9DD
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 17:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9FB1775A0
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCFB148FE6;
	Sat,  5 Apr 2025 15:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5848BEC;
	Sat,  5 Apr 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743866658; cv=none; b=Vl4ndIHjIzmAU/X9v4ldY1Ru9YZDI9DF5mM4BWjuXsGumRZMPjwghIhFdqYmxfP0vJHyuF8AMpgpbrRl91Onn2UQAsW0bkwEygfJGk6SQMJuOcdME+tbCYO/Ft7tKtDnwWiT/olsKs2op0sItAMYRRiUroVVDqSo0kLjdV2pvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743866658; c=relaxed/simple;
	bh=EIy/2h1mZS268iDpnuNOgkniGbO1brVB3zLnor5Y6c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pm871TmWBkD3DPBGpFiqi/7fD5v3fZ5WnPkYenGDUI/EB0nagDbMSAtfCmwWhqXOWhFLL8sOTaCD4w64M62uLIU6JxhYFJTmNVjq/iE1ORogkEP7cTFUbNvFEv92OMwIt/Ek3jGNWyARlgrNSECsZAGkPvX4Y7uP0ltIt6Aq2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [221.222.48.127])
	by APP-05 (Coremail) with SMTP id zQCowABnpAwIS_FnnxJLBg--.47924S2;
	Sat, 05 Apr 2025 23:23:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v2] octeontx2-pf: Add error log forcn10k_map_unmap_rq_policer()
Date: Sat,  5 Apr 2025 23:23:34 +0800
Message-ID: <20250405152334.2558-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnpAwIS_FnnxJLBg--.47924S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw4rtrWkAF43JF4fAw15XFb_yoW8JrWDpF
	4jk347CwnrXr4rJanrJa40gr15tay8J3yUGa4xA34fZ39aywnIvFn0yFWIvr4xGrZ5uFy3
	tF15AFW0yF1DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUDA2fxOcQbEgAAsr

The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
for each queue in a for loop without checking for any errors.

Check the return value of the cn10k_map_unmap_rq_policer() function during
each loop, and report a warning if the function fails.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index a15cc86635d6..895f0f8c85b2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -353,8 +353,10 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
 
 	/* Remove RQ's policer mapping */
 	for (qidx = 0; qidx < hw->rx_queues; qidx++)
-		cn10k_map_unmap_rq_policer(pfvf, qidx,
-					   hw->matchall_ipolicer, false);
+		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
+		if (rc)
+			dev_warn(pfvf->dev,
+				 "Failed to unmap RQ's policer.");
 
 	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
 
-- 
2.42.0.windows.2


