Return-Path: <netdev+bounces-47615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D5E7EAAB2
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 08:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF77280EBB
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5482BA2B;
	Tue, 14 Nov 2023 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="XtRXDcFh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2888F5F
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 07:03:17 +0000 (UTC)
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6F13E
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:03:14 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 45405440871;
	Tue, 14 Nov 2023 09:02:11 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699945331;
	bh=1rfJ16FI/W6yq+b3hiKtTrCWZXLvLTjA0Qnt7vb/GHM=;
	h=From:To:Cc:Subject:Date:From;
	b=XtRXDcFhZ9QfIEwdRc6nnp4IIRs5YxR6UH1WBv9hLdNTRz8mAfD7F96buYLP6iO0E
	 YpzedzVkVxHb/clZ2th5EUXABdPGooDN0eDzm75s0f7mU1h8bFzDiO7MwPFjVfgiE2
	 YYBPoYUIbb5Ko05gxKcA92I/R5ynz/XyhnparFeIXc9SvwplKBel5PpZrup22ykMfG
	 mYb+9dGarac6aROZ/ytwAHhgRbyv0TQCCC3xuaCPmf98gkpYheCv4kP+PnsR5RiPfE
	 SGeWBDBBfzZU9rha37iuHn1eHjxvoawh1+ZSZREOeGwIX6mZdR2SHwarpImvt7R91D
	 q8MZRNogivozA==
From: Baruch Siach <baruch@tkos.co.il>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH net-next v2 1/2] net: stmmac: remove extra newline from descriptors display
Date: Tue, 14 Nov 2023 09:03:09 +0200
Message-ID: <8e3121170d479cbe095f985e01fc5e0386f2afff.1699945390.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One newline per line should be enough. Reduce the verbosity of
descriptors dump.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3e50fd53a617..39336fe5e89d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6202,7 +6202,6 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
 				   le32_to_cpu(p->des2), le32_to_cpu(p->des3));
 			p++;
 		}
-		seq_printf(seq, "\n");
 	}
 }
 
-- 
2.42.0


