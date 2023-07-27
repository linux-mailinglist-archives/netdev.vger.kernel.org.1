Return-Path: <netdev+bounces-21869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1837651D3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E18F1C21377
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD13154A5;
	Thu, 27 Jul 2023 10:58:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154716418
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:58:27 +0000 (UTC)
Received: from mint-fitpc2.localdomain (unknown [81.168.73.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C765A271D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:58:25 -0700 (PDT)
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
	by mint-fitpc2.localdomain (Postfix) with ESMTP id 0A06C321ACA;
	Thu, 27 Jul 2023 11:41:00 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
	by palantir17.mph.net with esmtp (Exim 4.95)
	(envelope-from <habetsm.xilinx@gmail.com>)
	id 1qOyQV-0002Xn-PK;
	Thu, 27 Jul 2023 11:40:59 +0100
Subject: [PATCH net-next 04/11] sfc: Remove EFX_REV_SIENA_A0
From: Martin Habets <habetsm.xilinx@gmail.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
Date: Thu, 27 Jul 2023 11:40:59 +0100
Message-ID: <169045445969.9625.12355878286793078121.stgit@palantir17.mph.net>
In-Reply-To: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
References: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FROM,KHOP_HELO_FCRDNS,MAY_BE_FORGED,
	NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The workarounds for bug 8568 and 17213 are no longer needed.

Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/nic_common.h  |    3 +--
 drivers/net/ethernet/sfc/workarounds.h |    7 -------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/sfc/nic_common.h b/drivers/net/ethernet/sfc/nic_common.h
index 0cef35c0c559..e35ecbe8842e 100644
--- a/drivers/net/ethernet/sfc/nic_common.h
+++ b/drivers/net/ethernet/sfc/nic_common.h
@@ -15,11 +15,10 @@
 #include "ptp.h"
 
 enum {
-	/* Revisions 0-2 were Falcon A0, A1 and B0 respectively.
+	/* Revisions 0-3 were Falcon A0, A1, B0 and Siena respectively.
 	 * They are not supported by this driver but these revision numbers
 	 * form part of the ethtool API for register dumping.
 	 */
-	EFX_REV_SIENA_A0 = 3,
 	EFX_REV_HUNT_A0 = 4,
 	EFX_REV_EF100 = 5,
 };
diff --git a/drivers/net/ethernet/sfc/workarounds.h b/drivers/net/ethernet/sfc/workarounds.h
index 815be2d20c4b..e10e7f84958d 100644
--- a/drivers/net/ethernet/sfc/workarounds.h
+++ b/drivers/net/ethernet/sfc/workarounds.h
@@ -12,14 +12,7 @@
  * Bug numbers are from Solarflare's Bugzilla.
  */
 
-#define EFX_WORKAROUND_SIENA(efx) (efx_nic_rev(efx) == EFX_REV_SIENA_A0)
 #define EFX_WORKAROUND_EF10(efx) (efx_nic_rev(efx) >= EFX_REV_HUNT_A0)
-#define EFX_WORKAROUND_10G(efx) 1
-
-/* Bit-bashed I2C reads cause performance drop */
-#define EFX_WORKAROUND_7884 EFX_WORKAROUND_10G
-/* Legacy interrupt storm when interrupt fifo fills */
-#define EFX_WORKAROUND_17213 EFX_WORKAROUND_SIENA
 
 /* Lockup when writing event block registers at gen2/gen3 */
 #define EFX_EF10_WORKAROUND_35388(efx)					\



