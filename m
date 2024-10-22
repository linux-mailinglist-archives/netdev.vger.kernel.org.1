Return-Path: <netdev+bounces-137751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1F29A99EF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BADFB21504
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00D142E9F;
	Tue, 22 Oct 2024 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wEMifSCQ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231C513E03E;
	Tue, 22 Oct 2024 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729578901; cv=none; b=bnqTiL31d71V4RLv/QKg0BpgF3I+y4OTJgQ1iKSOAd6p0WJrv08XWnSNzp3VcJF43pa8wf4YRJQvf5xQUzekFYdSPrgndLqi/4ETF/+OaPN2lJbfWRzlH/GGGKGfPFETtsKgF91eNo/dvbNWYXxJYs1s+bPk918JFy8klIXKDoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729578901; c=relaxed/simple;
	bh=8K/VATla1L1n8Z05aZvcxnm6SoF/Q5GPkeLFx03jPxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o/9Ea952T7BYjwoTyNQ4vcLSQHdCmEKJgIEeMBcGXErRzV+gkvX1aamA/h8Ecr07jTsN7K6bvFtNCHGK9P0U3mLg+GwOLCyytl/BodJidravO3fh+xkt2/b441IYX+VlEGagj+ht+WmfxLUzh+tYWZFhmhA2H/h8KSGSePOdb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wEMifSCQ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729578895; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+ZZPQAYmRXKxmJmQ4eJpW73d5G6LtgL0a+fwNFvJN9Q=;
	b=wEMifSCQ2zAKL9U4jqcBK30U5Lz61BN2V7FyZXYAv+vsz3N2BweQv8wbmhX2RWmmAmI6fhv+83hMaXEkxGFr0aMdXinZmlp1xZGWQdLEJBtulUREUOUsfbjF0nsUmEc4QMzjpgPz8IeQEOd+HiWZXgSaPWOl1KC77cWFhXxEtTQ=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WHgplux_1729578894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Oct 2024 14:34:55 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: vburru@marvell.com,
	sedara@marvell.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] octeon_ep: Remove unneeded semicolon
Date: Tue, 22 Oct 2024 14:34:53 +0800
Message-Id: <20241022063453.103751-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes an unneeded semicolon after a while statement.

./drivers/net/ethernet/marvell/octeon_ep/octep_rx.c:381:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11430
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 8af75cb37c3e..d65d9572ffa6 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -378,7 +378,7 @@ static void octep_oq_drop_rx(struct octep_oq *oq,
 	while (data_len > 0) {
 		octep_oq_next_pkt(oq, buff_info, read_idx, desc_used);
 		data_len -= oq->buffer_size;
-	};
+	}
 }
 
 /**
-- 
2.32.0.3.g01195cf9f


