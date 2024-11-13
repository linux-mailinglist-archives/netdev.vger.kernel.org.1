Return-Path: <netdev+bounces-144383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB669C6E7E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63438282742
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CA0200B84;
	Wed, 13 Nov 2024 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKseVK6G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302461FF5E5;
	Wed, 13 Nov 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498942; cv=none; b=iVFfoT9Jt2Hh2QkvBHvg0k0+gn/SuTMQeJJanmdKLNzqYoFQ3crnLrouUmAOv0xcMVhz5s9O7iMk0X3iXARNG87VvQIMBOgjmUwnvsLHw0MvY/cpCWABFKytUr6ajDl8XobZGN0DkA2E71RjtvBVRWVSmzPimn9BYqHlVcfzkJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498942; c=relaxed/simple;
	bh=iovqs40/iE4xWRqK075NczG6y3maZGipRgITa/sx7jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fYOLSMtbffFozryxKf1u4N445vS0AoG8M+BNNrdYr7AzGxz6HF6gSg+0hD4yucze1/JulV5VNxnOucsanQjj8VfE9ox1RmDpW9DPyVsp454uXaSnW7ufewbj2bdEPnAwhEjejwplFSGpku9oDO1KR4pX1BxOd30hZCiN2oV/ypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKseVK6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6815FC4CECD;
	Wed, 13 Nov 2024 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731498941;
	bh=iovqs40/iE4xWRqK075NczG6y3maZGipRgITa/sx7jo=;
	h=From:To:Cc:Subject:Date:From;
	b=kKseVK6GqYZSQxXYO7M3Kj6KL4/hHMkOadZJhAJ/KQYXYd6Tch/8w95y+bvrOriR+
	 paL99S/geuZAP1SkdktXmcULash3X/TPn0N0OU1bm/WRKxMYiBvFKe1VewEffBaOiT
	 eNPnm5P903eGiGCQqo2t/Vb0m+hrcGO3GWfkFaS3cPVwAeQWNmBcnxJFDK8Cvzs60I
	 xy44X1Y+0R918u9jT00W26mJPb6jcRM3ryoM4j4fsJU1aQrx1uZ7mU2ED20t+/LGC4
	 PDzXWHbr5495V9y+Tz5qv/4Ebeev/MTpBxkmtLZaIZrPcZ7gic4KkogQauzXPmVMQm
	 txvQ62ttSmwlQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Jens=20Emil=20Schulz=20=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: sparx5: add missing lan969x Kconfig dependency
Date: Wed, 13 Nov 2024 12:55:08 +0100
Message-Id: <20241113115513.4132548-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The sparx5 switchdev driver can be built either with or without support
for the Lan969x switch. However, it cannot be built-in when the lan969x
driver is a loadable module because of a link-time dependency:

arm-linux-gnueabi-ld: drivers/net/ethernet/microchip/sparx5/sparx5_main.o:(.rodata+0xd44): undefined reference to `lan969x_desc'

Add a Kconfig dependency to reflect this in Kconfig, allowing all
the valid configurations but forcing sparx5 to be a loadable module
as well if lan969x is.

Fixes: 98a01119608d ("net: sparx5: add compatible string for lan969x")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Side note: given that lan969x is always built as part of sparx5,
wouldn't it make more sense to move all of it into the sparx5
subdirectory?
---
 drivers/net/ethernet/microchip/lan969x/Kconfig  | 2 +-
 drivers/net/ethernet/microchip/lan969x/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan969x/Kconfig b/drivers/net/ethernet/microchip/lan969x/Kconfig
index 728180d3fa33..c5c6122ae2ec 100644
--- a/drivers/net/ethernet/microchip/lan969x/Kconfig
+++ b/drivers/net/ethernet/microchip/lan969x/Kconfig
@@ -1,5 +1,5 @@
 config LAN969X_SWITCH
-	tristate "Lan969x switch driver"
+	bool "Lan969x switch driver"
 	depends on SPARX5_SWITCH
 	help
 	  This driver supports the lan969x family of network switch devices.
diff --git a/drivers/net/ethernet/microchip/lan969x/Makefile b/drivers/net/ethernet/microchip/lan969x/Makefile
index 9a2351b4f111..316405cbbc71 100644
--- a/drivers/net/ethernet/microchip/lan969x/Makefile
+++ b/drivers/net/ethernet/microchip/lan969x/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Microchip lan969x network device drivers.
 #
 
-obj-$(CONFIG_LAN969X_SWITCH) += lan969x-switch.o
+obj-$(CONFIG_SPARX5_SWITCH) += lan969x-switch.o
 
 lan969x-switch-y := lan969x_regs.o lan969x.o lan969x_calendar.o \
  lan969x_vcap_ag_api.o lan969x_vcap_impl.o
-- 
2.39.5


