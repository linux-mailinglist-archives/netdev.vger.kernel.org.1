Return-Path: <netdev+bounces-286950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBqFN42uAmpTvgEAu9opvQ
	(envelope-from <netdev+bounces-286950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:37:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC035199DA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D45503073775
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C89C3385A1;
	Tue, 12 May 2026 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j8SrvDb5"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9C331A66;
	Tue, 12 May 2026 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778560441; cv=none; b=BWV8rslLc/cg2Y5n3gr3GwA78FYOzHHuxUZg+uPQhuvVNXwTwbPaVURowwBNP7fLQoJv7Ls53I/Pce5JzHAdO2XeQFWPt4go4csjLRKhwMmelFpXz9UmM8DU1HPCKRVMNa1kgsXOmkxkAoKf8JvaHnzuaJK971Yjud+jeZKTxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778560441; c=relaxed/simple;
	bh=zhnYMihbLOfkVEZ4q/kjQvAho+Gw9BO7XUM9RnKRnI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwTNsyxHl8CLYQoUS3sHOqB4EcOYGqLe1D3mbuqMiyYh9Eu02hmr2OO8gQGXa9RdtCUOHxFMAeH9R36vxx68c7yx4mh6f84xDONQPq+tc6mrlF85hAzZorBUMymhUcmYncYEVRNMP+4ZKPTc1lEG3hstdsPbDYbLx2pMQ7IQNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j8SrvDb5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778560434;
	bh=zhnYMihbLOfkVEZ4q/kjQvAho+Gw9BO7XUM9RnKRnI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j8SrvDb5jKutc+aAOgfmB6DpL7/FAgUUqb2Ym+CI4pqEY+6fPvqju3LEDcROXR6c8
	 GhbwdMidkyNuvLF0kx7oo7Oe7E1y/NMQEpr7Sc16o1lyMtBzHxM/CcdqWfmzx9E6wN
	 X8/l9A8ACpqJZZar097p9p7zPiCPuOEv4Q9wYgh/YKgfURQvCNz6s9JhVMoAZKzzti
	 OAZ4Er/PMLtDh1S44tjRe7TG4wpmkzwEq3hkzYan/iTftYUoiBsBwGYjnq6zAkWLsn
	 Sk9k0jTeK8U6pulzV68NXw595XlzaSNEszybKKbzjCZCeuHfquF1uO/n8Ana5Ya4mH
	 2+StPZCfHecUQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1275917E38D0;
	Tue, 12 May 2026 06:33:53 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 12 May 2026 06:33:23 +0200
Subject: [PATCH net-next v3 6/6] net: phy: air_an8801: ensure maximum
 available speed link use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-add-airoha-an8801-support-v3-6-1edb34e363ae@collabora.com>
References: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
In-Reply-To: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com, 
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778560425; l=2139;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=zhnYMihbLOfkVEZ4q/kjQvAho+Gw9BO7XUM9RnKRnI8=;
 b=d9T+rQISrxFOFaBe5BEpNIhybPQ7T/mE0r+jxzAnoMd/s5SMIVX9pDgBRUQduTC/sMI1uMTx0
 z1/pbJUG4CxAmJ3BnRae6UjsTcN/Lwq48VnZL74ZQIstjStA7rbhbbM
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Queue-Id: 8CC035199DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286950-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.64.0.131:received,100.90.174.1:received,148.251.105.195:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:mid,collabora.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

To ensure that the Airoha AN8801R PHY uses the maximum available link
speed, an additional register write is needed to configure the function
mode for either 1G or 100M/10M operation after link detection.

So, in air_an8801 driver, implement a custom read_status callback, that
after genphy_read_status determines the link speed, sets the bit 0 of
the link mode register (REG_LINK_MODE) if the detected speed is 1Gbps,
or unsets it otherwise.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/net/phy/air_an8801.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/phy/air_an8801.c b/drivers/net/phy/air_an8801.c
index a0f164cbf92b..af46951b1a33 100644
--- a/drivers/net/phy/air_an8801.c
+++ b/drivers/net/phy/air_an8801.c
@@ -964,6 +964,36 @@ static int an8801r_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int an8801r_read_status(struct phy_device *phydev)
+{
+	int prev_speed, ret;
+	u32 val;
+
+	prev_speed = phydev->speed;
+
+	ret = genphy_read_status(phydev);
+	if (ret)
+		return ret;
+
+	if (phydev->link && prev_speed != phydev->speed) {
+		/* Ensure that PHY switches to 1G speed when available,
+		 * by configuring the function mode for either 1G or 100M/10M
+		 * operation.
+		 * Therefore, set the link mode register, after read_status
+		 * determines the link speed.
+		 */
+		val = phydev->speed == SPEED_1000 ?
+		      AN8801_BPBUS_LINK_MODE_1000 : 0;
+
+		return an8801_buckpbus_reg_rmw(phydev,
+					       AN8801_BPBUS_REG_LINK_MODE,
+					       AN8801_BPBUS_LINK_MODE_1000,
+					       val);
+	}
+
+	return 0;
+}
+
 static int an8801r_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -1061,6 +1091,7 @@ static struct phy_driver airoha_driver[] = {
 	.suspend		= an8801r_suspend,
 	.resume			= an8801r_resume,
 	.config_aneg		= genphy_config_aneg,
+	.read_status		= an8801r_read_status,
 	.config_intr		= an8801r_config_intr,
 	.handle_interrupt	= an8801r_handle_interrupt,
 	.set_wol		= an8801r_set_wol,

-- 
2.54.0


