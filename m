Return-Path: <netdev+bounces-47096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD07E7BF1
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC591C20D8E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D3C179A7;
	Fri, 10 Nov 2023 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7571B281
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:45:18 +0000 (UTC)
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 440B5311A3
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 03:45:17 -0800 (PST)
Received: from labnh.int.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 662117D07C;
	Fri, 10 Nov 2023 11:38:37 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>
Subject: [RFC ipsec-next 1/8] iptfs: config: add CONFIG_XFRM_IPTFS
Date: Fri, 10 Nov 2023 06:37:12 -0500
Message-ID: <20231110113719.3055788-2-chopps@chopps.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110113719.3055788-1-chopps@chopps.org>
References: <20231110113719.3055788-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/Kconfig  | 9 +++++++++
 net/xfrm/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index 3adf31a83a79..d07852069e68 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -134,6 +134,15 @@ config NET_KEY_MIGRATE
 
 	  If unsure, say N.
 
+config XFRM_IPTFS
+	bool "IPsec IPTFS (RFC 9347) encapsulation support"
+	depends on XFRM
+	help
+	  Information on the IPTFS encapsulation can be found
+          in RFC 9347.
+
+          If unsure, say N.
+
 config XFRM_ESPINTCP
 	bool
 
diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index cd47f88921f5..9b870a3274a7 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -20,4 +20,5 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
 obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
 obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
 obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
+obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
 obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
-- 
2.42.0


