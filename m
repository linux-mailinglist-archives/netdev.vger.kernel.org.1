Return-Path: <netdev+bounces-36427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B907AFC0A
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 09:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AAC3B281C9F
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 07:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C1114AA4;
	Wed, 27 Sep 2023 07:27:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C663DB
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 07:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC65EC433C7;
	Wed, 27 Sep 2023 07:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695799667;
	bh=uXmzZw+CSsAvM8Urfx0gAJMtEEVDIe/sd4WOWNPVU0M=;
	h=From:To:Cc:Subject:Date:From;
	b=o5+/4tc91kAuxHqAiFvEgJvVSI9YZ8YNSeL7FNa7zwURbHQTfqqhJYCyDGUSZcF5a
	 9M/6EfeW+3OgDcu4qpYgq3+w37NS23f67lecD8NOhHK89nlX7F6zDQG74mlZ/IBIAp
	 UShWAJs44HJ1BBURBtegStLXQBZc6Wlo2vDt7MHUO6IBfWfoAsjMXYtZ2BVnOGrWVn
	 ajXirFPtN2riEwzDOKn3G2j2CE/m07z2QbteJjat4c53wM/4A1KZDZMGBBtBWs9Kci
	 uAoiubAVNrkHeEpfkiV9qasEVkVtgrFWzeaORVexcRaDSrnkY8LNCROmUkUYuFYaQO
	 6Ldn9+wbwPQLQ==
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
Subject: [PATCH v5 net-next 0/4] net: ethernet: am65-cpsw: Add mqprio, frame pre-emption & coalescing
Date: Wed, 27 Sep 2023 10:27:37 +0300
Message-Id: <20230927072741.21221-1-rogerq@kernel.org>
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

This series adds mqprio qdisc offload in channel mode,
Frame Pre-emption MAC merge support and RX/TX coalesing
for AM65 CPSW driver.

Comparted to v4, this series picks up the coalesing patch.

Changelog information in each patch file.

cheers,
-roger

Grygorii Strashko (2):
  net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
  net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on
    hrtimers

Roger Quadros (2):
  net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
  net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
    support

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 229 ++++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |  61 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   9 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c     | 550 +++++++++++++++++---
 drivers/net/ethernet/ti/am65-cpsw-qos.h     | 112 ++++
 5 files changed, 879 insertions(+), 82 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.34.1


