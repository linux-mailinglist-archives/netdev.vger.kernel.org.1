Return-Path: <netdev+bounces-156314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E16A060C5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0AC169343
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4161FF1DE;
	Wed,  8 Jan 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlOtKMfY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95031FF1BD
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351567; cv=none; b=Hb5BLjkchU2ekR+GG9GKkoPPGdE6PR/ghJrvI0jfZ6ChSJY4GzfSST7HMVsNz2K9iWIh5VudpONPrIgAoIg3PmEPEeSgph7gHo9JWzOVd56jStrAHA6c/EV5UY3Fu1aXyrwOrFjmOFjU6vvhI+wvf8dPnHSMSnELwQxJs8Mmj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351567; c=relaxed/simple;
	bh=k9yriv3FjKegK1G3dRsHkGi2dQjrxB8t9Prkv6ezWiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIWvaiUznjn20XZdPtnopX/eluB/nyxuQ2MdUFPHs5hRagrwnehsi+MyJC6P4cCcJFzEJHp7f/Df5PgFcTx3qnzDWJSTmywH3WVUJUcHq0s1qlL122+L8J8hyyBJWgyqu1+Luzy0puF+WwF8+eWfYHLwgpTNDudKi6rz6xhlCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlOtKMfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D582C4CEDD;
	Wed,  8 Jan 2025 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351566;
	bh=k9yriv3FjKegK1G3dRsHkGi2dQjrxB8t9Prkv6ezWiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlOtKMfYb/N4rIvAfkjuiMLo3aYN7M/VXiK8xlGJt+DOVUi6qUun+iFfQG9uQSHP9
	 xa4sfKX02CRJW3mBQvIvfoCCXP3WVBW9QFlyoZHSSDFWaE1PIlLuW0CAkTDBhvyX6A
	 r+jQXE3FZTLoTbtU/N7mMwjj5WUmkuDyT2indPLB8TtQGFs5WWzSwKZ4e6SyFl9jBl
	 f70DRbbWMfFUxBAXxbU8pHOYpSbsvANUQted+z8ZEdpka+MA4pP+X0veISzt7QBweb
	 aYRvpneGVEL57FQkGiWa1Rkmk0cWA6z/Og2DEbvmYUGcNcLSZn2yRu29as+YV6LfAP
	 UmP2ATha6sguw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Jose.Abreu@synopsys.com
Subject: [PATCH net v2 1/8] MAINTAINERS: mark Synopsys DW XPCS as Orphan
Date: Wed,  8 Jan 2025 07:52:35 -0800
Message-ID: <20250108155242.2575530-2-kuba@kernel.org>
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

There's not much review support from Jose, there is a sharp
drop in his participation around 4 years ago.
The DW XPCS IP is very popular and the driver requires active
maintenance.

gitdm missingmaints says:

Subsystem SYNOPSYS DESIGNWARE ETHERNET XPCS DRIVER
  Changes 33 / 94 (35%)
  (No activity)
  Top reviewers:
    [16]: andrew@lunn.ch
    [12]: vladimir.oltean@nxp.com
    [2]: f.fainelli@gmail.com
  INACTIVE MAINTAINER Jose Abreu <Jose.Abreu@synopsys.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Jose.Abreu@synopsys.com
---
 CREDITS     | 4 ++++
 MAINTAINERS | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index b1777b53c63a..2a5f5f49269f 100644
--- a/CREDITS
+++ b/CREDITS
@@ -20,6 +20,10 @@ N: Thomas Abraham
 E: thomas.ab@samsung.com
 D: Samsung pin controller driver
 
+N: Jose Abreu
+E: jose.abreu@synopsys.com
+D: Synopsys DesignWare XPCS MDIO/PCS driver.
+
 N: Dragos Acostachioaie
 E: dragos@iname.com
 W: http://www.arbornet.org/~dragos
diff --git a/MAINTAINERS b/MAINTAINERS
index a685c551faf0..188c08cd16de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22746,9 +22746,8 @@ S:	Supported
 F:	drivers/net/ethernet/synopsys/
 
 SYNOPSYS DESIGNWARE ETHERNET XPCS DRIVER
-M:	Jose Abreu <Jose.Abreu@synopsys.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Orphan
 F:	drivers/net/pcs/pcs-xpcs.c
 F:	drivers/net/pcs/pcs-xpcs.h
 F:	include/linux/pcs/pcs-xpcs.h
-- 
2.47.1


