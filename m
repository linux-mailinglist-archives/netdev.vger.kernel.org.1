Return-Path: <netdev+bounces-246186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E98CE527F
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 16:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E8A63002D2F
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85CB2C0F96;
	Sun, 28 Dec 2025 15:59:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.blochl.de (mail.blochl.de [151.80.40.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D12D5925;
	Sun, 28 Dec 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.40.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937584; cv=none; b=rVa5R+7t9dOpwabAsrSCiDkd6Cd1FAUamu1ayywLrSH5b2AhKhLQGDFTYUUi8SHJMjlv/dAIpF8EQmC5R6P2uvrTHB8B2ybw0lw0toADuqKgVsQv3ZVo+mLw00r4EE3uBF79uOoZfzAkFBUIjVB65vIwCfW44mcCsGe4Tz+5HNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937584; c=relaxed/simple;
	bh=h+al5x7QZBZWGD1yV7+Jx5X8R7CzoykSu4n9nRd6UyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eIywCw5iuSMaqqUlA+dFKz9saU73DRW81cRP21a2/FE1cnAKwS3QFHgaOOg4HSKCEMbPCUYUe+zeocXDQyOmOblROXgTehNlkGBOe+YvB/unEJLxBf+Z11QfyTgcsNlwYiqXjuHxXajh7md2eBelfEO3ea2YnVafpzeSUkwIdoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de; spf=pass smtp.mailfrom=blochl.de; arc=none smtp.client-ip=151.80.40.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blochl.de
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.blochl.de 3516946C0140
Authentication-Results: mail.blochl.de; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: mail.blochl.de; spf=fail smtp.mailfrom=blochl.de
Received: from WorkKnecht (ppp-93-104-30-36.dynamic.mnet-online.de [93.104.30.36])
	by smtp.blochl.de (Postfix) with ESMTPSA id 3516946C0140;
	Sun, 28 Dec 2025 15:53:03 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at 0aeafd614e10
Date: Sun, 28 Dec 2025 16:52:59 +0100
From: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vikas Gupta <vikas.gupta@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>
Subject: [PATCH net] net: bnge: add AUXILIARY_BUS to Kconfig dependencies
Message-ID: <20251228-bnge_aux_bus-v1-1-82e273ebfdac@blochl.de>
X-B4-Tracking: v=1; b=H4sIAIpRUWkC/x2MQQqAIBAAvxJ7TtBNKfpKRGhttRcLzRCivycdZ
 2DmgUiBKUJfPRDo5siHL6DqCubd+o0EL4UBJRqF2AlX3GRTnlyKQtvZtbpB2TgDJTkDrZz/3QC
 eLhjf9wMlHxWpYwAAAA==
X-Change-ID: 20251228-bnge_aux_bus-4acb743203b5
X-Mailer: b4 0.14.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (smtp.blochl.de [0.0.0.0]); Sun, 28 Dec 2025 15:53:03 +0000 (UTC)

The build can currently fail with

    ld: drivers/net/ethernet/broadcom/bnge/bnge_auxr.o: in function `bnge_rdma_aux_device_add':
    bnge_auxr.c:(.text+0x366): undefined reference to `__auxiliary_device_add'
    ld: drivers/net/ethernet/broadcom/bnge/bnge_auxr.o: in function `bnge_rdma_aux_device_init':
    bnge_auxr.c:(.text+0x43c): undefined reference to `auxiliary_device_init'

if BNGE is enabled but no other driver pulls in AUXILIARY_BUS.

Select AUXILIARY_BUS in BNGE like in all other drivers which create
an auxiliary_device.

Fixes: 8ac050ec3b1c ("bng_en: Add RoCE aux device support")
Signed-off-by: Markus Blöchl <markus@blochl.de>
---
Basic steps to reproduce:
- make allnoconfig
- manually enable just PCI, NETDEVICES, ETHERNET, NET_VENDOR_BROADCOM and BNGE
- make
---
 drivers/net/ethernet/broadcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index ca565ace6e6a..cd7dddeb91dd 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -259,6 +259,7 @@ config BNGE
 	depends on PCI
 	select NET_DEVLINK
 	select PAGE_POOL
+	select AUXILIARY_BUS
 	help
 	  This driver supports Broadcom ThorUltra 50/100/200/400/800 gigabit
 	  Ethernet cards. The module will be called bng_en. To compile this

---
base-commit: 4d1442979e4a53b9457ce1e373e187e1511ff688
change-id: 20251228-bnge_aux_bus-4acb743203b5

Best regards,
-- 
Markus Blöchl <markus@blochl.de>


-- 

