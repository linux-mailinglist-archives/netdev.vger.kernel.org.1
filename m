Return-Path: <netdev+bounces-157861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE09AA0C19B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718EE188B1F9
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227B41C5F0B;
	Mon, 13 Jan 2025 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QgpfM2a9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49618CC1D;
	Mon, 13 Jan 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796994; cv=none; b=QvP63VZFDY78ipfjWKz7Dsj399ZpSat4WEKk7mXT7UzwthFJagmPVone3oDaFFuJEIvubFTJrL6yA29vACfdoh00YUJW8RvvHmk32Ne7dht1lEYvXZgQYyV9J4LDgRtl2WrXN+jWjf2bVxkhZ8iBlVmurWLKc17TXELuOlAwKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796994; c=relaxed/simple;
	bh=RWp3FTdHXsv0g7oH1Wf6zDIDMJuYWwCvt1vaU7Vp7Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WsNMqbypaIstge/RhPQJ7WNlYdwjwXCzHDP9QpqUQDq7Mh137DKS/YQhFUqRj3zpg2H6Da7XZpjsKfWDyvgvDr8DTG6yMMbEaA/dc9He4UZm/g3AWmBiJ8DtCC6nrSn9aqJCbJGEoWwsLw2L++wxOuK7HZAbwSJlquUk8o5aD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QgpfM2a9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736796992; x=1768332992;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RWp3FTdHXsv0g7oH1Wf6zDIDMJuYWwCvt1vaU7Vp7Bo=;
  b=QgpfM2a9fgAqP1S/DDchsFgXgkm3NjyDl1C8eb37T2o1KZgNWth+/8tS
   tj0SloDXs4R1rJ8ldiFoyymrrKQ31f4NUIcC/8xJ6z4QiXcrSY01cwAhq
   SowCYkEgnN5ZDNFOPS43mu4URnnRplgPvL9lwpUSdGZkkqTWXSHblVxFh
   X25CXQQN3KgJZ4VsV1x/f0/sRSQQSCTlsFIfTrK/mspUrro6NOtlHQXWH
   cZS8+Nv5ZsVYjdOSoFUzfo7xkdZLmer0BegMalNmjHAY19Ob+2xp+TlEm
   pJ8FCWOcD6PU2fvAe13wxrm1F659BwhpnYi5GkuxjHH+TfkQNT/Sy9eXO
   A==;
X-CSE-ConnectionGUID: Fja7+Z77S3CaoQEzhBU3bA==
X-CSE-MsgGUID: VaI5AklMQXSpnmIMZ0+v6g==
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="203970673"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2025 12:36:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 Jan 2025 12:36:22 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 13 Jan 2025 12:36:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 13 Jan 2025 20:36:05 +0100
Subject: [PATCH net-next v2 1/5] net: sparx5: enable FDMA on lan969x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250113-sparx5-lan969x-switch-driver-5-v2-1-c468f02fd623@microchip.com>
References: <20250113-sparx5-lan969x-switch-driver-5-v2-0-c468f02fd623@microchip.com>
In-Reply-To: <20250113-sparx5-lan969x-switch-driver-5-v2-0-c468f02fd623@microchip.com>
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


