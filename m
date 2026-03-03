Return-Path: <netdev+bounces-263429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFxTLuRUp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:38:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E61F7A4C
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DED0A3064EA5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF493932DE;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbnFiomA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CDA3932D2;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573920; cv=none; b=fSjKMDNOimVM80UJjFwmtimHNgMHOE00V7xQG8rFPZj30dk0fiNTxLVRUNF17ZhBIOhU1DHRE1avbqa+U50/9l3M1svWXgwYD9ymuoPJKaLiB5KlTeBQiGzDDKdhZ9vUSi/rFTA/rc+0ZRfbrxHyBRU9s8w+wUJrgYvZX7XTWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573920; c=relaxed/simple;
	bh=ncE0CctbXbxGWCznoqU5F/hOD+FPfa97eLIKp7komgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LUogGqF5+i/Zg2MZebvLrkxUGxD4Ltmh70SH63UzFGwaJwouBTVTVZlX18RfCVeWODjmW5LqV+1JrCwSCkswEuNh2HKOgD+CMPxw+WTpHOl+OETJsCojX2hbI4cUnp0hytumLyIl52P5n+hE3FMqETlZvZ7OUQACQzYfZVzOpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbnFiomA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F4A5C2BC87;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573920;
	bh=ncE0CctbXbxGWCznoqU5F/hOD+FPfa97eLIKp7komgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sbnFiomABj/XjQvcSLjqFae8r0RjcI+S8ubExK+QDP4GkOHMIB3OfgSVwJrbM6jSu
	 xq5j69eJpOBrBiavGLFlVeOViMxIEKYDWZGjmme5sJlD0iijoSOf8TAziRwY4hPrmw
	 9kPg10/nPvlOgpqdgk70IDWPN3JqiA1ykrANz/HW9I3W59ywwniCrkhapDSECNOOfH
	 Ps1X23UijDyZms5XXlZRf3Vx3mOm2/M37Oh9HihEPfD8pOdH0cDwaakXB98/YnxdkW
	 dZcKNb23a+kaZXDadD5Pta8wpp0qTp3RI1PfRR2wymWH1VYgjCcRgCUGSs3ncReP/s
	 S7J39mveIaJiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCECEDEBF7;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Tue, 03 Mar 2026 22:38:20 +0100
Subject: [PATCH 1/2] igb: fix typos in comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-master-v1-1-f180b1ad98b5@gmail.com>
References: <20260303-master-v1-0-f180b1ad98b5@gmail.com>
In-Reply-To: <20260303-master-v1-0-f180b1ad98b5@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772573919; l=2465;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=AFngQ6STbyhDDwY5fngMlDBMLtfCdqw2s6bzouZtL2E=;
 b=qscFiBIdFr8gVcycZYKsdxDbGRaYYhZi4k7TpaBmZU7jRhh6Nk2lxZlcIWLxJ7Zpg/q6WksS8
 hzVQxLU3m3aCckvy74Hmcjb2k2p2TNMacZ7ggzkVt5InwkGRXoR1osh
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reply-To: maximilianpezzullo@gmail.com
X-Rspamd-Queue-Id: 275E61F7A4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263429-lists,netdev=lfdr.de,maximilianpezzullo.gmail.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[maximilianpezzullo@gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Fix spelling errors in code comments:
 - e1000_nvm.c: 'likley' -> 'likely'
 - e1000_mac.c: 'auto-negotitation' -> 'auto-negotiation'
 - e1000_mbx.h: 'exra' -> 'extra'

Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
 drivers/net/ethernet/intel/igb/e1000_mac.c | 2 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.h | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index fa3dfafd2..2bcce6eef 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -1581,7 +1581,7 @@ s32 igb_disable_pcie_master(struct e1000_hw *hw)
  *  igb_validate_mdi_setting - Verify MDI/MDIx settings
  *  @hw: pointer to the HW structure
  *
- *  Verify that when not using auto-negotitation that MDI/MDIx is correctly
+ *  Verify that when not using auto-negotiation that MDI/MDIx is correctly
  *  set, which is forced to MDI mode only.
  **/
 s32 igb_validate_mdi_setting(struct e1000_hw *hw)
diff --git a/drivers/net/ethernet/intel/igb/e1000_mbx.h b/drivers/net/ethernet/intel/igb/e1000_mbx.h
index 178e60ec7..9e44527f5 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mbx.h
+++ b/drivers/net/ethernet/intel/igb/e1000_mbx.h
@@ -30,7 +30,7 @@
 /* Indicates that VF is still clear to send requests */
 #define E1000_VT_MSGTYPE_CTS	0x20000000
 #define E1000_VT_MSGINFO_SHIFT	16
-/* bits 23:16 are used for exra info for certain messages */
+/* bits 23:16 are used for extra info for certain messages */
 #define E1000_VT_MSGINFO_MASK	(0xFF << E1000_VT_MSGINFO_SHIFT)
 
 #define E1000_VF_RESET		0x01 /* VF requests reset */
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
index c8638502c..cf4e5d0e9 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -405,7 +405,7 @@ s32 igb_read_nvm_eerd(struct e1000_hw *hw, u16 offset, u16 words, u16 *data)
  *  Writes data to EEPROM at offset using SPI interface.
  *
  *  If e1000_update_nvm_checksum is not called after this function , the
- *  EEPROM will most likley contain an invalid checksum.
+ *  EEPROM will most likely contain an invalid checksum.
  **/
 s32 igb_write_nvm_spi(struct e1000_hw *hw, u16 offset, u16 words, u16 *data)
 {

-- 
Git-155)



