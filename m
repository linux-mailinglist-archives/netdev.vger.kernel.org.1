Return-Path: <netdev+bounces-124240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF5968A76
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0710282CB5
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513561C62D6;
	Mon,  2 Sep 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P4FtW9Ht"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639E1C62BC;
	Mon,  2 Sep 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288934; cv=none; b=X7CmFz5DGfD4+mq3vTzQEsFp1AwpTJVtwdqTGinsjxAa3NjpT4EeCHP0raL/sW/KMGkq6eaIchkgzvqQ9b2XZaLO2aYuZDHGd3qcgHJbOli8ZIJnQOe9dtOaKOhgKk25nxOlZNqxAkH7y5tfFlW0UthIuguCv+I1Cu9zsicvf7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288934; c=relaxed/simple;
	bh=VYuqsn82TNwXeOl9I4ZpMCH1VasU3oB3NNclgLdbMJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cKpY26A67mRMbqjLp/0kDhftWQZYYCIcXVEmYzwSACdGsVT+cMM5rWTAv/+6vcQ2ueeWfyB5LPxWa50TKY/EXiqei5bgnBlSJWNTNLfDtg29iv7T1IWpIYyKUEL+Fcoa6kuxpzM2GE27CWYUeFISOeC8MJ3o7rvCB8Q09/6ClkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P4FtW9Ht; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725288932; x=1756824932;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VYuqsn82TNwXeOl9I4ZpMCH1VasU3oB3NNclgLdbMJo=;
  b=P4FtW9Htm54NrIKwk0Wpe8uE5vu7E6ybYBxLTc5I01vsqC7rR/2IQlDc
   LxyFMq64dMUDbT73p59b2+JNdZI+QipUFINbhheTnN8GQ3Bfq2PHgVBSM
   x6YtalCy9E//4c0LpVcQBlUXMkKRbbTXiEtkKaOW4iOdwvU5Ujj+sPsbM
   EDpFkqdMWMfZY9G+bxa1rEfX+4rZXzTtJHYoH6QTzdiyJa+qOUZoWtjDt
   vKG7/W0RNxhpqd5HT+MC8cEm265M2zFSqr2I5wbc+lT/Ul9VrC02+UwGH
   RgX4sHR13a7RGx0qOIGHUv/uN+akzIblIbY9I6+M0EY+qrJcjw8dxf3x4
   g==;
X-CSE-ConnectionGUID: 6WD2x+lUSXKxeZe2mffqQA==
X-CSE-MsgGUID: LG5Q+ssUT9Cg0tqABrHfGA==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="31128331"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:55:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:55:03 -0700
Received: from [10.205.21.108] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 07:55:00 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Sep 2024 16:54:15 +0200
Subject: [PATCH net-next 10/12] net: sparx5: use library helper for freeing
 tx buffers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240902-fdma-sparx5-v1-10-1e7d5e5a9f34@microchip.com>
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
index 4fc52140752a..38735bac6482 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -494,5 +494,6 @@ int sparx5_fdma_stop(struct sparx5 *sparx5)
 			  FDMA_PORT_CTRL_XTR_BUF_IS_EMPTY_GET(val) == 0,
 			  500, 10000, 0, sparx5);
 	fdma_free_phys(&sparx5->rx.fdma);
+	fdma_free_phys(&sparx5->tx.fdma);
 	return 0;
 }

-- 
2.34.1


