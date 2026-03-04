Return-Path: <netdev+bounces-263621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lLx6BJndp2kMkwAAu9opvQ
	(envelope-from <netdev+bounces-263621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:22:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F70D1FB892
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E8C3016C83
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78A351C2A;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoBZNYir"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04A308F1D;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608917; cv=none; b=km1vj2gfJSWRjcwda/bDxuM7QJ2wqW+3XELB+Pnd6X+NTG3Dv7nc1xarFTGIUCAZROQm/vmR74ceTkO59SaJ0sgQRSk+FGVOq3AgSJ7tveVUV+Amg3D3M3d8S+SysS4p/Imeo6jFixRTeM2qMWhCBV5Z8ayq6ZK67wvaH0TrDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608917; c=relaxed/simple;
	bh=T3WU2tud5f1zj+ddXQ+KnrQnyM/64IFh8UPNBQDSfuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NHkTAVXJsseuM9DhwOIxeHAiTPsi2pGug9H9lSfrKV3p9lG37R0woEgdxAX+swvJiN8qeezXwIRXPei/TaLnjVKJ0psIGKevEKOUFqNLRnE5vdSqbwkUFFNYS88iUDPd7U3qdudE6f8J7lLz0YORNXwPUMbyeQo/5KpO0b9+9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoBZNYir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 886E1C2BC87;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772608917;
	bh=T3WU2tud5f1zj+ddXQ+KnrQnyM/64IFh8UPNBQDSfuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VoBZNYirhZe9+QoObwliEWqWPgfrKJcWhfW/GGBTmsNC+mkwFvoCW2UHYeQKalZHS
	 dlQnjwb8M13ECGhkHXu5QvtD9mTVy+ggnOtnmEQo2/Qa2SiCG4Dcp0+MfV7WJF/kQB
	 Nu7GFOz4Da7jlbH/zb0VOCGEV2lVwcMnLwyZ6WkqjFxiJqU+SxEVXmuTAWTyvcHOgc
	 AWNgoGKPeWMpt2GbcpBD7EGdZ1siRpC0xy39VP58GXpb4U4tMh1tZSyFYRaG2+aVg9
	 oPsO1WZCUnAj8ZzcIAT9wI6U9vFmCWi/L+f1ILWjwEGMRPcag5afNZftDG2NVuhx17
	 agZ0meo9UMOEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E774EDEC12;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Wed, 04 Mar 2026 08:21:19 +0100
Subject: [PATCH v2 1/2] igb: fix typos in comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-1-b6a9f1d336ff@gmail.com>
References: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-0-b6a9f1d336ff@gmail.com>
In-Reply-To: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-0-b6a9f1d336ff@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joe Damato <joe@dama.to>, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772608916; l=3309;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=W8usg+ZoKVYiNljk2RopBqbmBi4ULLILAmorANsna7E=;
 b=mWsgU8UroMDtAhcc+i0U1y93b4NgwW2F8a1QjPmUAoBZhfQ4xAKNNy1IIyRqqLwXT2Zrn43Iz
 55PmyxL2FMaCQfxLF6rSXrZX5R0+kHU0ZvbtW7mFe5CReLXI3w1EHXF
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reply-To: maximilianpezzullo@gmail.com
X-Rspamd-Queue-Id: 4F70D1FB892
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263621-lists,netdev=lfdr.de,maximilianpezzullo.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,dama.to,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[maximilianpezzullo@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Fix spelling errors in code comments:
 - e1000_nvm.c: 'likley' -> 'likely'
 - e1000_mac.c: 'auto-negotitation' -> 'auto-negotiation'
 - e1000_mbx.h: 'exra' -> 'extra'
 - e1000_defines.h: 'Aserted' -> 'Asserted'

Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
 drivers/net/ethernet/intel/igb/e1000_defines.h | 2 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c     | 2 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.h     | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index fa028928482f..7e6f9aa2d57b 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -442,7 +442,7 @@
 /* Interrupt Cause Set */
 #define E1000_ICS_LSC       E1000_ICR_LSC       /* Link Status Change */
 #define E1000_ICS_RXDMT0    E1000_ICR_RXDMT0    /* rx desc min. threshold */
-#define E1000_ICS_DRSTA     E1000_ICR_DRSTA     /* Device Reset Aserted */
+#define E1000_ICS_DRSTA     E1000_ICR_DRSTA     /* Device Reset Asserted */
 
 /* Extended Interrupt Cause Set */
 /* E1000_EITR_CNT_IGNR is only for 82576 and newer */
diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index fa3dfafd2bb1..2bcce6eef0c7 100644
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
index 178e60ec71d4..9e44527f5eea 100644
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
index c8638502c2be..cf4e5d0e9417 100644
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



