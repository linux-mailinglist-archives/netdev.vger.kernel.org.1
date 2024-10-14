Return-Path: <netdev+bounces-135145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463F699C77A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8BC1C2273F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4097F19CC3D;
	Mon, 14 Oct 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOxdL/l6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1520C19CC2F;
	Mon, 14 Oct 2024 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902905; cv=none; b=BML2evp5b4bE88hBS9FrGNdrDkCgdz1QI9O3B8RS3UNggfFlgPkRifHXwKqPdUOCsvZDfaw+2Y3wyBM1Bi2l4wbpQHtGTuO5r0QM/3kuHhjW4KSFnzmZbZCkqcpXc51uEaA+D/UA6ydy5neF1j5gISQQnwrTZLIAGgP/7fg5UYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902905; c=relaxed/simple;
	bh=3hLRauEYwJEHZvSFb0NBFQDokIr/VyMCsk6KndYmcGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peGI00g4xSwsS48LLIMpixnuFp1lzdWk+UaaTi5vCI+tTIlL/EhjjyI9RarPSSSMOCj9+Sn+VZxGAacKiu1Pwc53MOc95DBvDcjDqopLy7WBmWcLQtnttgwhFXvkzG1sQN6897YBWmKcjb9X3PTzBNd3tX8c0D5BBJCeraIdss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOxdL/l6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078D3C4CEC7;
	Mon, 14 Oct 2024 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728902904;
	bh=3hLRauEYwJEHZvSFb0NBFQDokIr/VyMCsk6KndYmcGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UOxdL/l6+O2m79yN4Mo15zkbT55iP9G4BYeazux6JHcS0srxQr8YKSiXgDl18+HrU
	 AvfZHqZn7lyMIABT6GAhK5JiXdf3OTBDM/m4WAdGT8uNcEFKG+z3H+q8EjoRY+wC1B
	 NJfSWO2i/EhaYtZ7HlHsLuNKZvdHrwcgp29Iu0YnFmXc6QPNgkgx3Zd3clG0M5He7s
	 lvmX3v/HX33pgX9vxIhhFHzAJ3eAx32gl8o0f3FWZ7ca/hlICnL1ByuOfuiJNegDWW
	 1YHJjQ9Rr89LffyjCfivU5RmG8lb0kqAoM6ZAw75YfGt54SpVyZDG3pA+/ekT3FYaA
	 kmyI8fEY4uPTg==
From: Simon Horman <horms@kernel.org>
Date: Mon, 14 Oct 2024 11:48:08 +0100
Subject: [PATCH 2/2] net: ethernet: fs_enet: Use %pa to format
 resource_size_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-net-pa-fmt-v1-2-dcc9afb8858b@kernel.org>
References: <20241014-net-pa-fmt-v1-0-dcc9afb8858b@kernel.org>
In-Reply-To: <20241014-net-pa-fmt-v1-0-dcc9afb8858b@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.14.0

The correct format string for resource_size_t is %pa which
acts on the address of the variable to be formatted [1].

[1] https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/core-api/printk-formats.rst#L229

Introduced by commit 9d9326d3bc0e ("phy: Change mii_bus id field to a string")

Flagged by gcc-14 as:

drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: In function 'fs_mii_bitbang_init':
drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:126:46: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
  126 |         snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
      |                                             ~^   ~~~~~~~~~
      |                                              |      |
      |                                              |      resource_size_t {aka long long unsigned int}
      |                                              unsigned int
      |                                             %llx

No functional change intended.
Compile tested only.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/netdev/711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
index e6b2d7452fe7..66038e2a4ae3 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
@@ -123,7 +123,7 @@ static int fs_mii_bitbang_init(struct mii_bus *bus, struct device_node *np)
 	 * we get is an int, and the odds of multiple bitbang mdio buses
 	 * is low enough that it's not worth going too crazy.
 	 */
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%pa", &res.start);
 
 	data = of_get_property(np, "fsl,mdio-pin", &len);
 	if (!data || len != 4)

-- 
2.45.2


