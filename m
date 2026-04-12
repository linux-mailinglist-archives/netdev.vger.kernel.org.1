Return-Path: <netdev+bounces-277754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9/arCz1b22keAwkAu9opvQ
	(envelope-from <netdev+bounces-277754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 10:43:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFBE3E31D5
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 10:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADA4D3009CF7
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E8030AACB;
	Sun, 12 Apr 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zah5asWQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B9212548
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775983417; cv=none; b=usfrg9a7CGqVO3JqlRbo2St4iesh6SNko2tFuWoDzc5TC1C5SPYqoEvzZ7QIJUiM3a0kqutjUi00cHgwgjLk50BON4hgr6Z5jp1DeK5EYrlp1l6efYbSWtj/O5ZIPRPZM69SL69jKeuuj05s8g6hb/hI4ln+qClTEsopErRmglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775983417; c=relaxed/simple;
	bh=fR4xkjuGCLJHBTxO040OymgXA4yd4dowEx+1+ardsFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZnKmgTBTK5COhWaBU/TdGcdroiqlzv6AeIblztrEFJSw+3+/RMkeaiiI2qsLcid9Z9dFBubxCJVa4I6Ow9NgHa+6SW4bcZ/hsCBW6b+9CwRAL4OmegcvEUg2Z2PmQ39oLVMTDbLe3U621CsPIGruTH163DJoX/P/AlTJreVEgBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zah5asWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9979BC19424;
	Sun, 12 Apr 2026 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775983417;
	bh=fR4xkjuGCLJHBTxO040OymgXA4yd4dowEx+1+ardsFU=;
	h=From:Date:Subject:To:Cc:From;
	b=Zah5asWQkPVZs3mMcEZP9qbES6XbPKDeeMYD2w7o10qTmltxV40RcjW1yVyoHD5YZ
	 nBrDZNGE5gic4YinYkAhidQpNPeHy7qZQ5cZpSYOh7Yn/61G273T/Sshuvkt8Yhx9i
	 XlO/mecZ9Tq0cqlu+mh1UwD+c/QuWaIpYdHrs/P2/edmSEcxAFdPp+KG9EZjeDBP+W
	 sFDWim3SgXBasfab/1Qtr3bQV6ACkYokB9JtjgI3fOpu70T2lHdi04Qu+jFwfFcLRL
	 igaIYmbbrnn3d8zrnkXop/39ZPNxknhn8JuhVDNo85pMl0qfcuXyz5K1hBvlY2sNSS
	 gI0TRPM7+8o7w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 12 Apr 2026 10:43:26 +0200
Subject: [PATCH net] net: airoha: Add missing PPE configurations in
 airoha_ppe_hw_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-airoha_ppe_hw_init-missing-bits-v1-1-06ac670819e3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQrCMBBG4auUWTuQRBH0KiJhbMbmX5iGTFCh9
 O4Gl9/mvY1MG9ToOm3U9A3DWgb8YaI5S1mUkYYpuHB2Jx9Y0NYssVaN+RNR0PkFM5SFH+jGx+S
 chHCRNHsaldr0ie//cKOine77/gO/4QwPdgAAAA==
X-Change-ID: 20260412-airoha_ppe_hw_init-missing-bits-3d00a229adc1
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277754-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AFBE3E31D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the following PPE configuration in airoha_ppe_hw_init routine:
- 6RD hw offloading is currently not supported by Netfilter flowtable.
  Disable explicitly PPE 6RD offloading in order to prevent PPE to learn
  6RD flows and eventually interrupt the traffic.
- Add missing PPE bind rate configuration for L3 and L2 traffic.
  PPE bind rate configuration specifies the pps threshold to move a PPE
  entry state from UNBIND to BIND. Without this configuration this value
  is random.
- Set ageing thresholds to the values used in the vendor SDK in order to
  improve connection stability under load and avoid packet loss caused by
  fast aging.

Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index c2c32b6833df..62cfffb4f0e5 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -111,13 +111,13 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 		airoha_fe_rmw(eth, REG_PPE_BND_AGE0(i),
 			      PPE_BIND_AGE0_DELTA_NON_L4 |
 			      PPE_BIND_AGE0_DELTA_UDP,
-			      FIELD_PREP(PPE_BIND_AGE0_DELTA_NON_L4, 1) |
-			      FIELD_PREP(PPE_BIND_AGE0_DELTA_UDP, 12));
+			      FIELD_PREP(PPE_BIND_AGE0_DELTA_NON_L4, 60) |
+			      FIELD_PREP(PPE_BIND_AGE0_DELTA_UDP, 60));
 		airoha_fe_rmw(eth, REG_PPE_BND_AGE1(i),
 			      PPE_BIND_AGE1_DELTA_TCP_FIN |
 			      PPE_BIND_AGE1_DELTA_TCP,
 			      FIELD_PREP(PPE_BIND_AGE1_DELTA_TCP_FIN, 1) |
-			      FIELD_PREP(PPE_BIND_AGE1_DELTA_TCP, 7));
+			      FIELD_PREP(PPE_BIND_AGE1_DELTA_TCP, 60));
 
 		airoha_fe_rmw(eth, REG_PPE_TB_HASH_CFG(i),
 			      PPE_SRAM_TABLE_EN_MASK |
@@ -145,7 +145,15 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			      FIELD_PREP(PPE_DRAM_TB_NUM_ENTRY_MASK,
 					 dram_num_entries));
 
+		airoha_fe_rmw(eth, REG_PPE_BIND_RATE(i),
+			      PPE_BIND_RATE_L2B_BIND_MASK |
+			      PPE_BIND_RATE_BIND_MASK,
+			      FIELD_PREP(PPE_BIND_RATE_L2B_BIND_MASK, 0x1e) |
+			      FIELD_PREP(PPE_BIND_RATE_BIND_MASK, 0x1e));
+
 		airoha_fe_wr(eth, REG_PPE_HASH_SEED(i), PPE_HASH_SEED);
+		airoha_fe_clear(eth, REG_PPE_PPE_FLOW_CFG(i),
+				PPE_FLOW_CFG_IP6_6RD_MASK);
 
 		for (p = 0; p < ARRAY_SIZE(eth->ports); p++)
 			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),

---
base-commit: 02f72964395911e7a09bb2ea2fe6f79eda4ea2c2
change-id: 20260412-airoha_ppe_hw_init-missing-bits-3d00a229adc1

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


