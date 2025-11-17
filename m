Return-Path: <netdev+bounces-239159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0360C64B32
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8AF134F8B1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1AB286426;
	Mon, 17 Nov 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SxXjpV6q"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06726E704;
	Mon, 17 Nov 2025 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390625; cv=none; b=Osv6jO3qB1+SGDtZHWI1GY62KsBMiJsx4zhPQVnxB0duV/HvbGP3CBaH/QfnXPD7iPi7ie1aW8uAKbnS8UsyW5doSBH7tZmhGAbTX9SejdSx+Z5LwmxRN2Qu2iZb9fXeCS5kyUtzjn3x9p/955oRavbXvThOFWoI51HSI9Dfsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390625; c=relaxed/simple;
	bh=uxawepCHXg2Yd36VpkxFPOJegt7XePgz7X7sztW4Ph0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XwVSpK0dcE6AH3cKl5lRvLOd+bZsO4rkWfIx6AmGHTQ3nQNj/dnU3W2SvIz6GOqAVGyoAabBcXA20N1k0BRLh+QJD4uRiA4R6mWGj+vGJML6SK4yD7OLQTkVgqirAoSwXyqndA+ehBul37npfLQQj/Sc17j+cDhhkWcWqjzKMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SxXjpV6q; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763390623; x=1794926623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uxawepCHXg2Yd36VpkxFPOJegt7XePgz7X7sztW4Ph0=;
  b=SxXjpV6qJx2LcU9bOM0cSjLtORimW3MvL49gek7rdhHDocHap2H1GezC
   vbFsw5ulbe91W2ykG1sle4skrQqA2f8HdEET/qCVGJrMYg5ZCQKcWd1Am
   L0qAGSziO2U0a8XMmMf3L6zu17wl/yEBy+9R+lZltPdFxB50VtC4z4/KO
   YINfFC+sPYasjYG47wvpIggwvc8Mo5V8uPXlAX4RD2rbou+GGrFEWA1SZ
   rNbSR/f02/kiY3NvEKYGzkrdBR9e4y1EiBBzPaMaFHksfy5cGFTkPy8Tr
   O/jMV2jqjod/S5BDgnveI/xArWhDqglBhYEzEdv0QIlu8ajNnq6x3Pisw
   A==;
X-CSE-ConnectionGUID: 5+kLe1HnQbGQTSeHxj+wLA==
X-CSE-MsgGUID: K9/4rSJrR4OJEFNZ1hicyQ==
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="49734143"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2025 07:43:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 17 Nov 2025 07:43:06 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Nov 2025 07:43:05 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] net: lan966x: Fix the initialization of taprio
Date: Mon, 17 Nov 2025 15:43:09 +0100
Message-ID: <20251117144309.114489-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

To initialize the taprio block in lan966x, it is required to configure
the register REVISIT_DLY. The purpose of this register is to set the
delay before revisit the next gate and the value of this register depends
on the system clock. The problem is that the we calculated wrong the value
of the system clock period in picoseconds. The actual system clock is
~165.617754MHZ and this correspond to a period of 6038 pico seconds and
not 15125 as currently set.

Fixes: e462b2717380b4 ("net: lan966x: Add offload support for taprio")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index b4377b8613c3a..905a967002def 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -1126,5 +1126,5 @@ void lan966x_ptp_rxtstamp(struct lan966x *lan966x, struct sk_buff *skb,
 u32 lan966x_ptp_get_period_ps(void)
 {
 	/* This represents the system clock period in picoseconds */
-	return 15125;
+	return 6038;
 }
-- 
2.34.1


