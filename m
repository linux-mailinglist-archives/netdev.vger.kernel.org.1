Return-Path: <netdev+bounces-197848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD91AADA053
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 01:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D144C1893D7A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 23:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C225569;
	Sat, 14 Jun 2025 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="SNMlDHAf"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580A2F5B;
	Sat, 14 Jun 2025 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749944991; cv=none; b=JZAyxZCmx31jXzLxFL9AflMMpWvfFmNtexC6EwfTarU6K6rHoukxrQbtCv5Kpj2mmj/QmdVCLmilIyKi6UezP9wkaBmWezu5ZRGxpJf+y1ecDU26Wwo3hxQNCWenZxHhoJxzqaHzvPWrxzUwwt89qNcXEvvisaz0658FKa58SMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749944991; c=relaxed/simple;
	bh=Qm2J2jSa2eE6T5pH/tb4qGXQe4ZNdC1SvphaBpY0xLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MtwWl2hg/uGmbcsnUIZIYUoZZIYdbyL3dvOVjxX0FQKG5ZVHwSKYlWr/8H2u4F0276zEL+5A0CFxUC2pnD1lOk/4ujaDXflzMHI3t01iRv792yCAcazSo2dZ2mGdPpMHHXxED+lWt+tn4yzR7fRq00eGF1D7WtqroywjJ9nvcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=SNMlDHAf; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=+P2lzINHq2/y6xN0ioG5pTpOH3ZgUkHK3MgajHPs5wA=; b=SNMlDHAfZnJHrZ0m
	dPZd9fT+6jY6XCjOYUQUdPCaJ4r9hvgYHRjzyV+9pvTyijtabpuw2KR0qFiLzvsdpVCtk0YkngfSN
	m+xTF5cm3mCDem2BowDutYbQ/gFxm4U+Y/s1vDI9r7e04PRsz3nhU01sQbUbEkKyZnQoZHQB08cKN
	XpsZtYr34u+Nd4pfz/5/7aN4IpHSIheUQjlYZD7F4sMNWTyzOP5pvNhziF+87U5B1dvD3dN6nrUAZ
	QK3Tco6LEHBlUbqELPTvET6zQETggZ/rMuYy+ZoGOK2GHT0H6q8KszCus3ICc2PfhISfs5+QLXxcb
	NR985iYX3ZQ4h0UJmA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uQad3-009g1d-2j;
	Sat, 14 Jun 2025 23:49:41 +0000
From: linux@treblig.org
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net: liquidio: Remove unused validate_cn23xx_pf_config_info()
Date: Sun, 15 Jun 2025 00:49:41 +0100
Message-ID: <20250614234941.61769-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

[Note, I'm wondering if actually this is a case of a missing call;
the other similar function is called in __verify_octeon_config_info(),
but I don't have or know the hardware.]

validate_cn23xx_pf_config_info() was added in 2016 by
commit 72c0091293c0 ("liquidio: CN23XX device init and sriov config")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../cavium/liquidio/cn23xx_pf_device.c        | 39 -------------------
 .../cavium/liquidio/cn23xx_pf_device.h        |  3 --
 2 files changed, 42 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index ff8f2f9f9cae..75f22f74774c 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -1208,45 +1208,6 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
 }
 EXPORT_SYMBOL_GPL(setup_cn23xx_octeon_pf_device);
 
-int validate_cn23xx_pf_config_info(struct octeon_device *oct,
-				   struct octeon_config *conf23xx)
-{
-	if (CFG_GET_IQ_MAX_Q(conf23xx) > CN23XX_MAX_INPUT_QUEUES) {
-		dev_err(&oct->pci_dev->dev, "%s: Num IQ (%d) exceeds Max (%d)\n",
-			__func__, CFG_GET_IQ_MAX_Q(conf23xx),
-			CN23XX_MAX_INPUT_QUEUES);
-		return 1;
-	}
-
-	if (CFG_GET_OQ_MAX_Q(conf23xx) > CN23XX_MAX_OUTPUT_QUEUES) {
-		dev_err(&oct->pci_dev->dev, "%s: Num OQ (%d) exceeds Max (%d)\n",
-			__func__, CFG_GET_OQ_MAX_Q(conf23xx),
-			CN23XX_MAX_OUTPUT_QUEUES);
-		return 1;
-	}
-
-	if (CFG_GET_IQ_INSTR_TYPE(conf23xx) != OCTEON_32BYTE_INSTR &&
-	    CFG_GET_IQ_INSTR_TYPE(conf23xx) != OCTEON_64BYTE_INSTR) {
-		dev_err(&oct->pci_dev->dev, "%s: Invalid instr type for IQ\n",
-			__func__);
-		return 1;
-	}
-
-	if (!CFG_GET_OQ_REFILL_THRESHOLD(conf23xx)) {
-		dev_err(&oct->pci_dev->dev, "%s: Invalid parameter for OQ\n",
-			__func__);
-		return 1;
-	}
-
-	if (!(CFG_GET_OQ_INTR_TIME(conf23xx))) {
-		dev_err(&oct->pci_dev->dev, "%s: Invalid parameter for OQ\n",
-			__func__);
-		return 1;
-	}
-
-	return 0;
-}
-
 int cn23xx_fw_loaded(struct octeon_device *oct)
 {
 	u64 val;
diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h
index 234b96b4f488..bbe9f3133b07 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h
@@ -54,9 +54,6 @@ struct oct_vf_stats {
 
 int setup_cn23xx_octeon_pf_device(struct octeon_device *oct);
 
-int validate_cn23xx_pf_config_info(struct octeon_device *oct,
-				   struct octeon_config *conf23xx);
-
 u32 cn23xx_pf_get_oq_ticks(struct octeon_device *oct, u32 time_intr_in_us);
 
 int cn23xx_sriov_config(struct octeon_device *oct);
-- 
2.49.0


