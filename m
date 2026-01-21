Return-Path: <netdev+bounces-251872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBpDK1PUcGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:27:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CEB57837
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DC2568B42D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0367745BD51;
	Wed, 21 Jan 2026 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="nWG08m1z"
X-Original-To: netdev@vger.kernel.org
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912543DA50;
	Wed, 21 Jan 2026 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=222.228.43.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000837; cv=pass; b=lqnKLR2VNrD57LADYvUosjVZze+aD64Sw48KCyQAuejNoAwGpz7wzdIGcq2CNzCNGFihddScxvVz4J9C9uA0q/oKH/YGxmjoGuO7/WhoSGX5VWz6AdkRwnOTglGaxqvFu1tYQsfyPcUscL/1va/6SzSKkIVl7z1NEl6PVe1TFTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000837; c=relaxed/simple;
	bh=ijVnNBltqi5y4XsveiL+1gT8vHFfHRQTdsbiqpAa8fU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sihynjdYtO0n+i7Khee/85BzTVSOHjcCzLdeGqW+cX/S5k9goYcYlwXyOUnrFkfECV7Zydi0s/2XXAqaSE2d/pWuztlf2UefQh6gRCbqb8g/B+PzL8lBZyvopGOwQ/orm295P8G+0tCI5vbdws4nEvkQDkSpDIBm4K0J6OVuSSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=nWG08m1z; arc=pass smtp.client-ip=222.228.43.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 2C057109EFDEB;
	Wed, 21 Jan 2026 22:07:10 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tH_3eGkdpw2J; Wed, 21 Jan 2026 22:07:06 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id AE9A7109F15C4; Wed, 21 Jan 2026 22:07:06 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1769000826;
	cv=none; b=Mv3IGKFtcx8w92efHQ3Wa0sZSBFo3fCo0EwbWxCmLu0KlFA95gweSDGVzqtg1GmFL1rMKgZPJJiOxDDW5Iqlpx8pKRwIqUZQcDjxVZPGmNfHH617SwjxozmzBOBXDWmCRrErwIakvBG6rKTt2ZV7uO2KxY4HW/5Bpp3sgAyk7uQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1769000826; c=relaxed/relaxed;
	bh=QMLNRWpwixh8LKR8HFAAkbzBV90YUpJRc8PMTEZ2Lco=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=HEvrCn2sZGw5P1Zcnjzjs7mJ+ymTBUQ0qsSbjPkQFovyMZNpPlVtZS+ZArgFy+E/3S1ZWH4Wm2HgemqkZVnAe7a1nLh778yuotODbIxwRGTBb7kPsfZGk8FgT2z+/o1j9FSW8iay104iJUQZ1n/lfuenDKjrx86nA8gga0Wo5Gs=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org AE9A7109F15C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1769000826;
	bh=QMLNRWpwixh8LKR8HFAAkbzBV90YUpJRc8PMTEZ2Lco=;
	h=From:To:Cc:Subject:Date:From;
	b=nWG08m1zEs+lOlsT13Ee9QwVFTu8vBXbL1A44CmnGC+S2fJUgp1omoIM2Xk8/pJAW
	 shJ9iYin4BhlomO0IuPr6tZj2IwHV+CEc698ERlBT6Tf6JpvL7kKtG9mN/MFcD01Mn
	 +oIVJYXfxg9MpiXFeV5OxjeZ1op/iv5KjDk11ABU=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: krzk+dt@kernel.org
Cc: robh@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	weibu@redadmin.org
Subject: [PATCH] dt-bindings: net: dsa: fix typos in bindings docs
Date: Wed, 21 Jan 2026 22:07:04 +0900
Message-ID: <20260121130704.2236452-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redadmin.org:s=20231208space];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redadmin.org,none];
	TAGGED_FROM(0.00)[bounces-251872-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,vger.kernel.org,redadmin.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[redadmin.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibu@redadmin.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,redadmin.org:email,redadmin.org:dkim,redadmin.org:mid]
X-Rspamd-Queue-Id: 75CEB57837
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix "alway" -> "always" in lan9303.txt and marvell,mv88e6xxx.yaml.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 Documentation/devicetree/bindings/net/dsa/lan9303.txt         | 4 ++--
 .../devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lan9303.txt b/Docume=
ntation/devicetree/bindings/net/dsa/lan9303.txt
index 94f4f286cef9..46a732087f5c 100644
--- a/Documentation/devicetree/bindings/net/dsa/lan9303.txt
+++ b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
@@ -16,9 +16,9 @@ Optional properties:
 Subnodes:
=20
 The integrated switch subnode should be specified according to the binding
-described in dsa/dsa.txt. The CPU port of this switch is alway port 0.
+described in dsa/dsa.txt. The CPU port of this switch is always port 0.
=20
-Note: alway use 'reg =3D <0/1/2>;' for the three DSA ports, even if the de=
vice is
+Note: always use 'reg =3D <0/1/2>;' for the three DSA ports, even if the d=
evice is
 configured to use 1/2/3 instead. This hardware configuration will be
 auto-detected and mapped accordingly.
=20
diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.ya=
ml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
index 170d8b74f6cf..19ae600e9339 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
@@ -63,7 +63,7 @@ properties:
=20
   interrupts:
     description: The switch provides an external interrupt line, but it is
-      not alway used by target systems.
+      not always used by target systems.
     maxItems: 1
=20
   interrupt-controller:
@@ -72,7 +72,7 @@ properties:
=20
   '#interrupt-cells':
     description: The internal interrupt controller only supports triggering
-      on active high level interrupts so the second cell must alway be set=
 to
+      on active high level interrupts so the second cell must always be se=
t to
       IRQ_TYPE_LEVEL_HIGH.
     const: 2
=20
--=20
2.47.3


