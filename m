Return-Path: <netdev+bounces-100533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5CF8FB02A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8F31F21E00
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F35148310;
	Tue,  4 Jun 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f6cHHPW8"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BF148303;
	Tue,  4 Jun 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497629; cv=none; b=DmvLwQHYI8Td+EuzV4ss7kBJBVjt/Lr5MZcagg6k0JB5VwnvvFFYgSQ9aaADAIRJ+BpO719Z9ZJe9JJXo9+aYExJJLOzgez9BSD9f6xlM35iHCceFi9/h22PdVMcakmbxDc2aDyu5WD3z+IOLRRefrqsZAW90RHislILrXZF34E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497629; c=relaxed/simple;
	bh=5SC4SCTap6xR5jJu0SFRaajHz4hnnGaOKkU6KevpGPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iScR7NAIt1vMPUBN2e1OVq1a/NRcpgBVKgrmtI52s+zhie1/sosONuUGIJycdBR3daXLeBt2zyVDkAhWqUxKCBuIiopXQlGmlOmJ4oycGT+Amfg1eIsBfnP1T5fk0S6SaTpwRbEd//5X2HKgvSSpA+wACOor39pINFpjBDIfFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f6cHHPW8; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F1AC1BF205;
	Tue,  4 Jun 2024 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717497626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4D/WDNBi2rRpqkB1dWLbSf8v7lY2RM4BPVKzd1iG1gE=;
	b=f6cHHPW8PNb+8CeWlUKndx3IikEMhIshtA/2l+G4u/X5rXpZTwSXEPpJlYBafN2e79IG2d
	kXGLsVUtnCKwbzE81S2MMNkX7G/MyoTYgIOt7IeWuCF2tMoeG1jNQ6mGDA19/Y/4GaQHu0
	HYp55/Jc6ns8RHUz32ibVSFSsisBXhu/7DtHbMv+3DMeii4Y7zjngG/KJ+tlO/P/3b2hli
	8HmlVYsM66KCpyWpopNg0Aztpu8H70lM3G0WYZao/STGyrWr/5NkQvrx8yQpdzi0h0rB9F
	MCaJPt0V3w7Y3/Q3TYb1Q5wi9NYdPQd1fIzHLrLPEHzBQ0p8bu0sQ8qv5e6oGg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 04 Jun 2024 12:39:49 +0200
Subject: [PATCH net-next v14 14/14] netlink: specs: tsinfo: Enhance netlink
 attributes and add a set command
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-feature_ptp_netnext-v14-14-77b6f6efea40@bootlin.com>
References: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
In-Reply-To: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Add new attributed to tsinfo allowing to get the tsinfo and the hwtstamp
from a phc provider (composed by a phc index and a phc qualifier) on a
netdevice's link.
Add simultaneously a set command to be able to set hwtstamp configuration
for a specified phc provider.

Here is few examples:
./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema
             --dump tsinfo-get
             --json '{"header":{"dev-name":"eth0"}}'
[{'header': {'dev-index': 3, 'dev-name': 'eth0'},
  'hwtst-provider': {'index': 0, 'qualifier': 0},
  'phc-index': 0,
  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                  {'index': 2, 'name': 'some'}]},
                 'nomask': True,
                 'size': 16},
  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                    {'index': 2, 'name': 'hardware-receive'},
                                    {'index': 6,
                                     'name': 'hardware-raw-clock'}]},
                   'nomask': True,
                   'size': 17},
  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                                {'index': 1, 'name': 'on'}]},
               'nomask': True,
               'size': 4}},
 {'header': {'dev-index': 3, 'dev-name': 'eth0'},
  'hwtst-provider': {'index': 2, 'qualifier': 0},
  'phc-index': 2,
  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                  {'index': 1, 'name': 'all'}]},
                 'nomask': True,
                 'size': 16},
  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                    {'index': 1, 'name': 'software-transmit'},
                                    {'index': 2, 'name': 'hardware-receive'},
                                    {'index': 3, 'name': 'software-receive'},
                                    {'index': 4,
                                     'name': 'software-system-clock'},
                                    {'index': 6,
                                     'name': 'hardware-raw-clock'}]},
                   'nomask': True,
                   'size': 17},
  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                                {'index': 1, 'name': 'on'},
                                {'index': 2, 'name': 'onestep-sync'}]},
               'nomask': True,
               'size': 4}}]

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-get
             --json '{"header":{"dev-name":"eth0"},
                      "hwtst-provider":{"index":0, "qualifier":0 }
}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'hwtst-provider': {'index': 0, 'qualifier': 0},
 'phc-index': 0,
 'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                 {'index': 2, 'name': 'some'}]},
                'nomask': True,
                'size': 16},
 'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                   {'index': 2, 'name': 'hardware-receive'},
                                   {'index': 6, 'name': 'hardware-raw-clock'}]},
                  'nomask': True,
                  'size': 17},
 'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                               {'index': 1, 'name': 'on'}]},
              'nomask': True,
              'size': 4}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-set
             --json '{"header":{"dev-name":"eth0"},
                      "hwtst-provider":{"index":2, "qualifier":0}}'
