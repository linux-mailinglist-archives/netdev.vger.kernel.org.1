Return-Path: <netdev+bounces-270949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN/+KMhZwmnQbwQAu9opvQ
	(envelope-from <netdev+bounces-270949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:30:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 204993059CB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 198B430242A0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A023DBD5D;
	Tue, 24 Mar 2026 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0AM3DAUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0074A3DCD94
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344102; cv=none; b=feOARemW75b3k/AT5cAnhCPVp1vFqp1uJN0wxxDk5+f8L8gzT0/8tx4JQA6oyZrzOBdkpnuN/K8uSaRnazpOahmuXXMqguWse7ggfd7oUlWERVTcSGk2BArWgL+XHbiykok7jVbu7oxZGG+ijqMNqp7krMY9cZwnT1iM+7KMO6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344102; c=relaxed/simple;
	bh=PK9VmfB/Zm9WB9+I5rhUehsIxk/SExGUW33povYtk+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA15CsQqE9ujQ4W18fvOIrbxFq1CxxSk8pzO0ENkPeFQHTF41juLOlT6rYQlVi1FSoDTiuL9lEEE2x76cJy9QkxIa0zmWTvnfKsS4mMtzWPqzjxqD0PYP9g0p8KJxRg/gK7eMCdLhu67x1VBViUwKpX4EmSkqhbCNaf8/0GzCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0AM3DAUN; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7BAF9C58097;
	Tue, 24 Mar 2026 09:21:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4994F6011D;
	Tue, 24 Mar 2026 09:21:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B977C10451116;
	Tue, 24 Mar 2026 10:21:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774344082; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3fR9TaU7lvH4uvfrULIcHLIjIm0TTYsxcGUZBDQbW9Y=;
	b=0AM3DAUNovS0AoQN8tCoBO5bOV8LDo/FacTUkB56iZvdrUuaPxoPy1Ah89OVi/XSdaT8nb
	FZXbYFiRaV7psWBEFgSjkAutu0QUrRzn6/TcgCvP9W7fmYg526DZobGsn0vrH4MV9+3xS+
	W6+eiefzcn2wPpOOqrvkwBvt0V+eI8MFiYJjgFTpUpF7b7mq6lU4PeBQZAZQdv2yhlL5VW
	ItTEI9zQDsiIZQtLhKDh59bS/Hhvb5vGeFS86ryS6btXPBwvteGyq0NsbZTF+0kf0m9oBM
	YH8Deb/SR9xveifB+KNPKR/JZnRbHovueLqh0Hxm/iyoWvj1EqksvaWP78Ie2Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 1/5] net: stmmac: dwmac-socfpga: Move internal helpers
Date: Tue, 24 Mar 2026 10:20:56 +0100
Message-ID: <20260324092102.687082-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
References: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-270949-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 204993059CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is preparatory work to allow reusing the SGMII configuration helper
and the wrapper to get the interface in the fix_mac_speed() callback.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 5f89fd968ae9..42da73b92ceb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -72,6 +72,18 @@ struct socfpga_dwmac {
 	const struct socfpga_dwmac_ops *ops;
 };
 
+static int socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
+{
+	return dwmac->plat_dat->phy_interface;
+}
+
+static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
+{
+	u16 val = enable ? SGMII_ADAPTER_ENABLE : SGMII_ADAPTER_DISABLE;
+
+	writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
+}
+
 static void socfpga_dwmac_fix_mac_speed(void *bsp_priv,
 					phy_interface_t interface, int speed,
 					unsigned int mode)
@@ -244,18 +256,6 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 	return ret;
 }
 
-static int socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
-{
-	return dwmac->plat_dat->phy_interface;
-}
-
-static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
-{
-	u16 val = enable ? SGMII_ADAPTER_ENABLE : SGMII_ADAPTER_DISABLE;
-
-	writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
-}
-
 static int socfpga_set_phy_mode_common(int phymode, u32 *val)
 {
 	switch (phymode) {
-- 
2.49.0


