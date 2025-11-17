Return-Path: <netdev+bounces-239183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8949FC65297
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 937994F0858
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D72F2D1936;
	Mon, 17 Nov 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prOrLcL6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E382D0C98;
	Mon, 17 Nov 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396693; cv=none; b=R2Qny9wq/8kBWx4YSCdhW/F0FeiJJIVXHBZmzIB9UjINIpcLEzbzYIl/mr6/0BaKlW6Jagjn9fbSK1mMaqd+v8/LMe2v55b+lhXUq8msKKYyDvRmHPIZZG+EI8GgXhQIDwuoaq0mjDUeYXeDOrvNTQ0wG00cLphWWfFb9lTszeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396693; c=relaxed/simple;
	bh=WO9cmkqeffZyHvtjs530916CcqsLtTtvOC0BcbAPs/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSRmbN0bMP04qUJa2yXQOaXNB7QJzyGj+KuoL+9ejkHS3mQOnZITirbzFu4NkyDvlyedobNrV5Ymyfxw8/z5EV9I1xOYDgBxXVcPdtQfMc5xFJDqPl7Dy4ZDQyZqOm7UxZJV2g60ZXv79s5UpMZnC+e51U363kl3A5aRe7qEJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prOrLcL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5014AC2BC87;
	Mon, 17 Nov 2025 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396693;
	bh=WO9cmkqeffZyHvtjs530916CcqsLtTtvOC0BcbAPs/g=;
	h=From:To:Cc:Subject:Date:From;
	b=prOrLcL6/hGTU8HydS480jFcyIfMpWrPO+qqX9FyWPIO+qmCiRZFNys8efJfsGUoM
	 LPmGJfrE2phaW6yjaz9nG6ygPe6Vw9ZQy/kcd0iNq/CHHiKRJLC0zJhIny6guP5mZf
	 +OSsP9RWXK0Npz1k2jdBViClrm364b0GN8JIvEnJKYoVp0vIO96DMWQsuQ8meOrSE2
	 lDc69gQkW2rf3JohLzd6gcekyEImdgnqWEtL2FAD7HG14uQ+EOeky9yTdfCUIzv36g
	 RmKO/75F/3UZ7dK4AOl+lnZovgqE7dEMQpVYYqFCc7cjwUFNU4gV/Du02eU9jAEqqT
	 B8ZlT511XfsVg==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [net-next] dt-bindings: net: cdns,macb: Add pic64gx compatibility
Date: Mon, 17 Nov 2025 16:24:33 +0000
Message-ID: <20251117-easter-machine-37851f20aaf3@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=4jfXTL0V77L5MgdXnQ2+Bnzxx45wqj60pFdPHRDnEqQ=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJnSPvZKjBPZzkc9WX+AN8az8LPQyyzJU0u7vy+fFV354 7N+msXujlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkbicjw0kFzyVxbTrmZb13 t6ulWygocW0SOHzLof/FjKS9nwL4dzIy3Lg8fylL6v79pRHKHWLOYjtc30y+/WrS3/ULOFuFVov XMgIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

The pic64gx uses an identical integration of the macb IP to mpfs.

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: netdev@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 1029786a855c..07ede706a8c6 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -38,7 +38,10 @@ properties:
               - cdns,sam9x60-macb     # Microchip sam9x60 SoC
               - microchip,mpfs-macb   # Microchip PolarFire SoC
           - const: cdns,macb          # Generic
-
+      - items:
+          - const: microchip,pic64gx-macb # Microchip PIC64GX SoC
+          - const: microchip,mpfs-macb    # Microchip PolarFire SoC
+          - const: cdns,macb              # Generic
       - items:
           - enum:
               - atmel,sama5d3-macb    # 10/100Mbit IP on Atmel sama5d3 SoCs
-- 
2.51.0


