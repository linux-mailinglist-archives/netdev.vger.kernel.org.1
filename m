Return-Path: <netdev+bounces-135999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F299FEA9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 04:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8DF1C20B80
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70E15665D;
	Wed, 16 Oct 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSoaxWyB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2F13B298
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044630; cv=none; b=d4doGCv5Mu1KwvPVcpclXdgShgsI25Cz1rFLbggScrA4BSSIp/6jFzFmjo1K+hhyuFYpthsdRvG4xfdGO2kkOxJZas+L1EK1+aDvk8jGWe0YFqm2ehphBAPQz8gmSx/mSPtzeJwb4JbCG0hEyV1fIBxN6YwQCHVZD1KC2GVT4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044630; c=relaxed/simple;
	bh=IfmEHdhf/ssEqY01zyVYGYiBRRkaE8mp/gXCD7yNClQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j3bL8YIR7mSNh33A8hF+xjL1kQRLCkpha5yQr68Q44Q4aMm96Drimg6Kw8l2/lGYjOzWcbilxTysIDs24G/31R39J13KWxk8X3JSuihv4aM2cNkou8DFpQv6ONDyGO6q6M7ItKnlYbeU91HD0bqJOHXJtaE4CEpPHhmSDi8szn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSoaxWyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE924C4CEC6;
	Wed, 16 Oct 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729044629;
	bh=IfmEHdhf/ssEqY01zyVYGYiBRRkaE8mp/gXCD7yNClQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sSoaxWyB8Rv6xnIBopci8MUHVNEr89ofzk+3l68Di3mC0VBDHT4OeaVLB5XLsHcSX
	 HWZElCvz9GFWhJcdX61HcsibqHK6PoZIKtw5jMVjUYN5nnMnfbqtjOwxIAroDbhqO2
	 fBrzCMfNhvfot77ivhnHUB8ZMo7EbeA6SMK1jhELtlSveXOgjIydH3S1+msuz6zbYW
	 +QxlJo/gQqSjtyeWD+oZ7V6ECYNMfy8M+xOTIuNSKoTZzSr45csFWJAIm7aagolYa2
	 bssWK8b147pJal+zP9RoK+chrVo5fh93HdA2AQlHjV3oXpgfYf2evDF8C2PrMxhM9l
	 FNL7UVFjoc+lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B2B3809A8A;
	Wed, 16 Oct 2024 02:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/11] rtnetlink: Use rtnl_register_many().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904463481.1358504.4196871357445111927.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 02:10:34 +0000
References: <20241014201828.91221-1-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 13:18:17 -0700 you wrote:
> This series converts all rtnl_register() and rtnl_register_module()
> to rtnl_register_many() and finally removes them.
> 
> Once this series is applied, I'll start converting doit() to per-netns
> RTNL.
> 
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/11] rtnetlink: Panic when __rtnl_register_many() fails for builtin callers.
    https://git.kernel.org/netdev/net-next/c/09aec57d8379
  - [v2,net-next,02/11] rtnetlink: Use rtnl_register_many().
    https://git.kernel.org/netdev/net-next/c/181bc7875b71
  - [v2,net-next,03/11] neighbour: Use rtnl_register_many().
    https://git.kernel.org/netdev/net-next/c/d0d14aef50a6
  - [v2,net-next,04/11] net: sched: Use rtnl_register_many().
    https://git.kernel.org/netdev/net-next/c/cc72bb030325
  - [v2,net-next,05/11] net: Use rtnl_register_many().
    https://git.kernel.org/netdev/net-next/c/803838a5f6c8
  - [v2,net-next,06/11] ipv4: Use rtnl_register_many().
    https://git.kernel.org/netdev/net-next/c/465bac91f953
  - [v2,net-next,07/11] ipv6: Use rtnl_register_many().
    https://git.kernel.org/netdev/net-next/c/a37b0e4eca04
  - [v2,net-next,08/11] ipmr: Use rtnl_register_many().
    https://git.kernel.org/netdev/net-next/c/3ac84e31b33e
  - [v2,net-next,09/11] dcb: Use rtnl_register_many().
    https://git.kernel.org/netdev/net-next/c/c82b031dcb19
  - [v2,net-next,10/11] can: gw: Use rtnl_register_many().
    https://git.kernel.org/netdev/net-next/c/df96b8f45aa5
  - [v2,net-next,11/11] rtnetlink: Remove rtnl_register() and rtnl_register_module().
    https://git.kernel.org/netdev/net-next/c/e1c6c383123a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



