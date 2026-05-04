Return-Path: <netdev+bounces-283892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFURCXuy+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EFC4C018C
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70BD9306BDDC
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC503E0C60;
	Mon,  4 May 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vAh2cZmq"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90713E0C59;
	Mon,  4 May 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905854; cv=none; b=kF4XmALb6HwPlLs04uZc1PhHeDvnE2BLAGVpwJM9zvZuMfVZskP4VSyt/pwDK08WtdrVRKPI7L4JDdFJf/frZw68VtskjJ1DZS00pYkB/jfednP/wBleNdI7EshR4w0BmBAcWqXlBCShixO3oIvfkgHk8U7USS7DcayQIVounxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905854; c=relaxed/simple;
	bh=MEHpsXH9lNIJOnJl8LRK8fvASgeNl0B9kl50QUAwWqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nniAgIHEDsJrxyCuQ8I7cNXyqBZ7hguzbf5v3d9PFsxcBjJ3MxNFV5rbbMu9SeLYVnbOgslJhim5Dy+RCAvhFFM3OTBJpunp8wpuHmlGgfpS0eClcgB09MfYTPROV9r8dI8Z27Ivu0a/Gwi5GvVrrV/jq6F+OUeRJwZlsZKwKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vAh2cZmq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777905852; x=1809441852;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=MEHpsXH9lNIJOnJl8LRK8fvASgeNl0B9kl50QUAwWqE=;
  b=vAh2cZmqAEP/fbQjkcvGDiVtwi8Oz8dFL3eSwrjtxeHsFAXQ/00CJhWg
   8xozWbCAd6hg3Se4Z7ALSwPT+rFhl42NkMlIYs90EMdLxlW7HWQw0eva1
   TDg5wVdiehkXrDlcsfXAQTEZSZjWfQ+sFVFN5qExYH/WoDXbYFPisfsHP
   zdonlT/BGaY1FzV9vXoFQCpoZc628NE3k9+EJAS1bZC/ihTLOEbg+iiDD
   1r5SfvoUkSLTD1fefIQ1GT1PY+TieTaR8JPtqeoJ6tNBhODqywkOYl+Bb
   JtER2glL2j0fMBSpuSyJM+72QwRLNXikgZicEpJqKDfjRmZk9iQGD700a
   w==;
X-CSE-ConnectionGUID: f6FNNhZuRiuYZMD8mQLEXA==
X-CSE-MsgGUID: AB2JYIKvQpaCASb5LbruRA==
X-IronPort-AV: E=Sophos;i="6.23,215,1770620400"; 
   d="scan'208";a="57409533"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2026 07:44:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 4 May 2026 07:44:11 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 4 May 2026 07:44:08 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 4 May 2026 16:43:45 +0200
Subject: [PATCH net 4/4] net: sparx5: configure serdes for 1000BASE-X in
 sparx5_port_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260504-misc-fixes-sparx5-lan969x-v1-4-6604306b5743@microchip.com>
References: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
In-Reply-To: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>, Andrew Lunn
	<andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 95EFC4C018C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283892-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,microchip.com:mid]

sparx5_port_init() only invokes sparx5_serdes_set() and the associated
shadow-device enable and low-speed device switch for SGMII and QSGMII.
On any port with a high-speed primary device (DEV5G/DEV10G/DEV25G)
configured for 1000BASE-X the serdes is therefore left uninitialized,
the DEV2G5 shadow is never enabled, and the port stays pointed at its
high-speed device rather than the DEV2G5. The PCS1G block looks
healthy in isolation, but no frames reach the link partner.

Add 1000BASE-X to the check so the same three steps run.

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


