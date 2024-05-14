Return-Path: <netdev+bounces-96427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3548C5BB7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 21:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869A6282BB3
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD4181316;
	Tue, 14 May 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2pDOyBmm"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6E3144D0B;
	Tue, 14 May 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715346; cv=none; b=ht43VtWrO56f4ePv9pHaD6sF/1qhvH0Gg3dqEdEu+xvB1vSqvXiIH5gE0VC+fLU8c0u6nmjhLpUmcmtvmjlOhL9e32aKuR/76s+bGcpAv6NUB+ieW63L6w5gx51rrGkICdjqKzha//91IBSEOM5FwXrSW4aHT8q1R5hQWrP0G8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715346; c=relaxed/simple;
	bh=1AQKTqlthb0+71Ui6GRUS6m0XsgqkeBwGdVpQ+qWzzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HrvkJolrWUttjr0STw/B2qlhdZDMHqh3wIFhgJ3lEjXrNqmbxS+kZYRjBBPaX/y0OgOblCe3xgHEb45XCdJwZg0JMaKUUwwSK9hGGUbySTpAvm5gbQjFFOa0DXtxLXEQ+AFQbFF4y4P0jjYgZIaoNrEBS6+iuau0RVg2AjZwCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2pDOyBmm; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715715345; x=1747251345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1AQKTqlthb0+71Ui6GRUS6m0XsgqkeBwGdVpQ+qWzzg=;
  b=2pDOyBmmD7+w4Mmabre/epfO7uaYaggV7KqWg3PRXy1EJ3nzcr64fKSP
   RfcK0DXg7rrMycV8SY/R2BpDpLigpJA/uLFkW6tC4MFIaMdkgkT2VE2ld
   VEohyub1EgCx4kD8x10V7KoKPq2F+ki863g2wPUvILZ8S8yqBFVyNCbHw
   xwiWgRlSu9Mv8TwTvSOn5ORkTok++GD3bcPej8guytlfW1qInF1GDMbWT
   5ISYbnuYqmRD453NxUaNMmBNCEZdl1zz6vEyt/aefFqikSsjjUL+wmd+e
   C0NDhcTGhLSosmXsKzOQ5Z+g/phzxkXUPfgI2BEG0Mcn1XjqK55t2qSAH
   w==;
X-CSE-ConnectionGUID: ghWqsb3zRqW8HedyXcqMOw==
X-CSE-MsgGUID: nbtoIpUHTw2a/hkEZSLaNg==
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="24731262"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 12:35:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 12:35:33 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 12:35:30 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net] net: lan966x: Remove ptp traps in case the ptp is not enabled.
Date: Tue, 14 May 2024 21:35:00 +0200
Message-ID: <20240514193500.577403-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Lan966x is adding ptp traps to redirect the ptp frames to the CPU such
that the HW will not forward these frames anywhere. The issue is that in
case ptp is not enabled and the timestamping source is et to
HWTSTAMP_SOURCE_NETDEV then these traps would not be removed on the
error path.
Fix this by removing the traps in this case as they are not needed.

Fixes: 54e1ed69c40a ("net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 2635ef8958c80..318676e42bb62 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -479,8 +479,10 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
 		return err;
 
 	if (cfg->source == HWTSTAMP_SOURCE_NETDEV) {
-		if (!port->lan966x->ptp)
+		if (!port->lan966x->ptp) {
+			lan966x_ptp_del_traps(port);
 			return -EOPNOTSUPP;
+		}
 
 		err = lan966x_ptp_hwtstamp_set(port, cfg, extack);
 		if (err) {
-- 
2.34.1


