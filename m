Return-Path: <netdev+bounces-155532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF71CA02E5A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A54A165359
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73C91DE4DB;
	Mon,  6 Jan 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0AIh11d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912521DE2AD
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182468; cv=none; b=Skfua/JWFn6hGomskdEZnUhWr39gnLofa4EGQr1g+WrCJJ9mZZ2tpZev3Eb4XNTABeFXuahhdJUf8wxEOqJvElEm+3w+0PPAR0nCXNMDXMAT5j61yQEVhtQFoNHkpOg9VKzX95UCbUoVXLsQ0omZH1K3+a9wRHveZekKxutlpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182468; c=relaxed/simple;
	bh=UbBIxHBVj4NJY9gnD4EmBfLPIdr73jUj7FheyBY7wSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evOik88enWn5i+L0NZ6aFn4RcrE+skoF6pqGVEWjkGWistP/46MkmceEWZzyoBzy842697X1TBIC8g9C2Llgidkp/HLRLilF8ufOcGeBRldEPvKP1Y7m7jpkMHK45dTU9AyfW3Q8s2kUal3fvRtMeQZHoW2aIEy5Z0djwSECVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0AIh11d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37744C4CEE2;
	Mon,  6 Jan 2025 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182468;
	bh=UbBIxHBVj4NJY9gnD4EmBfLPIdr73jUj7FheyBY7wSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0AIh11dk/lPSTN2gLDBcvVyVnA5s+nPcBwJJOTMq4Lk0rUSygbUBJIOmTXEdd+73
	 X06hkJQPNDbJHFyRRvi8Pg8pBB3uCzTj7UdRp2Akmbz5PYfMfOY4eVc2/I7KKSH1YO
	 9Z7S3++z3UsvSQIPVmd5T9Bw2JGw95wqflLWM6b5haCO373HRxMmNnPVaz6dnIrAze
	 7Lb85tL/rYQKoryHBwntsR3MNQht6w6ADvkFScXCMkJlt8AUf3mkb74gbGe/RMNVs9
	 IhWXPUrUgsHY3dKuGG+xs0gAahoLzOUXptIrsRqVTN15bf84PNOuloArwUoBhnacgg
	 fB4vyOPsVEQBg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>,
	joabreu@synopsys.com,
	alexandre.torgue@foss.st.com
Subject: [PATCH net 4/8] MAINTAINERS: mark stmmac ethernet as an Orphan
Date: Mon,  6 Jan 2025 08:54:00 -0800
Message-ID: <20250106165404.1832481-5-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106165404.1832481-1-kuba@kernel.org>
References: <20250106165404.1832481-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
We could add an entry to AUTHORS, but a quick git log doesn't show
huge number of patches or LoC. I could be looking wrong..

CC: joabreu@synopsys.com
CC: alexandre.torgue@foss.st.com
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f22da12284c..613f15747b6b 100644
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


