Return-Path: <netdev+bounces-275954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GlYO3Pn1GmeygcAu9opvQ
	(envelope-from <netdev+bounces-275954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:16:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E28D3AD900
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA34830A85CC
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB33AC0CB;
	Tue,  7 Apr 2026 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GBXC6V0+"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8763ACF05;
	Tue,  7 Apr 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775560285; cv=none; b=fYUuhUQGTlEg3k9+nlcDf/L1oNe6hKZ5Ad/YI9+I2Sljy65t1SoQ7FArEZsgr9bRZt8rM527O+U956nopyXfrNr7ftQsoCQJ2+5QtABybmCkBBfN38VkVhO00mj4dLA1MW/gunXPvKVptomqGrC/gjOfQDDZpKczuw5JoEs+u0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775560285; c=relaxed/simple;
	bh=TUx+zOkdIbgwvwJUIpQjeajGd8DR9V8Z0LlAjIsoAuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pKNumkanAWTIDjJVXB7FNrVEiT8eLqy7SO8Xh5yBNo8JguHobV2k5ASCbyVszNr/jQxInvD83Cd6tqB9Lz2tGlTVQE8kLZBY0BoFi9QPphoO6ZymLDphlPNAVbwOioMHTQfHmrVgglC3lBnuBAIFmcnLh2sEdFj9OXq/xA8ubiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GBXC6V0+; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=QAAMci2a2IFoW4AUViSFOjWysthteAkqh5wfGRrvW6A=; b=GBXC6V0+dFiTvQA6IXOTnWtp+Z
	HMDBgGe1y5PJ5yZivjW0OtO/7KJE9esMQ3jgtDAS7CUj86Fi+sPYX++NhGpvRTxcKhIVmYpLvs3Yu
	66Yh5yRbo6Tm4QhZkRxdZYvHoLH+ncScWPC+Mqp8R2qwpl9uLMHH2lyKj3jdYw8VA/TMSvpSW1iih
	n1KxTRS9eXtaGVNqf0BdI7baneLs1qlBqWSu2t4P8vc325bMOmWFUwRxSWUkm04Xm67lnAfyfHvPb
	2tGbXaCDr5XmOmlzepdDWHXbnzDjUSPc/yjksF0f/fLj9vYJAmxq6KDuNabzatbMRj9W4cPxmO31e
	50jitKVA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1wA3z1-0006oo-2R;
	Tue, 07 Apr 2026 12:48:35 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1wA3z0-0007uJ-2M;
	Tue, 07 Apr 2026 12:48:35 +0200
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
Subject: [PATCH net-next v4 1/2] dt-bindings: net: ti: k3-am654-cpsw-nuss: Add ti,j722s-cpsw-nuss compatible
Date: Tue,  7 Apr 2026 12:48:01 +0200
Message-ID: <191e9f7e3a6c14eabe891a98c5fb646766479c0a.1775558273.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275954-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ew.tq-group.com:dkim,ew.tq-group.com:mid,tq-group.com:email,tq-group.com:url]
X-Rspamd-Queue-Id: 6E28D3AD900
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S CPSW3G is mostly identical to the AM64's, but additionally
supports SGMII. The AM64 compatible ti,am642-cpsw-nuss is used as a
fallback.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---

v2: keep ti,am642-cpsw-nuss as a fallback
v3: resubmission for net-next, no changes
v4: remove redundant items: level

 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index a959c1d7e643a..c409c6310ed40 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -53,13 +53,18 @@ properties:
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
+      - enum:
+          - ti,am642-cpsw-nuss
+          - ti,am654-cpsw-nuss
+          - ti,j7200-cpswxg-nuss
+          - ti,j721e-cpsw-nuss
+          - ti,j721e-cpswxg-nuss
+          - ti,j784s4-cpswxg-nuss
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


