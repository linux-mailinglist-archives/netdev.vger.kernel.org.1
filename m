Return-Path: <netdev+bounces-215263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B246B2DD6C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE986270CA
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442331CA57;
	Wed, 20 Aug 2025 13:10:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827B31DD81
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695457; cv=none; b=XupuqBqGC/Cz/2oNPw6CIri+zEp/Fkee5FZt5R8hVIbvfsS3Q7IGzArdkNAmeOdfRWjiES4TWKGmX0u8h/2Pp+8P8eW/G/2Sit59azK0dRLkGF7eimeJ6eIgRdcxp8SpUquq6p//nCbnWFZlXazIWkVjeAXu5HLaOZyFU7iMJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695457; c=relaxed/simple;
	bh=fhBwj0/qXS75pS91i/DiEjnO64GV2qzUt87N+q2z4SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhaA7dod14nAdpsb02mV/2KmazK4uCj9Yto1c5amcY+KtHwoAhQGpW0uXqFgK8UaNQ1ZJtvUYyULd33/rarQDJD6M5Nh/APyenOMxTnH4Y6+moHxAchw6HElzKeBCV06cJG86X1kOb2pkyxrVynj3PZphPZgK0Fa7DpjFGIhaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uoiaA-0007YG-9h; Wed, 20 Aug 2025 15:10:26 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uoia8-001Fnd-2G;
	Wed, 20 Aug 2025 15:10:24 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uoia8-003atK-1x;
	Wed, 20 Aug 2025 15:10:24 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v3 1/3] tools: ynl-gen: generate kdoc for attribute enums
Date: Wed, 20 Aug 2025 15:10:21 +0200
Message-Id: <20250820131023.855661-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250820131023.855661-1-o.rempel@pengutronix.de>
References: <20250820131023.855661-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Parse 'doc' strings from the YAML spec to generate kernel-doc comments
for the corresponding enums in the C UAPI header, making the headers
self-documenting.

The generated comment format depends on the documentation available:
 - a full kdoc block ('/**') with @member tags is used if attributes are
   documented
 - a simple block comment ('/*') is used if only the set itself has a doc
   string

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index ef032e17fec4..d7634560c461 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3225,6 +3225,29 @@ def render_uapi(family, cw):
         if attr_set.subset_of:
             continue
 
+        # Write kdoc for attribute-set enums
+        has_main_doc = 'doc' in attr_set.yaml and attr_set.yaml['doc']
+        has_attr_doc = any('doc' in attr for _, attr in attr_set.items())
+
+        if has_main_doc or has_attr_doc:
+            if has_attr_doc:
+                cw.p('/**')
+                # Construct the main description line for the enum
+                doc_line = f"enum {c_lower(family.ident_name + '_' + attr_set.name)}"
+                if has_main_doc:
+                    doc_line += f" - {attr_set.yaml['doc']}"
+                cw.write_doc_line(doc_line)
+
+                # Write documentation for each attribute (enum member)
+                for _, attr in attr_set.items():
+                    if 'doc' in attr and attr['doc']:
+                        doc = f"@{attr.enum_name}: {attr['doc']}"
+                        cw.write_doc_line(doc)
+            else:  # Only has main doc, use a simpler comment block
+                cw.p('/*')
+                cw.write_doc_line(attr_set.yaml['doc'], indent=False)
+            cw.p(' */')
+
         max_value = f"({attr_set.cnt_name} - 1)"
 
         val = 0
-- 
2.39.5


