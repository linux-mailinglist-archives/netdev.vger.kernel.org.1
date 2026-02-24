Return-Path: <netdev+bounces-260643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBNbHdoKnmnkTAQAu9opvQ
	(envelope-from <netdev+bounces-260643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:32:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CC518C64F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C94D8305B46C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC0933A704;
	Tue, 24 Feb 2026 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2pTsFz/w"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199826A0C7;
	Tue, 24 Feb 2026 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965011; cv=none; b=AWoJZhEvDj3yqeyGUNSL6lOmCWbSuFuYMooQavCnau1CzUaLwxsRbZw676Cde9+geBPze/MaB8WixjC0XrImfsTkU8Nk6Z/oGrs0YMKPX0xQrGBkCcZhto3aOJvyWAWDyEd+UVltzG1Lq+vG5ce7PfvRGGvpCG8kF7pL9CzFtW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965011; c=relaxed/simple;
	bh=TARXgZXOLNs/wKtKFtya9KuH14skr0xMIwnTFQdfIYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQhBb6BzpBIWBVrTmcsIWhLJCj2U7vNMIXTccFZKki3vo7I+EZIuyvEm4tzxdhfZftznaRHDy4+rt53SChYUJLQhFajdwmMlSD1egmoAyp22yvF5Idb56zgDbU2lQ9egfHRYgBz13jr0+YGD+sGe8oLoMdxTFOozn8KOoqSFG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2pTsFz/w; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1771965008; x=1803501008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TARXgZXOLNs/wKtKFtya9KuH14skr0xMIwnTFQdfIYc=;
  b=2pTsFz/wTVTQksCjplYr5CYqiez76CHCEeCCCUwI8DgPBkGDVQWW7AjO
   q+JnMis814AHjTVGYfP9v4MhbClGJKT2foXoaLjkn6qNdqJx0M9+FwMRV
   yl967veNEyVKuWOAFsa1/mr+I7SoywjuJX+VIuOjPLp4lUZ0fGUdgcAyi
   KAzDP0pjJcJjqOsCaxriXeSl4vcIE0e6BsQPhfqPDchZLi4homi8rMjBh
   Dnzw4sYTVLFSSROB7mmGqDWX2uEvZ68MoLKv3MzrgWU1rTiUB1FnIP7LX
   x37t4tPXItsq/xwSWER03oQKIllSR2oPT9tx/rAcqzfbXoRD9bchPjmmj
   w==;
X-CSE-ConnectionGUID: nyoYymsUQturxNWE5RLEfQ==
X-CSE-MsgGUID: bW+eUffBSIWUhODcyvYB9g==
X-IronPort-AV: E=Sophos;i="6.21,309,1763449200"; 
   d="scan'208";a="53070978"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 13:30:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 13:29:38 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 24 Feb 2026 13:29:37 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Sean Anderson
	<sean.anderson@linux.dev>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 3/3] net: macb: add the .pcs_inband_caps() callback for SGMII
Date: Tue, 24 Feb 2026 12:28:54 -0800
Message-ID: <20260224202854.112813-4-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224202854.112813-1-charles.perry@microchip.com>
References: <20260224202854.112813-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260643-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: D8CC518C64F
X-Rspamd-Action: no action

In SGMII mode, GEM can work with or without inband
autonegotiation.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---

Notes:
    Changes in v2:
      * Added this patch

 drivers/net/ethernet/cadence/macb_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f6efc1bb88b6..4b1fe3beaa17 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -557,6 +557,12 @@ static int macb_usx_pcs_config(struct phylink_pcs *pcs,
 	return 0;
 }
 
+static unsigned int macb_pcs_inband_caps(struct phylink_pcs *pcs,
+					 phy_interface_t interface)
+{
+	return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+}
+
 static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 			       struct phylink_link_state *state)
 {
@@ -609,6 +615,7 @@ static const struct phylink_pcs_ops macb_phylink_usx_pcs_ops = {
 };
 
 static const struct phylink_pcs_ops macb_phylink_pcs_ops = {
+	.pcs_inband_caps = macb_pcs_inband_caps,
 	.pcs_get_state = macb_pcs_get_state,
 	.pcs_an_restart = macb_pcs_an_restart,
 	.pcs_config = macb_pcs_config,
-- 
2.47.3


