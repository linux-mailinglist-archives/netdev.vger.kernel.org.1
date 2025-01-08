Return-Path: <netdev+bounces-156317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD81A060CA
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6D518892B4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB561FFC44;
	Wed,  8 Jan 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCnYc9Ge"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36E1FF7D9
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351567; cv=none; b=C5QYSNtCinr0qOnmz7R1elPIWnq8jRVODCQhiIsNdmirhydOTvBNztYbaOzSFs/E7jgEj5xfmyHXYhWfHICNdGztk7odemfps07P3Ptvac6zcAsKKzTwSowTcIqFDzihrPqh3CNmS/WkTO9tBNgKDVu6zGGQp003pAqzfxPLp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351567; c=relaxed/simple;
	bh=ad8EadHB9tlq8T/aHLKanilCG/V65tlmp/UTD0oqrrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+jt3tVSF6XjpSNGkcvTgYGOtPGBnzY+MXB65LRgaerl1eJRnI6BZgXLlxD3/l/ZTMXj8NcFh2tcHjayivCmkkFEVYQ+hpQyuEnCAdvOIjUbEyX79mEHzFOfho0tfKa2q+FcWwiEJzaXMLUlW3m9cHfJICIvXqIayUNDdcIOmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCnYc9Ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFA9C4CEDF;
	Wed,  8 Jan 2025 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351567;
	bh=ad8EadHB9tlq8T/aHLKanilCG/V65tlmp/UTD0oqrrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCnYc9GemPATyAo9e3LFsHw2Yn63R2wAQX1I/z7YGUDFqaRhRb/S+z1wYPAbjHArF
	 m3ggi0B407fKQGtaow5LHabbG1TwNWvO7KW8ASTdSpoPh4diFbO0gONzyx6Nv17kVS
	 r+Z2HXRkGPnd1Oezp5EFjXaO1EyaFXRkpJUujLIUtms1bozRQbU9pIb2LxpKked9jP
	 Ombi6hG+G6C79eTlXt7rEqILYIef/DmS8/ioIEUvT3hjnOtvROly5ajlQGPPLwIiv2
	 ZZjEfqKzmliGBzRfhDEpX8cJoXLRAgA8vsVKxCj2uIVG9YHDtOaes/tXSfPJrBGYax
	 GMDJLHb/YGjnw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	joabreu@synopsys.com
Subject: [PATCH net v2 4/8] MAINTAINERS: mark stmmac ethernet as an Orphan
Date: Wed,  8 Jan 2025 07:52:38 -0800
Message-ID: <20250108155242.2575530-5-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108155242.2575530-1-kuba@kernel.org>
References: <20250108155242.2575530-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I tried a couple of things to reinvigorate the stmmac maintainers
over the last few years but with little effect. The maintainers
are not active, let the MAINTAINERS file reflect reality.
The Synopsys IP this driver supports is very popular we need
a solid maintainer to deal with the complexity of the driver.

gitdm missingmaints says:

Subsystem STMMAC ETHERNET DRIVER
  Changes 344 / 978 (35%)
  Last activity: 2020-05-01
  Alexandre Torgue <alexandre.torgue@foss.st.com>:
    Tags 1bb694e20839 2020-05-01 00:00:00 1
  Jose Abreu <joabreu@synopsys.com>:
  Top reviewers:
    [75]: horms@kernel.org
    [49]: andrew@lunn.ch
    [46]: fancer.lancer@gmail.com
  INACTIVE MAINTAINER Jose Abreu <joabreu@synopsys.com>

Acked-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
We could add an entry to AUTHORS, but a quick git log doesn't show
huge number of patches or LoC. I could be looking wrong..

CC: joabreu@synopsys.com
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e16a55c3dd3a..2b81ed230848 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22509,11 +22509,8 @@ F:	Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
 F:	drivers/phy/st/phy-stm32-combophy.c
 
 STMMAC ETHERNET DRIVER
-M:	Alexandre Torgue <alexandre.torgue@foss.st.com>
-M:	Jose Abreu <joabreu@synopsys.com>
 L:	netdev@vger.kernel.org
-S:	Supported
-W:	http://www.stlinux.com
+S:	Orphan
 F:	Documentation/networking/device_drivers/ethernet/stmicro/
 F:	drivers/net/ethernet/stmicro/stmmac/
 
-- 
2.47.1


