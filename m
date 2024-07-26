Return-Path: <netdev+bounces-113206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC093D347
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F3B22787
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3B917B4F3;
	Fri, 26 Jul 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0i7Ti99Q"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E4CA953;
	Fri, 26 Jul 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997628; cv=none; b=ZGe52DuK9FZu/I6BiYZqrB4oRt9Ly1vnmjWaYvOeDx3W+1SVVLTB4UliE5/1qYy7awLtF6+BsoMc8qft8PLkztyZdz1CgY89kni7gsROXLUEn4DhyOOWXQcZ2EAlld+YMmvh8teWIJLVAF7hQMEc6tTDYpEMDTE85DwMLIUbSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997628; c=relaxed/simple;
	bh=HTMQZME4GZqTFjwi5R+yunpA7xVUytFNf1qf2m5+vKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMT1BiAh+1KzXOomIQDq5Qo4V2CuCPVwo8d4bCTeylTfV2HcHepKmvwu9ZO/HWrSjwBrwoJF9pMK0x1EMj+x27iHE0um1iqSQrJ3RIZVC/I+xvxFIVm/8PmXM7fS5ktK4IMbOt74kIxgXlSyKGnhtiiSNF5Lj6f7NsoC5+/IQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0i7Ti99Q; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721997627; x=1753533627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTMQZME4GZqTFjwi5R+yunpA7xVUytFNf1qf2m5+vKg=;
  b=0i7Ti99Qai3AEraJ+/12AW0pFWaNguBTnZkdYk5xEMARj21zSEicVmDp
   4hTdyOItLgiMZB5XnAfjg0Nw56xeyVggyziMO/OBnLw1KYnT01lP/2fQg
   rakziv4ivX+u4P1M2My/92GPi5bt/zV8t9UIf4s7PWtDjo2NfpQLIZXVw
   VGXuEpwM3TR3vIGg/R8cg3mib58zO3n6kyTQA3KYPVw1cw97WVmFA+IdS
   PBBmU5mTMwmFt9R8DeJSgghXyf82H2zvWxzcBPxG09lgZVq9JfjcjD93A
   VPMvLIz6vH84NJmEReCtfiMlG0aYdtNwpg2xm4BRBM4y+kJV5w7m0yBpB
   w==;
X-CSE-ConnectionGUID: 8p2anauWQXeBrQFhbv5Fng==
X-CSE-MsgGUID: Gg3pc2Q/QUmaogdKY/mixQ==
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="197145183"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jul 2024 05:40:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jul 2024 05:39:51 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jul 2024 05:39:42 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v5 08/14] net: ethernet: oa_tc6: enable open alliance tc6 data communication
Date: Fri, 26 Jul 2024 18:09:01 +0530
Message-ID: <20240726123907.566348-9-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
References: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enabling Configuration Synchronization bit (SYNC) in the Configuration
Register #0 enables data communication in the MAC-PHY. The state of this
bit is reflected in the data footer SYNC bit.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index b9906d18840d..542d68d4b338 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -20,6 +20,10 @@
 #define OA_TC6_REG_RESET			0x0003
 #define RESET_SWRESET				BIT(0)	/* Software Reset */
 
+/* Configuration Register #0 */
+#define OA_TC6_REG_CONFIG0			0x0004
+#define CONFIG0_SYNC				BIT(15)
+
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
 #define STATUS0_RESETC				BIT(6)	/* Reset Complete */
@@ -559,6 +563,21 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
 	return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
 }
 
+static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)
+{
+	u32 value;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_CONFIG0, &value);
+	if (ret)
+		return ret;
+
+	/* Enable configuration synchronization for data transfer */
+	value |= CONFIG0_SYNC;
+
+	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, value);
+}
+
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
@@ -616,7 +635,18 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 		return NULL;
 	}
 
+	ret = oa_tc6_enable_data_transfer(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev, "Failed to enable data transfer: %d\n",
+			ret);
+		goto phy_exit;
+	}
+
 	return tc6;
+
+phy_exit:
+	oa_tc6_phy_exit(tc6);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
 
-- 
2.34.1


