Return-Path: <netdev+bounces-248285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA4CD067B1
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 23:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB743302174A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 22:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56732F740;
	Thu,  8 Jan 2026 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpD9j2hu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C2327BFC;
	Thu,  8 Jan 2026 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912817; cv=none; b=u2HKJ0pXAKjH0oWyoZLvkMGtFgf/DcT2MU+hJXPvxW+D8U7amxuCfDyIm6c+cdi1da4g1unkQgln9HnwZxsF9qvDqc+HJ0TgBGgFV8J08IAbo8FSvNECajoWyumTQmMPyZCzqsKNW+ikysTanPK96oShv9KmoZCOs9juqmdHEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912817; c=relaxed/simple;
	bh=2sZpikIF2a6wvySDojngzYZtfZ3NdwmeMrSs/cDnWi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbVOEgIlX6x2m9b+8iv4nLtYe130R70j2BPA2iNdDeG6zYIjoF0hO3bUjcu2dmqzRHOFt1qsdxSIqlYSXCM3Ockq+/yuVe/eTOzsYFN0IO5js8nfIoQPIIJnIU143tTsgw2Eg0LykZMJJve+K+9xBuX7fXCoaQMNXeFVwsksx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpD9j2hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69EBC116C6;
	Thu,  8 Jan 2026 22:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767912816;
	bh=2sZpikIF2a6wvySDojngzYZtfZ3NdwmeMrSs/cDnWi4=;
	h=From:To:Cc:Subject:Date:From;
	b=hpD9j2hub5ofuvHRQBkdBsv3ZM49CDeVCITQTKYjWSXceLZ+iL8t8JT3esJp3CkPP
	 d2vKjHQ9YckGXjOpGau2SpCzVP7EwY9nbVWqjB/amjX8n7ngABUmZZK6+LoMM6/7v/
	 cuQ4sGgMfJqPfrAqeAuYbaXWSAEWIgJG8qPjLejqPQRsYM3M4Ol+SDCAmKDTrG1fFl
	 nLDp9bc/ZQtW6oM+LHKtv0MqJHTq5FQFJDuZGRYGIpexs0QPn1AKBY+EkfsfB3Gp2M
	 +vB8fa+Rv9VGObOxC62/S/+/5vCB1t3GBY3mPJzwYca+5ZjU3GX3m6jS9shXrV0g9S
	 j7byI+9QlW3tA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	David Wu <david.wu@rock-chips.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: rockchip-dwmac: Allow "dma-coherent"
Date: Thu,  8 Jan 2026 16:53:18 -0600
Message-ID: <20260108225318.1325114-2-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GMAC is coherent on RK3576, so allow the "dma-coherent" property.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index d17112527dab..80c252845349 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -85,6 +85,8 @@ properties:
         - clk_mac_refout
         - clk_mac_speed
 
+  dma-coherent: true
+
   clock_in_out:
     description:
       For RGMII, it must be "input", means main clock(125MHz)
-- 
2.51.0


