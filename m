Return-Path: <netdev+bounces-275961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GCGMNrt1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:43:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 843FA3ADDC9
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 704473014854
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748933AF648;
	Tue,  7 Apr 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="S5/QaV/t"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CD3A9628;
	Tue,  7 Apr 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562193; cv=none; b=TsldaCoGJ4piPNvmBVX3lKx834PTETw6i/JUAMTn0HF9RmWtoUJQtsDWqrILLvvJiu0tRvkgGGwr2/32ANrb/2WF8E+GCKyygXz21eAPYLuSDNrlTGaFG2Ful9Rx1Iaqcl27aYw8WbTWWQtgeO3xwIe8kiwhKzlUnTUcWBDxAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562193; c=relaxed/simple;
	bh=xNvQRH54xeI/P7c19AO7ijZKAWjdtknEZ27FOBbb600=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q863w8Sk7MXaslZukm9sVB9esO1/ObZ80HftVZnrM2T5i0korPkBTpgdOiorNhAtG52oNEvn6uaBaPFlVvxu4bF3Z9CgS30y+yUJMaOoi2BUYVbPAHpEdipc402uskCODEh4m5epUVywtNZaVPujxh5E0iBmcZjeBsrb34qPNNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=S5/QaV/t; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qO5k30uA69sxBqiJPUeQ9fi8jukxeSWoCcgtPscWoDM=; b=S5/QaV/tmmIuCaw4zyUPjf5Gp3
	bQ29FH/AX+UZxUt8Y7HcBWj644+V3zge/hXcis9rqSyhL5qvetxodx8G0gqi1Iu5Tnmx09gHCGnxX
	K2uPsQVpoHfJielC08hX/HKJh76lJL2Hg2mGHgjKkLBG3uvZRHrZLuL3jQBKrAAgpejg2LL7Pv8qI
	SaWydjesAOcRNJtLEVBfY9uVFTo7vdvIAHk9/ydHdqEAbxqpqOis1OaWxC/moROqkqa4Dleys9eFK
	v6vTIAvTr6NJBd+2ChS+mZhGMGfgJ4/hgQ9hXBLL6WimKqKZ1z0HMR6CL3Ly27F+f1YWfJK4xGkx/
	Z81FYWGw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1wA4pp-000IJb-05;
	Tue, 07 Apr 2026 13:43:09 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1wA4pn-000PKA-1S;
	Tue, 07 Apr 2026 13:43:08 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v4 2/5] dt-bindings: phy: ti: phy-gmii-sel: Add ti,j722s-phy-gmii-sel compatible
Date: Tue,  7 Apr 2026 13:42:34 +0200
Message-ID: <b67c8b0bc9cc918667e9329d79f617d033d025d5.1775559102.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775559102.git.nora.schiffer@ew.tq-group.com>
References: <cover.1775559102.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27964/Tue Apr  7 08:24:40 2026)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275961-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 843FA3ADDC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S gmii-sel is mostly identical to the AM64's, but additionally
supports SGMII. The AM64 compatible ti,am654-phy-gmii-sel is used as a
fallback.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
index be41b4547ec6d..60b644a4c6390 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
@@ -47,15 +47,20 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - ti,am3352-phy-gmii-sel
-      - ti,dra7xx-phy-gmii-sel
-      - ti,am43xx-phy-gmii-sel
-      - ti,dm814-phy-gmii-sel
-      - ti,am654-phy-gmii-sel
-      - ti,j7200-cpsw5g-phy-gmii-sel
-      - ti,j721e-cpsw9g-phy-gmii-sel
-      - ti,j784s4-cpsw9g-phy-gmii-sel
+    oneOf:
+      - enum:
+          - ti,am3352-phy-gmii-sel
+          - ti,dra7xx-phy-gmii-sel
+          - ti,am43xx-phy-gmii-sel
+          - ti,dm814-phy-gmii-sel
+          - ti,am654-phy-gmii-sel
+          - ti,j7200-cpsw5g-phy-gmii-sel
+          - ti,j721e-cpsw9g-phy-gmii-sel
+          - ti,j784s4-cpsw9g-phy-gmii-sel
+      - items:
+          - enum:
+              - ti,j722s-phy-gmii-sel
+          - const: ti,am654-phy-gmii-sel
 
   reg:
     maxItems: 1
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


