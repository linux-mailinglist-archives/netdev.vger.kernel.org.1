Return-Path: <netdev+bounces-19178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30DE759E23
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F4D1C21179
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D62514F;
	Wed, 19 Jul 2023 19:00:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7925140
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:06 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853B9171E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 39E86D8FFC;
	Wed, 19 Jul 2023 20:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792736; bh=EaIcxpmjNc0QR061uuCm3jYP1iKJaulaybDKpl3lFAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lg2LqL6ThxgTpYxmBJgcmA8wu7aS1qMVJs89x7UH/tM7ieonjMOGb8+gKQm+dV4Vt
	 eFiQIp2xfA2I8ayJwgkXultUEJ54Zg58/jTcBml7yljCXF810vXnpYGF76UsNBAi+m
	 oDg6Gg6HTRcEiZPMXB4oNhWUGGLzIZxKNGcvNK4tq5B1Z0OE2GoE4x7jGZEQdSMBW+
	 lnTsoPvLXfbYbagBnCwCMT4h+jNyTz0DjmpoirAu0mp4ucB2OgwnP4/1Ji9pb1OjbS
	 ylh0Im+f5K00DFkDCJtRAKqbKc2/nmGV9CQc2sEkqe3TAk1J7p8LHiDD5kMEsTy32Y
	 kUiZHhUGY4x6Q==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 02/22] Makefile: Add CONF_USR_DIR for system-installed configuration files
Date: Wed, 19 Jul 2023 20:50:46 +0200
Message-Id: <20230719185106.17614-3-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719185106.17614-1-gioele@svario.it>
References: <20230719185106.17614-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Gioele Barabucci <gioele@svario.it>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 54e5cde2..a2af4426 100644
--- a/Makefile
+++ b/Makefile
@@ -17,6 +17,7 @@ endif
 PREFIX?=/usr
 SBINDIR?=/sbin
 CONF_ETC_DIR?=/etc/iproute2
+CONF_USR_DIR?=$(PREFIX)/lib/iproute2
 NETNS_RUN_DIR?=/var/run/netns
 NETNS_ETC_DIR?=/etc/netns
 DATADIR?=$(PREFIX)/share
@@ -37,7 +38,8 @@ ifneq ($(SHARED_LIBS),y)
 DEFINES+= -DNO_SHARED_LIBS
 endif
 
-DEFINES+=-DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
+DEFINES+=-DCONF_USR_DIR=\"$(CONF_USR_DIR)\" \
+         -DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
          -DNETNS_RUN_DIR=\"$(NETNS_RUN_DIR)\" \
          -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\"
 
-- 
2.39.2


