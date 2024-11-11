Return-Path: <netdev+bounces-143744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFA9C3F0E
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E40285874
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F01A0BE1;
	Mon, 11 Nov 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EBzx7WBd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97819E802;
	Mon, 11 Nov 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329958; cv=none; b=pvI0AL5NamyA050PGVeD6HuKDQf6DupVsU1Z4rINH++ZA0kxLwA5bu/gH5N4VhplBZAkoXU0D4BMcRXljioM+dJ66CDtikAaobaOia57zitePud5d0e8MV/Y/JURCM4OSkmhga2UqO5xmQ0K8pefwDZPTlGIw1BJ+Vi5Hb1IR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329958; c=relaxed/simple;
	bh=vTkFGY0qwj+sGYvNP9/web9ULuyUUa7zcF8AaORDoiw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im/hf2sghdrqflMonWhMkYNje0nia/sC2I/4h4yLOzvSkC9MR7Yn8w78AEbQ9Iy4RqTuFOS4qTzPlX3mAcylaDSmbnnmjXS9s34Ddaktu5czXmF3HJ3lzRBZ+0qmjcvYPyJ3O6iktxtX4CCj1pAglkVJaOcKLdqy6XcZFCIHYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EBzx7WBd; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731329956; x=1762865956;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=vTkFGY0qwj+sGYvNP9/web9ULuyUUa7zcF8AaORDoiw=;
  b=EBzx7WBdOFGLW+9qumJ9DvBlObDcNj7dIdW9s1KhC+bX4/jp2gKNsc6u
   Nx+ySHrv+lsB3foERexmzuSdlCIChcyrI6WsOcP6towOLVpog6AXbeY2B
   q5leB3u0WR7sXpgGAyTU6xnA72q4JcyVOOz+/7/tVUvXcX2Px85R2bpHK
   ZJ8wh21AXuih2iwtERF80hDfmwRiHk5b0aHNpR52mrTwQqjqXRxCAMdT1
   r5rddnq+oposacDqllUuOo+BGoFDRpwkgoT417hYQnu4EXI5wgTvAzRnn
   1LNto18IDAlM/2dEPI4vC4S+69KqvLf+TxtWoacCPyaktf+WY3PE3eNnN
   A==;
X-CSE-ConnectionGUID: dZFC6vp0Q/6hLNqL+TdxVg==
X-CSE-MsgGUID: saVFwXQzRH6XQPITDSJWjQ==
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="37646826"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2024 05:59:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Nov 2024 05:59:03 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 11 Nov 2024 05:58:59 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: [PATCH net-next v2 4/5] net: phy: Makefile: Add makefile support for ptp in Microchip phys
Date: Mon, 11 Nov 2024 18:28:32 +0530
Message-ID: <20241111125833.13143-5-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111125833.13143-1-divya.koppera@microchip.com>
References: <20241111125833.13143-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add makefile support for ptp library.

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v1 -> v2
- No changes
---
 drivers/net/phy/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 90f886844381..58a4a2953930 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MICROCHIP_PHY)	+= microchip.o
+obj-$(CONFIG_MICROCHIP_PHYPTP) += microchip_ptp.o
 obj-$(CONFIG_MICROCHIP_T1_PHY)	+= microchip_t1.o
 obj-$(CONFIG_MICROCHIP_T1S_PHY) += microchip_t1s.o
 obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
-- 
2.17.1


