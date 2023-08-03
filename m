Return-Path: <netdev+bounces-24229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3150176F5E1
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 01:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622DC1C21676
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA2263DC;
	Thu,  3 Aug 2023 23:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1CEA0
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 23:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C42DC433C8;
	Thu,  3 Aug 2023 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691103610;
	bh=ccIm1rGe3Hp7krzzcqx6GlPuhX/o5ZBv4ZaK5p/gSPE=;
	h=From:To:Cc:Subject:Date:From;
	b=HAROorNh3rStWyOoJv8JDjDoQNDFYlQ2xQWoUvoSHcuhKFrw7zo/ONa0k4vgwNf2T
	 EtCORCrSBQjL6gN6sb9+f7SVDnd9GM9lbFnV73avwh51KlDmz75Lm+a6Jelm9azVbu
	 bbjb71o8SxRLOKgyutrkyexoNZRaEzLE7fawsyEaPjo9Lajf9BMl6fgIQYfO8xxHE0
	 xB3tK5D4afVeuv6c/tQQMnLzmrHtfzKIHHWtEBGdg3fSrdVuIBEEonStXmPAsm3AK1
	 XXG+I2GjGM9AbGoLuM5yM90ox/t0SWrDwg/ey2MgAREaOjG+OYiYNfPE/q9VpvDu9U
	 U08WBM/mHp9dQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	kernel test robot <lkp@intel.com>,
	madalin.bucur@nxp.com,
	martin.lau@kernel.org
Subject: [PATCH net-next] eth: dpaa: add missing net/xdp.h include
Date: Thu,  3 Aug 2023 16:00:07 -0700
Message-ID: <20230803230008.362214-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing include for DPAA (fix aarch64 build).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308040620.ty8oYNOP-lkp@intel.com/
Fixes: 680ee0456a57 ("net: invert the netdevice.h vs xdp.h dependency")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: madalin.bucur@nxp.com
CC: martin.lau@kernel.org
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
index 35b8cea7f886..ac3c8ed57bbe 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
@@ -8,6 +8,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/refcount.h>
+#include <net/xdp.h>
 #include <soc/fsl/qman.h>
 #include <soc/fsl/bman.h>
 
-- 
2.41.0


