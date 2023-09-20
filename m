Return-Path: <netdev+bounces-35233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3C47A7E20
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343521C2099F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E0E30F8E;
	Wed, 20 Sep 2023 12:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807152E63B
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D44C433C7;
	Wed, 20 Sep 2023 12:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695212136;
	bh=H575bRTPoElpINF9yF6RhdCCUTc3Ej/a2wKGdnvU8T8=;
	h=From:To:Cc:Subject:Date:From;
	b=sPyy5wUduBlldhulEJTDY75t6fdiJXSP3KwK2MHv8c17A6s+ZbzGWsePv1aAnApw0
	 NJg6vsazYYm4RbyyYf8pjmt04mn2afoSaDqQ6mDo+wakwADTP7bndm5Cpu42jx1iql
	 DFEplbEoV3r6ZCxZ8rGkE4YUUzLciQO4zuFw740yX1s6qAPpR8KOUKJkgnIXbBYgEm
	 3CcMbvZ8yeZHMH4Jkg3P5HsQ5w2/xNqfyTHDN86AGT1Z8nnedhfVC50LvyDkaI32mg
	 XJofybMv8ky2cFUH9AISL29f85LNRkg0vj+H4W1SqtWufMS1q2yF7Dne0HjAzxTGax
	 RgFVctd1frv1w==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com
Cc: horms@kernel.org,
	s-vadapalli@ti.com,
	srk@ti.com,
	vigneshr@ti.com,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH net-next v4 0/3] net: ethernet: ti: am65-cpsw: Add mqprio and frame pre-emption
Date: Wed, 20 Sep 2023 15:15:27 +0300
Message-Id: <20230920121530.4710-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series adds mqprio qdisc offload in channel mode and
Frame Pre-emption MAC merge support for AM65 CPSW driver.

Changelog information in each patch file.

cheers,
-roger

Grygorii Strashko (1):
  net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode

Roger Quadros (2):
  net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
  net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
    support

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 150 ++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c     | 550 +++++++++++++++++---
 drivers/net/ethernet/ti/am65-cpsw-qos.h     | 112 ++++
 5 files changed, 745 insertions(+), 74 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1


