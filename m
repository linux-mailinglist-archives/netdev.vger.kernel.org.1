Return-Path: <netdev+bounces-138277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5309ACC0F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D706A1F224B9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D461B85C5;
	Wed, 23 Oct 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IDRNyp98"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B571DDAB;
	Wed, 23 Oct 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692975; cv=none; b=eQwATFzcpEdBjKc86CwoKfbLcUoTSeRGvchN3MoZotk9ZrM09ioyO05ANYc3HqUjckI8LCPFKFaQ6yL7ZdO7vWT6GTr12DmGi62Fbrc2yp4LYnT+7LPL/tseQwaguyrvYcqoRbcFAImdEUa7nN3OU3ZEcXw2vUrIxr2DTcCswHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692975; c=relaxed/simple;
	bh=PYn0/G4zbkeddnkUt9zimJ5fgr19m6ni9SlxG7d9aoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XZ9fNtQVGNeOfPZzmrHzQXl4T0SDgxowkDSvOTlFfD2ZtRplvWcZAuVkJealeFWuJ09PHAMGf2I41P8ATM4gzlfLxdpuzVZvCTd0qMT0DVDIyFDbHQlq3ksWypiOmOHZSXjmvha30Z6J1PqPaAKWlbnK4MUFWvUNLnE7X1qkaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IDRNyp98; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A9E31BF204;
	Wed, 23 Oct 2024 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729692965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=82jccvIIGFuz0O4xWiEnBCoVG+FlKjZjshEnZFYt54E=;
	b=IDRNyp98d7l1TShz2R8J5Zk2IvD7P87/mk2H0VTExHO79H3QotsVDiOz/SuCUdqyKP1dVx
	7e3qPQHv1GkwF9zMGHluhCLxbdUtrPlJxlCoBon3t8OxzuroXPEf9tHQw5a2TNpP+0koXe
	B7eCWcDl6PDwx6fCDRLPUpt48dWtXfw8cqRFDzVKiQgkbeiIcVXvtatL+/+meyx7Jx9jS1
	C9ftgqESQQ0xOtiHNvI3tbWekuNWNvaf7pHn65GenOpu3Gf6rABZGx80meczGHsOitCLPD
	Zw5H95YvHt42y8zEzqenHwUcFngjT/yv2f9YAb4Z3ypkVvVT5KuEMIDrxso6Eg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next] Documentation: networking: Add missing PHY_GET command in the message list
Date: Wed, 23 Oct 2024 16:15:58 +0200
Message-Id: <20241023141559.100973-1-kory.maincent@bootlin.com>
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
 Documentation/networking/ethtool-netlink.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 295563e91082..70ecc3821007 100644
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
+  ``ETHTOOL_MSG_PHY_NTF``                  Ethernet PHY information
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
-- 
2.34.1


