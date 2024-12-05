Return-Path: <netdev+bounces-149409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D579E5801
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5612D16BF04
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A889A21D5B1;
	Thu,  5 Dec 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZaM/17IJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593D21A447;
	Thu,  5 Dec 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406969; cv=none; b=INI/NEQ5hoGCboOgXx98rPFuiWd7JI+iqDGncyJs3ZM3FqLq0eJCL8GICQPCaEu7ImkclIOILKTZTQlZDwzZdH6dCzEAFr2Ghc1LvY80VDAp2UCvvLmUvgw+8eYM7vk34L77y3jIx5qE4gTBu7lwH677qgtnIn7jMyHBJthRdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406969; c=relaxed/simple;
	bh=6GvfB7edygOjof5RC098NRUa57MLKSj4Kl9eAHtIq4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RxmOza+mmj2JgsXdhnNvt0oitjFBPq6Vz/LqNEvY70AyrHndU23mUpX80w4iUsN2MJiglUm3EOC81EZcKPq+3FaxapP7hMs4bAJNEnw9CctusV6GI3y0kqJ3yrtk65eHKddb/M1oE/5pWKLAo7eAm9/BVm7W32vjFQpczZ4FOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZaM/17IJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733406967; x=1764942967;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6GvfB7edygOjof5RC098NRUa57MLKSj4Kl9eAHtIq4U=;
  b=ZaM/17IJbtTWHByr8AaGUn/wUWJxqlTZHs3q6aS3PAcmTC3KdKnlGYQH
   idoBKhF1XccWVbYYLvRJO/QsabwYgQ+XSBYguPZkmgOPyR/FWEUJtSbs2
   +Xa8Wf1d09Bfj8u3KyvByz3Cm0vPs67xbPZSHyX15VhSmQMF+F0gOKle3
   7JK+Pygr9aOA4Z0vLVv9MPDSGv1CHiKroScOUi4Ki8/J2hWggTQwIbksw
   J5Am4a8e8eC0o6jgP+8qNVFbAu1/HNQNK+xkN8N1T6+XaCbaQj/btVfKx
   EPwpvnrTZnI/l4eYPpXPt/j/CqKKpRby3yYosJzM7qxBHhKXa1L8M19re
   Q==;
X-CSE-ConnectionGUID: qy+UA5uVS7igPsVfubi4eA==
X-CSE-MsgGUID: JzRvWx8tQKavjYXcv/wEYw==
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="202626300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2024 06:56:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Dec 2024 06:55:36 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 5 Dec 2024 06:55:33 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Dec 2024 14:54:28 +0100
Subject: [PATCH net 5/5] net: sparx5: fix the maximum frame length register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241205-sparx5-lan969x-misc-fixes-v1-5-575ff3d0b022@microchip.com>
References: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
In-Reply-To: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<arnd@arndb.de>, <jacob.e.keller@intel.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: Calvin Owens <calvin@wbinvd.org>, Muhammad Usama Anjum
	<Usama.Anjum@collabora.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

On port initialization, we configure the maximum frame length accepted
by the receive module associated with the port. This value is currently
written to the MAX_LEN field of the DEV10G_MAC_ENA_CFG register, when in
fact, it should be written to the DEV10G_MAC_MAXLEN_CFG register. Fix
this.

Fixes: 946e7fd5053a ("net: sparx5: add port module support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 1401761c6251..f9d1a6bb9bff 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -1151,7 +1151,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 	spx5_inst_rmw(DEV10G_MAC_MAXLEN_CFG_MAX_LEN_SET(ETH_MAXLEN),
 		      DEV10G_MAC_MAXLEN_CFG_MAX_LEN,
 		      devinst,
-		      DEV10G_MAC_ENA_CFG(0));
+		      DEV10G_MAC_MAXLEN_CFG(0));
 
 	/* Handle Signal Detect in 10G PCS */
 	spx5_inst_wr(PCS10G_BR_PCS_SD_CFG_SD_POL_SET(sd_pol) |

-- 
2.34.1


