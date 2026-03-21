Return-Path: <netdev+bounces-270171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKNEJPsuvmn3IgMAu9opvQ
	(envelope-from <netdev+bounces-270171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 06:39:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED672E36BF
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 06:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6C8E3034295
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 05:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B803563E1;
	Sat, 21 Mar 2026 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="uneE3rGy"
X-Original-To: netdev@vger.kernel.org
Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E20175A76;
	Sat, 21 Mar 2026 05:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774071531; cv=none; b=ljI4xD0ePwxYUuwl9obC7iie+3cW+5YxosgE9etsL7RerloirE1p1lCRL8jNivyYoBV+jXYNQZN2evZKMrp+rcVcBzxSdMgr+L8k1XDuFoPOaNgqE+E53T5ReKTO5lJprBIKzHvc1zcgayBq6REvHl4JQG4Q7GKAoVMZ/HdZe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774071531; c=relaxed/simple;
	bh=+bvTMvdty1fzgGCGx7v/YOGgwFlkD7szerZ7TPZd6jE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=paL+dAsaAeeQIxXBkd/PNzh4b+jxgRwvqGqYbLSqGABZbSLypR65+iYS/1JislJK/gsFGDsB08MRBB59fss5QpSPzgfiRWx6Aji7pzo9HZpUtkX22SSajSsg0RDwyaXipwYgIXbfmAEInex9uB5JkzZURMxLfQjyQtdNebpvM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=uneE3rGy; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:Message-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cuzcUcquOIpuEvBuH4lStYzlUUTfGnCUE2b66iIEQMo=; b=uneE3rGyjHiN0M6FvRHDM1q/TE
	nMmqUvSuwJnjGmo9uPYMHU7ssNgpGuuJ0sjpe6WYE+Di5tBQ3ToMTk/PF4+KmtGe9Y6GrPghw+HAp
	e675zS5gQwbHU+lYJy/CkXI1RTJorF4AgdVHFeplLtY3JDMGPNq89IUYgwnTvXcH+rdWxhTGITrqH
	dgo0XvYxm3QlPG3UyYviXW8CrJgonUfPh+MEugTtz1qek8r8O7eXa4hsytuRf9uFKSiVRinHNSbKM
	b6Y4ES0532y4N282eMzcGuu/CJ14ndQrfJIhmG526awHyqtRbUEAcelb2m1GksFUj0UfKTterzasg
	KtheNFIg==;
Received: from user-5-173-16-20.play-internet.pl ([5.173.16.20] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1w3p2p-000000088Q7-0S6s;
	Sat, 21 Mar 2026 06:38:43 +0100
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Sat, 21 Mar 2026 06:38:17 +0100
Subject: [PATCH v2] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl>
X-B4-Tracking: v=1; b=H4sIAMguvmkC/32NSw6DMAxEr4K8riscPq264h4VizR1SiR+slFUh
 Lh7Awfo8o1m3mygLIEVHtkGwjFomMYE5pKB6+z4YQzvxGByU+cFlRh7O6KwLpMwssgk6O+vwpK
 7+Sq3kIazsA/fU/psE3fhaK/nR6Qj/auLhISld7Ur2BBVvhmGWVddeNDr3EO77/sPF5qAm7gAA
 AA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Michal Piekos <michal.piekos@mmpsystems.pl>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774071499; l=1877;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=+bvTMvdty1fzgGCGx7v/YOGgwFlkD7szerZ7TPZd6jE=;
 b=zSrlFLj2+YAmXXjeA5B74clu6Ih6A2qDQaIcZg1MC6BKlQ4CyUZM1vm5Wa41N7pbzWysMMasq
 tpBqMbRpWvkCo961IqT5g0j8/EWoyoPl12g+XE65SzpeMFXEXpq+Y2v
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[mmpsystems.pl:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[mmpsystems.pl : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270171-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	FROM_NEQ_ENVFROM(0.00)[michal.piekos@mmpsystems.pl,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mmpsystems.pl:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mmpsystems.pl:email,mmpsystems.pl:mid]
X-Rspamd-Queue-Id: DED672E36BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
-EINVAL via stmmac_do_void_callback(), resulting in a spurious
"Failed to restore VLANs" error even when no VLAN filtering is in use.

Check presence of VLAN HW FILTER flags before stmmac_vlan_update().

Tested on Orange Pi Zero 3.

Fixes: bd7ad51253a7 ("net: stmmac: Fix VLAN HW state restore")
Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
This patch fixes a noisy "Failed to restore VLANs" message on platforms
where stmmac VLAN hash ops are not implemented.
stmmac_vlan_restore() calls stmmac_vlan_update() without checking for
VLAN hash ops presence which results in -EINVAL. 
---
Changes in v2:
- Replace check for hash ops with check for HW FILTER flags
- Link to v1: https://lore.kernel.org/r/20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6827c99bde8c..cfc0ce9cec9c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6863,7 +6863,8 @@ static int stmmac_vlan_restore(struct stmmac_priv *priv)
 {
 	int ret;
 
-	if (!(priv->dev->features & NETIF_F_VLAN_FEATURES))
+	if (!(priv->dev->features &
+	      (NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)))
 		return 0;
 
 	if (priv->hw->num_vlan)

---
base-commit: 42bddab0563fe67882b2722620a66dd98c8dbf33
change-id: 20260314-vlan-restore-error-f8b3a1c7f50a

Best regards,
-- 
Michal Piekos <michal.piekos@mmpsystems.pl>


