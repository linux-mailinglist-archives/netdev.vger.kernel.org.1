Return-Path: <netdev+bounces-278999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Iv2OeS+4GnQlQAAu9opvQ
	(envelope-from <netdev+bounces-278999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:50:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97740D0AC
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FA803031CE5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A609F39FCCA;
	Thu, 16 Apr 2026 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adn6IMBN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936C39D6CA;
	Thu, 16 Apr 2026 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336538; cv=none; b=VhgPXpuWcWWV/tx3N0/6NMyBi2EXFjZRg9qCsDbZcM6t9457zwK2ctSGsbHKp9F4V7tgbmQc6hj+4Hw0QJ+clIs6pPOexl6UAzybK/J5tMVYboV2i8I/gjQBjYtshtYbC775PkpffTl3FKkxDGvW2jMZOcrzClgaEzQ+Siz8c8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336538; c=relaxed/simple;
	bh=wXkfIYpS6b/Rm6RISVw0uD+Z7OPzR8Gm6AByQPr0xkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBGVaWUAE5E8+atCZsfIT7SaGqiski29Uy8/lCB75xefg7jyfruC18cavGk32GHmu2c23yqHyjjopAY1gil8/xOhG/zHVEWvOuQODGeGS6btpoYraZfS5L4kydVwJe3s1hsWmeBjOKURbPqGd+RxncIjunyivS2Kb2KiOtcgn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adn6IMBN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776336537; x=1807872537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wXkfIYpS6b/Rm6RISVw0uD+Z7OPzR8Gm6AByQPr0xkc=;
  b=adn6IMBNgwoE38eXpM/fL5MzHhLTRioM/1ClF1yxwcxqaraiggw54xWl
   rHWOmngT5CwAWJsojVHbrUqvWcI13o28G7l0xWJKy4NGnyE1kfs9MgQlF
   iTGmO/6u1OiSfX0fHWUpDhJ4hnjSiZe/un3rKgmC5AyKOg1e4i/vRYk8r
   RDmltPorebFP4sjNPDhh9k7E2H8PZsVhjTeaZVI4jcINZAYqSAeoCvAew
   yO7Eag+A2PMogHW9OChetZ2ktHtkcjcGiyDoWnseGvD60OKVuRCQwhO2+
   JEQq2OFeygwIZSOQhNYw32gp4AIX9PLe8tXLI5bQHazHmffjGLnShlczF
   g==;
X-CSE-ConnectionGUID: PRX0WXwxTvWAYSZAuSOXHA==
X-CSE-MsgGUID: x0+k3bjFQvuzV4ZuVlo3Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="88410753"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="88410753"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 03:48:56 -0700
X-CSE-ConnectionGUID: EuPlTi58RSGNxq0lcRmGWQ==
X-CSE-MsgGUID: imgnVKh1QGqItlImdg15EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="235076890"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.31])
  by orviesa004.jf.intel.com with ESMTP; 16 Apr 2026 03:48:52 -0700
From: KhaiWenTan <khai.wen.tan@intel.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yoong.siang.song@intel.com,
	hong.aun.looi@intel.com,
	khai.wen.tan@intel.com,
	KhaiWenTan <khai.wen.tan@linux.intel.com>
Subject: [PATCH net,v3 1/1] net: stmmac: Update default_an_inband before passing value to phylink_config
Date: Thu, 16 Apr 2026 18:26:09 +0800
Message-ID: <20260416102609.7953-1-khai.wen.tan@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278999-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 4B97740D0AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: KhaiWenTan <khai.wen.tan@linux.intel.com>

get_interfaces() will update both the plat->phy_interfaces and
mdio_bus_data->default_an_inband based on reading a SERDES register. As
get_interfaces() will be called after default_an_inband had already been
read, dwmac-intel regressed as a result with incorrect default_an_inband
value in phylink_config.

Therefore, we moved the priv->plat->get_interfaces() to be executed first
before assigning priv->plat->default_an_inband to config->default_an_inband
to ensure default_an_inband is in correct value.

Fixes: d3836052fe09 ("net: stmmac: intel: convert speed_mode_2500() to get_interfaces()")
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v3:
  - rebase on the latest net tree (Paolo Abeni)

v2: https://patchwork.kernel.org/project/netdevbpf/patch/20260413020339.68426-1-khai.wen.tan@linux.intel.com/
  - update commit message for better understanding (Russell King)
  - corrected the blamed commit (Russell King)

v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260410020735.327590-1-khai.wen.tan@linux.intel.com/
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 01a983001ab4..ca68248dbc78 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1410,8 +1410,6 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
 	priv->tx_lpi_clk_stop = priv->plat->flags &
 				STMMAC_FLAG_EN_TX_LPI_CLOCKGATING;
 
-	config->default_an_inband = priv->plat->default_an_inband;
-
 	/* Get the PHY interface modes (at the PHY end of the link) that
 	 * are supported by the platform.
 	 */
@@ -1419,6 +1417,8 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
 		priv->plat->get_interfaces(priv, priv->plat->bsp_priv,
 					   config->supported_interfaces);
 
+	config->default_an_inband = priv->plat->default_an_inband;
+
 	/* Set the platform/firmware specified interface mode if the
 	 * supported interfaces have not already been provided using
 	 * phy_interface as a last resort.
-- 
2.43.0


