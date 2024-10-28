Return-Path: <netdev+bounces-139565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9748D9B319B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 14:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D802828F3
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E831DA305;
	Mon, 28 Oct 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="njnJGrsW"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68812AE8C;
	Mon, 28 Oct 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121839; cv=none; b=Xv1/jYdHBuwDnC7XXBoRuMGkm6cGnwlm0QHrk+QKk/XlezWXsnbEu3OidAQPYoqh3Dsx+fOSo3alAimVHWmX374WZ7EdX/lBeJk55H32ku3DM2Cq9MoBzyB0zexh676ti7B5X7C8cSvqJRWzR7saRKpjH99tJfF+1d6cwP18DJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121839; c=relaxed/simple;
	bh=gEMbi5qxENymLNxKYAFczZWzBdAX+/dVNMjqLtq+TDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KDOdlDgfLBlZA4AmSbu0anRx0Saxf/H8nURxNi86uv0dHf2U/Nv2tfBZq7lPv4Hr7+cy1XD/d5P9Ma5JFnmD+DY5EEkE8uxubFBQ3S1xQkDOBxzT7aJFDDtYrFWevBOZJ9SjnKnWq4OPgsub2m1J1Mf6gEd8umeUL2rbrWG2NOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=njnJGrsW; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9ADEF240029;
	Mon, 28 Oct 2024 13:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730121834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=APaln243WoT7nii0on9C4x7guubAGe/M53+of8eJv5s=;
	b=njnJGrsWVK9asMCMPGMctmF57Kox69zCrCfsz+LOIqCN4moXKSfkEO3SYkl9CsF/SPUrgi
	0/4NmfIhsL9hEFP4VdVjkp7IUK+57okxYbKVA0QtmylfKdVn2iboGERuCvL5kDgxTNVhKs
	41LVaa8rv/S7CMaITreDvHqf+p688YhDrjOzZlOCN8FGRChLQoxQFaAczDfw2yKTHG7AbS
	kfYqZM17n5yO7ICwMC8Pcxv49CJbyqm0ycBmSLT/ikYg4ayQgLjFiUSwmK0bRxwX/iIrg0
	qHYA/sZr+fgzC+aVwMcQ0I21hb4lpAxG+Xl8pZCFyzujAmbUBa1n2ivThXkCpw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v2] Documentation: networking: Add missing PHY_GET command in the message list
Date: Mon, 28 Oct 2024 14:23:51 +0100
Message-Id: <20241028132351.75922-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

ETHTOOL_MSG_PHY_GET/GET_REPLY/NTF is missing in the ethtool message list.
Add it to the ethool netlink documentation.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Change PHY_NTF documentation
---
 Documentation/networking/ethtool-netlink.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 295563e91082..b25926071ece 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -236,6 +236,7 @@ Userspace to kernel:
   ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
   ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``   flash transceiver module firmware
+  ``ETHTOOL_MSG_PHY_GET``               get Ethernet PHY information
   ===================================== =================================
 
 Kernel to userspace:
@@ -283,6 +284,8 @@ Kernel to userspace:
   ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
   ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
   ``ETHTOOL_MSG_MODULE_FW_FLASH_NTF``      transceiver module flash updates
+  ``ETHTOOL_MSG_PHY_GET_REPLY``            Ethernet PHY information
+  ``ETHTOOL_MSG_PHY_NTF``                  Ethernet PHY information change
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
-- 
2.34.1


