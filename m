Return-Path: <netdev+bounces-49512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79527F2401
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580F3B213A8
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BC91862E;
	Tue, 21 Nov 2023 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ6XBcgw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C94518640
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62F0DC433C8;
	Tue, 21 Nov 2023 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700533823;
	bh=FLriGiCcaRM8Lgn8IZR9yOMGdN6r6rlbIEh2rJ890Xs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YQ6XBcgwb6Dp548/hlt796wG9d3ADs08e5y0pzb2+RzPXncjhhwMJoKXe/U84qMHh
	 LSFzCmIvGBu49y05SM725pfaNwf4nAC9zubK0CAY7R49yhFeGU5drxTZPfwtydbbnp
	 C0wqHWLekc+5ORcm/I1KupOodFFqvaVWB0zxh8Fjf2Sw3HJRZaF2aQjucaGZoi35Hg
	 kUBQgFDcQfnELUWd0sDJUzvEvMsxqxK0BUCg6+0j7a1OHbpbO3DEz8hnMs56cE3kCE
	 sNZGYDsNWyDaNVeN+a62OyAAUGvma+yTk4n1+NnUzl/X3zk8uWgWuMDQpSJMtD7pKa
	 28k+ds/P+Vkuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D2B7EAA957;
	Tue, 21 Nov 2023 02:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: add support for devices with
 more than 4GB of dram
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170053382324.30656.13816188524175534259.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 02:30:23 +0000
References: <1c7efdf5d384ea7af3c0209723e40b2ee0f956bf.1700239272.git.lorenzo@kernel.org>
In-Reply-To: <1c7efdf5d384ea7af3c0209723e40b2ee0f956bf.1700239272.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, john@phrozen.org,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lorenzo.bianconi@redhat.com, sujuan.chen@mediatek.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Nov 2023 17:42:59 +0100 you wrote:
> Introduce WED offloading support for boards with more than 4GB of
> memory.
> 
> Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: mtk_wed: add support for devices with more than 4GB of dram
    https://git.kernel.org/netdev/net-next/c/31c54867fdea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



