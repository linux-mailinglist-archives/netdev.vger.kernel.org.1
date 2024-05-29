Return-Path: <netdev+bounces-99055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B22C8D38C9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E49F1C20DF9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B3200CB;
	Wed, 29 May 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V3JjvTv6"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA61CAB0;
	Wed, 29 May 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991782; cv=none; b=IG5HYn2NhLT1Hp8FgKpgyjla4lYBiBz8OROPAj3cS8yvd18du4hOTUQr6KN0QFI3RMmDGraR1KYl65lFnp5JbN8qSdmxKZWLHFjA7uRMOo2hFSAnzYkxQZRiGaBe4L+7FlzOGRlDEyac78ZoSwoT2ZdgsgxRrAQCpBmUrIflDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991782; c=relaxed/simple;
	bh=+bP/22xQiFd116zCqbH0fpzRttA7dXKpkwmoSq8t2xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucHo9eDjWLZm5XoGwE3svpU4tYMhs8jJHbkyl67FGsDzth50vYjcGpY1kdWVk/omKSvUbm9ZR+qpe0AoTwEuMTYYr2UOUrvgV9MOBKQniJohKmgp2pRrK9txwF4NIxJREnL/jcDqFbvZoA26Qb1TEKCeH4CbQH+MAgfsSMezVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V3JjvTv6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0240340002;
	Wed, 29 May 2024 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716991777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MP3SXUKiRdFIc55Wy63iB6MDo+HEoEyyYvRE69gtp8=;
	b=V3JjvTv6Nb5o6Uq/QUVBL0gPT5hnZ6K/vJn989qJSL3R4VL2efBS7fS+6AfBs8JzJB8wAW
	KkLr6l+xI4mpWjojtMd5yEmmHxB1ySNTmO7NjO0wNJJr2SJHYGxsQYgDsS20qmnfrzZXkk
	j8CtYMJWyLj9qzSHiaDDEgYFSdfv13HC4g917tIJdJAdAm/H6d8YB8ZTFX2i12Ye4ckwUh
	12esfODE0QzTGB+mk/gnx7MZlX42PE098f9h8VfQWKZX4+IGq3fHWL4ZpWm/h2u3pEnVTX
	dZvX6Jj200KpDSPLg7iPwWRvL7U8KZNT//l5rehRVxnbljcEXqJPwCDYM4yNEg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 29 May 2024 16:09:30 +0200
Subject: [PATCH 3/8] netlink: specs: Expand the PSE netlink command with
 C33 new features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-feature_poe_power_cap-v1-3-0c4b1d5953b8@bootlin.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
In-Reply-To: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

Expand the c33 PSE attributes with PSE class, status message and power
consumption.

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
	     --json '{"header":{"dev-name":"eth0"}}'
{'c33-pse-actual-pw': 1800,
 'c33-pse-admin-state': 3,
 'c33-pse-pw-class': 4,
 'c33-pse-pw-d-status': 4,
 'c33-pse-pw-status-msg': b'2P Port delivering IEEE.\x00',
 'header': {'dev-index': 4, 'dev-name': 'eth0'}}

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 00dc61358be8..bb51c293435d 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -922,6 +922,18 @@ attribute-sets:
         name: c33-pse-pw-d-status
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-status-msg
+        type: binary
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-class
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-actual-pw
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1611,6 +1623,9 @@ operations:
             - c33-pse-admin-state
             - c33-pse-admin-control
             - c33-pse-pw-d-status
+            - c33-pse-pw-status-msg
+            - c33-pse-pw-class
+            - c33-pse-actual-pw
       dump: *pse-get-op
     -
       name: pse-set

-- 
2.34.1


