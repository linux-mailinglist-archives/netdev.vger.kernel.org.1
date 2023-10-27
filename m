Return-Path: <netdev+bounces-44855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEDB7DA236
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1875D2825FA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486183E017;
	Fri, 27 Oct 2023 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clqtMrw4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E13B7AF
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 21:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52867C433CB;
	Fri, 27 Oct 2023 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698441195;
	bh=OPecCp/XyMVm/dOfr6CPEQLzqByCbS27gtSKvJHfL7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clqtMrw4mgg0WIF5TrB8mawbvCRrtXl7hg2A9HE9ysr/WgpsU9CnMne3p3GHvohFH
	 vgRlB/W3LIEDz2O1QCrkD9gLScgngHC3NCIfEj2udljHjER9G3WQEi6mmOxjUMfAkG
	 AVFjs1Yyaarn5W28dcMopeeCOcjQNjkJTKkDl9xOvhLX7qJ4GPc6ZQGHC7HFSDod/I
	 beOqil6OxVrO46L8pzTg8AiXwZN2+Ycosk2NJqnpKg3gxKYc4RgUKdGf5JdmO5wtZ5
	 0IyFgxNYwv4ZvnzByenWjgah619aUoECncmjXhMYmIqCU3oOQmub04LykIKjEVpigq
	 5cwezDt5SEvew==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	jonbither@gmail.com
Subject: [PATCH net-next v2 1/4] net: fill in MODULE_DESCRIPTION()s in kuba@'s modules
Date: Fri, 27 Oct 2023 14:13:08 -0700
Message-ID: <20231027211311.1821605-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027211311.1821605-1-kuba@kernel.org>
References: <20231027211311.1821605-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Fill it in for the modules I maintain.

Acked-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jonbither@gmail.com

v2: s/USD/USB/

 drivers/net/netdevsim/netdev.c              | 1 +
 drivers/net/wireless/mediatek/mt7601u/usb.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 2eac92f49631..aecaf5f44374 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -470,4 +470,5 @@ static void __exit nsim_module_exit(void)
 module_init(nsim_module_init);
 module_exit(nsim_module_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Simulated networking device for testing");
 MODULE_ALIAS_RTNL_LINK(DRV_NAME);
diff --git a/drivers/net/wireless/mediatek/mt7601u/usb.c b/drivers/net/wireless/mediatek/mt7601u/usb.c
index cc772045d526..c41ae251cb95 100644
--- a/drivers/net/wireless/mediatek/mt7601u/usb.c
+++ b/drivers/net/wireless/mediatek/mt7601u/usb.c
@@ -365,6 +365,7 @@ static int mt7601u_resume(struct usb_interface *usb_intf)
 
 MODULE_DEVICE_TABLE(usb, mt7601u_device_table);
 MODULE_FIRMWARE(MT7601U_FIRMWARE);
+MODULE_DESCRIPTION("MediaTek MT7601U USB Wireless LAN driver");
 MODULE_LICENSE("GPL");
 
 static struct usb_driver mt7601u_driver = {
-- 
2.41.0


