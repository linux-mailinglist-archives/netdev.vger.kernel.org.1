Return-Path: <netdev+bounces-261867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAiRCm+xoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:59:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC71B95B0
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78303302158C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CEA42E004;
	Fri, 27 Feb 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S9YfkOvz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1634742B75B;
	Fri, 27 Feb 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204267; cv=none; b=C89XGOrPdAL+R/eeBQhuEvkdzyc2id3kbMash74OOgStLwETYKNFCCt2PRZv8YwsRAEY+2QxEZ9sZpIl0hnhfdBSEdzUQeq4uYQTUonS1IiLqoSBl2kugM+GF6SVxkZJYQw0i1jvIvSO20irwXjzAF7pUdvG0NjR8nGuRtJ6xHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204267; c=relaxed/simple;
	bh=gVcNnj+ZlXLYFHsDMZvUG7C8eoXS0EkcdZXKECQ31PQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oSQK8SJ2sHO0hysORGUeLIouWryVBC/cFmKNWPNchOfUkv9+SwGXA/otRJ+bl4orx0l+ZtPVHSazljs6xfFXASFU70Do61JfGhprghCFWq4N1JxH1p/AS16j0/PboFVZXEOmlPJtGEqob8F9roEQemYXi+EeNd9zfCr6SwqLTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S9YfkOvz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772204266; x=1803740266;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gVcNnj+ZlXLYFHsDMZvUG7C8eoXS0EkcdZXKECQ31PQ=;
  b=S9YfkOvzzz6zVD8L6UzUUA9AA2C9A0L04o5hcpZWnzxwZOtvLrJr5dym
   w/Je862nm+5Jre+GH7VkfMr7f/KBaPsL0HNkyJhetj/P8BIGICgFBoxPn
   fsg1J6bEcZawTVxbdTMIdADepOb/dnC2T+6pei0sglsCZrxnqqcYdPrN1
   OimCXI+06WCQLaEJttQJwh1Oj4/6fxYAiSXZ/oxNtnWjAHVf/eb1vdl6u
   5lgCsYLQZLW9LSZkOZQ53iYyZWqYQ4rXdFtwjuTuEvfySwoX6cxjHagB+
   ThYm6+tUW2HQdkQugjXHUajaM36ZKbU7YhptYm7TJXnSM87bsqWFb7FTO
   w==;
X-CSE-ConnectionGUID: wDbLW9d7SnOseX1061A6kw==
X-CSE-MsgGUID: qJfegyn5QBW4ymcFlia6Gg==
X-IronPort-AV: E=Sophos;i="6.21,314,1763449200"; 
   d="scan'208";a="221253469"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 07:57:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 27 Feb 2026 07:57:14 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 27 Feb 2026 07:57:11 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 27 Feb 2026 15:56:44 +0100
Subject: [PATCH net-next v2 6/9] net: sparx5: move remaining init functions
 from start() to probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260227-sparx5-init-deinit-v2-6-10ba54ccf005@microchip.com>
References: <20260227-sparx5-init-deinit-v2-0-10ba54ccf005@microchip.com>
In-Reply-To: <20260227-sparx5-init-deinit-v2-0-10ba54ccf005@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <maxime.chevallier@bootlin.com>,
	<rmk+kernel@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261867-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,bootlin.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:dkim,microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1EC71B95B0
X-Rspamd-Action: no action

Move sparx5_pgid_init(), sparx5_vlan_init(), and sparx5_board_init()
from sparx5_start() to probe(). These functions do not require cleanup.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index a58c79a6e873..d37f34197e84 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -726,17 +726,9 @@ static int sparx5_start(struct sparx5 *sparx5)
 			 ANA_CL_FILTER_CTRL_FORCE_FCS_UPDATE_ENA,
 			 sparx5, ANA_CL_FILTER_CTRL(idx));
 
-	/* Init PGID table arbitrator */
-	sparx5_pgid_init(sparx5);
-
-	/* Setup VLANs */
-	sparx5_vlan_init(sparx5);
-
 	/* Enable queue limitation watermarks */
 	sparx5_qlim_set(sparx5);
 
-	sparx5_board_init(sparx5);
-
 	/* Start Frame DMA with fallback to register based INJ/XTR */
 	err = -ENXIO;
 	if (sparx5->fdma_irq >= 0) {
@@ -943,6 +935,10 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		}
 	}
 
+	sparx5_pgid_init(sparx5);
+	sparx5_vlan_init(sparx5);
+	sparx5_board_init(sparx5);
+
 	err = sparx5_start(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Start failed\n");

-- 
2.34.1


