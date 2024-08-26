Return-Path: <netdev+bounces-121771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E7C95E745
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 05:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71719B20D77
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD081DFDE;
	Mon, 26 Aug 2024 03:23:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD15320C
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724642630; cv=none; b=Ha9ja3oAFN/i8qVxHELxVCWnUjh2/D5860e4FEnc5sBoDcLjf1l0bnfT608BloLqeehENLBsqicpPRcz2cy7kgbIGQn8lye9+1FUz3AcNJg562tyxE81ziUPLiVbiC9QdEm3xzypEEZm0Q2boaKBHpWo3fXQ1pbSn380TdNdLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724642630; c=relaxed/simple;
	bh=AeeWU13P858SIDf9jSvlJrjhbljtDRUChGmj0NvobMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=flpDDqy2nCodS8O4cVxIPHgQZ4A1xnncLEmrFLf/6FLxMbWligsfp10zG6scKwU6eFQr9VLdrgbKhBE4tjDofebGN51qHvP+vMBmRl8Ur0Qg8u+MfPNOS/QkN1zI8VXcwg9PakS0X2pCMXMx8z1oWfx9R24oRBZsdX8n3cbDCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WsbZ50knqz1xvNd
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:21:49 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id B180714022F
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:23:45 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 26 Aug 2024 11:23:45 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <sebastian.hesselbarth@gmail.com>, <cuigaosheng1@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH -next] MIPS: Remove obsoleted declaration for mv64340_irq_init
Date: Mon, 26 Aug 2024 11:23:44 +0800
Message-ID: <20240826032344.4012452-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The mv64340_irq_init() have been removed since
commit 688b3d720820 ("[MIPS] Delete Ocelot 3 support."), and now
it is useless, so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 include/linux/mv643xx.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mv643xx.h b/include/linux/mv643xx.h
index 000b126acfb6..a7975c16d13f 100644
--- a/include/linux/mv643xx.h
+++ b/include/linux/mv643xx.h
@@ -916,6 +916,4 @@
 #define MV64340_SERIAL_INIT_CONTROL                                 0xf328
 #define MV64340_SERIAL_INIT_STATUS                                  0xf32c
 
-extern void mv64340_irq_init(unsigned int base);
-
 #endif /* __ASM_MV643XX_H */
-- 
2.25.1


