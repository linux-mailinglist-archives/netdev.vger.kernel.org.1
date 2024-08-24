Return-Path: <netdev+bounces-121641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A97895DCF9
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 10:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FC0283992
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7115532E;
	Sat, 24 Aug 2024 08:34:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44738143889;
	Sat, 24 Aug 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724488446; cv=none; b=Y9HNtPttBtTQL0rnMJ3NFMpi8H9KaRt4DWsfNdeotwIMMos5788MRASyRuO7c5N/4G40c8nB66xQh4d7Zdk/HKHnnWajRRMsqIhtPbhhfzfcNM1SGQOaNLH/cNiEcxaWNVET5TbiNhgBHLv3hNqZbQLpd/Ga0fSt/Na2wwxi3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724488446; c=relaxed/simple;
	bh=MIgnZt56BHFYeqqcz3kGwDEHJAlpDmon977+D6oIONY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jFVgbdb9jGnwKjvu5xffRpatNazqip0D8wSa6rqZsE37WrsgSwocUfeVy8tmsGrGbfXm3CrP2aQhoYxnKoH9b6wkV5qoJV0aV0djuAAq2xjoltUQA9SvOitAg1mVS4oVXxdftOqW6EfU+rXf+j3SNeqRzs6kZ9V+kTxLFjoFMFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WrVWV0MJ6z1HHDk;
	Sat, 24 Aug 2024 16:30:46 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FB651A0188;
	Sat, 24 Aug 2024 16:34:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 Aug
 2024 16:34:00 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: liquidio: Remove unused declarations
Date: Sat, 24 Aug 2024 16:31:07 +0800
Message-ID: <20240824083107.3639602-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit da15c78b5664 ("liquidio CN23XX: VF register access") declared
cn23xx_dump_vf_initialized_regs() but never implemented it.

octeon_dump_soft_command() is never implemented and used since introduction in
commit 35878618c92d ("liquidio: Added delayed work for periodically updating
the link statistics.").

And finally, a few other declarations were never implenmented since introduction
in commit f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.h | 2 --
 drivers/net/ethernet/cavium/liquidio/cn66xx_device.h    | 1 -
 drivers/net/ethernet/cavium/liquidio/octeon_device.h    | 7 -------
 drivers/net/ethernet/cavium/liquidio/octeon_droq.h      | 2 --
 drivers/net/ethernet/cavium/liquidio/octeon_iq.h        | 3 ---
 5 files changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.h b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.h
index 2d06097d3f61..40f529d0bc4c 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.h
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.h
@@ -43,6 +43,4 @@ int cn23xx_octeon_pfvf_handshake(struct octeon_device *oct);
 int cn23xx_setup_octeon_vf_device(struct octeon_device *oct);
 
 u32 cn23xx_vf_get_oq_ticks(struct octeon_device *oct, u32 time_intr_in_us);
-
-void cn23xx_dump_vf_initialized_regs(struct octeon_device *oct);
 #endif
diff --git a/drivers/net/ethernet/cavium/liquidio/cn66xx_device.h b/drivers/net/ethernet/cavium/liquidio/cn66xx_device.h
index 8ed57134ee0c..129c8b84f549 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn66xx_device.h
+++ b/drivers/net/ethernet/cavium/liquidio/cn66xx_device.h
@@ -86,7 +86,6 @@ u32
 lio_cn6xxx_update_read_index(struct octeon_instr_queue *iq);
 void lio_cn6xxx_enable_interrupt(struct octeon_device *oct, u8 unused);
 void lio_cn6xxx_disable_interrupt(struct octeon_device *oct, u8 unused);
-void cn6xxx_get_pcie_qlmport(struct octeon_device *oct);
 void lio_cn6xxx_setup_reg_address(struct octeon_device *oct, void *chip,
 				  struct octeon_reg_list *reg_list);
 u32 lio_cn6xxx_coprocessor_clock(struct octeon_device *oct);
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.h b/drivers/net/ethernet/cavium/liquidio/octeon_device.h
index fb380b4f3e02..d26364c2ac81 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_device.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.h
@@ -804,13 +804,6 @@ int octeon_init_consoles(struct octeon_device *oct);
 int octeon_add_console(struct octeon_device *oct, u32 console_num,
 		       char *dbg_enb);
 
-/** write or read from a console */
-int octeon_console_write(struct octeon_device *oct, u32 console_num,
-			 char *buffer, u32 write_request_size, u32 flags);
-int octeon_console_write_avail(struct octeon_device *oct, u32 console_num);
-
-int octeon_console_read_avail(struct octeon_device *oct, u32 console_num);
-
 /** Removes all attached consoles. */
 void octeon_remove_consoles(struct octeon_device *oct);
 
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_droq.h b/drivers/net/ethernet/cavium/liquidio/octeon_droq.h
index c9b19e624dce..232ae72c0e37 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_droq.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_droq.h
@@ -395,8 +395,6 @@ int octeon_register_dispatch_fn(struct octeon_device *oct,
 void *octeon_get_dispatch_arg(struct octeon_device *oct,
 			      u16 opcode, u16 subcode);
 
-void octeon_droq_print_stats(void);
-
 u32 octeon_droq_check_hw_for_pkts(struct octeon_droq *droq);
 
 int octeon_create_droq(struct octeon_device *oct, u32 q_no,
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_iq.h b/drivers/net/ethernet/cavium/liquidio/octeon_iq.h
index bebf3bd349c6..a04f36a0e1a0 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_iq.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_iq.h
@@ -378,9 +378,6 @@ int octeon_send_command(struct octeon_device *oct, u32 iq_no,
 			u32 force_db, void *cmd, void *buf,
 			u32 datasize, u32 reqtype);
 
-void octeon_dump_soft_command(struct octeon_device *oct,
-			      struct octeon_soft_command *sc);
-
 void octeon_prepare_soft_command(struct octeon_device *oct,
 				 struct octeon_soft_command *sc,
 				 u8 opcode, u8 subcode,
-- 
2.34.1


