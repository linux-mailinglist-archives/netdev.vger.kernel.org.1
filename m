Return-Path: <netdev+bounces-48987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F37F0481
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 06:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926561C204AB
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 05:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF55398;
	Sun, 19 Nov 2023 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="pjoWLR9T"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A28192
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 21:39:50 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id BA7CA44065D;
	Sun, 19 Nov 2023 07:38:37 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1700372317;
	bh=UhiRRzAlk5BqKc/Ch0MkFnxLBQcz+X6HuIfKyXh3d18=;
	h=From:To:Cc:Subject:Date:From;
	b=pjoWLR9TnazcHk0JFrb+qBHF2shGRhbeqBtGkvuJGcoEN2sd25PVF9B1kgXaRYugc
	 yF4AFnQrgnzZcfXrpTN668WrzSNpJsIBF3NHfES9cjmAHken+q49kuDiOe1hGC7QU2
	 SoySCYT+PdNwNkjwAWyQsuLHHBlx4XYHQR4+8U0ZZiqPIgGTvSK5aiq8Nw2E5bqPE1
	 rtxso93b3mR6oSfxaxj07KDvf04Iu8rYJCLumpO9Yk0EwHrgllI2x6LsyCcJl9cueI
	 1FjMDROoqN3i2y7V8kIelyPdOkVtz4YDgdnVYt7bqDuudZElwOf6D6UL7AdQ1WL/pU
	 O1CZC/PidPZvg==
From: Baruch Siach <baruch@tkos.co.il>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	Serge Semin <fancer.lancer@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH net-next v3 1/2] net: stmmac: remove extra newline from descriptors display
Date: Sun, 19 Nov 2023 07:39:40 +0200
Message-ID: <444f3b1dd409fdb14ed2a1ae7679a86b110dadcd.1700372381.git.baruch@tkos.co.il>
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

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2afb2bd25977..8ab99c65ac59 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6203,7 +6203,6 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
 				   le32_to_cpu(p->des2), le32_to_cpu(p->des3));
 			p++;
 		}
-		seq_printf(seq, "\n");
 	}
 }
 
-- 
2.42.0


