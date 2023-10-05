Return-Path: <netdev+bounces-38165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2A87B9973
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 03:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 177F3281C28
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397110EF;
	Thu,  5 Oct 2023 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1D7ED1
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 01:12:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86CA5BF;
	Wed,  4 Oct 2023 18:12:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,201,1694703600"; 
   d="scan'208";a="181959968"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Oct 2023 10:12:05 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BB21E41241A4;
	Thu,  5 Oct 2023 10:12:05 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH net v2 0/2] ravb: Fix use-after-free issues
Date: Thu,  5 Oct 2023 10:11:59 +0900
Message-Id: <20231005011201.14368-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series fixes use-after-free issues in ravb_remove().
The original patch is made by Zheng Wang [1]. And, I made the patch
1/2 which I found other issue in the ravb_remove().

[1]
https://lore.kernel.org/netdev/20230725030026.1664873-1-zyytlz.wz@163.com/

Changes from v1:
https://lore.kernel.org/all/20231004091253.4194205-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest net/main branch.
 - Fix the subjects in the patch [12]/2.
 - Fix commit descriptions in the patch [12]/2.
 - Use Closes tag instead of Link tag for checkpatch.pl in the patch 2/2.
 - Add Reviewed-by tags in the patch [12]/2.

Yoshihiro Shimoda (2):
  ravb: Fix up dma_free_coherent() call in ravb_remove()
  ravb: Fix use-after-free issue in ravb_tx_timeout_work()

 drivers/net/ethernet/renesas/ravb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1


