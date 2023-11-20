Return-Path: <netdev+bounces-49255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7677F150A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863A328249A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531EA1BDC9;
	Mon, 20 Nov 2023 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USJOSq4F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA951BDC5
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 14:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFE4C433C7;
	Mon, 20 Nov 2023 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700488914;
	bh=cGs0HyLCS5owCtkNE0emwtvUGyUvuxU5P+zsEgYBDI0=;
	h=From:To:Cc:Subject:Date:From;
	b=USJOSq4FNNxuYHQWs39YPg8R6ZZT+dXf9CCSEbSmnoZvEJmpZgraC6D4FuvVk2qzX
	 I4sVkWxGntrax3KKEZ9NvCg0v7pRImkteJhx0vQzmjKPdPrc6TqRoE1H4dvMUWt21E
	 BBNI1BwEywTl9qxYpp6OoSre8bZmmtcyd/+m/AKqSuibfx8L9kYQjwI+9xd1LR5S4u
	 tGUWMladzPHaO1ROHdN6OAOul3oHBYHnwNEopltcawyNc9P8dJGcAp1Yc1lrNCDvqZ
	 K6kXn3t2qKkbOjMvEdf/SsYp/qRnadeHWHvbaDgYeP2HRjsfyiji6P4wbCvmKPIdWx
	 fhFTMVM3jLN9A==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v6 net-next 0/7] net: ethernet: am65-cpsw: Add mqprio, frame pre-emption & coalescing
Date: Mon, 20 Nov 2023 16:01:40 +0200
Message-Id: <20231120140147.78726-1-rogerq@kernel.org>
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

Changelog information in each patch file.

cheers,
-roger

Grygorii Strashko (2):
  net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
  net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on
    hrtimers

Roger Quadros (5):
  net: ethernet: am65-cpsw: Build am65-cpsw-qos only if required
  net: ethernet: am65-cpsw: cleanup TAPRIO handling
  net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
  net: ethernet: am65-cpsw: Move register definitions to header file
  net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
    support

 drivers/net/ethernet/ti/Makefile            |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 234 +++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |  64 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   9 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c     | 730 +++++++++++++++-----
 drivers/net/ethernet/ti/am65-cpsw-qos.h     | 184 +++++
 6 files changed, 1046 insertions(+), 178 deletions(-)


base-commit: 94c81c62668954269ec852ab0284256db20ed9b4
-- 
2.34.1


