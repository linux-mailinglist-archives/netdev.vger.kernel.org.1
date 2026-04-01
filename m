Return-Path: <netdev+bounces-274087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPB5FQ0ZzWnOaAYAu9opvQ
	(envelope-from <netdev+bounces-274087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:09:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686F37AF63
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9159317D0E1
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA3405ACD;
	Wed,  1 Apr 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qUPqjwtj"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D92517AF;
	Wed,  1 Apr 2026 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046369; cv=none; b=P5P8Rf9avZchsH7+2BsgIWG1dqljbamoA+iI3M2iQI1pQAfOkmfnL7P4pbV9Jl2SLTctdXon6W8jC/vmHviWMQlx6dCxkEs0d1lWMfmfduKN2H2SV2CRZvc/6cvfpw0//3YMAkEyEYiG1h6q+ZYOJ2CtM91c8oxof1arh9LPEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046369; c=relaxed/simple;
	bh=gMJ4qA4+BpPEiz7VEhBVeNQFffnLFENP2d7DPETg0gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zl2f0vCXcPwia/eTbtifyQDsMpVeRib6K7P71qT8ht2hs6EH30MAaHyluDsSPi9mkqnoDxBT7uXqIlgI5lg33FR+6hgk5vXhAuM4gsivZJZpseg/Ym13FlO2KihoCo4iNR3PsyjPKEtbT/UbO2IpA5lZJSA6grbXgm612c9QfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qUPqjwtj; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=E2G3cP9X4cNiCp8YAHg4IjVGgRKZxQbDkjOgRFSfK7s=; b=qUPqjwtj78zGf4p2xh8VKaEQ+Q
	nXh0ts7fQKRqRNCbcMe+P/Qdiy6M/f2n/Gkt+xCOOKyQSjQAVmiVAsngP00UMTqqrNikSusWRdnyJ
	HoAOnGFoKlFfEWH+8ewMciN9PotAn5dqkZuL5zQbxgSz+r7SPxXXi1AfOk0u3DUJuj9zE4HxWSclL
	Wxr41qgXd//s/IAhl9wvXLV+9vWEWF3NytCTUTN7M9548MRofsfaMaCtjzwh0qzQA3bgMJGqo9ExM
	hl/fGl4BPN3TATHfh8JfCQLqCLmTz+Iso5CHa0lnTN2KXpe7xM2cNxBsWPbnoqe37oLgDZG+CGlaY
	5u0no4Uw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7ue3-000IQk-26;
	Wed, 01 Apr 2026 14:26:03 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7ue3-00089b-0X;
	Wed, 01 Apr 2026 14:26:02 +0200
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
Subject: [PATCH v3 2/5] dt-bindings: phy: ti: phy-gmii-sel: Add ti,j722s-phy-gmii-sel compatible
Date: Wed,  1 Apr 2026 14:25:22 +0200
Message-ID: <5ac1c52827a1a246584dddb62335f9ce4715eceb.1775045279.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775045279.git.nora.schiffer@ew.tq-group.com>
References: <cover.1775045279.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27958/Wed Apr  1 08:24:34 2026)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274087-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:email,tq-group.com:url,ew.tq-group.com:dkim,ew.tq-group.com:mid]
X-Rspamd-Queue-Id: 4686F37AF63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S gmii-sel is mostly identical to the AM64's, but additionally
supports SGMII. The AM64 compatible ti,am654-phy-gmii-sel is used as a
fallback.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
index be41b4547ec6d..6e12a75100eb8 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
@@ -47,15 +47,21 @@ description: |
 
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
+      - items:
+          - enum:
+              - ti,am3352-phy-gmii-sel
+              - ti,dra7xx-phy-gmii-sel
+              - ti,am43xx-phy-gmii-sel
+              - ti,dm814-phy-gmii-sel
+              - ti,am654-phy-gmii-sel
+              - ti,j7200-cpsw5g-phy-gmii-sel
+              - ti,j721e-cpsw9g-phy-gmii-sel
+              - ti,j784s4-cpsw9g-phy-gmii-sel
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


