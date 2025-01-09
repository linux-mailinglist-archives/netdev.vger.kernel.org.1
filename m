Return-Path: <netdev+bounces-156846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A4A07FEE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2B1163870
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C951ACEC6;
	Thu,  9 Jan 2025 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Itam8u42"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F281A9B45;
	Thu,  9 Jan 2025 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447905; cv=none; b=MPQeu7xoy1TEhWrLPl6k8zbabImvgS7rRpLenT8aAna4wOx2yPFnxtfyWt3ykgvbApUsQzXX43McOO+FpARNIT/IEUB9g0XeqvBsGDfpTM5R2vpZIn76oby9rESsoPGhlIg5Z3NR2v9y7ZTCUGv1Yfy2tby7qBwaBVqHMQoKPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447905; c=relaxed/simple;
	bh=RWp3FTdHXsv0g7oH1Wf6zDIDMJuYWwCvt1vaU7Vp7Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jypOBbd7S6kZfCWqHTs9yIix/4DsAD1DJ5ekIGrJj4zHBYAOOiyzxQZsoqxVcC8FzuL1vkWY4hMJYidgJ1yg/con8ilI560Su96uPuyU1ODAUaMsrnVesdlUQg52R+VsIOYa/L6dHvrxxZC/w7AUPOJQ8ZE7IncFdBYOsNDuBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Itam8u42; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736447904; x=1767983904;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RWp3FTdHXsv0g7oH1Wf6zDIDMJuYWwCvt1vaU7Vp7Bo=;
  b=Itam8u42vkfIsW0hxBcR1WLNkrONtsnHDn9D4Zx37Cc3lbce3kGgXbyJ
   zSLy9zyE9oPSjBxCRyDhyJRdGFm2aBDm9+uXPxCYRJk0+xPZnmkA+QMwa
   4iteZFDbSOhseBiWMufq1gC/XtuZF/NTVfXCBsFy3izqim/cgjcOOVT4a
   NFDYNSzW6/kq42eDOHbBIbQHzq/FwraNrLxovleF0FGxdodz3iWuq0w/T
   KSBUN3r0UVsM0+It/kqUJgHS3qLz3WO1XbeMcUZPFFXFzexyYj/7DRSdw
   /c8WcRlHAUJtf0U+lzuKuReoD4kGX8n7OKmorxJ1DMIBDHJdaDg68SqQW
   w==;
X-CSE-ConnectionGUID: lYxo9VQwQ0yequjZYTYLoQ==
X-CSE-MsgGUID: SjiN47tOSoGue7cLsXILMQ==
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36007557"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 11:38:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 11:38:08 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 11:38:06 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 9 Jan 2025 19:37:53 +0100
Subject: [PATCH net-next 1/6] net: sparx5: enable FDMA on lan969x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-sparx5-lan969x-switch-driver-5-v1-1-13d6d8451e63@microchip.com>
References: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
In-Reply-To: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

In a previous series, we made sure that FDMA was not initialized and
started on lan969x. Now that we are going to support it, undo that
change. In addition, make sure the chip ID check is only applicable on
Sparx5, as this is a check that is only relevant on this platform.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index e68277c38adc..340fedd1d897 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -784,8 +784,9 @@ static int sparx5_start(struct sparx5 *sparx5)
 
 	/* Start Frame DMA with fallback to register based INJ/XTR */
 	err = -ENXIO;
-	if (sparx5->fdma_irq >= 0 && is_sparx5(sparx5)) {
-		if (GCB_CHIP_ID_REV_ID_GET(sparx5->chip_id) > 0)
+	if (sparx5->fdma_irq >= 0) {
+		if (GCB_CHIP_ID_REV_ID_GET(sparx5->chip_id) > 0 ||
+		    !is_sparx5(sparx5))
 			err = devm_request_irq(sparx5->dev,
 					       sparx5->fdma_irq,
 					       sparx5_fdma_handler,

-- 
2.34.1


