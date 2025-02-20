Return-Path: <netdev+bounces-168222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AE1A3E279
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C9D7A85C5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845A9212FB7;
	Thu, 20 Feb 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To8z59bO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C9212D68;
	Thu, 20 Feb 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072566; cv=none; b=ION8xOP/5TxflfKjJXf5xiC7KPrWU5gpOF+ZKFUf1guYmFUrnpDlbM/PCvlS+r3kealfOezW5XMfNSlZscwMB9KTxwpsFfHu6Opsdo4EJPn4LAYUaVnqoVcJmVhxs1vpNZDr4Rg+318kng4kl3BrTk4d4yx5oZPsVRcFl9kvQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072566; c=relaxed/simple;
	bh=8DRank7hcoqwzjzdr0LkR/6xtYkDEfTlYTLqYDTD3QU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jyy5r9SUUT9CRV2U+VWmHrHDUYThRBIAHGhZPHglv9+8oZ2R67PDKO6S74CQBEfpfvYmDrfRFXb9v3FoOXWX7U6ytQAOcZ9FL0haHUg6xCQmEx17TnN8AUDOAPYoKnkEpDuIp490ueN5qPfHvFmYXcQt8/PNN6fCrfspiD/24y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To8z59bO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D87FC4CEE2;
	Thu, 20 Feb 2025 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740072566;
	bh=8DRank7hcoqwzjzdr0LkR/6xtYkDEfTlYTLqYDTD3QU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=To8z59bOxpHqeEPKX+qgSBnsuWBTRYHvdzqVmJj7s66yFU/7Cl4blGmnEySzSYC5m
	 X+gpEEgaVnPvp6bGSNakaNjN2isurABCp9VJcJojO8XexSh5DampNn7J/BltSuBTOb
	 Lm5hCrhM30L4QwXRUEN2fqha/wFIrqYtpzspf3lWMXLkZlhwtZo8VIKO7k8nc/uL9h
	 iKG8hn2hn8iQW9IZEVyWmhMdWZSUihNXxsc0LLHCgTSxvwFmln8XIdPoeXKRFfqjfM
	 H1jwVgv9ZsAAhJyvK9qp8/W+C8858J3nDNooovvGakGvodckss2STv1kZr1Bom02gd
	 Is8z66GguFVPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D964C021B1;
	Thu, 20 Feb 2025 17:29:26 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 20 Feb 2025 18:29:22 +0100
Subject: [PATCH 2/3] dt-bindings: net: fsl,gianfar-mdio: Update information
 about TBI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250220-gianfar-yaml-v1-2-0ba97fd1ef92@posteo.net>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
In-Reply-To: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740072564; l=2096;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=RZWZAJph1/uEOt9gW5/ECKBcrLQZU1OohzXAiV6s6nw=;
 b=ZyXzj03I9b5jbSaN19fSe0Mt8Pzj7+eZFW6Ahv1uPV65xksQBOllsT6t+GhhXM7/WLqszpY/l
 u93QdxM2ErDCRhHx0RMHlS3nw39DTrX4q981Wdu2c+ePgNjqtPjuofJ
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

When this binding was originally written, all known TSEC Ethernet
controllers had a Ten-Bit Interface (TBI). However, some datasheets such
as for the MPC8315E suggest that this is not universally true:

  The eTSECs do not support TBI, GMII, and FIFO operating modes, so all
  references to these interfaces and features should be ignored for this
  device.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
index 2dade7f48c366b7f5c7408e1f7de1a6f5fc80787..0d2605512c4711a4dcb77620b94ea77a71b45fa8 100644
--- a/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
@@ -11,13 +11,12 @@ description:
   connected. For each device that exists on this bus, a child node should be
   created.
 
-  As of this writing, every TSEC is associated with an internal Ten-Bit
-  Interface (TBI) PHY. This PHY is accessed through the local MDIO bus. These
-  buses are defined similarly to the mdio buses, except they are compatible
-  with "fsl,gianfar-tbi". The TBI PHYs underneath them are similar to normal
-  PHYs, but the reg property is considered instructive, rather than
-  descriptive. The reg property should be chosen so it doesn't interfere with
-  other PHYs on the bus.
+  Some TSECs are associated with an internal Ten-Bit Interface (TBI) PHY. This
+  PHY is accessed through the local MDIO bus. These buses are defined similarly
+  to the mdio buses, except they are compatible with "fsl,gianfar-tbi". The TBI
+  PHYs underneath them are similar to normal PHYs, but the reg property is
+  considered instructive, rather than descriptive. The reg property should be
+  chosen so it doesn't interfere with other PHYs on the bus.
 
 maintainers:
   - J. Neuschäfer <j.ne@posteo.net>

-- 
2.48.0.rc1.219.gb6b6757d772



