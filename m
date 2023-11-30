Return-Path: <netdev+bounces-52688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFFF7FFAF3
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 20:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5EA1C20EA9
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034DD5FF0C;
	Thu, 30 Nov 2023 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nKtL2f+I"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF210F1;
	Thu, 30 Nov 2023 11:14:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75D1420002;
	Thu, 30 Nov 2023 19:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701371645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PV0l1NIZNMh69B6nDjZj0YkTHvJCTXzHrPnQeeMYxTI=;
	b=nKtL2f+I4jSys+yl/ptWrpQaSC+/CEoTXI9xtpH71qWWquuuubZUw96Jd1uyW6Wi0qk45m
	1aM6E5lPLv8ThCwZKABHjDT+c7ltdl+2HWs6o2BgSSZl4wjxVWsI6wGVZDZ5wTh3m8JYLY
	o3gyJlcI2sTwXi9JwbX1hdOXQPO45kW87kg2Kxx75FHpSU+kzpc3vppivUhK3WGWHdr7m4
	LkH2Dlm/whTu9l5hFTUjj6c//NJo7PNLBh6WiwS7M0ckt8L+tNPDmQW/CC/wf5onYBZyh7
	YlqfVBezVsLZ+SQM7eE14ZlxX+1Wpkskzconk2xBzLbGKDoI/m4XY4G1wjEjoA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Jonathan Corbet <corbet@lwn.net>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] Documentation: networking: add missing PLCA messages from the message list
Date: Thu, 30 Nov 2023 20:13:59 +0100
Message-ID: <20231130191400.817948-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Physical Layer Collision Avoidance messages are correctly documented but
were left-out of the global list of ethnl messages, add them to the
list.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/ethtool-netlink.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 2540c70952ff..6a49624a9cbf 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -223,6 +223,9 @@ Userspace to kernel:
   ``ETHTOOL_MSG_PSE_SET``               set PSE parameters
   ``ETHTOOL_MSG_PSE_GET``               get PSE parameters
   ``ETHTOOL_MSG_RSS_GET``               get RSS settings
+  ``ETHTOOL_MSG_PLCA_GET_CFG``          get PLCA RS parameters
+  ``ETHTOOL_MSG_PLCA_SET_CFG``          set PLCA RS parameters
+  ``ETHTOOL_MSG_PLCA_GET_STATUS``       get PLCA RS status
   ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
   ===================================== =================================
@@ -267,6 +270,9 @@ Kernel to userspace:
   ``ETHTOOL_MSG_MODULE_GET_REPLY``         transceiver module parameters
   ``ETHTOOL_MSG_PSE_GET_REPLY``            PSE parameters
   ``ETHTOOL_MSG_RSS_GET_REPLY``            RSS settings
+  ``ETHTOOL_MSG_PLCA_GET_CFG_REPLY``       PLCA RS parameters
+  ``ETHTOOL_MSG_PLCA_GET_STATUS_REPLY``    PLCA RS status
+  ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
   ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
   ======================================== =================================
 
-- 
2.42.0


