Return-Path: <netdev+bounces-135144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7899C777
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6127728539B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1651991A8;
	Mon, 14 Oct 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkKjUHZS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC01953A9;
	Mon, 14 Oct 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902903; cv=none; b=p+81arqyqG7rb0P20aOHR195wbwbPYZAT2g/MdWhwS/9W1ZCkno5hmO1ABXH3L5NN5qjfQLMvPlqfMdUz7b1dH8R60AGGvZRzZnEvgauf7nT1dUNy3LSGguWp+S/DNNvJTemMt4v1IjUuh0h1okY3juFehuMWMQHv8mKskSB/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902903; c=relaxed/simple;
	bh=/OCNlnab7LfsKEO2VBkimOwewUj/x1P/69LUtdzV8g0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cnp4nyjdqoYc9W56smC1weMqQHlskrwOOLjaCk46dzBnHMJvlda/V5RqCPPQ8GIi+hkinD8v8nJUNScetannNTpoaveXd56tM+qrXuYOS8Gt0q/gUoDuMKxAsRbRRI+MMNY+WHjQd40Mp/msd4j25di1EwN4s8gGyKJH+9w1YBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkKjUHZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D82C4CED0;
	Mon, 14 Oct 2024 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728902902;
	bh=/OCNlnab7LfsKEO2VBkimOwewUj/x1P/69LUtdzV8g0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VkKjUHZS/u3NFSC9JvmfosumUNe8X8td95QU+p4SCOlUVIjq/MGZ25TnjcI8mOF46
	 0+JxRa6Cq5BPpi06vQDSt8huggXNk/227rTcUmA9JZF8vBBwNdoNZPvVvCBxVOxo8K
	 pTAH3thq1hkoOHL5q8lWqhOiiL9iYwckwBqFtrWGvSDoMfuRXZVy2OXAi7744tt5Eg
	 zrYXjKOLrqxGc27zGvR25rfzYZd5gZeJTsOFkAivCBSM7UYUdonZ5HzsZI8xcxfd1F
	 wP42Wa9rnL1c8en/4CZlIKv4Biuvme3qznuyVFEeWnK+N/Pfnjp5Rd5fAZr0P7kXcC
	 DWpYw7MPrEPOw==
From: Simon Horman <horms@kernel.org>
Date: Mon, 14 Oct 2024 11:48:07 +0100
Subject: [PATCH 1/2] net: fec_mpc52xx_phy: Use %pa to format
 resource_size_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-net-pa-fmt-v1-1-dcc9afb8858b@kernel.org>
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

drivers/net/ethernet/freescale/fec_mpc52xx_phy.c: In function 'mpc52xx_fec_mdio_probe':
drivers/net/ethernet/freescale/fec_mpc52xx_phy.c:97:46: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
   97 |         snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
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
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
index 2c37004bb0fe..3d073f0fae63 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
@@ -94,7 +94,7 @@ static int mpc52xx_fec_mdio_probe(struct platform_device *of)
 		goto out_free;
 	}
 
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%pa", &res.start);
 	bus->priv = priv;
 
 	bus->parent = dev;

-- 
2.45.2


