Return-Path: <netdev+bounces-59218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9706819E71
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085401C22519
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199D219EA;
	Wed, 20 Dec 2023 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHL5iV9g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9095219E5
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 11:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 341F7C433C8;
	Wed, 20 Dec 2023 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703073023;
	bh=mARVmx1+q9umGMbkbZ7ptjb8EjT+DgKEUGo6cV7zMMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HHL5iV9g7Nejme7XRNhTpAMNgh6oLpY9kDxw1AIoCoXcek2Xyes47Us8yYY8dxwju
	 SEqi8lQbgkg35qoSTPdAPSfYZZ6nkO+9snCCOIAPVsc3SZraLNlexEdwVQaDlUZEag
	 n/XAl86IvaeKC+l7xXYbRv0bDPPGtd1wwX5OJqDkGa7H9KEPwFE6gL/1agViyo26qj
	 PCDI1fI5U23Q87eZeg8d9cHZyc9kArKfmV5/tQGgNy7Rbfv9qi5ocFYZyfqSYj7SzR
	 Qvm04wYFiO76wi7SxBgECT2lFOvjuVpSou2+pja1VUnPh5odZd4GmeXGa32WIDwuLA
	 QtGA98uCE5hgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D489DD4EE5;
	Wed, 20 Dec 2023 11:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] r8169: add support for LED's on RTL8168/RTL8101
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170307302311.27593.13735667668813260803.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 11:50:23 +0000
References: <6639e1bc-9b8a-4f59-9614-3c1c3cae8be2@gmail.com>
In-Reply-To: <6639e1bc-9b8a-4f59-9614-3c1c3cae8be2@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org,
 kabel@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 16 Dec 2023 20:58:10 +0100 you wrote:
> This adds support for the LED's on most chip versions. Excluded are
> the old non-PCIe versions and RTL8125. RTL8125 has a different LED
> register layout, support for it will follow later.
> 
> LED's can be controlled from userspace using the netdev LED trigger.
> 
> Tested on RTL8168h.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] r8169: add support for LED's on RTL8168/RTL8101
    https://git.kernel.org/netdev/net-next/c/18764b883e15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



