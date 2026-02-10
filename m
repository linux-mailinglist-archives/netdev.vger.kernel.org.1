Return-Path: <netdev+bounces-258090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGxWGGM2i2neRgAAu9opvQ
	(envelope-from <netdev+bounces-258090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:45:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F53411B5CC
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5539E300E58F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8AF329E7B;
	Tue, 10 Feb 2026 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gNFqYbHQ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3DE31DD96;
	Tue, 10 Feb 2026 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731104; cv=none; b=OAFgFbNg4H0/c0Sl4gpEZDEtz8T6URBVYAdQDrtt68NUm40f52K1sNUGFSPInvi6QPD/DKjl+p253waDn+UaCgj2f19OUqmPIMt5G++14rvzcrNXnTSzxQ66bchKdS6FnULTNfkIua+USsQ62X87AzH/vsKhrc7YZld+5JKAtnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731104; c=relaxed/simple;
	bh=EhL0tpkBrxubwpdX/Ve5B+6GSp3hJZb9E1BrHeOhcmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=sX+kE/P+bNx2WQSrfhr1YyKCNkG49nhuPwSFheLrvMEuSXMTy7h4bnzCzv/Bh4fFeDYznWmKZ1Sf6UUUBM+GDVLHWont6nz89bwjjaZWtdBGupZ35AAthahvCPz0vXkcm81By2s5v+yMdV9u82kSMQ1p1yRDTSlqC8xmMUY3g2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gNFqYbHQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1770731103; x=1802267103;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=EhL0tpkBrxubwpdX/Ve5B+6GSp3hJZb9E1BrHeOhcmU=;
  b=gNFqYbHQVTnEwrupCjQ5CQKC22c3s8lSWfmqcgMQIOS3fa/6dBYwnBWP
   viTVFS0wADKRFIN7SqzwEq3gpZdevRw5Y+TmkyjYIOzjzeiQKG7iLZq4e
   djhE2K5KbJTNUl/VC/eVqc9iRIx/KpOolEHvQTMaI0+KBl+EUY7ys0hW1
   H2xRXoXhzHb3/PygLPDb8mxK16Jj14I/O3yAaI7z0t80YJ0huwLAfHJ1D
   22pzgHgtBvdq5PcK7Gt7TieMYgBG0gwvGErr3X13Um/QEMhMcquXrZEfm
   FjFFLH3jZjfbya+eFGtO0r3CP3DmfxWhATm5KGGFawIUTmBsowmplxYta
   Q==;
X-CSE-ConnectionGUID: p+szQNDPSrmTr8I0ZeLXsg==
X-CSE-MsgGUID: 21H4pAP7SHi08a/lT8ZIsA==
X-IronPort-AV: E=Sophos;i="6.21,283,1763449200"; 
   d="scan'208";a="52474411"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 06:44:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 10 Feb 2026 06:44:26 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 10 Feb 2026 06:44:24 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 10 Feb 2026 14:44:01 +0100
Subject: [PATCH net] net: sparx5/lan969x: fix DWRR cost max to match
 hardware register width
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260210-sparx5-fix-dwrr-cost-max-v1-1-58fbdbc25652@microchip.com>
X-B4-Tracking: v=1; b=H4sIACA2i2kC/x2MQQqEMAwAvyI5G6gFi/oV8VDaVHOwSiJaEP++Z
 Y8DM/OCkjApTM0LQjcrH7lC1zYQNp9XQo6VwRrrjO0M6uml9Ji4YHxEMBx64e4LpsHFcXApht5
 AzU+hKv3XM2S6YPm+Hx0/ntBvAAAA
X-Change-ID: 20260210-sparx5-fix-dwrr-cost-max-f86d986fdc50
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258090-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: 0F53411B5CC
X-Rspamd-Action: no action

DWRR (Deficit Weighted Round Robin) scheduling distributes bandwidth
across traffic classes based on per-queue cost values, where lower cost
means higher bandwidth share.

The SPX5_DWRR_COST_MAX constant is 63 (6 bits) but the hardware
register field HSCH_DWRR_ENTRY_DWRR_COST is GENMASK(24, 20), only
5 bits wide (max 31). This causes sparx5_weight_to_hw_cost() to
compute cost values that silently overflow via FIELD_PREP, resulting
in incorrect scheduling weights.

Set SPX5_DWRR_COST_MAX to 31 to match the hardware register width.

Fixes: 211225428d65 ("net: microchip: sparx5: add support for offloading ets qdisc")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
index 1231a80335d7..04f76f1e23f6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
@@ -35,7 +35,7 @@
 #define SPX5_SE_BURST_UNIT 4096
 
 /* Dwrr */
-#define SPX5_DWRR_COST_MAX 63
+#define SPX5_DWRR_COST_MAX 31
 
 struct sparx5_shaper {
 	u32 mode;

---
base-commit: 9384a1d1897a809f073a0f8cc252b7a41f9c05ac
change-id: 20260210-sparx5-fix-dwrr-cost-max-f86d986fdc50

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


