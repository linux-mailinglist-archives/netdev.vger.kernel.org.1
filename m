Return-Path: <netdev+bounces-214815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDF7B2B5B2
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DC25237FA
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482BA12FF6F;
	Tue, 19 Aug 2025 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PDUxAA8O"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DE28E5;
	Tue, 19 Aug 2025 01:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565502; cv=none; b=M9dHfd72T7El3h2LL27CkYx0S4grbAGld0tT+8wEzMTgMVG82Bnu5giyV1qgPEWS5fj7xEAwsf1qMtzD9mbh7fdrmeqZrHBCh/kOZdPPiKybGdbsV2F7POIULo7O7Ggu9Rqid0+GTQfWr0wKl/nGWsH6eT8oD01ZOcIKtRKsiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565502; c=relaxed/simple;
	bh=Sr5zwSNGAHiDCQJc0Yg4zbONzLP+8ObWLrx7oYLFQGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KWObGgeOgKVd1pb2IJgPi5+KPbXdhx/L8YJYE7YbCZinSUHZV2IZy6huWUCT41BOvXaG4rnn9XP+g9z3tnDJP5NlppMEzItfM6P5PRtLzLMh8d/RUBGW25kUqAKqb8LH8M7q73H/2f8XqHyc1NC8qLuGG5SLEY62e5lkglmJe7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PDUxAA8O; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755565500; x=1787101500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sr5zwSNGAHiDCQJc0Yg4zbONzLP+8ObWLrx7oYLFQGA=;
  b=PDUxAA8O5oJGeusynn/R5qRJt+5HEn0n0EpGoYy8yO3rEhXNbFPZWw6C
   JEELxVbkyJO20hZEsCtEURWs8kFPODI8565tTusT8z3R/gyHLoOy5r48O
   2NR6m2nyyLeIVLntVwhmHvHY/QwdheOI77rT2EAZlBOeiU85CL6Vg/GI/
   yFPHVrPs7TOKMdvUMeq/vnNycVEZp81eI3FmbL4B9cLtkO8csU+8q6Ggc
   fDNgxFR+8db9mMV0C3lWzpDjyY09FnCWtBP4bzdeFvFJumHfgivTftEHk
   Nokcbv0zdLdJSm3CveUkhtqRLTyBT368vIyOqhCZVvX1Hg02zRtl3jbBT
   w==;
X-CSE-ConnectionGUID: 3sW4sM8IRgihpNYU5NDkGQ==
X-CSE-MsgGUID: OXPFspOgQ4OWBmnmMDLUnQ==
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="212774479"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2025 18:04:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 18 Aug 2025 18:04:52 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 18 Aug 2025 18:04:52 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Frieder Schrempf
	<frieder.schrempf@kontron.de>
CC: =?UTF-8?q?=C5=81ukasz=20Majewski?= <lukma@nabladev.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net] net: dsa: microchip: Fix KSZ9477 HSR port setup issue
Date: Mon, 18 Aug 2025 18:04:57 -0700
Message-ID: <20250819010457.563286-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

ksz9477_hsr_join() is called once to setup the HSR port membership, but
the port can be enabled later, or disabled and enabled back and the port
membership is not set correctly inside ksz_update_port_member().  The
added code always use the correct HSR port membership for HSR port that
is enabled.

Fixes: 2d61298fdd7b ("net: dsa: microchip: Enable HSR offloading for KSZ9477")
Reported-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 4cb14288ff0f..9568cc391fe3 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2457,6 +2457,12 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
 		dev->dev_ops->cfg_port_member(dev, i, val | cpu_port);
 	}
 
+	/* HSR ports are setup once so need to use the assigned membership
+	 * when the port is enabled.
+	 */
+	if (!port_member && p->stp_state == BR_STATE_FORWARDING &&
+	    (dev->hsr_ports & BIT(port)))
+		port_member = dev->hsr_ports;
 	dev->dev_ops->cfg_port_member(dev, port, port_member | cpu_port);
 }
 
-- 
2.34.1


