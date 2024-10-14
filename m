Return-Path: <netdev+bounces-135143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F73499C773
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8980BB2663A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41588184556;
	Mon, 14 Oct 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDehbRUi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC417DE16;
	Mon, 14 Oct 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902901; cv=none; b=Vrcm9eDIe9zNk8JpjovSEWylQbaVS4P11mz056MsLB4QJtLPkl3Ch3hcT+gacBG1BxeM8fel5Co+4yiuN1RaPgB8GuKGSd6zfjxU4KrjYEavbQylUPHCyee/RnTAtF3/TiG7mGsrhwjb/CyzfSCCYLYrC5Uf+NLKA88BFADiE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902901; c=relaxed/simple;
	bh=nyk7KmsjJVeX09LhsxjDfvCwzgNz1+vfkwwUVY+0C/g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aSUznDNQNff+vmc97LWKOzjxIQKAbpHNzztpS2L+48xXUUnnGRJGZX9/MrkomERC7sAPxZ33Mu9YKcECrVK98tHQTdbOZIoOl0fWwM7l8j6yelR/A7OPSdlnydgHUtR07mk4knloT0I58xvDKho8QF3QDtsm3/6TbiBxL5tskF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDehbRUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AF4C4CEC3;
	Mon, 14 Oct 2024 10:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728902900;
	bh=nyk7KmsjJVeX09LhsxjDfvCwzgNz1+vfkwwUVY+0C/g=;
	h=From:Subject:Date:To:Cc:From;
	b=lDehbRUijHK3VViD/M4SotvPenvFUgbjHygLq7PtTA+4wUYOFk0PYzWJ3MPsh1XdR
	 Z2jBi7HUs+M2OXVJrZYFSU/dpy+BV+wt35g2d15fDTqBzi9lqYZDZf61gnw4NeSwA+
	 Sdyrxe7Ch/to8A+VconinXXUYSzz4Fv1mieeWg8Hysqj7w7ftZbHJsZ8NthDT1Mrkn
	 kf4Rj+LbgbHT1738OkBBqjo7VLFeOPUHVklgbNzDR6ap3b77Ht/Nj/lGmvsqR/tsrh
	 RYSDTKLHsFbyuQ3ZB7OLPWylJ3J6RMFNNc8pWBn0HkvDiWUWersbpfsUOaBeLcJsXC
	 Jloo1d4yj+BIQ==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH 0/2] net: ethernet: freescale: Use %pa to format
 resource_size_t
Date: Mon, 14 Oct 2024 11:48:06 +0100
Message-Id: <20241014-net-pa-fmt-v1-0-dcc9afb8858b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOb2DGcC/x3MQQqAIBBA0avErBtQGQi6SrTQGmsWmahEIN49a
 fkW/1fInIQzzEOFxI9kuUOHHgfYThsORtm7wShDWmnCwAWjRX8VZOccaTsReYIexMRe3n+2rK1
 94+9cQVwAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.14.0

Hi,

This short series addersses the formatting of variables of
type resource_size_t in freescale drivers.

The correct format string for resource_size_t is %pa which
acts on the address of the variable to be formatted [1].

[1] https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/core-api/printk-formats.rst#L229

These problems were introduced by
commit 9d9326d3bc0e ("phy: Change mii_bus id field to a string")

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/netdev/711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org/

---
Simon Horman (2):
      net: fec_mpc52xx_phy: Use %pa to format resource_size_t
      net: ethernet: fs_enet: Use %pa to format resource_size_t

 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c     | 2 +-
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

base-commit: 6aac56631831e1386b6edd3c583c8afb2abfd267


