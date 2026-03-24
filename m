Return-Path: <netdev+bounces-271035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM4KLZOFwmkAegQAu9opvQ
	(envelope-from <netdev+bounces-271035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:37:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E1E308645
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FAF430B4D93
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF583FA5F0;
	Tue, 24 Mar 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kPkvszrt"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931FF3F99D1;
	Tue, 24 Mar 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355430; cv=none; b=ksg1e0yXUjQTNWf1SyoLWg6WwOnaJxLfCxFTGOhCA7VYAdLyyzxMYIygnlROVzZ7BpUvrEF8U204LmY9Py40CahRopsvZCJoLwgwN80c4lUgoWKp0og7DNSWQxCF+DRE5Ui0EpwD79lwxBfhVoOm/QXKu6r694BsQMmhuIqUBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355430; c=relaxed/simple;
	bh=ku589tly/tCZifa7lwuGz9Rn8STrv9dkH8Z3dMpeH84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IW1bTn9y01N8M3yxEh900hhK76oi6WAZgpZZSSSBJr4ZtO9VOpjo3IdDut3SDakyZGhm9wFPbkEbvUaiQllUwMtTJNb6vXUXJt2Syk5zX8ZQx7MdxvEt0W3DoCoyzf8D1Y/8vBWMCN5e35zqf0ooj5ZpDYLzjdnfqVAH8S5xflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=kPkvszrt; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YYZDaFWbRwD+Y6m8tmBwPFr2FatMkna546OJAPMNkgU=; b=kPkvszrtAcNA1Duv6MZr4nGqSN
	59MyxnLWvTrZ0BWGTWrR1pg+V1IDXJEAE/JMiRCBGGd/hNIj143J58e22lfBR+EgqkHZcwxyhv6Hi
	eeG86Pmi76UFq+FvbxnCUPOoW9dvSXEj+TCquWn/UhoZaF//dSmGU4q81SZf+MLVdj2B4LdeFyt0t
	yFLvwpWg3pAEb6psJxLrsiyzESw5Ly32TwSVgOjoU5GE7S2X0/yIiYXEIoLNHsa3FhMda0MNWR/lE
	PSKuRa42kLyKLo2l0hbz/vqJvvGgJqWia8UxSgpirx3hZMhCYZvaS/TDkZsmVlbsj2jNnGF5S8rHJ
	WNy0dfGw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tr-0005qJ-13;
	Tue, 24 Mar 2026 13:30:23 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tr-000Pna-0V;
	Tue, 24 Mar 2026 13:30:22 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 3/7] dt-bindings: net: ti: k3-am654-cpsw-nuss: Add ti,j722s-cpsw-nuss compatible
Date: Tue, 24 Mar 2026 13:29:39 +0100
Message-ID: <f0aab212828fb4cad774de6b88fe6d24dfa96833.1774354734.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
References: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27950/Tue Mar 24 07:24:19 2026)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271035-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:email,tq-group.com:url,ew.tq-group.com:dkim,ew.tq-group.com:mid]
X-Rspamd-Queue-Id: 18E1E308645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S CPSW3G is mostly identical to the AM64's, but additionally
supports SGMII. The AM64 compatible ti,am642-cpsw-nuss is used as a
fallback.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index a959c1d7e643a..70d25f5ff1cfe 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -53,13 +53,19 @@ properties:
   "#size-cells": true
 
   compatible:
-    enum:
-      - ti,am642-cpsw-nuss
-      - ti,am654-cpsw-nuss
-      - ti,j7200-cpswxg-nuss
-      - ti,j721e-cpsw-nuss
-      - ti,j721e-cpswxg-nuss
-      - ti,j784s4-cpswxg-nuss
+    oneOf:
+      - items:
+          - enum:
+              - ti,am642-cpsw-nuss
+              - ti,am654-cpsw-nuss
+              - ti,j7200-cpswxg-nuss
+              - ti,j721e-cpsw-nuss
+              - ti,j721e-cpswxg-nuss
+              - ti,j784s4-cpswxg-nuss
+      - items:
+          - enum:
+              - ti,j722s-cpsw-nuss
+          - const: ti,am642-cpsw-nuss
 
   reg:
     maxItems: 1
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


