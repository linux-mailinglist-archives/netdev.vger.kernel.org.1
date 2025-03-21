Return-Path: <netdev+bounces-176709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B29A6B8D7
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB1418983D6
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDE021B9C5;
	Fri, 21 Mar 2025 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CeSI6YTZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46B1FC7D9;
	Fri, 21 Mar 2025 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553318; cv=none; b=JAv/f1+k50vZLOjiZM/P+hSUkfgUw6C0DiZ0wU/z6TFn8wJlHj0+ogva/OVdRwGMfQ7nhWVBC6qv7K0eslq9qhkveZpBdnbbmGyy+8YadEEi9NcDy0ZE0CgtXcXqcwGXPtHn/4VsOxZSDCxOD1+Xl8o1IA6FEcNEDaDbP/iUrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553318; c=relaxed/simple;
	bh=MVSVPmZLeZXiQYxzzG8ovcZb+UVA+GGalY06rOu+Kfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TlRiYDntXyTasRjYlVxyb9WiSXcgqxwP7oyZXOiqj/KT9IYw6OLvmLwgIp3EAUPCh0JYv1nxUeijD1Yb+syAARgaeEhAwJ0pMrJZQgSFb28sy5Ru+AyjZAHYkdWyZq7WJRxNCcJbSmEecglKtY6vAdIbfPryMQnChDVqXDmddU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CeSI6YTZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05FAD432C1;
	Fri, 21 Mar 2025 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742553307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=co8JDmZx4HmArnDvcnRVxtXy60X141/SmNungt+YCYA=;
	b=CeSI6YTZlyjSoGnwVyaPrxNXGMcD0MVY7JCZqknxbNudjZRVwShUwplGqX/Rc6KTLWyad/
	PeMmQE67B3ZVIvVmQkFb/eOeRRoCq+GGLkA1CDqgb+O5VYFg7SVQ3HSfFHIIsetfiZnCwS
	DR0nW7NmN63AbrL/Lc57umqyo4KL4buT+yzTd+/gj5+agAZP66mSZKO6JbN+k83dzse054
	+5JbjHRIDf8xbmvB5IjrGyBCPK8bKqvyuEl9kp6Qt9Otz6uZl9IBvX3R3yX07HBtTHxnPd
	4EHidxqS7qsPpAVfmuE4YL7vMk5XKkIZEmANEoyjRWsSiPIS/ejCrC56+RLvjA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Simon Horman <horms@kernel.org>,
	alexis.lothore@bootlin.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH net-next] net: stmmac: Call xpcs_config_eee_mult_fact() only when xpcs is present
Date: Fri, 21 Mar 2025 11:35:01 +0100
Message-ID: <20250321103502.1303539-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephedtheeufeeutdekudelfedvfefgieduveetveeuhffgffekkeehueffueehhfeunecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Some dwmac variants such as dwmac_socfpga don't use xpcs but lynx_pcs.

Don't call xpcs_config_eee_mult_fact() in this case, as this causes a
crash at init :

 Unable to handle kernel NULL pointer dereference at virtual address 00000039 when write

 [...]

 Call trace:
  xpcs_config_eee_mult_fact from stmmac_pcs_setup+0x40/0x10c
  stmmac_pcs_setup from stmmac_dvr_probe+0xc0c/0x1244
  stmmac_dvr_probe from socfpga_dwmac_probe+0x130/0x1bc
  socfpga_dwmac_probe from platform_probe+0x5c/0xb0

Fixes: 060fb27060e8 ("net: stmmac: call xpcs_config_eee_mult_fact()")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
This targets net-next as the blamed commit is also still in net-next.

 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 7c0a4046bbe3..836f2848dfeb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -524,7 +524,8 @@ int stmmac_pcs_setup(struct net_device *ndev)
 	if (ret)
 		return dev_err_probe(priv->device, ret, "No xPCS found\n");
 
-	xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
+	if (xpcs)
+		xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
 
 	priv->hw->xpcs = xpcs;
 
-- 
2.48.1


