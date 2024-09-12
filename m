Return-Path: <netdev+bounces-127748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE453976525
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD4AB2241D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5038119259B;
	Thu, 12 Sep 2024 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hJcTxavP"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7E136338;
	Thu, 12 Sep 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131987; cv=none; b=mY+RRJ63mN1NufB5oNnHLKns8Wqg00+zr+C4O58SmpMmmwrivWImGeuIbpmv9xb2972ndx0R31FLCKoPrFoKSeyLHB/Ypu5guvRritppdtAtT1JWj+u3aH+Aww5uRBHImgXGaZ8wxTR7w6L1azoru7xgM6TA1sttT8nXZuUJkKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131987; c=relaxed/simple;
	bh=gmWaGnaYgvGtbS+/WmvQDW233G9+1neW7bCLMHLlyQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LdeD6P6/MYfddpNzqsbek6/O9bMUZWCmxsqhDNXA8UXrR6X4vnaRau2eoFKq8OHPQKe1NR8+KgrRPVwpInm0BkBf1YZvaJxRb7iE1q5sASkQ1KpaMBfyKUu3bRhtxWixNZJAdZ10AxR4unExjuAu0ZrVVM08P1YSq8eAxzJVfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hJcTxavP; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 830EB24000A;
	Thu, 12 Sep 2024 09:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726131982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IF+Eaipz1NUyYQfRLpw/7X4WaLCiU+z8IzAnLdbUwUQ=;
	b=hJcTxavPDHghkve0RstAdi2ef2NNqHjw2MxQEDkpMRuz3G0m4iEF05cjhuexy1lfJDZeyS
	LxQNYsljFGd/OVcU+lOxw34N1WiuqYHnpc8ZTk58AoILmF7vjf4MOEQDoEnTwe1CWRmT03
	8fNywin7C88k2rVdGM7ccykm84fILrS3J7k4z9rVg00ytxHmSjWJiQ7EQFmBl00enOMhh1
	Kv44vOqy4XAhVJRmh/1O+rFiDHqCgD7Krc2nlRKjrlpfYq/GdE2uRAaVuu5TYZsTDylSCM
	iSAqlhRivio+zaeRT2u3C1ZaWHNicnGmDCx39LQvupZchWcSeon5fPgx9dmI0Q==
From: Kory Maincent <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v2] Documentation: networking: Fix missing PSE documentation and grammar issues
Date: Thu, 12 Sep 2024 11:05:50 +0200
Message-Id: <20240912090550.743174-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Fix a missing end of phrase in the documentation. It describes the
ETHTOOL_A_C33_PSE_ACTUAL_PW attribute, which was not fully explained.

Also, fix grammar issues by using simple present tense instead of
present continuous.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Add grammar issue fixes.
---
 Documentation/networking/ethtool-netlink.rst | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index ba90457b8b2d..295563e91082 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1768,7 +1768,7 @@ Kernel response contents:
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
 the operational state of the PoDL PSE functions.  The operational state of the
 PSE function can be changed using the ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``
-action. This option is corresponding to ``IEEE 802.3-2018`` 30.15.1.1.2
+action. This attribute corresponds to ``IEEE 802.3-2018`` 30.15.1.1.2
 aPoDLPSEAdminState. Possible values are:
 
 .. kernel-doc:: include/uapi/linux/ethtool.h
@@ -1782,8 +1782,8 @@ The same goes for ``ETHTOOL_A_C33_PSE_ADMIN_STATE`` implementing
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_PW_D_STATUS`` attribute identifies
 the power detection status of the PoDL PSE.  The status depend on internal PSE
-state machine and automatic PD classification support. This option is
-corresponding to ``IEEE 802.3-2018`` 30.15.1.1.3 aPoDLPSEPowerDetectionStatus.
+state machine and automatic PD classification support. This attribute
+corresponds to ``IEEE 802.3-2018`` 30.15.1.1.3 aPoDLPSEPowerDetectionStatus.
 Possible values are:
 
 .. kernel-doc:: include/uapi/linux/ethtool.h
@@ -1797,12 +1797,13 @@ The same goes for ``ETHTOOL_A_C33_PSE_ADMIN_PW_D_STATUS`` implementing
 
 When set, the optional ``ETHTOOL_A_C33_PSE_PW_CLASS`` attribute identifies
 the power class of the C33 PSE. It depends on the class negotiated between
-the PSE and the PD. This option is corresponding to ``IEEE 802.3-2022``
+the PSE and the PD. This attribute corresponds to ``IEEE 802.3-2022``
 30.9.1.1.8 aPSEPowerClassification.
 
 When set, the optional ``ETHTOOL_A_C33_PSE_ACTUAL_PW`` attribute identifies
-This option is corresponding to ``IEEE 802.3-2022`` 30.9.1.1.23 aPSEActualPower.
-Actual power is reported in mW.
+the actual power drawn by the C33 PSE. This attribute corresponds to
+``IEEE 802.3-2022`` 30.9.1.1.23 aPSEActualPower. Actual power is reported
+in mW.
 
 When set, the optional ``ETHTOOL_A_C33_PSE_EXT_STATE`` attribute identifies
 the extended error state of the C33 PSE. Possible values are:
@@ -1851,7 +1852,7 @@ Request contents:
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
-to control PoDL PSE Admin functions. This option is implementing
+to control PoDL PSE Admin functions. This option implements
 ``IEEE 802.3-2018`` 30.15.1.2.1 acPoDLPSEAdminControl. See
 ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` for supported values.
 
-- 
2.34.1


