Return-Path: <netdev+bounces-49494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DBA7F2360
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833041F24A77
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13C8495;
	Tue, 21 Nov 2023 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw4lbU4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C42C8E2
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C001C433CA;
	Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700532025;
	bh=uQOCVxwdvKIvn2qxuwF9Et8pByqTASiiEmyLxL5+5aY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gw4lbU4AsXiEukQxpYmO9dWCBSk7UzyOSgAoMhAXhgHE//njJ/jLtefyb5Gbdt4Y5
	 MDTaFIZOAXEk3S41b8X+CB7rKWIhI9iQPndHQYTU2NyXEJXqALx5o9CmOiO3U8dpKL
	 l0u21iPW9raR0e/1DQsXmZYL6Mbc5kS5RcFBzmOTEz87SMOAEbWde7Zmvtx6crnXbh
	 K6AewcOI0Ql4GuwZ8tLVaEusYyXnu5mVS59QZJAQLZ53X3Bsuoz5lqzNZDYmtCis5Y
	 3ts9+Eto3TZ3ETjSGp2LJgNDQLeZ6BCwuxgrGFVbclCvZvy7hFilyTOo9VryYcg6A6
	 eIEpPIRmmuxyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 433B6E000A4;
	Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: microchip: lan743x : bidirectional throughput
 improvement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170053202527.14605.1759031814684336138.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 02:00:25 +0000
References: <20231116054350.620420-1-vishvambarpanth.s@microchip.com>
In-Reply-To: <20231116054350.620420-1-vishvambarpanth.s@microchip.com>
To: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 jacob.e.keller@intel.com, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Nov 2023 11:13:50 +0530 you wrote:
> The LAN743x/PCI11xxx DMA descriptors are always 4 dwords long, but the
> device supports placing the descriptors in memory back to back or
> reserving space in between them using its DMA_DESCRIPTOR_SPACE (DSPACE)
> configurable hardware setting. Currently DSPACE is unnecessarily set to
> match the host's L1 cache line size, resulting in space reserved in
> between descriptors in most platforms and causing a suboptimal behavior
> (single PCIe Mem transaction per descriptor). By changing the setting
> to DSPACE=16 many descriptors can be packed in a single PCIe Mem
> transaction resulting in a massive performance improvement in
> bidirectional tests without any negative effects.
> Tested and verified improvements on x64 PC and several ARM platforms
> (typical data below)
> 
> [...]

Here is the summary with links:
  - [net-next] net: microchip: lan743x : bidirectional throughput improvement
    https://git.kernel.org/netdev/net-next/c/45933b2db91b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



