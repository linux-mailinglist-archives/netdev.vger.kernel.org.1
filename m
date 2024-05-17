Return-Path: <netdev+bounces-96969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C78C87A2
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8E51F22672
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C395576D;
	Fri, 17 May 2024 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KB3cZuft"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09FB3B1AE;
	Fri, 17 May 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954301; cv=none; b=t8LlFNz+kZb2+Bl+1ako4umPB5f+EVA7/uDBKMK7MvxuKSdJ7IZXJVkpX7IvJj3ncyQBp2NOGXW5AlyceO7N+fcn67ljv9yfMgdTVRKrSexcdkTvULq4wYIOi+mupIoMDYkCoBbqxcC3PrD3UtrLopLA7hIKQfcAsa+BUiNRko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954301; c=relaxed/simple;
	bh=+dsbdBjhGrjm4WBAkfNNWSaDLuo2cRZvTPsNHLA+HzM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qsZgYdWxgu2fIaEKQ+vRs0+HRuUxRWeb+FnjGdQiT9pcD3ljuasJdsG2fl2SNUwoEMovepBYh+J1yK0keTDAKKolL5bIcfViDfB+SGB5GUYoV3I8cP9yT2WF5t6KtAunvmRlDOWNTPr117kcD7iFpkFtfWpa0q12eiuLNYz5oWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KB3cZuft; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715954300; x=1747490300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+dsbdBjhGrjm4WBAkfNNWSaDLuo2cRZvTPsNHLA+HzM=;
  b=KB3cZuftFQW/AdUrm3kFtkMbHGK0LoWT262YTfYYefJk9hcgDVE9QsMp
   tnddwFR1V8sXslRKW7ebrxo8cnCygsQmQ+ZntxnyY1qCxz1vpLX6GvCju
   isk8tC18MymYvwWTaRPTvyB7YmUT4t4CxnfsonxMAKIXC7eR9E3z5mJa5
   U1FDj6oqkTB39jB+0UI3vA/nq1S/DmCAGnBOhfiUDYKi4rWRGcoFE8TDB
   mNjavp/lC9c5oUeMP1TmzhQLzMIEcCuyTJ41pvkpiJ3yazjMy6DLOUxQ9
   aRYn402olCqBxJlUI0XfR2nmBOiihJxcFjjlJamJXnPVNr/eyUMN94M/G
   w==;
X-CSE-ConnectionGUID: ufAfKQToSxqUayt+FPsL2A==
X-CSE-MsgGUID: 27KVWmirSw2qpnX6nz50SQ==
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="25061077"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 May 2024 06:58:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 17 May 2024 06:58:15 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 17 May 2024 06:58:12 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<jacob.e.keller@intel.com>
CC: <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net v2] net: lan966x: Remove ptp traps in case the ptp is not enabled.
Date: Fri, 17 May 2024 15:58:08 +0200
Message-ID: <20240517135808.3025435-1-horatiu.vultur@microchip.com>
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
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v1->v2:
- as suggested by Vladimir, add the check before programming the traps
  in the first place
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 2635ef8958c80..fbff37067ab78 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -474,14 +474,14 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
 	    cfg->source != HWTSTAMP_SOURCE_PHYLIB)
 		return -EOPNOTSUPP;
 
+	if (cfg->source == HWTSTAMP_SOURCE_NETDEV && !port->lan966x->ptp)
+		return -EOPNOTSUPP;
+
 	err = lan966x_ptp_setup_traps(port, cfg);
 	if (err)
 		return err;
 
 	if (cfg->source == HWTSTAMP_SOURCE_NETDEV) {
-		if (!port->lan966x->ptp)
-			return -EOPNOTSUPP;
-
 		err = lan966x_ptp_hwtstamp_set(port, cfg, extack);
 		if (err) {
 			lan966x_ptp_del_traps(port);
-- 
2.34.1


