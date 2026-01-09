Return-Path: <netdev+bounces-248410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A2D083DA
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB28730312DE
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05BB3590BB;
	Fri,  9 Jan 2026 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="b4et7jNl"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B47332EB8;
	Fri,  9 Jan 2026 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951358; cv=pass; b=emEnqtWfoSskWkHdhfDX30fhnMMYg1D9GR6IXT9cf5wbwnJbb3tgVJZFe/h8bhgy2Dn+TD0UFqPup9f5m21xi1BjH+g8pFp3HAga0a80sCva80eIc25ShVKLEy0EuS+3uJDdywnckGIPaP8P2SwJkeLXyHe5G05pPJhzkIE71GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951358; c=relaxed/simple;
	bh=FjAjqaHilq3EZcDP2UV2+kFI+T5O1Vx9la2NeovXlog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIKhFohHweM3pme3ehw+oUMzGh+LE69jzNgMo/Y+abX/PAxSYZzhZHuHat7mqw0AH9qveTFWaboB4bPkVWWzHuydLHVQXAwZ9tHznM4l1XVpOZvIdQSsbHeLGRXrd6sE3l0rcZTOiDwe5Egt6N67a0/MK+d9JXkfTrtXeLeN0Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=b4et7jNl; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1767951319; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eCaaSRvkJjQAow+e/0HdWZhGF4NcUnm2E4rg44TePVxJkaC6L/dD41PoRitX0yiXrUfwhEKdxsEUFnjbmudvziIhCppXgFJWkhS+5grrrjIDxqGgpkI37Ht+Dr/D8tmPRiANJ78xkAi83ti5Jb5oX2MZIEZrjWPJ6xR7MjBCNhQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767951319; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AJiUi0vgyPXUZGcPlj9tYD4kFQD9YLQA3gmxYQ9BkRA=; 
	b=PRRtsIz8x95a12uEh1JKyNPAQv7lNymkZDLFgP/Hs5gJpR2sh2k7sbDXVxmvg1fH1Q7T3yV9edhmsdYtQO7umFPCpiZmTbpDppw/PW5JpU+0mInljYSf3hh81NrLFWPWL9Wpolq2SEd9+HWGDZU8L0PY3b4EI+99a3ik7PoXn/o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767951319;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AJiUi0vgyPXUZGcPlj9tYD4kFQD9YLQA3gmxYQ9BkRA=;
	b=b4et7jNlNMrXeD53Oix1Sl0Mn6PaOaAfK+c/xS1xzUAYnmXNR+2MKbDJGmHm2F6G
	B1nZvRoUXUgj4fDw2B29KLGau0r0aBvC74JoPpcv0PcX48NlgjjuKbWvhzxOFPkcwBw
	NFUhWXTyN5gDhCcR8HBem35IooMi5gemuTFofVpE=
Received: by mx.zohomail.com with SMTPS id 1767951317965832.252306704789;
	Fri, 9 Jan 2026 01:35:17 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <me@ziyao.cc>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RESEND net-next v6 1/3] net: phy: motorcomm: Support YT8531S PHY in YT6801 Ethernet controller
Date: Fri,  9 Jan 2026 09:34:44 +0000
Message-ID: <20260109093445.46791-3-me@ziyao.cc>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109093445.46791-2-me@ziyao.cc>
References: <20260109093445.46791-2-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

YT6801's internal PHY is confirmed as a GMII-capable variant of YT8531S
by a previous series[1] and reading PHY ID. Add support for
PHY_INTERFACE_MODE_GMII for YT8531S to allow the Ethernet driver to
reuse the PHY code for its internal PHY.

Link: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/ # [1]
Co-developed-by: Frank Sae <Frank.Sae@motor-comm.com>
Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/motorcomm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 89b5b19a9bd2..dc9569a39cb4 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -910,6 +910,10 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
 		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
 		break;
+	case PHY_INTERFACE_MODE_GMII:
+		if (phydev->drv->phy_id != PHY_ID_YT8531S)
+			return -EOPNOTSUPP;
+		return 0;
 	default: /* do not support other modes */
 		return -EOPNOTSUPP;
 	}
-- 
2.52.0


