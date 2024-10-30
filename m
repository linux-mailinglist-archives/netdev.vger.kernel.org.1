Return-Path: <netdev+bounces-140493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30769B6A02
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36C0281C81
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFE622ADA9;
	Wed, 30 Oct 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZXjVIAqU"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055BC229B53;
	Wed, 30 Oct 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307258; cv=none; b=fXwOVfjAveL1k7utkO/cFIXukMzJoID0iEHUhLKKFGi35IbuBTeXOwk2e3iV5lh7n+H2PF24p+qH+bs5L3dtvQdhpJRCPmAkQM021dF52M5w37F0o+qaDPs/9jhUUlfjEX894Kl52fdCyBEYg+sb1/DCVj3XWPNZDD2ZRKXpytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307258; c=relaxed/simple;
	bh=9cukOkYRogE1mhLOxtycmjYIZUWe3RSkVOyfP1/px2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DdJqEUqi0QuBLh7+8WTQxfkAu03kheKq3niakNwyxWeNDMhRIzEz6G9hwlrooJi2WkvjEItIRg0Uyh+IfBOnJZdVa1PAPUchxFPD+bsv/vNnhHUp5VrlbvLctxASoSG+Q1OWrjNmyvgKiEufDnKF0nxJPF+5Gh0Bl0dfS8YW69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZXjVIAqU; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69859C0005;
	Wed, 30 Oct 2024 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OObJe6vbRMobdbnH8FQ/PXBwgJ5Y8hlbjp8Qdz9Lv0M=;
	b=ZXjVIAqUqFhDrzAF5g11GjGgOYpNItTEkUzDCHQNCsSaQs4ebdDr9u8g8/GjP1v8JERFD8
	PuZtB9bsJxQGfmoqW8G9tRSo7sb0emHXo6ycJLoI4aOo8qMLKFPCpGUcV4IGTK+ZO4pcli
	0VlFm0mVbgI+YcS3U9r3E8yj2+KLD8VAFEGteSZGN5IwonmJbSpeYVq0+w7p5lGe4ZQtCY
	ypm5jioQ6TuIoV9OfhwkcBs/YHzG04KHq37LEpB/j1gFHj7ra60VFVawI65+Gf1tsOk3p7
	HfpBxisV0AjZTRIJGsn3ofLJqbK36SAMv2zhcd8KtFxJttwmDMPb/d12d9jjdQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 17:53:19 +0100
Subject: [PATCH RFC net-next v2 17/18] netlink: specs: Expand the PSE
 netlink command with newly supported features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_poe_port_prio-v2-17-9559622ee47a@bootlin.com>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
In-Reply-To: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Expand the c33 PSE attributes with PSE id, PSE power domain id, priority
and priority max to be able to set and get the PSE Power Interface
priority.

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
             --json '{"header":{"dev-name":"eth1"}}'
{'c33-pse-actual-pw': 1700,
 'c33-pse-admin-state': 3,
 'c33-pse-avail-pw-limit': 97500,
 'c33-pse-prio': 2,
 'c33-pse-prio-max': 2,
 'c33-pse-pw-class': 4,
 'c33-pse-pw-d-status': 4,
 'c33-pse-pw-limit-ranges': [{'max': 18100, 'min': 15000},
                             {'max': 38000, 'min': 30000},
                             {'max': 65000, 'min': 60000},
                             {'max': 97500, 'min': 90000}],
 'header': {'dev-index': 5, 'dev-name': 'eth1'}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set
             --json '{"header":{"dev-name":"eth1"},
                      "c33-pse-prio":1}'
None

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6983dea39976..5f5634acd24f 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1025,6 +1025,30 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: c33-pse-pw-limit
+      -
+        name: pse-id
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: pse-pw-d-id
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-prio-supp-modes
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-prio-mode
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-prio-max
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-prio
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1793,6 +1817,12 @@ operations:
             - c33-pse-ext-substate
             - c33-pse-avail-pw-limit
             - c33-pse-pw-limit-ranges
+            - pse-id
+            - pse-pw-d-id
+            - c33-pse-prio-supp-modes
+            - c33-pse-prio-mode
+            - c33-pse-prio-max
+            - c33-pse-prio
       dump: *pse-get-op
     -
       name: pse-set
@@ -1807,6 +1837,7 @@ operations:
             - podl-pse-admin-control
             - c33-pse-admin-control
             - c33-pse-avail-pw-limit
+            - c33-pse-prio
     -
       name: rss-get
       doc: Get RSS params.

-- 
2.34.1


