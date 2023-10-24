Return-Path: <netdev+bounces-43766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB33C7D4A8D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC46B20C66
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E74746A;
	Tue, 24 Oct 2023 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMuYTelh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFAF2F5B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 08:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5210EC433C9;
	Tue, 24 Oct 2023 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698136822;
	bh=Swt1HdkYhDuCBYOR75sgO0ONU+7S/yD5FMYrGp04s4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KMuYTelhahEUY4rgvgIRJA7rfbJzdmzMhMjMEuVbx8Tc07xk8V8RXmcAdEA12HN+4
	 zSnCjVUcJyHX92/c8/tQZ+rJdzVSSPezf7WeQ3ZYDg9MGpOUHgIQOxOYM1Se9pHx4c
	 k5ZRhcelMZCaTAU3cRDgDBf5cWi1ijcFOA8F+gwyXr9jDE9kTmp3KaamNk+RBNs/DK
	 nnURaYmkHEGEsbGZMpdWIM5AB3V/iX5RczSK2V5cp5FFpwq7jlP2f6mOgVetRK99px
	 aZ/Uh1ADy4Vbt0vaHBbLogGB8NVv4fwko96jEDo9m31j5DQjGvWgrP7/qOE4v6ltMW
	 5A2GSFwe0Tlqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35326C00446;
	Tue, 24 Oct 2023 08:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ti: icssg-prueth: Add phys_port_name support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169813682221.10549.8413389074006826689.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 08:40:22 +0000
References: <895ae9c1-b6dd-4a97-be14-6f2b73c7b2b5@siemens.com>
In-Reply-To: <895ae9c1-b6dd-4a97-be14-6f2b73c7b2b5@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, danishanwar@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, diogo.ivo@siemens.com, nm@ti.com,
 baocheng.su@siemens.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 22 Oct 2023 10:56:22 +0200 you wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Helps identifying the ports in udev rules e.g.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> [...]

Here is the summary with links:
  - net: ti: icssg-prueth: Add phys_port_name support
    https://git.kernel.org/netdev/net-next/c/f6e12277011d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



