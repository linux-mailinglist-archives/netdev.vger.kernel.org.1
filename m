Return-Path: <netdev+bounces-41901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F27CC1D8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A52B20D90
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EDA41AB0;
	Tue, 17 Oct 2023 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646B41AA4
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:34:06 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFE8C9F;
	Tue, 17 Oct 2023 04:34:04 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; 
   d="scan'208";a="179586175"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Oct 2023 20:34:04 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 11D4540083CC;
	Tue, 17 Oct 2023 20:34:04 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH net-next v3 0/2] rswitch: Add PM ops
Date: Tue, 17 Oct 2023 20:34:00 +0900
Message-Id: <20231017113402.849735-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch is based on the latest net-next.git / next branch.
After applied this patch with the following patches, the system can
enter/exit Suspend to Idle without any error:
https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=next&id=aa4c0bbf820ddb9dd8105a403aa12df57b9e5129
https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=next&id=1a5361189b7acac15b9b086b2300a11b7aa84c06

Changes from v2:
https://lore.kernel.org/all/20231013121936.364678-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest net-next.git / main branch.
 - Change the subject in the patch 1/2.
 - Fix a condition to avoid endless loop in the patch 1/2.

Changes from v1:
https://lore.kernel.org/all/20231012121618.267315-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest net-next.git / main branch. So, the following patches
   are already merged.
   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=510b18cf23b9bd8a982ef7f1fb19f3968a2bf787
   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=053f13f67be6d02781730c9ac71abde6e9140610
 - Add a new patch to use unsigned int for array index in the patch 1/2.
 - Use unsigned int for array index in the patch 2/2.
 - Use DEFINE_SIMPLE_DEV_PM_OPS() and drop __maybe_unused tags in the patch 2/2.
 - Use pm_sleep_ptr() in the patch 2/2.

Yoshihiro Shimoda (2):
  rswitch: Use unsigned int for port related array index
  rswitch: Add PM ops

 drivers/net/ethernet/renesas/rswitch.c | 53 ++++++++++++++++++++++++--
 drivers/net/ethernet/renesas/rswitch.h |  2 +-
 2 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.25.1


