Return-Path: <netdev+bounces-43322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922F7D25EE
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 22:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7961F2176E
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 20:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A112B71;
	Sun, 22 Oct 2023 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TtDPyhZ4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA2111AA
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 20:53:30 +0000 (UTC)
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76803F2
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=uqg/71DNqlYBu9Jd0uaNQkliMLuejjBAWornZC8f+ow=; b=TtDPyh
	Z4kNmQAGAqlzU5OBx6xIhRUsA7YOLj8CMIeuyFNwXXF1gssGLBZBh1HCYaISfe1B
	rI9mYIAxxhwCjmkhQTI3xCU3076yfZitZc40+hG2loG8uyHpuhsh1btaINzxoGto
	KQWzzDMTzppx3iw6bwlUbnD2bgF+nTtEU20frctr7b4TL6YJGFawkb/OA65Gqera
	aQzUyt9h8l7yGxC6eJ+H9uyJOUqwVnK0OuxB0YVNikmUdatd33ZAmhHkA+zKUNaR
	BBA1mKsj/gSRbXaZZkkuc+MS+DePVP/NdqEcBiQBI0kYd2OEZZR3Hea5nFi7dteq
	jzNmdZh7bGD8oZlw==
Received: (qmail 1741676 invoked from network); 22 Oct 2023 22:53:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Oct 2023 22:53:25 +0200
X-UD-Smtp-Session: l3s3148p1@8XPzS1QIrMcujnvq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: ethernet: renesas: group entries in Makefile
Date: Sun, 22 Oct 2023 22:53:15 +0200
Message-Id: <20231022205316.3209-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
References: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new Renesas driver shall be added soon. Prepare the Makefile by
grouping the specific objects to the Kconfig symbol for better
readability. Improve the file description a tad while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/ethernet/renesas/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/Makefile b/drivers/net/ethernet/renesas/Makefile
index 592005893464..e8fd85b5fe8f 100644
--- a/drivers/net/ethernet/renesas/Makefile
+++ b/drivers/net/ethernet/renesas/Makefile
@@ -1,14 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Makefile for the Renesas device drivers.
+# Makefile for the Renesas network device drivers
 #
 
 obj-$(CONFIG_SH_ETH) += sh_eth.o
 
 ravb-objs := ravb_main.o ravb_ptp.o
-
 obj-$(CONFIG_RAVB) += ravb.o
 
 rswitch_drv-objs := rswitch.o rcar_gen4_ptp.o
-
 obj-$(CONFIG_RENESAS_ETHER_SWITCH) += rswitch_drv.o
-- 
2.35.1


