Return-Path: <netdev+bounces-269607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDomJDc7vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:06:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B14F2D0883
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 762CB30054FE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2C39478E;
	Thu, 19 Mar 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cf8182Ew"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960E03F23C1;
	Thu, 19 Mar 2026 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943579; cv=none; b=fOhYzkSOpWkZNNxyB841oypZc7ga+7tDQCpH+rsuiCm3766la47xyWjygLP6jro31uIGbbUa7N+cv4CdAwkonn/i8dOHDAJyPM4C7vCpUYiMxWHxxXWaA1ECz3BmbkXwqC1O/ARRA5glOvJhhgurL9Kt134+7Eo2joKBA3TQsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943579; c=relaxed/simple;
	bh=yWk/zb9i8ADanjUib5zN8DNeoubD6Ix0yXiODg8nCVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xa5O9Kt0qM4l00nx1VFauQWhPi05C9U2d4Rb9uPosrwqY7swctL+Ps2+VJqFLxzoPagmveAml4pZDkkgUCMdHCk1VPlIqQOTyXj3JOdvug7YagCQwGWvz5iLLF85uEnFQy655U4faRuCWLephWvJ8A2wvAvCrBKRwqD/oc9V4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cf8182Ew; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 25DF14E42720;
	Thu, 19 Mar 2026 18:06:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E607260050;
	Thu, 19 Mar 2026 18:06:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E1F2104509E1;
	Thu, 19 Mar 2026 19:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773943568; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=OkVYPQSURTBGS15S9WGvvX1Mht2CQVANXCjZE0kpWCc=;
	b=cf8182EwTCdErhj5Y+wDxN3p7MXSOctat29Lp05Tx+K1WTrj+VFKbtUQYSBhvjV7oZkcBE
	nBfi64Wttri4NCUPR33H0RkKRgY7fdHWnV8hYdEINb+3GrnqLXx5WxXq/k8C4Y5COnknQH
	Hlewb0CwtrbwXBJZoluUBsHfhHXkB+GUCNRcY4yEFPoNLg81xaN7ZSSixUN1eOvGVAEHwo
	ym8InBPkNXP1kenoL8AqlfSQdPij0k2qYYUI8/6/FkOK2Z2/ucRP2siINiyffHgh18n4u6
	Yne09BYUf9VTEacbEp7B8MqcjIJ7oU5pqACvYfO0tGvseesOCdB/p3Tkqawf9g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethtool: re-order local includes
Date: Thu, 19 Mar 2026 19:05:54 +0100
Message-ID: <20260319180555.1531386-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,nxp.com,gmail.com,pengutronix.de,bootlin.com,iogearbox.net];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269607-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:email,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: 3B14F2D0883
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most local #include in the ethtool command handling is out of order,
with either :

 #include "netlink.h"
 #include "common.h"

or even :

 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"

One of the reasons is because bitset.h s lacking definitions for
nlattr, netlink_ext_ack, ETH_GSTRING_LEN, and types such as u32, bool,
etc.

Make bitset.h standalone by including <linux/ethtool.h> for
ETH_GSTRING_LEN, and <linux/netlink.h> for nlattr, netlink_ext_ack and
the rest.

While at it, take a pass on ethnl sources to re-order the local
includes :
 - put them after the global includes
 - add a newline between global and local includes
 - alpha-sort the local includes

