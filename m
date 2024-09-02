Return-Path: <netdev+bounces-124233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B2F968A60
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3EF9B22186
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC37F2139A1;
	Mon,  2 Sep 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QhiJZGqy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4194B205E11;
	Mon,  2 Sep 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288901; cv=none; b=MjqSJpsbQKMC8VJaqapFL7y7Ai1AR2D3Y5UADZPWttZg8LK2ortunIUsxAo3i9smTsQWZPHiXSjIKKlh0gA+1PiZXg4sm/+y5a2sMOyvLr58t8CbXjf9DH/Pvo0EP7Ap7o7keJ9BPMRwuS1lqUlAZZ22bkUWlkOBlXQLUTwKQ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288901; c=relaxed/simple;
	bh=Pi32t5UY/P3LWFumotKzK0POQA28FP5B1cv8ISci/Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QDqHeWDs95rAJCYuMQmPikvmDOfR74fvpMRaCulN5MLus3cs7Q6lBoQ/1iGt5eTBHfj3F+MGmkdQX8GZclI3dXaClFnBsciAxIFWxHHO2vQzvxPEqTVw0fOjdsv6+QsoXjLOS02stSMPkCs6kWVX1NyEKEpdUerv9rKV1eSjlpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QhiJZGqy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288900; x=1756824900;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Pi32t5UY/P3LWFumotKzK0POQA28FP5B1cv8ISci/Pg=;
  b=QhiJZGqy07MFyrzkA/stGbdGB5EmLLRy0jegqUmsfUZXZG0+QBz5BvzF
   XSIsajVYpZ4FcCx+a9qay577p17sCpJCNn7qH7nb39BHUnqp1nFRyN2N/
   kMDcrBA4MLexQkY+g9hY9P7/t7ca8Bg5y68FNGqSVy+nTpFAOy+hw+eGt
   lPnHUg9cBl+ScC779Ifwmn5FNFz69d7A0KwOxTEJne0OnjKEVs0NAMsFK
   uOgYd0oshrCep+QVEXeqaaa+YJk8KwHlyRDFflHaquJhuVScfYbrfk0ER
   HEYjZR4LZJWFAwdpxWx0uSAU834sMO8mBqRDXW96ke/aJMFeTmbE4Du3z
   Q==;
X-CSE-ConnectionGUID: WWovGYJSTraVm+sPH856TA==
X-CSE-MsgGUID: CQIqPPUvSU2IDx2nLMTnUA==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="262150745"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:54:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:54:55 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:54:52 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:12 +0200
Subject: [PATCH net-next 07/12] net: sparx5: use a few FDMA helpers in the
 rx path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-7-1e7d5e5a9f34@microchip.com>
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

The library provides helpers for a number of DCB and DB operations. Use
these in the rx path.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index d01516f32d0c..c37718b99d67 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -162,19 +162,17 @@ static void sparx5_fdma_tx_reload(struct sparx5 *sparx5, struct sparx5_tx *tx)
 static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx)
 {
 	struct fdma *fdma = &rx->fdma;
-	unsigned int packet_size;
 	struct sparx5_port *port;
 	struct fdma_db *db_hw;
 	struct frame_info fi;
 	struct sk_buff *skb;
 
 	/* Check if the DCB is done */
-	db_hw = &fdma->dcbs[fdma->dcb_index].db[fdma->db_index];
-	if (unlikely(!(db_hw->status & FDMA_DCB_STATUS_DONE)))
+	db_hw = fdma_db_next_get(fdma);
+	if (unlikely(!fdma_db_is_done(db_hw)))
 		return false;
 	skb = rx->skb[fdma->dcb_index][fdma->db_index];
-	packet_size = FDMA_DCB_STATUS_BLOCKL(db_hw->status);
-	skb_put(skb, packet_size);
+	skb_put(skb, fdma_db_len_get(db_hw));
 	/* Now do the normal processing of the skb */
 	sparx5_ifh_parse((u32 *)skb->data, &fi);
 	/* Map to port netdev */
@@ -211,17 +209,16 @@ static int sparx5_fdma_napi_callback(struct napi_struct *napi, int weight)
 	int counter = 0;
 
 	while (counter < weight && sparx5_fdma_rx_get_frame(sparx5, rx)) {
-		fdma->db_index++;
+		fdma_db_advance(fdma);
 		counter++;
 		/* Check if the DCB can be reused */
-		if (fdma->db_index != fdma->n_dbs)
+		if (fdma_dcb_is_reusable(fdma))
 			continue;
 		fdma_dcb_add(fdma, fdma->dcb_index,
 			     FDMA_DCB_INFO_DATAL(fdma->db_size),
 			     FDMA_DCB_STATUS_INTR);
-		fdma->db_index = 0;
-		fdma->dcb_index++;
-		fdma->dcb_index &= fdma->n_dcbs - 1;
+		fdma_db_reset(fdma);
+		fdma_dcb_advance(fdma);
 	}
 	if (counter < weight) {
 		napi_complete_done(&rx->napi, counter);

-- 
2.34.1


