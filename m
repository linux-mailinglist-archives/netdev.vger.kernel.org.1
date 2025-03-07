Return-Path: <netdev+bounces-172865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A668A5655C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C9518997EF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40474211719;
	Fri,  7 Mar 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1BbLK1f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247D20E035;
	Fri,  7 Mar 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343406; cv=none; b=brVYj6bbZ0TXDSiD64IVdYZMLXqU7KEqVsRslcX/BNxhB/kuRd3MZUTeNExqn5B4C3aHIpVc1KxY1dqsw0kiF91SJOkszZzKyEc67AsBVMvzbyNq59/W1CZ5wYw0TT6gnGAqE5hq8CZFpzn8VlxLNQ8HaatNwvm8AmG1CiCpuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343406; c=relaxed/simple;
	bh=u5PIwoXpE4i5c/yw91eUN1ZLY/9JIP8Pu8SR2ZLJDFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GAPEOqHQfeLYHRnRSnagUBsBBrtrId+i6/8eiLorj6wctaCKIAvTpzWRMwdKZfnhkMnhb4AnHga1DUXL/Onw7nwqxFrYvWKAVl5WwDkNFX2G95x/7aDh8o8SjQoMaKVVdhqA+pKDcz1ZQvFYyA4YLAa5/1cQ7WBom5N5dMVleEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1BbLK1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96C5BC4CEE5;
	Fri,  7 Mar 2025 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741343405;
	bh=u5PIwoXpE4i5c/yw91eUN1ZLY/9JIP8Pu8SR2ZLJDFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S1BbLK1fK1YHOwwy904m8XHDqOH5joR/8QUmzsjejiCoZGNQuEYpp1aRoBedzrHNV
	 t9iFE+fXdCG/KKlQclVZltdW8oQdq1ol3Sol89N6Gaxlrr/odmPVPTq/ofPbqeOR36
	 Z7jWMarayaCw1sNTnCzvE44Xp2k8YGx3UrwKTdpllahzYX5/A2PWuvxowh2fd6LwwN
	 Gv0U5fTo+qPgTqRqFRD4UsqsebXmWLUulD4sSSJAPNnBeCNcrPIu8vs5X6cO9cHSUG
	 q+Hu47ROvHroxTP+B/mM4u+imbWAdR6k9KkiP3hsTfsORAMct5jEul2zT6W91/P1Wc
	 QgtZZANh5Xctg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828FDC282DE;
	Fri,  7 Mar 2025 10:30:05 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Fri, 07 Mar 2025 11:30:01 +0100
Subject: [PATCH net-next 1/3] dt-bindings: net: ethernet-phy: add property
 mac-series-termination-ohms
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-dp83822-mac-impedance-v1-1-bdd85a759b45@liebherr.com>
References: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
In-Reply-To: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741343404; l=1172;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=ZGmwSQ66d6eh0REzIdZ/UIEpJ5tg0qml7Jgb30CA/sI=;
 b=saFDSQW7Jz8/Enl1FHon3rf594hns5gXEUgOWurxrpPav7KflToUD4W5QlRvITNlq/ZnSUojD
 +mRZ/XT/QMcAiir3nldKVFiiC1AKLJyVnxb8wl+3U6i439k7thfBH91
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add property mac-series-termination-ohms in the device tree bindings for
selecting the resistance value of the builtin series termination resistors
of the PHY. Changing the resistance to an appropriate value can reduce
signal reflections and therefore improve signal quality.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 824bbe4333b7ed95cc39737d3c334a20aa890f01..4a710315a83ccf15bfc210ae432ae988cf31e04c 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -238,6 +238,11 @@ properties:
       peak-to-peak specified in ANSI X3.263. When omitted, the PHYs default
       will be left as is.
 
+  mac-series-termination-ohms:
+    description:
+      The resistance value of the series termination resistor. When omitted, the
+      PHYs default will be left as is.
+
   leds:
     type: object
 

-- 
2.39.5