One notable exception is the cmis.h include, that needs definitions from
module_fw.h. Keep them in this order for now.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/bitset.c      | 3 ++-
 net/ethtool/bitset.h      | 3 +++
 net/ethtool/cabletest.c   | 3 ++-
 net/ethtool/channels.c    | 2 +-
 net/ethtool/coalesce.c    | 3 ++-
 net/ethtool/common.c      | 2 +-
 net/ethtool/debug.c       | 4 ++--
 net/ethtool/eee.c         | 4 ++--
 net/ethtool/eeprom.c      | 3 ++-
 net/ethtool/features.c    | 4 ++--
 net/ethtool/fec.c         | 4 ++--
 net/ethtool/ioctl.c       | 1 +
 net/ethtool/linkinfo.c    | 2 +-
 net/ethtool/linkmodes.c   | 4 ++--
 net/ethtool/linkstate.c   | 5 +++--
 net/ethtool/module.c      | 4 ++--
 net/ethtool/mse.c         | 2 +-
 net/ethtool/netlink.c     | 3 ++-
 net/ethtool/pause.c       | 2 +-
 net/ethtool/phc_vclocks.c | 2 +-
 net/ethtool/phy.c         | 6 +++---
 net/ethtool/plca.c        | 2 +-
 net/ethtool/privflags.c   | 4 ++--
 net/ethtool/pse-pd.c      | 7 ++++---
 net/ethtool/rings.c       | 2 +-
 net/ethtool/rss.c         | 2 +-
 net/ethtool/stats.c       | 4 ++--
 net/ethtool/strset.c      | 3 ++-
 net/ethtool/tsconfig.c    | 6 +++---
 net/ethtool/tsinfo.c      | 4 ++--
 net/ethtool/wol.c         | 4 ++--
 31 files changed, 58 insertions(+), 46 deletions(-)

diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index f0883357d12e..8bb98d3ea3db 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -2,8 +2,9 @@
 
 #include <linux/ethtool_netlink.h>
 #include <linux/bitmap.h>
-#include "netlink.h"
+
 #include "bitset.h"
+#include "netlink.h"
 
 /* Some bitmaps are internally represented as an array of unsigned long, some
  * as an array of u32 (some even as single u32 for now). To avoid the need of
diff --git a/net/ethtool/bitset.h b/net/ethtool/bitset.h
index c2c2e0051d00..07bc547d47a8 100644
--- a/net/ethtool/bitset.h
+++ b/net/ethtool/bitset.h
@@ -3,6 +3,9 @@
 #ifndef _NET_ETHTOOL_BITSET_H
 #define _NET_ETHTOOL_BITSET_H
 
+#include <linux/ethtool.h>
+#include <linux/netlink.h>
+
 #define ETHNL_MAX_BITSET_SIZE S16_MAX
 
 typedef const char (*const ethnl_string_array_t)[ETH_GSTRING_LEN];
diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 0364b8fb577b..8d375dac2a40 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -3,8 +3,9 @@
 #include <linux/phy.h>
 #include <linux/ethtool_netlink.h>
 #include <net/netdev_lock.h>
-#include "netlink.h"
+
 #include "common.h"
+#include "netlink.h"
 
 /* 802.3 standard allows 100 meters for BaseT cables. However longer
  * cables might work, depending on the quality of the cables and the
diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index ca4f80282448..45232cf1c144 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -2,8 +2,8 @@
 
 #include <net/xdp_sock_drv.h>
 
-#include "netlink.h"
 #include "common.h"
+#include "netlink.h"
 
 struct channels_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 349bb02c517a..1e2c5c7048a8 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/dim.h>
-#include "netlink.h"
+
 #include "common.h"
+#include "netlink.h"
 
 struct coalesce_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index e252cf20c22f..6a4a3797a812 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -8,8 +8,8 @@
 #include <linux/phy_link_topology.h>
 #include <net/netdev_queues.h>
 
-#include "netlink.h"
 #include "common.h"
+#include "netlink.h"
 #include "../core/dev.h"
 
 
diff --git a/net/ethtool/debug.c b/net/ethtool/debug.c
index 0b2dea56d461..6043916b440e 100644
--- a/net/ethtool/debug.c
+++ b/net/ethtool/debug.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
+#include "common.h"
+#include "netlink.h"
 
 struct debug_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index bf398973eb8a..50d6fcd3661b 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
+#include "common.h"
+#include "netlink.h"
 
 struct eee_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index 3b8209e930fd..caf1e41e676b 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -2,8 +2,9 @@
 
 #include <linux/ethtool.h>
 #include <linux/sfp.h>
-#include "netlink.h"
+
 #include "common.h"
+#include "netlink.h"
 
 struct eeprom_req_info {
 	struct ethnl_req_info	base;
diff --git a/net/ethtool/features.c b/net/ethtool/features.c
index f2217983be2b..d9455b30aec9 100644
--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -2,9 +2,9 @@
 
 #include <net/netdev_lock.h>
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
+#include "common.h"
+#include "netlink.h"
 
 struct features_req_info {
 	struct ethnl_req_info	base;
diff --git a/net/ethtool/fec.c b/net/ethtool/fec.c
index 4669e74cbcaa..e2d539271060 100644
--- a/net/ethtool/fec.c
+++ b/net/ethtool/fec.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
+#include "common.h"
+#include "netlink.h"
 
 struct fec_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index ff4b4780d6af..11dfbf076b6d 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -33,6 +33,7 @@
 #include <net/flow_offload.h>
 #include <net/netdev_lock.h>
 #include <linux/ethtool_netlink.h>
+
 #include "common.h"
 
 /* State held across locks and calls for commands which have devlink fallback */
