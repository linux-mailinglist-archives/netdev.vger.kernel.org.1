Return-Path: <netdev+bounces-256230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LyJAYPIgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:05:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5128FD74BC
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4C763120451
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D739B4B7;
	Tue,  3 Feb 2026 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mV6aF2ti"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB839A800
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112890; cv=none; b=rgxheS5zWEpZWUBa51pqzR7xN2N2Tq2gboriVyATQjaLs5g7LQ+VrSO0QNOY29tFG/Dl9kvdwjU/xB1TsoxVutWtTJtFfmOIEdr2xQFK2+gg0ejzMBZBzEsckfTjWh4SiTJUz3mV8erF37I+ELeafzH5ESLr+4+sl/F52p9+Rb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112890; c=relaxed/simple;
	bh=HeVWllMkts1oBkfHBQeLEyeUDCQottpKrjRt9FKIeck=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Jz0iSOBzn11JjzgIj8XD9B34EL72LYmhGd+xKG5YXjKAC80/5lXJU8yNuFi91R0R4aySS0GpS5GG9c8cK5hdxvrWJck5rihFATtBZRgHmHbTUYTmWn+qd50TmXfM5y98hkCjmOpgiQsapC0op2oa81sUCRE0iJCuM+cAq1N2okY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mV6aF2ti; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MYFlSK6uEYjArH0tobsWoO8ZoSVzbZj76ucnVVcsoLM=; b=mV6aF2timT0QAo7ORy2SYdYhR3
	wUgUSHNRG56ABCdbtQIrmcrOLqoGc8g1VY5oXPd1OgxndubvjKLnakB4EdFrEo+e4DdUCGWXI8lxi
	eGrQLd9KO51hrcz+M6g1jlIjEF0M2oX6bjRZep5p6CnS0ckT/uHob25KQ6ePjVgm0lX0C9ZcjroJF
	Vyo9n28Rkm8jogPGoJrL37numtpayNAob2jwl9Jwf5XTSTOfvIHtYjKWXL0YLcsaNZG1nFnvZDCKF
	OC9E8k4IhYiDmz5jSpgwiF+7l11ZtvJByVLZl0STq/WPzGhXR+3TIiPq1xnbYUAKIs4TD02uIsf9s
	ws5iR2pQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40614 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vnDDk-000000004ww-1sEp;
	Tue, 03 Feb 2026 10:01:20 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vnDDj-00000007Xx3-2xZ0;
	Tue, 03 Feb 2026 10:01:19 +0000
In-Reply-To: <aYHHWm5UkD1JVa7D@shell.armlinux.org.uk>
References: <aYHHWm5UkD1JVa7D@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/4] net: stmmac: add state tracking for legacy
 serdes power state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vnDDj-00000007Xx3-2xZ0@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Feb 2026 10:01:19 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256230-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5128FD74BC
X-Rspamd-Action: no action

Avoid calling the serdes_powerdown() method if we have not had a
preceeding successful call to the serdes_powerup() method. This
avoids unbalancing refcounted resources that may be used in the
these platform glue serdes methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 012b0a477255..5bd97aaaba86 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -303,6 +303,7 @@ struct stmmac_priv {
 	bool eee_enabled;
 	bool eee_active;
 	bool eee_sw_timer_en;
+	bool legacy_serdes_is_powered;
 	unsigned int mode;
 	unsigned int chain_mode;
 	int extend_desc;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 93d18709bc13..9efdde915229 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -884,8 +884,10 @@ static void stmmac_release_ptp(struct stmmac_priv *priv)
 
 static void stmmac_legacy_serdes_power_down(struct stmmac_priv *priv)
 {
-	if (priv->plat->serdes_powerdown)
+	if (priv->plat->serdes_powerdown && priv->legacy_serdes_is_powered)
 		priv->plat->serdes_powerdown(priv->dev, priv->plat->bsp_priv);
+
+	priv->legacy_serdes_is_powered = false;
 }
 
 static int stmmac_legacy_serdes_power_up(struct stmmac_priv *priv)
@@ -898,6 +900,8 @@ static int stmmac_legacy_serdes_power_up(struct stmmac_priv *priv)
 	ret = priv->plat->serdes_powerup(priv->dev, priv->plat->bsp_priv);
 	if (ret < 0)
 		netdev_err(priv->dev, "SerDes powerup failed\n");
+	else
+		priv->legacy_serdes_is_powered = true;
 
 	return ret;
 }
-- 
2.47.3


