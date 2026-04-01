Return-Path: <netdev+bounces-274076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHTZEisTzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:44:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A709837AA69
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BFCE31852B2
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AE3FADEE;
	Wed,  1 Apr 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fnuKjJIa"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E49636AB50;
	Wed,  1 Apr 2026 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045206; cv=none; b=nGPaG3CkC3it8CqTHl90JU1rKXjhfCez4zsOH4C78sizj7RaOKge6pAVCEtCJwRPPuelgm9v1QzNgU42OlfcTqO7XRc9oedtpi0Gxk+PNy+Q5RhkJ9Ui7saDl/Friuc0vCpRD/AwYKYAaTduuo8hOaSehkWolJCH4Zg0bWnOHSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045206; c=relaxed/simple;
	bh=ige1mHpDUOJSc8Xyb/oveMemNufurk82SCH+gfklp7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lv26w6jTp9fSY+25Id2r1aezgVtvfCxeMfok+33hGOCwqybBRyCCp5Dj3Q6Jgph419aOJMTsepDAsgowLowaOdff6TvlOSGclSY+QLSL4AfJfbEvwhi9kn3RIswGsLy5QJ+23zco6Ni6mU+aoSenyz218PgP7no8LcWT/Gxqu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=fnuKjJIa; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=047O0Bnm7X7eFxP7dbf2lFni3tJL8l/+lwR4gP4mP0c=; b=fnuKjJIash0Ly3Blm7dlknBg/R
	tJyMWI2S9H7Ak8KNXtF4BV4SVuzswduPWcxnXRpDKmQzb+Vbx6toOQKI5DDCQR5CwWB7+gs++rg40
	p/5BB+JcZFqvcdmF5K0CqwJrQ4NKWgUw91YsqNPxDHB+xt7W1bw1VoKtDoLy6DW9W939yhIUpy/BF
	/HZ/BjpcrcLbHVfapirJ9S/YChNH9T2C2WIDZLafFLGPkBXuiBlRF2ESIimaWLtqZTAzoJ9qED0/o
	9uTycrK52cXBM/3gdEOXAerUgGJ1PzfwwyK59ADYfD4cUTuSygNjsYOnxW5KyeMNTdQLuf8OKpEeb
	TvbA5+JQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7uLH-000FCz-2X;
	Wed, 01 Apr 2026 14:06:39 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7uLH-000JGT-1D;
	Wed, 01 Apr 2026 14:06:39 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: ti: k3-am654-cpsw-nuss: Add ti,j722s-cpsw-nuss compatible
Date: Wed,  1 Apr 2026 14:05:42 +0200
Message-ID: <e7ec1b928357d1240a962a88dc6ac67fd2c92357.1774958552.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274076-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-0.977];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tq-group.com:email,tq-group.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ew.tq-group.com:dkim,ew.tq-group.com:mid]
X-Rspamd-Queue-Id: A709837AA69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S CPSW3G is mostly identical to the AM64's, but additionally
supports SGMII. The AM64 compatible ti,am642-cpsw-nuss is used as a
fallback.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---

v2: keep ti,am642-cpsw-nuss as a fallback
v3: resubmission for net-next, no changes

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

