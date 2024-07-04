Return-Path: <netdev+bounces-109131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D992714D
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495FD1C2186F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8181A3BD7;
	Thu,  4 Jul 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V4cP6f9P"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090A1A3BA3;
	Thu,  4 Jul 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080746; cv=none; b=Ac95uBQV7XlLl2qoUwj5CMEZQ2ELCU1giIuTjYfnXESiBfSzkCzPSoCiyw+B0rDhGe/oSx+hwbkMte+kuc+DHguYw7x8E8aWKoJJfzUuGjPhzCKb9kTr826GsGsR5CFYPunaYkhD2l5l/rIet5/rk91ogjZwZQi+1q58eN9ElYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080746; c=relaxed/simple;
	bh=JIEiw4C41tOpxwtwCKb7ZJb/schr4pI3+cSR7xeIKj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZkSXD6mgePMuI2oaN7YFewMtK8Ef1W2W8gqjHjKFWVtwS1OOt6D7zNhwUwyQL8OzrqIE1MKKHbRHkh/dsgjyCbIpwqHG2zHmT9tOnmwMqD76qzWac1f63wxykeaQnkIjEwXvZYqLQtvitVxZl9p7jV21JV7aeYsoKn+K5n5MPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V4cP6f9P; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA5551BF206;
	Thu,  4 Jul 2024 08:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720080736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/FkkE0tfSbBK87JK+AH8wZIjpZ8/ihWaMWQidnD+tBQ=;
	b=V4cP6f9POFHyrIetk+lwirnQXo71DvjlPQ+Nn7u5tMfCX9gifULZ7d3Hd3OUBdIKefbtXQ
	wGkgcMWIiQvnhV01+x3Q9LNIlTC3pHkLvjXV1nB/OYtcr3bEUm3FbGPvcPdj42kBcdxHbp
	qhmIaogIfAX3FaS5a0TM1HbFijXNVdRXfKWm253mzVoG+J2gzrsjACwldwkoVRmJQFlKez
	5eBLC0Nyh03FDGgd9WagKzdosHd3WPk1J65T1sTl68WQIrUcrDkbZIb2TCDiGMWuNToyx+
	vtJPN2XEUgAhc40IhVZWbQ7v7Fc4Q1h7Jc2IrjtvF/v80OfqseQRjQNcWAGQhA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 04 Jul 2024 10:11:57 +0200
Subject: [PATCH net-next v6 2/7] netlink: specs: Expand the PSE netlink
 command with C33 new features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-feature_poe_power_cap-v6-2-320003204264@bootlin.com>
References: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
In-Reply-To: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 linux-doc@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Expand the c33 PSE attributes with PSE class, extended state information
and power consumption.

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
	     --json '{"header":{"dev-name":"eth0"}}'
{'c33-pse-actual-pw': 1700,
 'c33-pse-admin-state': 3,
 'c33-pse-pw-class': 4,
 'c33-pse-pw-d-status': 4,
 'header': {'dev-index': 4, 'dev-name': 'eth0'}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
	     --json '{"header":{"dev-name":"eth0"}}'
{'c33-pse-admin-state': 3,
 'c33-pse-ext-state': 'mr-mps-valid',
 'c33-pse-ext-substate': 2,
 'c33-pse-pw-d-status': 2,
 'header': {'dev-index': 4, 'dev-name': 'eth0'}}

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- Update c33-pse-ext-state and c33-pse-ext-substate to u32
- Add enum for listing c33-pse-ext-state

Change in v4:
- Add name-prefix.
- Use hyphen-case instead of snwke_case.
- Use yaml list format.
- Updated substate list.
---
 Documentation/netlink/specs/ethtool.yaml | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 949e2722505d..3c7744acc6c7 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -24,6 +24,21 @@ definitions:
     name: module-fw-flash-status
     type: enum
     entries: [ started, in_progress, completed, error ]
+  -
+    name: c33-pse-ext-state
+    enum-name:
+    type: enum
+    name-prefix: ethtool-c33-pse-ext-state-
+    entries:
+        - none
+        - error-condition
+        - mr-mps-valid
+        - mr-pse-enable
+        - option-detect-ted
+        - option-vport-lim
+        - ovld-detected
+        - power-not-available
+        - short-detected
 
 attribute-sets:
   -
@@ -955,6 +970,23 @@ attribute-sets:
         name: c33-pse-pw-d-status
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-class
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-actual-pw
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-ext-state
+        type: u32
+        name-prefix: ethtool-a-
+        enum: c33-pse-ext-state
+      -
+        name: c33-pse-ext-substate
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1672,6 +1704,10 @@ operations:
             - c33-pse-admin-state
             - c33-pse-admin-control
             - c33-pse-pw-d-status
+            - c33-pse-pw-class
+            - c33-pse-actual-pw
+            - c33-pse-ext-state
+            - c33-pse-ext-substate
       dump: *pse-get-op
     -
       name: pse-set

-- 
2.34.1


