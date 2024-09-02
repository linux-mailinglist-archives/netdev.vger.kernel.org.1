Return-Path: <netdev+bounces-124232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A75968A5E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84762283266
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2679E2101A0;
	Mon,  2 Sep 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mxLhpKTv"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893B19F11E;
	Mon,  2 Sep 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288901; cv=none; b=dfUlmDfpJBG8FFtwzgNDPVVIezXwQdbyXwDIjUWMX/GbQ64aW7lKCHBCPiW4pS5YPLLHRHPySazaOQBBUDdgsWH7/e+acA1awHwGDx6Ysu0fCYRprEc0gSyQOzTnfPhdRyVa8rMUmzxJwA9LykNj9YMHTDMM5+pSfY4p5XDC/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288901; c=relaxed/simple;
	bh=KX8AI4UXfG/1IXK+0J7/AL5lRmkNFuq7JAiUuKB4fJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i0dytTGVFzFnJqrWSXA/MU27SEH6M6k3Axq2g28YlnogamoUqsg64c7FxB61PyWIzXnQd0yz4k6LII4UCNWl9qezTNZTW613a94jAqJQq/7DAlsD9zA18S4OBNn1wVKr2l9RL93XSMn5ZNQN1+N4cnc72BQ5J2jv7lfPaQXLTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mxLhpKTv; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288899; x=1756824899;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KX8AI4UXfG/1IXK+0J7/AL5lRmkNFuq7JAiUuKB4fJw=;
  b=mxLhpKTv/zuCy2eJ6C1L/6VftSkvEMmZOpCa0qw5GSXDgARmMyT0YA1V
   GqQQhMRkahbaN/7TulhGnXpDm/pCpqjZknLZ/TEG1RB4sBXi82ftS8BxG
   lAznxnFG5By53qmw3hyCVQN5YiiKmyeZ3pA0IXiQ0jklbrrbRW7Qdl+hZ
   QgTOIH9J5r3I5br3ab2vXc1da6o6EhSdz4AfLDMBKFiiZE4m+zfSnIjJa
   AtAGKp9gUdNNDjNBREjHeITDwcdE4LHoztIzDMCqJ/kYkzGlsD0qrOraC
   CZFeo5lpi3YaF06DxATX307ZdNI46NI4clnfICdYsSJ7aFNX72U44lpVA
   w==;
X-CSE-ConnectionGUID: WWovGYJSTraVm+sPH856TA==
X-CSE-MsgGUID: EXA3SlDFQ8ubCdKTRuTucA==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="262150744"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:54:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:54:52 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:54:50 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:11 +0200
Subject: [PATCH net-next 06/12] net: sparx5: use library helper for freeing
 rx buffers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-6-1e7d5e5a9f34@microchip.com>
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

The library has the helper fdma_free_phys() for freeing physical FDMA
memory. Use it in the exit path.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index 122876136f75..d01516f32d0c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -523,5 +523,6 @@ int sparx5_fdma_stop(struct sparx5 *sparx5)
 	read_poll_timeout(sparx5_fdma_port_ctrl, val,
 			  FDMA_PORT_CTRL_XTR_BUF_IS_EMPTY_GET(val) == 0,
 			  500, 10000, 0, sparx5);
+	fdma_free_phys(&sparx5->rx.fdma);
 	return 0;
 }

-- 
2.34.1


