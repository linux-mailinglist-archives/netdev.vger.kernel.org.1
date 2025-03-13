Return-Path: <netdev+bounces-174646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7982DA5FB4C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43ED8883C9A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794292690F4;
	Thu, 13 Mar 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmdwz3Df"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035277104;
	Thu, 13 Mar 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882476; cv=none; b=W1+CLAcKa4Kj4t+Ve7u9XbGgRctle13BiAcnGdwJU7CxKCJGXaxTSrxTA4SGvOPPRwC8donnzNtONPzOPcuZyqd/8QE+ALBoUmV/WSDa7cg/ceFuDY2kSFAftlziLYLjuUqSq1Sy/SHHpfRKwn7GSVNOclS4vtZYxWZJDU891Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882476; c=relaxed/simple;
	bh=ivXaovMXFkHRDnIc2B3mYOHIjoMxZWzDfaRmCccBPHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BL4N80QgYN9KcNgl3WOECnJmedV1nEbSjTj4x5PnIhYK7M64SZiajSRqemqbc11JFRxx5z8E3NoluNnWNo2q/0jmnI5jX0Ty/RLCR8HSIb94WNctiUrsS3b/3CSs4kuAcEjMugaxEK8Io+tnN5qAn9EzOjWaPBqwCY1PGMscz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmdwz3Df; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2510C4CEDD;
	Thu, 13 Mar 2025 16:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882475;
	bh=ivXaovMXFkHRDnIc2B3mYOHIjoMxZWzDfaRmCccBPHw=;
	h=From:To:Cc:Subject:Date:From;
	b=bmdwz3DfqVK/2LgcxeGvzyz3uBN4tuCsJKdf9qsxNrO7rIBQoqqyvZRBob6XYjzai
	 DhvEH9bAkd5LG45bgr2nbTPSFw5yEKEIx/pWdaLB6KjvL/LebIwyhPseaYTks9m2yz
	 ktkLZ6h7wO5iGwwE5rRLCkCu1atbJm5Y1e79HY/RSSrUnZLtX0iFtSHswUPJL0w2G7
	 hFwS6WYfJPizwxHYa67aNte+a+ffyFxRaY0CbVrYfW/4uKK4d4udq44eo4cv8E39bo
	 Bxjb2HQHa5CxMyndA36s5221bo5r8JWMfHEcqgWJCFaIj2unMhSdjG3fPaoVpV/Doe
	 S04bpru+hueSQ==
From: Philipp Stanner <phasta@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Serge Semin <fancer.lancer@gmail.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH net-next 0/3] Clean up deprecated PCI calls
Date: Thu, 13 Mar 2025 17:14:20 +0100
Message-ID: <20250313161422.97174-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spiritual successor of this older series, of which one patch has already
been merged [1]

P.

[1] https://lore.kernel.org/netdev/20250226085208.97891-1-phasta@kernel.org/

Philipp Stanner (3):
  stmmac: loongson: Remove surplus loop
  stmmac: Remove pcim_* functions for driver detach
  stmmac: Replace deprecated PCI functions

 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 27 +++++--------------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 26 +++++-------------
 2 files changed, 13 insertions(+), 40 deletions(-)

-- 
2.48.1