diff --git a/net/ethtool/linkinfo.c b/net/ethtool/linkinfo.c
index 30b8ce275159..244ff92e2ff9 100644
--- a/net/ethtool/linkinfo.c
+++ b/net/ethtool/linkinfo.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "netlink.h"
 #include "common.h"
+#include "netlink.h"
 
 struct linkinfo_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/linkmodes.c b/net/ethtool/linkmodes.c
index 259cd9ef1f2a..30d703531652 100644
--- a/net/ethtool/linkmodes.c
+++ b/net/ethtool/linkmodes.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
+#include "common.h"
+#include "netlink.h"
 
 /* LINKMODES_GET */
 
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 05a5f72c99fa..8a5985fd7712 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "netlink.h"
-#include "common.h"
 #include <linux/phy.h>
 #include <linux/phylib_stubs.h>
 
+#include "common.h"
+#include "netlink.h"
+
 struct linkstate_req_info {
 	struct ethnl_req_info		base;
 };
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 0a761bf4771e..cad2eb25b5a4 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -6,10 +6,10 @@
 #include <net/devlink.h>
 #include <net/netdev_lock.h>
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
+#include "common.h"
 #include "module_fw.h"
+#include "netlink.h"
 
 struct module_req_info {
 	struct ethnl_req_info base;
diff --git a/net/ethtool/mse.c b/net/ethtool/mse.c
index 8cb3fc5e7be4..e91b74430f76 100644
--- a/net/ethtool/mse.c
+++ b/net/ethtool/mse.c
@@ -4,8 +4,8 @@
 #include <linux/phy.h>
 #include <linux/slab.h>
 
-#include "netlink.h"
 #include "common.h"
+#include "netlink.h"
 
 /* Channels A-D only; WORST and LINK are exclusive alternatives */
 #define PHY_MSE_CHANNEL_COUNT 4
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 6e5f0f4f815a..14cb06ec5171 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -6,8 +6,9 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/phy_link_topology.h>
 #include <linux/pm_runtime.h>
-#include "netlink.h"
+
 #include "module_fw.h"
+#include "netlink.h"
 
 static struct genl_family ethtool_genl_family;
 
diff --git a/net/ethtool/pause.c b/net/ethtool/pause.c
index 5d28f642764c..29f812e935b6 100644
--- a/net/ethtool/pause.c
+++ b/net/ethtool/pause.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "netlink.h"
 #include "common.h"
+#include "netlink.h"
 
 struct pause_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/phc_vclocks.c b/net/ethtool/phc_vclocks.c
index cadaabed60bd..15146e38ab27 100644
--- a/net/ethtool/phc_vclocks.c
+++ b/net/ethtool/phc_vclocks.c
@@ -2,8 +2,8 @@
 /*
  * Copyright 2021 NXP
  */
-#include "netlink.h"
 #include "common.h"
+#include "netlink.h"
 
 struct phc_vclocks_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 68372bef4b2f..d4e6887055ab 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -3,14 +3,14 @@
  * Copyright 2023 Bootlin
  *
  */
-#include "common.h"
-#include "netlink.h"
-
 #include <linux/phy.h>
 #include <linux/phy_link_topology.h>
 #include <linux/sfp.h>
 #include <net/netdev_lock.h>
 
+#include "common.h"
+#include "netlink.h"
+
 struct phy_req_info {
 	struct ethnl_req_info base;
 };
diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index e1f7820a6158..91f0c4233298 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -3,8 +3,8 @@
 #include <linux/phy.h>
 #include <linux/ethtool_netlink.h>
 
-#include "netlink.h"
 #include "common.h"
+#include "netlink.h"
 
 struct plca_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/privflags.c b/net/ethtool/privflags.c
index 297be6a13ab9..46a4d2a43ba8 100644
--- a/net/ethtool/privflags.c
+++ b/net/ethtool/privflags.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
+#include "common.h"
+#include "netlink.h"
 
 struct privflags_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 24def9c9dd54..2eb9bdc2dcb9 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -6,14 +6,15 @@
 // Copyright (c) 2022 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
 //
 
-#include "common.h"
-#include "linux/pse-pd/pse.h"
-#include "netlink.h"
 #include <linux/ethtool_netlink.h>
 #include <linux/ethtool.h>
 #include <linux/export.h>
 #include <linux/phy.h>
 
+#include "common.h"
+#include "linux/pse-pd/pse.h"
+#include "netlink.h"
+
 struct pse_req_info {
 	struct ethnl_req_info base;
 };
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index aeedd5ec6b8c..0fd5dcc3729f 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -2,8 +2,8 @@
 
 #include <net/netdev_queues.h>
 
-#include "netlink.h"
 #include "common.h"
+#include "netlink.h"
 
 struct rings_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index da5934cceb07..0f4e5cd2ac71 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -2,8 +2,8 @@
 
 #include <net/netdev_lock.h>
 
-#include "netlink.h"
 #include "common.h"
+#include "netlink.h"
 
 struct rss_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 3ca8eb2a3b31..38136f19b2ec 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -3,9 +3,9 @@
 #include <linux/phy.h>
 #include <linux/phylib_stubs.h>
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
+#include "common.h"
+#include "netlink.h"
 
 struct stats_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index f6a67109beda..aa1e50c98f34 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -2,8 +2,9 @@
 
 #include <linux/ethtool.h>
 #include <linux/phy.h>
-#include "netlink.h"
+
 #include "common.h"
+#include "netlink.h"
 
 struct strset_info {
 	bool per_dev;
diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index e49e612a68c2..e4f518e49d4c 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -3,11 +3,11 @@
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
-#include "../core/dev.h"
+#include "common.h"
+#include "netlink.h"
 #include "ts.h"
+#include "../core/dev.h"
 
 struct tsconfig_req_info {
 	struct ethnl_req_info base;
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index c0145c752d2f..9aad62695dfb 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -6,9 +6,9 @@
 #include <linux/ptp_clock_kernel.h>
 #include <net/netdev_lock.h>
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
+#include "common.h"
+#include "netlink.h"
 #include "ts.h"
 
 struct tsinfo_req_info {
diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
index a39d8000d808..60f9a1d8535e 100644
--- a/net/ethtool/wol.c
+++ b/net/ethtool/wol.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include "netlink.h"
-#include "common.h"
 #include "bitset.h"
+#include "common.h"
+#include "netlink.h"
 
 struct wol_req_info {
 	struct ethnl_req_info		base;
-- 
2.49.0


