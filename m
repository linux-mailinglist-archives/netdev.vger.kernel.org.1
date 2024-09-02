Return-Path: <netdev+bounces-124237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1906968A6A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F57E1F22D9D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460341A3040;
	Mon,  2 Sep 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WqKaA9KY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70121A3023;
	Mon,  2 Sep 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288911; cv=none; b=V7U0NqSk/7aZHKyUp4TVZDIfze0dJ6TY/Oo2ux85ed8p9RAxL4QRiAN1IdwYoKXcfUP18SkMyY6+4+rnsegzCaO01sFW837udP4wZ/tejWpoG0hYPGtMXryUxTyLiQ9ETE/hthD8u4r+xyMuszh+IyFiKWiipw84tIV7TOkQnkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288911; c=relaxed/simple;
	bh=jwWkASf3G7kv40S9EsN+y10tbnAS8A+ecSlPyxahQC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hbNDZG14/7FBD0zjMpAbbXzs4ym5EioEcoLToY8fFaYnNWh3J/olajhUaZcjtzmQteUNAyP4lT7HIXofD8uUbrkkXc5059jVorhz/mHqDckknvI9PwVdr9TzzeISAZy2JOnuTcTdw+Peef0rVuPC7kNGY8DXowEXyMMecsp/BLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WqKaA9KY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288909; x=1756824909;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jwWkASf3G7kv40S9EsN+y10tbnAS8A+ecSlPyxahQC0=;
  b=WqKaA9KY0Ruq1jOhPloJrAknhc4g8hcQQV3rLmvTNHbPxzrNh7oi+oq+
   gfAVYA+88ZcWiJehhJYmEiEozGAfU5jX9MCp3jWP8ydAqR2cDc8lDzHmi
   MWj7s7HfIhR6CVMKe5fG5AI9VxzuFKJcscu7pMpUnvWZhHZLi05X2jO56
   YWevOivRtdVaR/WXnKBODaUEpvU6kOSue4yaTS8XYRcu5KaVt7/BOELmG
   uhtTJOfwl5qYZvktb5iUr1R6UigwTOrkPUPusaSmr9UImhb86tGUkUjzw
   U9Z/PzZ9M+BrstjA0AilDcyz95u6PutKwvARkyNLoHSvUzSdyC902cFzD
   A==;
X-CSE-ConnectionGUID: /Vcaqev1TP+OZLTGnI90pA==
X-CSE-MsgGUID: og3g0DqBT9yIdinbSxuLcw==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34271105"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:55:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:54:42 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:54:39 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:07 +0200
Subject: [PATCH net-next 02/12] net: sparx5: use FDMA library symbols
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-2-1e7d5e5a9f34@microchip.com>
References: <20240902-fdma-sparx5-v1-0-1e7d5e5a9f34@microchip.com>
In-Reply-To: <20240902-fdma-sparx5-v1-0-1e7d5e5a9f34@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<rdunlap@infradead.org>, <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.14-dev

Include and use the new FDMA header, which now provides the required
masks and bit offsets for operating on the DCB's and DB's.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/Makefile     |  1 +
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 44 ----------------------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  2 +
 3 files changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
index b68fe9c9a656..288de95add18 100644
--- a/drivers/net/ethernet/microchip/sparx5/Makefile
+++ b/drivers/net/ethernet/microchip/sparx5/Makefile
@@ -18,3 +18,4 @@ sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
 
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
+ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 1915998f6079..e7acf4ef291f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -21,53 +21,9 @@
 #define FDMA_XTR_CHANNEL		6
 #define FDMA_INJ_CHANNEL		0
 
-#define FDMA_DCB_INFO_DATAL(x)		((x) & GENMASK(15, 0))
-#define FDMA_DCB_INFO_TOKEN		BIT(17)
-#define FDMA_DCB_INFO_INTR		BIT(18)
-#define FDMA_DCB_INFO_SW(x)		(((x) << 24) & GENMASK(31, 24))
-
-#define FDMA_DCB_STATUS_BLOCKL(x)	((x) & GENMASK(15, 0))
-#define FDMA_DCB_STATUS_SOF		BIT(16)
-#define FDMA_DCB_STATUS_EOF		BIT(17)
-#define FDMA_DCB_STATUS_INTR		BIT(18)
-#define FDMA_DCB_STATUS_DONE		BIT(19)
-#define FDMA_DCB_STATUS_BLOCKO(x)	(((x) << 20) & GENMASK(31, 20))
-#define FDMA_DCB_INVALID_DATA		0x1
-
 #define FDMA_XTR_BUFFER_SIZE		2048
 #define FDMA_WEIGHT			4
 
-/* Frame DMA DCB format
- *
- * +---------------------------+
- * |         Next Ptr          |
- * +---------------------------+
- * |   Reserved  |    Info     |
- * +---------------------------+
- * |         Data0 Ptr         |
- * +---------------------------+
- * |   Reserved  |    Status0  |
- * +---------------------------+
- * |         Data1 Ptr         |
- * +---------------------------+
- * |   Reserved  |    Status1  |
- * +---------------------------+
- * |         Data2 Ptr         |
- * +---------------------------+
- * |   Reserved  |    Status2  |
- * |-------------|-------------|
- * |                           |
- * |                           |
- * |                           |
- * |                           |
- * |                           |
- * |---------------------------|
- * |         Data14 Ptr        |
- * +-------------|-------------+
- * |   Reserved  |    Status14 |
- * +-------------|-------------+
- */
-
 /* For each hardware DB there is an entry in this list and when the HW DB
  * entry is used, this SW DB entry is moved to the back of the list
  */
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 1982ae03b4fe..f7ac47af58ce 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -20,6 +20,8 @@
 #include <linux/debugfs.h>
 #include <net/flow_offload.h>
 
+#include <fdma_api.h>
+
 #include "sparx5_main_regs.h"
 
 /* Target chip type */

-- 
2.34.1


