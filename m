Return-Path: <netdev+bounces-222015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A42CBB52B83
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE735625C9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4692DF156;
	Thu, 11 Sep 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tozocLld"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B12DCF72;
	Thu, 11 Sep 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579009; cv=none; b=O/qwKA44QOKoVxTnjet+yQuU6KI7K6fxtReFbcci2OygGZ0i+iEYUBWJBHDUd9cF2jwl997Q6h5dG0l4Zpnky90gkmN4yEcbCgCUeZJhNuXr4dkE+DvFjGD5z0H924Qau06Ar7OPN7Yq/Xp+eU4biNq77PwACIB5QBT6ON8ZPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579009; c=relaxed/simple;
	bh=1NTqCYvC1K8jjPMv2VYdraK1iRDgvz7FsY1W+cOys54=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JE9HZlTATZk/3Z0XP8Sk1iZoaMbu0x4PKM3RWm+/FohAhHSmaSiyBe2ymQoylC7OoX0jqmEee2Nt04V6TJ8BJo/czyOBM0ZjSRyleCBPxC4VcfWWrV12MZIj76Hz7XFq3/FKXPbiF9OUXnxqzNRo6Qy7H5emxSB1SLq/m+HKC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tozocLld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54C25C4CEF1;
	Thu, 11 Sep 2025 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757579009;
	bh=1NTqCYvC1K8jjPMv2VYdraK1iRDgvz7FsY1W+cOys54=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tozocLldwSOpQgbhOhuvt904CuPrNKqz+MyiPtI+nj9sGun7ieVcxmDeSsvZdBjfE
	 DLC53avdIrGgvbJ7sYRUGgMdyO5pDjfLUmKKhASmcFSxQsv4LthlyehDTGPFBOJyFE
	 LWECmeFEORqBI6+cZlkendWmxSj4/qKrNl9EJ87Db8k6v49PLB2my6YBkHqNGOavIZ
	 /NF0Ecd/e1bXoBZaP1lNhSBIoZtyF0KfALdU7cr7WYkNc/bpQEfZujDShE7nrw67h/
	 8yQ53MOPF1dkpX+X/zg3sSrpVvWb7nNLUq9i7dqyb7Wo6CWHDHTMLXyr1rKSB1cLyV
	 mBubwOsiRx0CQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F6CCAC58D;
	Thu, 11 Sep 2025 08:23:29 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Subject: [PATCH net 0/2] net: stmmac: Minor fixes for stmmac EST
 implementation
Date: Thu, 11 Sep 2025 16:22:58 +0800
Message-Id: <20250911-qbv-fixes-v1-0-e81e9597cf1f@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOKGwmgC/x3KSwqAIBRG4a3IHSdo2HMr0cDqr+7ESkOCcO9Jw
 49zXgrwjEC9eMkjcuDDZehC0Lxbt0Hykk2lKivVaS2vKcqVHwRpLGqzoK2BhvJ/evwh7wM53DS
 m9AHmLbwtYAAAAA==
X-Change-ID: 20250911-qbv-fixes-4ae64de86ee7
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757579008; l=729;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=1NTqCYvC1K8jjPMv2VYdraK1iRDgvz7FsY1W+cOys54=;
 b=/0L8KgDwlzFCr8RVOL5SgK/pXkurP0ELzcipg5jz0KqFqfz7OjcBHkJi9PknfxYLHM1GdYnME
 v5v0C/w9B7TBnsTcDbFxJQY0Jdl7+CyWmJD9rD5EXlB2gHxKlKOoeeO
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

This patchset includes following minor fixes for stmmac EST
implementation:
   1. Fix GCL bounds checks
   2. Consider Tx VLAN offload tag length for maxSDU

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
Rohan G Thomas (2):
      net: stmmac: est: Fix GCL bounds checks
      net: stmmac: Consider Tx VLAN offload tag length for maxSDU

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++++++++++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   |  4 ++--
 2 files changed, 20 insertions(+), 9 deletions(-)
---
base-commit: 1f24a240974589ce42f70502ccb3ff3f5189d69a
change-id: 20250911-qbv-fixes-4ae64de86ee7

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



