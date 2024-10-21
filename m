Return-Path: <netdev+bounces-137508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE419A6B74
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D41A28334E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2756A1FEFBE;
	Mon, 21 Oct 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ych/mnVI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779911F9EBF;
	Mon, 21 Oct 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519226; cv=none; b=Psl9VFJwOeSSbZ4laI5p4SKWa0wiILS8hDnDBGx0Yt/qjNKi238cz3s14BICFHkcaKiXcoiJzxiAE6GnENXVutYBoIP0mdOTDpLd6k4qRfK+aguv6LMZZonmp5BR3NKuvNm/VhY72KQyzvuqNQv7NTCxdVqDGlbdP/GptyEuyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519226; c=relaxed/simple;
	bh=Db4mo36NIk5280MwSTl+F0lyO0vOeJdT0JiFPqacJdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DRe+pdFwxsjq9dF9dAoMDM2ed8nYij1StZwRfP1DNZz3dDhv9n73414kHhnQjyUxGRG1VB6Dw03AcRe5xktDVpQJeImksMGz2vc3ru41gKxq3Rt1IWia5WesKuCpFivgF0z8eiWHQWogFuiEtrHz0R08sHjEHQH/wGZR/4Vr0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ych/mnVI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519223; x=1761055223;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Db4mo36NIk5280MwSTl+F0lyO0vOeJdT0JiFPqacJdE=;
  b=Ych/mnVIIkzzFIBYj8NAj9rJfYgxa67eQxiYtXFAEFHKEIu6NNtDxYhS
   DevkFaDLusVv4425LjldOeT6iFOHzlM+asEsRJHVbh0ygQ/5MNU5jfOdS
   q3NbtWgdAqnZyhXrNSZVLX9TyVdOUGxUE60LYujOQzbSKS70uYyUESHrp
   TcGUpXKR5cN08c1bUroxVMOmvqsdSF+QnnC/qBRDJSitwMCZTNLY6m1kL
   iSwHrTc+d2D5cI1HaQA2fBOtDy6H2N1DJALJgJux7fZL8YwSOOoQHQJhv
   JVmJtEpX3EGwu7o+RGgTzywVcrpJtO7ASTo1LdVyRyt5Vwcypc0KzksgZ
   g==;
X-CSE-ConnectionGUID: Ky42XnPuQxK/Okp36Nw4mA==
X-CSE-MsgGUID: CCXML1ZXTTKxIzxqXx/2bw==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="200707749"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 06:59:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:06 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:59:03 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:40 +0200
Subject: [PATCH net-next 03/15] net: sparx5: change frequency calculation
 for SDLB's
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-3-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x, rework the function that calculates the SDLB
(Service Dual Leacky Bucket) clock. This is required, as the
HSCH_SYS_CLK_PER register is Sparx5-exclusive. Instead derive the clock
from the core clock, using the sparx5_clk_period() function. The clock
stays the same before and after this patch, only now,
sparx5_sdlb_clk_hz_get() can be used for lan969x too.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h |  2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c | 10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index f117cf65cf8c..2a3b4e855590 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -552,7 +552,7 @@ struct sparx5_sdlb_group *sparx5_get_sdlb_group(int idx);
 int sparx5_sdlb_pup_token_get(struct sparx5 *sparx5, u32 pup_interval,
 			      u64 rate);
 
-int sparx5_sdlb_clk_hz_get(struct sparx5 *sparx5);
+u64 sparx5_sdlb_clk_hz_get(struct sparx5 *sparx5);
 int sparx5_sdlb_group_get_by_rate(struct sparx5 *sparx5, u32 rate, u32 burst);
 int sparx5_sdlb_group_get_by_index(struct sparx5 *sparx5, u32 idx, u32 *group);
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
index df1d15600aad..98a3f44c569c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_sdlb.c
@@ -25,17 +25,13 @@ struct sparx5_sdlb_group *sparx5_get_sdlb_group(int idx)
 	return &sdlb_groups[idx];
 }
 
-int sparx5_sdlb_clk_hz_get(struct sparx5 *sparx5)
+u64 sparx5_sdlb_clk_hz_get(struct sparx5 *sparx5)
 {
-	u32 clk_per_100ps;
 	u64 clk_hz;
 
-	clk_per_100ps = HSCH_SYS_CLK_PER_100PS_GET(spx5_rd(sparx5,
-							   HSCH_SYS_CLK_PER));
-	if (!clk_per_100ps)
-		clk_per_100ps = SPX5_CLK_PER_100PS_DEFAULT;
+	clk_hz = (10 * 1000 * 1000) /
+		 (sparx5_clk_period(sparx5->coreclock) / 100);
 
-	clk_hz = (10 * 1000 * 1000) / clk_per_100ps;
 	return clk_hz *= 1000;
 }
 

-- 
2.34.1


