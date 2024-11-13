Return-Path: <netdev+bounces-144600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44CC9C7E7B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697ED28246C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 22:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8657D18C033;
	Wed, 13 Nov 2024 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChvkXR3f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AA18BC0E;
	Wed, 13 Nov 2024 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538630; cv=none; b=epMQ+l5xcKAqJFBdQKbS82/qrovO0wxHXalRL8/jWoeRY7c6V8QOS8vyCUy1oSgbBjc03tOMWuXs9I1Im7/A9s2hQ0zIA7tJbHFT3kAW1FmJW87f9LrlncPsohM1p/Biv3olqkxNdiklHFGpd3xZAKm1RXN8CISZNMntJ6OFkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538630; c=relaxed/simple;
	bh=3Pdori3dLtCS2vscBLvSM4i/0rrvMuUiXiugqhvyQ1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8EHuJTfep9zpXmO9RK8iPne/gWR0BdLtciXZH+wdsfJyZj++1ZXihardaUtl5ignzlyp9h0UlwwdmqaImuejhm6ZDA5+HjT7XRDeZIZ2mf1XAgOjhPpvxo3VDE8QM9FgdrLf4tp2xdX1MDq2dGaO/1YmfJADSmsOyTKXqD1y+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChvkXR3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8451CC4CEC3;
	Wed, 13 Nov 2024 22:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731538629;
	bh=3Pdori3dLtCS2vscBLvSM4i/0rrvMuUiXiugqhvyQ1g=;
	h=From:To:Cc:Subject:Date:From;
	b=ChvkXR3fWWKj2GmIlZbJ6dJZypQsMDc+z3RGbepij1cYDXey7WcrQDKg2SR5W+ThG
	 ziomRGoqhLv8wkucDS0B8lejHxYfC5lNyHzuwvTFgOJKq242kPpT52msturzWrVnnU
	 LEKRF+5SaUM2XNueqgR9oncf6QfiGM++2FdTDcVssqgKi4i7qNdoQ+BApJlHGAQIkI
	 jrt6EdWh66XWkEQgQZLVxUGN75twvScRuQi5N9srMzmObzCwDlPusa31EWres6rXvU
	 sINlWNAHGDNVPXadApKIpLkkSaDrOu6PeosdEXTr6QW1STiJuqby+5DtyzeNecH3U3
	 XJP8Oeh+P/Qgw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: dsa: microchip,ksz: Drop undocumented "id"
Date: Wed, 13 Nov 2024 16:56:43 -0600
Message-ID: <20241113225642.1783485-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"id" is not a documented property, so drop it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 30c0c3e6f37a..7a99eeb47a82 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -138,7 +138,6 @@ examples:
 
         pinctrl-0 = <&pinctrl_spi_ksz>;
         cs-gpios = <&pioC 25 0>;
-        id = <1>;
 
         ksz9477: switch@0 {
             compatible = "microchip,ksz9477";
-- 
2.45.2


