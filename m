Return-Path: <netdev+bounces-267750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHgMJMF+tWmK1AAAu9opvQ
	(envelope-from <netdev+bounces-267750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:29:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 169A428DADF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D4543036E8D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326492EDD6C;
	Sat, 14 Mar 2026 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="ZNPvi+Mc"
X-Original-To: netdev@vger.kernel.org
Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508C2D8376;
	Sat, 14 Mar 2026 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773502125; cv=none; b=i8V1ymbXEv9IjMhxXK+AhCcRGeHsPZXLhPL87vUd4tbVVSE5mdWlEEvhePEC+oCbAd2l6kXdENw6dVEHCCeDVY4HbnMsJsiAa9/nZLXr1t9MPX7sH7h9+3nVyB6Jgodi9BwCqhUHBYlwV7T1v7FG4LaypJnme3hmq4FBUhs9Hzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773502125; c=relaxed/simple;
	bh=/vy+c1nLswFOkWzuqJsjFYoXMYDn1ssIa4VCRdJjqZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZDwICtU4hxDVLUJUc/7pAuo99ULPpKrWZSZzRs1J0UAbkMu4j45VfhrgfX7IGfo6vLl9j3LDQnHvEppfpyUhHoIZ8G5xUHXj4k+RArj5eClR63Q9uWn3aiXP8bJGFYrqwHg8sO46tQLTvZcAZSnBZ//PaB+irKab76JQO63l5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=ZNPvi+Mc; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:Message-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EgCsQpLfP6jlSC3mUtz80d1LyhN5q7HHT6hn2BMEbcI=; b=ZNPvi+McsNM6sE7cSCcvs2gMnt
	OsbLb7qY/gGb/PN6F/geAZ+HRQmKgclGugspuJIQa16LMG74KvYVkzb9Ikt1ykW4FsJqUoGHOYffM
	BmbysA7+7zM9YaHvTMh2B2IfOxjl2Y2oK4wF43p/3+xeChXWl2dpGzU+nZI6ckmYM8BCyTxjoM62H
	FLFPMVK4/W8RxaLgiHkLeyZ65J7KQKvnG8HEJTv1AwlH8rqqs2lvnLkVCIJnNcXFH29WgItZLjS+W
	CUP3XtsrKfKEfGPM6W07UVbcn2GwfspKJYjg7AjiRJqn/cEtfQRQhgakkzglQGa49doBw6abKTMXM
	hXYDmBfg==;
Received: from user-5-173-16-20.play-internet.pl ([5.173.16.20] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1w1Qur-00000006o6Z-2wCk;
	Sat, 14 Mar 2026 16:28:37 +0100
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Sat, 14 Mar 2026 16:27:46 +0100
Subject: [PATCH] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl>
X-B4-Tracking: v=1; b=H4sIAHF+tWkC/x3MTQqAIBBA4avIrBvQ/ukq0cJqrIHQGCOC8O5Jy
 2/x3guRhCnCoF4Qujly8BmmULDs1m+EvGZDqctWV6bG+7AeheIVhJBEgqDr58qapXONtpDDU8j
 x80/HKaUP7JbUyWQAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773502079; l=1719;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=/vy+c1nLswFOkWzuqJsjFYoXMYDn1ssIa4VCRdJjqZI=;
 b=Cu15vltkrAWQrlPZvWghHLF0X7ub3MupcOdEB2OM0WisVyNFkoVZePcUctt+43i2PwPh4l1Fk
 e83DoBoc1+pApN/haQ4gv2Vm+I4+fIuayVxZpr3tYcRVbiPRIH0qIQa
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[mmpsystems.pl:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[mmpsystems.pl : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.531];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.piekos@mmpsystems.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mmpsystems.pl:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 169A428DADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
-EINVAL via stmmac_do_void_callback(), resulting in a spurious
"Failed to restore VLANs" error even when no VLAN filtering is in use.

Check presence of VLAN hash ops before stmmac_vlan_update().

Fixes: bd7ad51253a7 ("net: stmmac: Fix VLAN HW state restore")
Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
This patch fixes a noisy "Failed to restore VLANs" message on platforms
where stmmac VLAN hash ops are not implemented.
stmmac_vlan_restore() calls stmmac_vlan_update() without checking for
VLAN hash ops presence which results in -EINVAL. 
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6827c99bde8c..bc09439ec00b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6869,6 +6869,9 @@ static int stmmac_vlan_restore(struct stmmac_priv *priv)
 	if (priv->hw->num_vlan)
 		stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
 
+	if (!priv->hw->vlan || !priv->hw->vlan->update_vlan_hash)
+		return 0;
+
 	ret = stmmac_vlan_update(priv, priv->num_double_vlans);
 	if (ret)
 		netdev_err(priv->dev, "Failed to restore VLANs\n");

---
base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
change-id: 20260314-vlan-restore-error-f8b3a1c7f50a

Best regards,
-- 
Michal Piekos <michal.piekos@mmpsystems.pl>


