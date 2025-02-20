Return-Path: <netdev+bounces-168055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C330CA3D385
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FB43BBB02
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070401EB9F4;
	Thu, 20 Feb 2025 08:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EEC1E571F
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040992; cv=none; b=qLd5ZPQZup7ZiAsb9dySlD8XHeYjuhFFWVumSaFWbgRIrsl+VOwWR7OueT5R6RSl2lEvfXXLT3xm559UNJybURe1T8A3SWolyu88xDW2Q19gCo9afOSZgJz/VQyq01a2umIF1YBqfvsipLazkQTMe+y4D/06TGxqYeyDLE/HK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040992; c=relaxed/simple;
	bh=Hkw0dJOHNLo4uG1zeS+vveeIZfudqlrwwysZ+Gis3Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I4vlo35K2LKG614ZVDBU2VB7k+N2U89JHZ4Mv9jaySGCUID4VYYGr7ZhLTh/vo+EnJggrGXivJoVBk8mTc5zEsi5zm9DJWvmiLwQvmHfmEMqBjselyy+DrxOX6Igti6loGPU0Y4sSJ8HsWlnkilLA70pCRhRgKgGaEART1Gws9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tl29E-00045c-3F; Thu, 20 Feb 2025 09:43:08 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tl29C-001uGv-2R;
	Thu, 20 Feb 2025 09:43:06 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tl29C-00Bd85-28;
	Thu, 20 Feb 2025 09:43:06 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 20 Feb 2025 09:43:06 +0100
Subject: [PATCH] net: ethernet: ti: am65-cpsw: select PAGE_POOL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-net-am654-nuss-kconfig-v1-1-acc813b769de@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIABnrtmcC/x3MQQqEMAxA0atI1gZqp4p4FXHRaqpBjNI4w4B4d
 4vLt/j/AqXEpNAVFyT6sfIuGVVZwLh4mQl5ygZrbG2sNSh0ot+a2qF8VXEdd4k8ow8tuejoU7U
 Bcnwkivx/x/1w3w9pHZMBaAAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740040986; l=856;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Hkw0dJOHNLo4uG1zeS+vveeIZfudqlrwwysZ+Gis3Z4=;
 b=nkfiD2uWiAR1+JfH8eMTAN23n0hol/3LLSYhN+TwwdZyg856EYpg0o8Xs3OKckE8L285KmLWV
 xQNw6IlZDWZB0RWdD4xHK5KFm8xkiIPAOFcepfGuD3jTHprhxDDZTWU
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

am65-cpsw uses page_pool_dev_alloc_pages(), thus needs PAGE_POOL
selected to avoid linker errors.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 0d5a862cd78a6..3a13d60a947a8 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -99,6 +99,7 @@ config TI_K3_AM65_CPSW_NUSS
 	select NET_DEVLINK
 	select TI_DAVINCI_MDIO
 	select PHYLINK
+	select PAGE_POOL
 	select TI_K3_CPPI_DESC_POOL
 	imply PHY_TI_GMII_SEL
 	depends on TI_K3_AM65_CPTS || !TI_K3_AM65_CPTS

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250220-net-am654-nuss-kconfig-ab8e4f4e318b

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


