Return-Path: <netdev+bounces-136101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101239A0509
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC6B1F25A19
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EDE205158;
	Wed, 16 Oct 2024 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGlBx7qD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60653134A8;
	Wed, 16 Oct 2024 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069615; cv=none; b=JnNU9i7jr+w9BLjnipDBEC+9Olcvuwm/Za+38XDufmM4DdQisXRvDlmpam0KcpynALlIVPtcH/FPQkup/sC9L3JDnJJ6aycxNaJgeUcWopJrpDoqij2yeyD7262d7oC6Eqx8eB8QyQ931R9+lhwWPqBwnYmW3PBTSrm/Srbn1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069615; c=relaxed/simple;
	bh=7Pnq+kiE64Aw9F+Qui7sM7/+ztdkvVujPlNKG8hxS0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sWDrtUwdv0DZ2l7H5CC7SsSrDANEG89KyESzGtnAnPr34K3uzxo7rO5xtB2QqoPqt76XI0zjKeO4FIeil2Iztu2bgDun6atcVZdDB25A3qzapUlkm/7H5Tydy7hEKADtFXb1pIAuNcEdEfs2tRuSBmSNrsRFX2rWg1dtFtU5feg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGlBx7qD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729069614; x=1760605614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Pnq+kiE64Aw9F+Qui7sM7/+ztdkvVujPlNKG8hxS0Q=;
  b=bGlBx7qDVU0C5H7AxamRb1o5397adDoCdfis8Ylyufe+i+D/02LrleXQ
   Nzgslpu0PNbnlIQBcn+lFZfXsPvKST/zQv8l+80gZG1HkzpeWuoHNnVIm
   jyJKkLy0trn85+SxhE1YR36TXx0qyGZc1FZJVDm/0UKdwL/YMjG7Vmglp
   tKDcEptvjuOyZhaV0tcaB5MzLYJNL5tZ17BLAKRZp7ghmKfmqoNOiDvmn
   jUSGuuvPB9+Mfqpct36dTtSJ7fbtrtVW3YzOK5ZAjt3dRURW0AWCAU/Pv
   CFHuOSbOJoTHyDrW6esY/UxBF5xM/UcmliRLXdBOm8UD3AaxHq4tbxh+S
   w==;
X-CSE-ConnectionGUID: /u9pSPFySmeT+ANKaJYraA==
X-CSE-MsgGUID: +nXeylAORZWO+7Cr73DgZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45980194"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45980194"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 02:06:53 -0700
X-CSE-ConnectionGUID: tmpz67oQSiq56GVOlSGlJg==
X-CSE-MsgGUID: UqJbcIVkTDio31EXlBVWSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82134420"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 16 Oct 2024 02:06:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3478A331; Wed, 16 Oct 2024 12:06:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 1/1] tg3: Increase buffer size for IRQ label
Date: Wed, 16 Oct 2024 12:05:54 +0300
Message-ID: <20241016090647.691022-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC is not happy with the current code, e.g.:

.../tg3.c:11313:37: error: ‘-txrx-’ directive output may be truncated writing 6 bytes into a region of size between 1 and 16 [-Werror=format-truncation=]
11313 |                                  "%s-txrx-%d", tp->dev->name, irq_num);
      |                                     ^~~~~~
.../tg3.c:11313:34: note: using the range [-2147483648, 2147483647] for directive argument
11313 |                                  "%s-txrx-%d", tp->dev->name, irq_num);

When `make W=1` is supplied, this prevents kernel building. Fix it by
increasing the buffer size for IRQ label and use sizeoF() instead of
hard coded constants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: don't move the field to the stack (Jakub)
 drivers/net/ethernet/broadcom/tg3.c | 9 ++++-----
 drivers/net/ethernet/broadcom/tg3.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 378815917741..675178ab77b8 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -11309,18 +11309,17 @@ static int tg3_request_irq(struct tg3 *tp, int irq_num)
 	else {
 		name = &tnapi->irq_lbl[0];
 		if (tnapi->tx_buffers && tnapi->rx_rcb)
-			snprintf(name, IFNAMSIZ,
+			snprintf(name, sizeof(tnapi->irq_lbl),
 				 "%s-txrx-%d", tp->dev->name, irq_num);
 		else if (tnapi->tx_buffers)
-			snprintf(name, IFNAMSIZ,
+			snprintf(name, sizeof(tnapi->irq_lbl),
 				 "%s-tx-%d", tp->dev->name, irq_num);
 		else if (tnapi->rx_rcb)
-			snprintf(name, IFNAMSIZ,
+			snprintf(name, sizeof(tnapi->irq_lbl),
 				 "%s-rx-%d", tp->dev->name, irq_num);
 		else
-			snprintf(name, IFNAMSIZ,
+			snprintf(name, sizeof(tnapi->irq_lbl),
 				 "%s-%d", tp->dev->name, irq_num);
-		name[IFNAMSIZ-1] = 0;
 	}
 
 	if (tg3_flag(tp, USING_MSI) || tg3_flag(tp, USING_MSIX)) {
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index cf1b2b123c7e..b473f8014d9c 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3033,7 +3033,7 @@ struct tg3_napi {
 	dma_addr_t			rx_rcb_mapping;
 	dma_addr_t			tx_desc_mapping;
 
-	char				irq_lbl[IFNAMSIZ];
+	char				irq_lbl[IFNAMSIZ + 6 + 10]; /* name + "-txrx-" + %d */
 	unsigned int			irq_vec;
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


