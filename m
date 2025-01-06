Return-Path: <netdev+bounces-155529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA71A02E52
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA6165082
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F371662E9;
	Mon,  6 Jan 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXXrGPbL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2150153814
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182467; cv=none; b=T4aWAUtCRQNGqV7DKZ78Q54vYxqNFOXMy8AdWLvxni7DflRmmvjfLzkHNS4lOGnoHS7B/WKNAnC7XQqG3OaRIa5cQVKTaNngQNGM6WRpG6iFAJ07wSWj84DxWnUgQIEI4jCVhTmCKdoS6g2AUAHT4qbAJlP0ePuJLuNSMsbXImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182467; c=relaxed/simple;
	bh=k9yriv3FjKegK1G3dRsHkGi2dQjrxB8t9Prkv6ezWiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIbYCyrhetT+bE8rlXMoQXE7paOkRrrzlPN3N4dW+2u+WvFvbBOMCyUl2IKrQf1DkQfKEh1NnmXE0JM5V31xKDePOdYfxlrlYlIYO+h/6P1iKyt8QfnCWJ8tM+0hqomJLH52gj6GlV3BXe1GI2RxYpy9UpjDYm7yH+tU48IFsr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXXrGPbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2704CC4CED6;
	Mon,  6 Jan 2025 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182467;
	bh=k9yriv3FjKegK1G3dRsHkGi2dQjrxB8t9Prkv6ezWiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXXrGPbLzwSEUkWR7QzhNR00Vg2wFYlGZYlz1HUwu0VUEq1D29gy1gGkzHnRPsxDa
	 1AtpVrdzcoU0KVexusyNyohFE1NeKXqHVBtLumNfYuv3UmANp6ioZrGtpcLWccclZt
	 4CR61ovWJQODRHSc237bsaFC97x7zpg8le3wKIDLbVqEIUDSbAQMph58BLUee0YP6p
	 9ObSoIytMwIFD6Z+mSDH3j2i5CdX4iVTuaiatETWtBs9vpZtlQ4f5KS120sh3O/nTE
	 b3XddlV9KZ7VS5X0w7XA1FrAwUHcVu49SYoJP91t/zmraw28orncPskXMtRZ4jhEcP
	 s2rqdaqn6zIOA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>,
	Jose.Abreu@synopsys.com
Subject: [PATCH net 1/8] MAINTAINERS: mark Synopsys DW XPCS as Orphan
Date: Mon,  6 Jan 2025 08:53:57 -0800
Message-ID: <20250106165404.1832481-2-kuba@kernel.org>
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


