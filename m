Return-Path: <netdev+bounces-127430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F689755F9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB141F22EB3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199621A3033;
	Wed, 11 Sep 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kEVH4LO2"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041A71E50B;
	Wed, 11 Sep 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066050; cv=none; b=PVC6Hvb1CepqAhP1Hec5zUIBHWkowJzjswexw3e7IM6YveSUfSaJzhLTg6u0RkQ34U4YFnRNcG+dGadSzTd7p/yPFPk399RKW7Xjbqf2XdZCpHcwkvwU3e1kpCDckErgMYtA+Aj0F84XEXTKUviSiRtkBh6kiOCYDpJ2TvecYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066050; c=relaxed/simple;
	bh=Jk9sM3WSppSXZ5GFNuGb0uqqwzkDmHlVY6tlSZiILdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zgp8hwqV8HpqnpHT+qd0e9kHGRWl2DaD0N1Xe14yqggkoC2dZwg5bsRw/5UWDGc6w7a0Oa6yjCK9mAsBjpsomyWwuIJjKrX6xM3KhBg2SpXI6PkI02Gy05mZq7YuoRpaRpQBSMKLonYUlrNFrj3y3uMUy/6VPJImuUMjCCqKAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kEVH4LO2; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF3D6C0006;
	Wed, 11 Sep 2024 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726066038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mevpMli+Ir0LCy4bWmSREdhaCAndezP3bc2kWgPkQ1I=;
	b=kEVH4LO2Jk3B/d3bzJdE9D1vmm9FZL7JcSPP430UN2hztQeN8jUDsQFaN5ddwl37MS/jAu
	5vjvDtL4GXlnFu6fE+BOahkOi6Fj/4EJnOjT2YNiF92OBRisevPBSxIGvcgMpovLKg2p+6
	kcM6zvJ4ntQ60Z+TWWGnKu/a8sIrCdx/nNI9wt3ZzAnp4CQqSXLVmE1ZJCCC+bNVOxDl4j
	EkepAnnMRNT9PnYn6JLWepInDNI1L2Gx3EnOgRwqD9l9HSEgWy0aRURnqCrLaNFwbfCEsR
	wkW23g9ei9ZPkLMETGR2M4ak63IpDp0cYmZmOzaV7rwCAS4hjYv58Gb7r2xV4Q==
From: Kory Maincent <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next] Documentation: networking: Fix missing PSE documentation issue
Date: Wed, 11 Sep 2024 16:47:11 +0200
Message-Id: <20240911144711.693216-1-kory.maincent@bootlin.com>
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

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/networking/ethtool-netlink.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index ba90457b8b2d..b1390878ba84 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1801,8 +1801,9 @@ the PSE and the PD. This option is corresponding to ``IEEE 802.3-2022``
 30.9.1.1.8 aPSEPowerClassification.
 
 When set, the optional ``ETHTOOL_A_C33_PSE_ACTUAL_PW`` attribute identifies
-This option is corresponding to ``IEEE 802.3-2022`` 30.9.1.1.23 aPSEActualPower.
-Actual power is reported in mW.
+the actual power drawn by the C33 PSE. This option is corresponding to
+``IEEE 802.3-2022`` 30.9.1.1.23 aPSEActualPower. Actual power is reported
+in mW.
 
 When set, the optional ``ETHTOOL_A_C33_PSE_EXT_STATE`` attribute identifies
 the extended error state of the C33 PSE. Possible values are:
-- 
2.34.1