None

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-get
             --json '{"header":{"dev-name":"eth0"}, "ghwtstamp":1}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'hwtst-flags': 1,
 'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'}]},
                'nomask': True,
                'size': 16},
 'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'}]},
              'nomask': True,
              'size': 4}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-set
             --json '{"header":{"dev-name":"eth0"},
                      "rx-filters":{"bits": {"bit": {"name":"ptpv2-l4-event"}},
                                    "nomask": 1},
                      "tx-types":{"bits": {"bit": {"name":"on"}},
                                  "nomask": 1}}'
None

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v8:
- New patch

Changes in v10:
- Add ghwtstamp attributes
- Add tsinfo ntf command

Changes in v11:
- Add examples in the commit message.

Changes in v13:
- Replace shorter name by real name.
- Fix an issue reported by "make -C tools/net/ynl" on the namings.
---
 Documentation/netlink/specs/ethtool.yaml | 43 +++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 00dc61358be8..80484908c5ee 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -576,6 +576,15 @@ attribute-sets:
       -
         name: tx-err
         type: uint
+  -
+    name: tsinfo-hwtstamp-provider
+    attributes:
+      -
+        name: index
+        type: u32
+      -
+        name: qualifier
+        type: u32
   -
     name: tsinfo
     attributes:
@@ -602,6 +611,16 @@ attribute-sets:
         name: stats
         type: nest
         nested-attributes: ts-stat
+      -
+        name: ghwtstamp
+        type: u8
+      -
+        name: hwtstamp-provider
+        type: nest
+        nested-attributes: tsinfo-hwtstamp-provider
+      -
+        name: hwtstamp-flags
+        type: u32
   -
     name: cable-result
     attributes:
@@ -1406,7 +1425,7 @@ operations:
       notify: eee-get
     -
       name: tsinfo-get
-      doc: Get tsinfo params.
+      doc: Get tsinfo params or hwtstamp config.
 
       attribute-set: tsinfo
 
@@ -1414,6 +1433,8 @@ operations:
         request:
           attributes:
             - header
+            - ghwtstamp
+            - hwtstamp-provider
         reply:
           attributes:
             - header
@@ -1422,6 +1443,8 @@ operations:
             - rx-filters
             - phc-index
             - stats
+            - hwtstamp-provider
+            - hwtstamp-flags
       dump: *tsinfo-get-op
     -
       name: cable-test-act
@@ -1730,3 +1753,21 @@ operations:
       name: mm-ntf
       doc: Notification for change in MAC Merge configuration.
       notify: mm-get
+    -
+      name: tsinfo-set
+      doc: Set hwtstamp.
+
+      attribute-set: tsinfo
+
+      do:
+        request:
+          attributes:
+            - header
+            - tx-types
+            - rx-filters
+            - hwtstamp-provider
+            - hwtstamp-flags
+    -
+      name: tsinfo-ntf
+      doc: Notification for change in tsinfo configuration.
+      notify: tsinfo-get

-- 
2.34.1


