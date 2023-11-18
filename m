Return-Path: <netdev+bounces-48916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C2B7F003D
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 16:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B279B2096E
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E1168B7;
	Sat, 18 Nov 2023 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV0XAJbx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513214A83
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 15:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03E51C433C8;
	Sat, 18 Nov 2023 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700320227;
	bh=7tQP0fC6mgP0gsULuCrf3QoHhwFbYjBWxb86gwT4xhc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HV0XAJbxwlQBpOLAISmLiS3lqGD4dWJnFcE8zsaKMyAYpq636IKReE0kSCDk6F8QS
	 CtpTd75vCW2TgmdGgW7K8Btx+wEL5FUC4HO5lNgqN6e275y7BhbcfmmC8WS2jtwjXc
	 p5FNWM3Yh+DzV0f+ByxdhQiXYTKAQ/Zl/Ym7YhL5KIbouI8ZMG0z4u4fFOstL6E7ED
	 QjXEospQXXqINqsYIyXfD1d3bVr6QCxc73vaQnlV7JJdj9jq3+qz9dxem1T5UMJE0u
	 wV+XG67EyRPJyjDyw+lIE9I+Y5HB8nM2Ak/zQyMl6k/6H7fT2+cpdpBxbqzSkdLbj9
	 CSO/qd69gbE8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4E56EA6303;
	Sat, 18 Nov 2023 15:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net/ncsi: Add NC-SI 1.2 Get MC MAC Address
 command
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170032022686.7145.14748650955833179032.git-patchwork-notify@kernel.org>
Date: Sat, 18 Nov 2023 15:10:26 +0000
References: <20231114160737.3209218-1-patrick@stwcx.xyz>
In-Reply-To: <20231114160737.3209218-1-patrick@stwcx.xyz>
To: Patrick Williams <patrick@stwcx.xyz>
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, joel@jms.id.au,
 gwshan@linux.vnet.ibm.com, peter@pjd.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 10:07:32 -0600 you wrote:
> NC-SI 1.2 has now been published[1] and adds a new command for "Get MC
> MAC Address".  This is often used by BMCs to get the assigned MAC
> address for the channel used by the BMC.
> 
> This change set has been tested on a Broadcomm 200G NIC with updated
> firmware for NC-SI 1.2 and at least one other non-public NIC design.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net/ncsi: Simplify Kconfig/dts control flow
    https://git.kernel.org/netdev/net-next/c/c797ce168930
  - [net-next,v2,2/3] net/ncsi: Fix netlink major/minor version numbers
    https://git.kernel.org/netdev/net-next/c/3084b58bfd0b
  - [net-next,v2,3/3] net/ncsi: Add NC-SI 1.2 Get MC MAC Address command
    https://git.kernel.org/netdev/net-next/c/b8291cf3d118

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



