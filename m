Return-Path: <netdev+bounces-155877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07434A0427E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BBB1882A9B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B111EE03B;
	Tue,  7 Jan 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KoOAP5qk"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130971EF0AF;
	Tue,  7 Jan 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260056; cv=none; b=SQl8ANCV+EljPFQzVicPDZJzQLo4wijYv3GnEwr2jY+EITKWIGCslJ8Phky2QPVgQUMTioZeIgNkYjsnQgJI7myYSP6Kn+46pe8n9+Y8i1bm00kliBVzPtMWrHrIgH2vjINr5y7kKDxQGX/tAxVYXm4Mo00hEHwOxZTEaTA93D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260056; c=relaxed/simple;
	bh=DQOgxuU8KZZ7HfyFn2N5Umm7gqjFCbVTdxttiKZH66c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lfO4hZeSUH676JvMcwY9D+QNUFauGvWO3SIl9as2vIuwbBJ8GOof+BHgM/NzYPOHWComnBdA2tv5Fj6CNtOwX0M4npwIQ6CpVXzCThqRRofTcrz/U0ORynQmrjJpqYjnRy4gcZDVI2aineWNr+v+ny7i1Uca6YNVFtnJDL2rBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KoOAP5qk; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 581ACFF804;
	Tue,  7 Jan 2025 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736260051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eh2fGGQ10iT+x6CMppwD5qBvxhaDaxT3qsXajyTyxSM=;
	b=KoOAP5qk2VeBswS48NSrfBUjCsA90qulpKGtbN5GiNzTCd2wnOAD++V7Jrt0vrtr0LAKUe
	/yOMEDqy3P2jgcnmYVQYdj2TtrHKSR++MFKiqwT/ZnNk+18rUWFaKMEf954FMYEyFH67qy
	EyhCEs9WF+sggQAAnFHV3oER76o6DHV5LX8BjH+/x+pUHsfqiwtnfOhvKLKFMKWiR2UZG9
	m6dUsit62kpni4eIKVPC9xORGVzxSyL5FRP+xlQCYzqlDWW610+948YQZL/lFS73im2NAa
	h1Hz25yYKO5aQ5wcJpSiCKYv7qNxJN3tNvypq28cmhiTja+WwI/Qevd4QEXU1A==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH] dt-bindings: net: pse-pd: Fix unusual character in documentation
Date: Tue,  7 Jan 2025 15:26:59 +0100
Message-Id: <20250107142659.425877-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

The documentation contained an unusual character due to an issue in my
personal b4 setup. Fix the problem by providing the correct PSE Pinout
Alternatives table number description.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

I don't use net-next prefix as I suppose it would go in the devicetree
tree.

 .../devicetree/bindings/net/pse-pd/pse-controller.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
index a12cda8aa764..cd09560e0aea 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
@@ -81,7 +81,7 @@ properties:
               List of phandles, each pointing to the power supply for the
               corresponding pairset named in 'pairset-names'. This property
               aligns with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
-              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145\u20133)
+              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145-3)
               |-----------|---------------|---------------|---------------|---------------|
               | Conductor | Alternative A | Alternative A | Alternative B | Alternative B |
               |           |    (MDI-X)    |     (MDI)     |      (X)      |      (S)      |
-- 
2.34.1


