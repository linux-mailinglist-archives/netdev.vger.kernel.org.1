Return-Path: <netdev+bounces-73611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FED85D617
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33881C219D9
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4903E47C;
	Wed, 21 Feb 2024 10:52:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460EC3EA6F
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512775; cv=none; b=Nh4dGtTFzVSg2rVzdGxxmxEvj0fJ7UYrOfqAzfYl4/GwwAKb48ycOBYe+sVpxJsFsm7da033ho+97i02awxOy6Dn//Rt3ncmED2fdomCwiqg2IAHuxF2kQMmqHa52N0hHmw6t/DWKKh1Gst3F+zqjElNCimWz3iwQn+le+39vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512775; c=relaxed/simple;
	bh=xdqio47qX0QHz+F+MzyEbD62K3UDC1/NI6DWIDHjdy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrpXBctRVcBIr7ZyJdxiAdHSPCG6mQ6gY2U+JagCe4hQ+xms/zuWf5JXNvdxSp/RLXa4MQNu+u7R6Qc4PNw02eJwpcbjlwgM2y3cO48EZkOmQeOk3Iiln4mwETiDBWP2wNqSDhRNYJkmA9rZHwbkaLEJKKwaEo5l1hZBy49jXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5450:2f24:6e58:231d])
	by michel.telenet-ops.be with bizsmtp
	id pmsi2B00C59vpg206msiir; Wed, 21 Feb 2024 11:52:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rckDK-001FTk-0D;
	Wed, 21 Feb 2024 11:52:42 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rckDS-00Bltk-9j;
	Wed, 21 Feb 2024 11:52:42 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [net-next] octeon_ep_vf: Improve help text grammar
Date: Wed, 21 Feb 2024 11:52:41 +0100
Message-Id: <b3b97462c3d9eba2ec03dd6d597e63bf49a7365a.1708512706.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing articles.
Fix plural vs. singular.
Fix present vs. future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig b/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig
index dbd1267bda0c00e3..e371a3ef0c49a1d7 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig
@@ -8,12 +8,12 @@ config OCTEON_EP_VF
 	depends on 64BIT
 	depends on PCI
 	help
-	  This driver supports networking functionality of Marvell's
+	  This driver supports the networking functionality of Marvell's
 	  Octeon PCI Endpoint NIC VF.
 
-	  To know the list of devices supported by this driver, refer
+	  To know the list of devices supported by this driver, refer to the
 	  documentation in
 	  <file:Documentation/networking/device_drivers/ethernet/marvell/octeon_ep_vf.rst>.
 
-	  To compile this drivers as a module, choose M here. Name of the
-	  module is octeon_ep_vf.
+	  To compile this driver as a module, choose M here.
+	  The name of the module will be octeon_ep_vf.
-- 
2.34.1


