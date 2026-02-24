Return-Path: <netdev+bounces-260642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD8kLEcKnmnkTAQAu9opvQ
	(envelope-from <netdev+bounces-260642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:29:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5631218C60C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8294303CB33
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F733A02D;
	Tue, 24 Feb 2026 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BCvCyUhT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9034CDD;
	Tue, 24 Feb 2026 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964996; cv=none; b=ZwtnMQkmTnawVBMe0A4UKVBw/pxLt1i1/0qJC0nJEF6MKzCXJaecNBKJLaNJSrgjDb0C+Bgq3LQGWUdVTHw9w6iZN1G9xFNHgfPOtq7AEfNDY0N3qE5T0GL7Xn0mi3Xlzoqy+dqFFHxtJkma2a66ia1upx7VXnMtIcdT2IgFk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964996; c=relaxed/simple;
	bh=JYrKBiLiuP7chA3VIle2cWQufy5LUnFCNtHJLGMMsTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWdQsbcQ/NWxJuVLOw1q81BV91NkYm+0ZzX0EqeG3D54TF4MB1ayClBwMsy16DB3BjIDm8tB37wZbPhmNXHMchnkjaQ4fVzkXIMRFFFW65WnMX6TtDKzGXIqRw2sG0Vw+8zrxG+n2ThNSKeFc1zlhcoI/Bg/dSQH6S/LQdBHNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BCvCyUhT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1771964996; x=1803500996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JYrKBiLiuP7chA3VIle2cWQufy5LUnFCNtHJLGMMsTM=;
  b=BCvCyUhTUWtAHI6uPgypxCYQOT4hY33E/kJ7xhurkzCr0jgtPjTLszGv
   rIzoBzw120hHNTKc7q9EsAjho9jrTFgQhZcsPtKXDaYRy8KzFcea5NhfT
   UvFt0O5LsoWH0J24giTOtSjCG6P/k8vcnqUkvcPGAoj+FXIqa0Krd7FCA
   8eIuywAtPiclPR5Oo2+W0SRn61+4AjZz1SvV5UCDsC4fL2kmPw+aXh8md
   J1rC9IV4EafQmY1HdFvsdXqA+0/3ahOZcFe2mhMXZX+sDW4GTWbCgTWPA
   pDMeDiqU/GpHW+/+CpirDq8JkDs9rzbLlzHuLUQMjpSVikJclzRsrsn5i
   w==;
X-CSE-ConnectionGUID: q8IE9EiCRpeM7ZzmGaO9hg==
X-CSE-MsgGUID: 0jgpgC3WRwCaJijj4ru4FQ==
X-IronPort-AV: E=Sophos;i="6.21,309,1763449200"; 
   d="scan'208";a="53802224"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2026 13:29:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 24 Feb 2026 13:29:34 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 24 Feb 2026 13:29:33 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Sean Anderson
	<sean.anderson@linux.dev>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 2/3] net: macb: add support for reporting SGMII inband link status
Date: Tue, 24 Feb 2026 12:28:53 -0800
Message-ID: <20260224202854.112813-3-charles.perry@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260642-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:dkim,microchip.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5631218C60C
X-Rspamd-Action: no action

This makes it possible to use in-band autonegotiation with
SGMII.

If using a device tree, this can be done by adding the managed =
"in-band-status" property to the gem node.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---

Notes:
    Changes in v2:
      * Move my notes to the cover letter

 drivers/net/ethernet/cadence/macb_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f4250e76cef0..f6efc1bb88b6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -560,7 +560,12 @@ static int macb_usx_pcs_config(struct phylink_pcs *pcs,
 static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 			       struct phylink_link_state *state)
 {
-	state->link = 0;
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+	u16 bmsr, lpa;
+
+	bmsr = gem_readl(bp, PCSSTS);
+	lpa = gem_readl(bp, PCSANLPBASE);
+	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
 }
 
 static void macb_pcs_an_restart(struct phylink_pcs *pcs)
-- 
2.47.3


