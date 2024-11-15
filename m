Return-Path: <netdev+bounces-145122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF719CD52B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030242824ED
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F3139D0A;
	Fri, 15 Nov 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grZQ1CzQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D984D02
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635636; cv=none; b=RAHiBQRhEQuOrHlulNPFYuHcfOrcMX4NjLNtq1kBxm2q9/aRm+Jl1BlxlLOuofK9bzbK7uENP+q51R7dDp98xlMD90jpEM7ltrqdx8GjzyDat+7MpU6TY3iR9KPGf3cQAUg2Utq+i8m3NdMOAqrMUUb2kdX9dmGOFz0Nl2C3/gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635636; c=relaxed/simple;
	bh=vAK4JibEjQaTgeFyvInPGmLKARtRXCEA6NdLgtBCVCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukMMMsESx9tgpVG43OYEh1QRI/Niu3m0ylWNhw83x/Aiy8sZUuIsbBOd70Te1KaYLtJfv/BDCnETMd3i7u8aqRowt5FJkglnnAvA8lr6ce2CqLkj5L145NshLwVMs6KgDWtH8/bnEGE9T5vk+4wze+n7qQCszG/KSV7b5NLc8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grZQ1CzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF8CC4CED0;
	Fri, 15 Nov 2024 01:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731635635;
	bh=vAK4JibEjQaTgeFyvInPGmLKARtRXCEA6NdLgtBCVCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grZQ1CzQ5ICt9UWKPyoiMqbDdXyLUukLZ1RxGmF9/Ltmf983Qu+Q2S6+2H0Gyl5ff
	 DvqyRcKaqRSZVEpF329cTk9ndVmLCj70nD+Ay1RadfdkDYRi/0gaTlty1ftaNqzC2k
	 7/hjY1sn6vv1G5r5v3cn5+rFzT1fsLFkYpcpePq9508kL4ynhY5jvX5b8pZOS1szt6
	 FrX+H8weIspL+83jiX9karKSYgyCvu01/lYfFLc4OX6cUUhvjrSEfVfNQHmRlolXYv
	 xltqKZng8cOdSFaMpcu3in/VptYoTpN/4vT6PZ3P2QPuL4NN4YBUmUbZC6gURmhJPu
	 FSMd512Ifj8dQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] eth: fbnic: add missing SPDX headers
Date: Thu, 14 Nov 2024 17:53:40 -0800
Message-ID: <20241115015344.757567-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115015344.757567-1-kuba@kernel.org>
References: <20241115015344.757567-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paolo noticed that we are missing SPDX headers, add them.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c  | 3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c | 3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 354b5397815f..589cc7c2ee52 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1,3 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index a0acc7606aa1..b3f8dc299b29 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -1,3 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
 #include "fbnic.h"
 
 u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index 30348904b510..a2b6e88fc113 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -1,3 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
 #include <linux/ethtool.h>
 
 #include "fbnic_csr.h"
-- 
2.47.0


