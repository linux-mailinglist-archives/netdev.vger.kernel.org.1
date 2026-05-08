Return-Path: <netdev+bounces-285701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IhANpWT/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:41:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 507244F326B
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B32FD30AAE40
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574083806D5;
	Fri,  8 May 2026 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x1YchZMb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C975736E49B;
	Fri,  8 May 2026 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225771; cv=none; b=m2aPQ3Pbcm4HPiWj/GyHsvw11mJW4jD6zHdZFbavJbvil5/sypT3reFp0wqwN9kRUFLLkRV4ty16pf4DihM/NLlHWXsWYIBssdqdMgOgS8uZSjtLg5AQzN2uQK/ZyrOA6yYr0CEUpykZoJOJ9g0HgtMxLtCn5/XqRppqCBeayJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225771; c=relaxed/simple;
	bh=aEVxBzQijPj9PRsFyC76Lsq/Pj8h04R9UN1sWdxuvLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=k4ErGm8Gjojs4VWw2HSYsQgn/UZjBa+SXfsKb66q7UQ01jboMnNBcOorf16RWrsxWdgF5v6DCgOgmZI1Yy2GZZ8az/tVucWPowUVDUxBvSHXLUHh0Cr57gilCSpl78oqVmemi1dEvpYeL7vC/HoeDtKu8894yQyP3FWZ/GPoNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x1YchZMb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778225769; x=1809761769;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aEVxBzQijPj9PRsFyC76Lsq/Pj8h04R9UN1sWdxuvLM=;
  b=x1YchZMbJ5zKnF1e/UvbxCk3dVQVKG+JWPBIjgi9NyAe1XJtDtCYYx8H
   QoWScjQTryfmsopDjLo7k3p9SUZVBxx1426kWt/unOTx5EWidmXJ/DIow
   CeEGvjzt3mHIntDYoODPZbpRj311GxFKNJJien+sfFMr+Ma81sG9PHvqn
   6J3h7FsKopwLJ65XbZUgfXnieTRJe8HJu2RSw4vU0gqVVriZg9OrWZadp
   Y2jF+bq99AROI0GT83P3DfASlADVhHU5QC6wjLlosj0hBrbKuOWkVsFtZ
   DNONDvmACbf0zgSH55lVeFte5u0VRIbyPACA7xdzcG+iCN/Jjb3Aa/iQh
   w==;
X-CSE-ConnectionGUID: 04CrYwjMRBu/p5E9vZKUNA==
X-CSE-MsgGUID: /RHntvoyQ865QM2P2applA==
X-IronPort-AV: E=Sophos;i="6.23,223,1770620400"; 
   d="scan'208";a="224455766"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:36:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Fri, 8 May 2026 00:36:08 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 8 May 2026 00:36:05 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 8 May 2026 09:35:31 +0200
Subject: [PATCH net-next v4 07/13] net: lan966x: clear FDMA interrupt
 stickies after switch reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260508-lan966x-pci-fdma-v4-7-14e0c89d8d63@microchip.com>
References: <20260508-lan966x-pci-fdma-v4-0-14e0c89d8d63@microchip.com>
In-Reply-To: <20260508-lan966x-pci-fdma-v4-0-14e0c89d8d63@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 507244F326B
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
	TAGGED_FROM(0.00)[bounces-285701-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Action: no action

When in PCI mode, the GCB soft reset issued by the reset controller
can latch spurious bits in the FDMA error stickies. The latched bits
sit in FDMA_INTR_ERR until the FDMA IRQ is requested later in probe,
at which point the handler fires immediately and WARNs.

Clear FDMA_ERRORS, FDMA_INTR_ERR and FDMA_INTR_DB right after the
switch reset so the FDMA comes out clean and the IRQ handler does not
see ghost errors on probe.

The clear runs on both the PCI and platform paths. On the platform
path it has no effect — there are no spurious stickies to clear — but
keeping it unconditional avoids a PCI-specific code path here.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 9f69634ebb0a..b3701953b090 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1064,6 +1064,15 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
 
 	reset_control_reset(switch_reset);
 
+	/* When in PCI mode, the GCB soft reset issued by the reset
+	 * controller can latch spurious bits in the FDMA error stickies.
+	 * Clear them before request_irq hooks up the FDMA IRQ line,
+	 * otherwise the handler fires immediately on probe.
+	 */
+	lan_wr(lan_rd(lan966x, FDMA_ERRORS),   lan966x, FDMA_ERRORS);
+	lan_wr(lan_rd(lan966x, FDMA_INTR_ERR), lan966x, FDMA_INTR_ERR);
+	lan_wr(lan_rd(lan966x, FDMA_INTR_DB),  lan966x, FDMA_INTR_DB);
+
 	/* Don't reinitialize the switch core, if it is already initialized. In
 	 * case it is initialized twice, some pointers inside the queue system
 	 * in HW will get corrupted and then after a while the queue system gets

-- 
2.34.1


