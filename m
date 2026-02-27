Return-Path: <netdev+bounces-261869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMbqN7uxoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:01:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD61B960B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8510E30639FF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF4436344;
	Fri, 27 Feb 2026 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pn+OG6zU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDD42E00D;
	Fri, 27 Feb 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204268; cv=none; b=LtbulmDL9z1MZT9zphUKLU+ZsXYYfkKaBLYb6u1tlVRt1A0P2YLoprtC6fwuzy6Bjiz3uQybE4vabUr7ow7PkLmyu2IJdzNFdWW/BRdCZc4/b7aWdMriy3RsOWneJpaVnLDWIetQfuoThi3lA8l9HIm7znIERpfdnfAE42g+Dm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204268; c=relaxed/simple;
	bh=iZqObIlnGsrxaMJ/K/m7e8CKplLt7VJNcogmW6z0W/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RIZReXwJ5UdU1TYqPhD0m9a9BXEKygbFjVhpiUM4G+yd9BJKnwrpSVVwXORODOYOOoOGuowGOMoeur4trAETITe2U4QLXy94KdbV++8C1hpSZmHChICGXfD9vRr0EGtwaH4CzdYBmAt40f7UFAA0sGCFX0RUYakGxj/+Jw6wZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pn+OG6zU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772204267; x=1803740267;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iZqObIlnGsrxaMJ/K/m7e8CKplLt7VJNcogmW6z0W/U=;
  b=pn+OG6zUgdY23fDIbcsrcjzMkJ17NjyU4s74QoP00Az14jetXVzfT8D5
   2mHtW9x1nQrlR+UK7X8aUK3/OZm8a+YnXZrEUlHw1+1Dl1SHRDLCS3qZz
   Sm1UOR54yHYNZNlCXvoSd0PKAoEntfTiLCvE0loZcSVB0P5Q+x0hIuZVf
   ME/wMMRSwWZUPWQWE2zCsLIjx7Wx9IYKnPxYz2/O6lfhCizDMQU3ssY20
   g8+aL6YkHJlysi56vv+ZEZlwSVnCX7TA34jJsGvt1NnXxxpU9WNNzMVtH
   1EQjvCHhYF9q7mp5+snGATavcocDFl6E+xiSIjLq8UyGi45CwBeqmuyn5
   Q==;
X-CSE-ConnectionGUID: wDbLW9d7SnOseX1061A6kw==
X-CSE-MsgGUID: 5z+WZYXARCGYoexIWYfVfg==
X-IronPort-AV: E=Sophos;i="6.21,314,1763449200"; 
   d="scan'208";a="221253471"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 07:57:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 27 Feb 2026 07:57:21 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 27 Feb 2026 07:57:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 27 Feb 2026 15:56:47 +0100
Subject: [PATCH net-next v2 9/9] net: sparx5: replace sparx5_start() with
 sparx5_forwarding_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260227-sparx5-init-deinit-v2-9-10ba54ccf005@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,bootlin.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: F0DD61B960B
X-Rspamd-Action: no action

With all subsystem initializations moved out, sparx5_start() only sets
up forwarding (UPSIDs, CPU ports, masks, PGIDs, FCS, watermarks).
Rename it to sparx5_forwarding_init() and make it void since it cannot
fail. This removes sparx5_start() entirely.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index e4a448fd2b30..cab5daf265c2 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -735,7 +735,7 @@ static void sparx5_board_init(struct sparx5 *sparx5)
 					GCB_HW_SGPIO_TO_SD_MAP_CFG(idx));
 }
 
-static int sparx5_start(struct sparx5 *sparx5)
+static void sparx5_forwarding_init(struct sparx5 *sparx5)
 {
 	const struct sparx5_consts *consts = sparx5->data->consts;
 	u32 idx;
@@ -779,7 +779,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 	/* Enable queue limitation watermarks */
 	sparx5_qlim_set(sparx5);
 
-	return 0;
 }
 
 static int mchp_sparx5_probe(struct platform_device *pdev)
@@ -944,12 +943,7 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	sparx5_pgid_init(sparx5);
 	sparx5_vlan_init(sparx5);
 	sparx5_board_init(sparx5);
-
-	err = sparx5_start(sparx5);
-	if (err) {
-		dev_err(sparx5->dev, "Start failed\n");
-		goto cleanup_ports;
-	}
+	sparx5_forwarding_init(sparx5);
 
 	err = sparx5_calendar_init(sparx5);
 	if (err) {

-- 
2.34.1


