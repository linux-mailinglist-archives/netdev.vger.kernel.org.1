Return-Path: <netdev+bounces-218344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE1B3C0C2
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D46A1C88085
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB33375AD;
	Fri, 29 Aug 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OVtktu26"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB5322DAA;
	Fri, 29 Aug 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485009; cv=none; b=uLvMr7iLoiQgdcCE5Ukn8CqYZpIOLzwlAWDkV7x6+pXNzseL27nmBgl0MC98HYBdZVXPxWzNUNgZAOKVHJJsblNX6BGS9aCnLAHP0GCY1EFfdf8NNy4WL06jZ6Z+XsMueVNhUocOOuFTAmB+oA4UCNd33wLXrrsfk6Z+JSnGqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485009; c=relaxed/simple;
	bh=1fC6qPHhw0+ReUKx7i0sZJqlysF67p/4YIgETaU4kAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlveDUzHl+lQ1nJOgTHBz/aw/RQBV8WEcrKbQ1xDYet7aFErCA+LDCSYLstK4QE0+18+vrL8UYt3YDYUfs3azN22uAP0YHj+0lP6+l9BLuy9LW/eTBYn8t1BxYlcJESiqrYwTDUgs2pwfnX75OAObIzRYSyomLt/BeX8YadUT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OVtktu26; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E51B71A0E43;
	Fri, 29 Aug 2025 16:30:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BD972605F1;
	Fri, 29 Aug 2025 16:30:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AFB71C22DC9A;
	Fri, 29 Aug 2025 18:30:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756485004; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7Z/vVaiwPDqUIpffCxIZ4JsTPL7u+izJHcekcnCQ+bw=;
	b=OVtktu26HdJEMs3GIss/zzWd1tOEkxZaGce+ith9pHLeaF57Z/QwrGtoSOiKbErgfJEVQb
	1XGFxjwGL8g8Yo4uVPnvm3sY9IwmfAIsQEGquRqdhigbVmRTZ5QclgODGo4HakqNQOq8jm
	3fdc3pCGN4j/0qThuzZDknUlktHv3CponcoyFkDzS16lDW1XtRlAJ8+pEeNSo6JsGkacwB
	zirLFyiaxpHVy9+NfR+oSSn/pZ1hzwUZQyvsQexcG9rnuEpRP7Nu2WV8T2fXYP+YFgW9Ms
	OnAq9LeCBRghil/gML3YTPlh+FmduyM6Ur9BBWG4SoZS6xgKoOAw1Azqg8DIhA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 29 Aug 2025 18:28:45 +0200
Subject: [PATCH net-next v2 3/4] docs: devlink: Sort table of contents
 alphabetically
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-feature_poe_permanent_conf-v2-3-8bb6f073ec23@bootlin.com>
References: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
In-Reply-To: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-doc@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Sort devlink documentation table of contents alphabetically to improve
readability and make it easier to locate specific chapters.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- New patch
---
 Documentation/networking/devlink/index.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 270a65a014111..0c58e5c729d92 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -56,18 +56,18 @@ general.
    :maxdepth: 1
 
    devlink-dpipe
+   devlink-eswitch-attr
+   devlink-flash
    devlink-health
    devlink-info
-   devlink-flash
+   devlink-linecard
    devlink-params
    devlink-port
    devlink-region
-   devlink-resource
    devlink-reload
+   devlink-resource
    devlink-selftests
    devlink-trap
-   devlink-linecard
-   devlink-eswitch-attr
 
 Driver-specific documentation
 -----------------------------
@@ -78,12 +78,14 @@ parameters, info versions, and other features it supports.
 .. toctree::
    :maxdepth: 1
 
+   am65-nuss-cpsw-switch
    bnxt
    etas_es58x
    hns3
    i40e
-   ionic
    ice
+   ionic
+   iosm
    ixgbe
    kvaser_pciefd
    kvaser_usb
@@ -93,11 +95,9 @@ parameters, info versions, and other features it supports.
    mv88e6xxx
    netdevsim
    nfp
-   qed
-   ti-cpsw-switch
-   am65-nuss-cpsw-switch
-   prestera
-   iosm
    octeontx2
+   prestera
+   qed
    sfc
+   ti-cpsw-switch
    zl3073x

-- 
2.43.0


