Return-Path: <netdev+bounces-56654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E05180FC01
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BD31F215B0
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A47518E;
	Wed, 13 Dec 2023 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtaTjcAP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB2642
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2BCBC433CC;
	Wed, 13 Dec 2023 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426224;
	bh=h2g/8Os5qUEY3rBj2ekf0RjmMAG2pZTltDoY8TnV2es=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UtaTjcAPy54igNFuHztI5xfF5/G3S5ffpdO4nD9TyllVw4fzgMiiyIlIF+5lQGHsz
	 dmH5/5dNPvudSFbmPxpwTFatcb6kivVse/Yvjb71sjDHhUD2r4gvty/9F96iwPEJVe
	 tvI1CVloURL714+eF8KkcU1LiRk5grJEC4sVj7HqwDkmSCk1UblQsvt2RDBuG5JNfK
	 g6U0G4e1CJ6BKi2SSEHe8OHvXEkFcYtU/3nTnWUMDS4YnvXhcYT+mjjJtVcx+AACzt
	 L4os746Minp+4wwwLkTzh3WoKM2kbJjsrH3yKzac2tb5994eTIy6khFapEaYTpG5Ck
	 HOj2+JFFO4kXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 988D9DFC907;
	Wed, 13 Dec 2023 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/4] ENA driver XDP bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170242622462.31821.18195551706619226192.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 00:10:24 +0000
References: <20231211062801.27891-1-darinzon@amazon.com>
In-Reply-To: <20231211062801.27891-1-darinzon@amazon.com>
To: Arinzon@codeaurora.org, David <darinzon@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 dwmw@amazon.com, zorik@amazon.com, matua@amazon.com, saeedb@amazon.com,
 msw@amazon.com, aliguori@amazon.com, nafea@amazon.com, netanel@amazon.com,
 alisaidi@amazon.com, benh@amazon.com, akiyano@amazon.com, ndagan@amazon.com,
 shayagr@amazon.com, itzko@amazon.com, osamaabb@amazon.com,
 evostrov@amazon.com, sameehj@amazon.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Dec 2023 06:27:57 +0000 you wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> This patchset contains multiple XDP-related bug fixes
> in the ENA driver.
> 
> Changes in v2:
> - Added missing Signed-off-by as well as relevant Cc.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/4] net: ena: Destroy correct number of xdp queues upon failure
    https://git.kernel.org/netdev/net/c/41db6f99b548
  - [v2,net,2/4] net: ena: Fix xdp drops handling due to multibuf packets
    https://git.kernel.org/netdev/net/c/505b1a88d311
  - [v2,net,3/4] net: ena: Fix DMA syncing in XDP path when SWIOTLB is on
    https://git.kernel.org/netdev/net/c/d760117060cf
  - [v2,net,4/4] net: ena: Fix XDP redirection error
    https://git.kernel.org/netdev/net/c/4ab138ca0a34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



