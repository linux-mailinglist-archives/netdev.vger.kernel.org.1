Return-Path: <netdev+bounces-275494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP2fEpXw0mmtcQcAu9opvQ
	(envelope-from <netdev+bounces-275494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:30:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD183A035D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28C9830063A5
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ED43845DA;
	Sun,  5 Apr 2026 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xKFwlgt5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KtyCJdO2"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F0B3845DC;
	Sun,  5 Apr 2026 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775431826; cv=none; b=GCCrzqzM6LgYbdeHXfHF/MSXoZy0thC7GtswZeLE5ATtK7lthrAUhC7cxyXvGOn9y9TKBnx5heAF4Q0c5tQ9dKhXFDDxcKxpE/FdmalBh6uMYBRbwDrQth7fruvT633cm+wOcPfU2P9NAQ8A7uQVUSGUl1w3KXCQBEthPw4rKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775431826; c=relaxed/simple;
	bh=oZdMCxFFsKsHF3vPt2TMwnzgmvwBXv7RaDyF0hwzf/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJ03/lEXbxwOMM9gwYtIRJ3/LzBzSeBAy/qhWI5vVQjZcph01W2PB9RzVQBWszbD7pK+vMGVZNtnYg7yUAt6hhUCCfo1ebekWupGaLoSEv62XOW2+Nc61LmR2+WQjkcjfSBhfG7X9Lyn7ShreVSRFCpCteXxDpKJ5+g4Q2wuenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xKFwlgt5; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KtyCJdO2; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fppbc1zVHz9vLq;
	Mon,  6 Apr 2026 01:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775431820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+jHb+JyP7bouVvbJS6iybJ47vr1k59g9Nt6WxRh6bSY=;
	b=xKFwlgt5dLTpp0s6z9T7rH5/p9b4Bc+ZIH6otswQ0WsO4sTNmGQXl912S3Rliw6vr8+592
	UAV4S5FqRxI/Z182mvDb6VsxFJhTPkOfam8Y5foSv5L0NwDXv2gQq67dRD9Hy2UFkY8yM2
	kcksnSbaGA1sS3TipeAAlR/Bw2Co2eumyooUGrPLGlKu1roT3eQ0Lcm1cHRE7oUAj2lCPU
	DNJC0I9sh947zRQw7mrHPvvJphQ8yI0W6GhPFugTLqFNJXb2yXcsQIkfVJLV7IsSB8dHKy
	xtOER29x+aNL5+0neC2QR6V4g58wl7dWUgg35Wuw0vtg2vmQBE56HjDBRVo7dQ==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775431818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+jHb+JyP7bouVvbJS6iybJ47vr1k59g9Nt6WxRh6bSY=;
	b=KtyCJdO20lWjeKdZHXO5PEQMA0Mt0bdGjX44BnGCW3eiC9uZgwNsEcjAHuxH7GzeL6c9FR
	lvQ1EcM4r0il10Di7Jfm5WdI6SnpkhUmL6po3yklbCLW0SwvyytL7gtuh+euhehqbU5l6Y
	i0vyCnLuuz7xCsRk6R+GBtnLBh1A/9mJzS1khs7tYvuuOaSEG6Ef8Rjuti7XO4+C9adFkF
	utNczADP+itlnnw5oxD3nUGz7LxEqrmc11WuagbPnWYh0eA/txE7D73auZnELye7A3qWv+
	f90c5kCh9iqoXKJKSTXnBvdWLsPiRlP13ZUWlcuUi4PyKXDmIYjE4q2s0Egw4A==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ivan Galkin <ivan.galkin@axis.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH v6 1/3] dt-bindings: net: realtek,rtl82xx: Keep property list sorted
Date: Mon,  6 Apr 2026 01:29:56 +0200
Message-ID: <20260405233008.148974-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 176992d66fa91593939
X-MBO-RS-META: tas54gdpejf6p13pajydx49tzghb4dcn
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mailbox.org,kernel.org,davemloft.net,wp.pl,lunn.ch,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-275494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CD183A035D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sort the documented properties alphabetically, no functional change.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ivan Galkin <ivan.galkin@axis.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Klein <michael@fossekall.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: No change
V3: No change
V4: Add AB from Rob
V5: No change
V6: No change
---
 .../devicetree/bindings/net/realtek,rtl82xx.yaml          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 2b5697bd7c5df..eafcc2f3e3d66 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -40,15 +40,15 @@ properties:
 
   leds: true
 
-  realtek,clkout-disable:
+  realtek,aldps-enable:
     type: boolean
     description:
-      Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
+      Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
 
-  realtek,aldps-enable:
+  realtek,clkout-disable:
     type: boolean
     description:
-      Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
+      Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
 
   wakeup-source:
     type: boolean
-- 
2.53.0


