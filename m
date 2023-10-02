Return-Path: <netdev+bounces-37505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489957B5B65
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2876E1C2084E
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1F1F940;
	Mon,  2 Oct 2023 19:35:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B141D53B
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 19:35:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A5BDC;
	Mon,  2 Oct 2023 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WBSG551xTpINGiPaoSlT0YJNNZU7wlH+dq+VeSa6y8s=; b=4WWmj/xvGXz42YVSOaxsoIbPti
	jLqMTFH2Xr05KWwT0WUmaw6aExnzj3aVTbnuDhi9s9PXQRjCx1oCeDl9F2I3SMjJGDHSiTfnxP3Fw
	Ap5HmbgMUS3mVaBgiXC9AEmnAjIkspsJqAzxlv/jQIyvh8doje9fvksZ9IHfQgmTJ6Cx9xFm7YPrP
	kwqSDUx3f7dbQssuP97ZrCn5K0YW3ZlSLhwovJLB/jikgQxA9Fw7BTycsfL8eVJKZnDHm7Pybn81G
	Plij3HFAI7MJgnewCpwsezzc/IYswh9yK9espoI2bj39o0kcxQ7gnEqLSaq1LmfIBakeiwgqeu9pk
	c574okOQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qnOhn-00DIVR-1z;
	Mon, 02 Oct 2023 19:35:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2] net: lan743x: also select PHYLIB
Date: Mon,  2 Oct 2023 12:35:44 -0700
Message-ID: <20231002193544.14529-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since FIXED_PHY depends on PHYLIB, PHYLIB needs to be set to avoid
a kconfig warning:

WARNING: unmet direct dependencies detected for FIXED_PHY
  Depends on [n]: NETDEVICES [=y] && PHYLIB [=n]
  Selected by [y]:
  - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]

Fixes: 73c4d1b307ae ("net: lan743x: select FIXED_PHY")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202309261802.JPbRHwti-lkp@intel.com
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
v2: Also Cc: netdev and Microchip people;

 drivers/net/ethernet/microchip/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -46,6 +46,7 @@ config LAN743X
 	tristate "LAN743x support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	select PHYLIB
 	select FIXED_PHY
 	select CRC16
 	select CRC32

