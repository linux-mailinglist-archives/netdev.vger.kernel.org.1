Return-Path: <netdev+bounces-284732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOxsKEnu+mn3UQMAu9opvQ
	(envelope-from <netdev+bounces-284732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3844D73FC
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854FB30966D6
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3E37A4AF;
	Wed,  6 May 2026 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Sr+/h44a"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234C371046;
	Wed,  6 May 2026 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052384; cv=none; b=FfIhkkuXVDPz4Dp5sj6ZCr5jzEVQqccdIzJBHRRYKt96xwBvY3sOIx63UnedWCN2hzJiM10LMefnNGX94qi3yG2+/GBV2ZqElYNLFpRcQvvnaNt9EgzmIwUj/wD6F3ETFvEpjLTEMHSknRMGD3tifASGMhTJ85jiWiPYxe0ijtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052384; c=relaxed/simple;
	bh=619p+RzrpqmDK4uuw5RRQJ+j6sdBsG4AloG918xNeJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nTeq5xLedHWyxHC87i1Cm++Cf+N94sGpi+mQWsG0g9V0e6ZJnlcIZAUwqzGl+PHkJqrtGh7Pprx15V3RLFbIO2PQ+nVFn/hUsPbUQEW2olXh1wvPTtpd5uVLrz/2q+zH0NGVbiHnwNniDz+ejmur5263SVvXC1rowwPjobB+NLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Sr+/h44a; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778052384; x=1809588384;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=619p+RzrpqmDK4uuw5RRQJ+j6sdBsG4AloG918xNeJE=;
  b=Sr+/h44ak0M1WAtHlKqyNoOW5F21Qhat0woeOfOQK5M3LC+fjjKR7Sdm
   gNGztPTlAww5XQ05nQJhIBlg+qFMoVyp7immQZUjd76+DXHkiBT8h7a0O
   HIUOuPXlx7eVFYq8SbvSX1Yoc3hwjXIoi/MjHsjaEVrKRnTPMmJ+X5ycI
   KfuImxD+orW5oR8I/0YIr2JkN+LNHcN9r6Zb2w/RjmTbBakp6sjqIF97v
   xSVix9ypa/6agxLWm7BZmo0BrfaVos0DlllrmU+oIVmiNKnjAvszZauOe
   35gy/GgSTbaipsqLADZkevMzNdFIN9AK4nOrwwWm2bAojAV/zKa3itkRv
   w==;
X-CSE-ConnectionGUID: NddUM9SwQN+U4k2D3/Zahg==
X-CSE-MsgGUID: 3sJC9WEQSLe3yX2/JKra7w==
X-IronPort-AV: E=Sophos;i="6.23,219,1770620400"; 
   d="scan'208";a="288477306"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:26:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Wed, 6 May 2026 00:26:22 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 6 May 2026 00:26:18 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 6 May 2026 09:25:39 +0200
Subject: [PATCH net v2 4/4] net: sparx5: configure serdes for 1000BASE-X in
 sparx5_port_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260506-misc-fixes-sparx5-lan969x-v2-4-fb236aa96908@microchip.com>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
In-Reply-To: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>, Andrew Lunn
	<andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: EA3844D73FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284732-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:dkim,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]

sparx5_port_init() only invokes sparx5_serdes_set() and the associated
shadow-device enable and low-speed device switch for SGMII and QSGMII.
On any port with a high-speed primary device (DEV5G/DEV10G/DEV25G)
configured for 1000BASE-X the serdes is therefore left uninitialized,
the DEV2G5 shadow is never enabled, and the port stays pointed at its
high-speed device rather than the DEV2G5. The PCS1G block looks
healthy in isolation, but no frames reach the link partner.

Add 1000BASE-X to the check so the same three steps run.

Note: the same issue might apply to 2500BASE-X, but that will,
eventually, be addressed in a separate commit.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Fixes: 946e7fd5053a ("net: sparx5: add port module support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 04bc8fffaf96..62c49893de3c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -1128,7 +1128,8 @@ int sparx5_port_init(struct sparx5 *sparx5,
 		DEV2G5_PCS1G_SD_CFG(port->portno));
 
 	if (conf->portmode == PHY_INTERFACE_MODE_QSGMII ||
-	    conf->portmode == PHY_INTERFACE_MODE_SGMII) {
+	    conf->portmode == PHY_INTERFACE_MODE_SGMII ||
+	    conf->portmode == PHY_INTERFACE_MODE_1000BASEX) {
 		err = sparx5_serdes_set(sparx5, port, conf);
 		if (err)
 			return err;

-- 
2.34.1


