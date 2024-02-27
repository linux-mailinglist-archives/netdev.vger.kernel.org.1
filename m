Return-Path: <netdev+bounces-75181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25498687B3
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 04:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FB11F23299
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533681F61C;
	Tue, 27 Feb 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7lGF3BF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10521BF24;
	Tue, 27 Feb 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709004030; cv=none; b=Ky3pZjpekNPkWX63iJIp88URWunRbrI1dQyjFSs+8lTcrYEFYvL7aNrBhlzszRT+WJi3im3lfqLaReSbNUphxvF8quymH600wzxYe+LL2cX7Utluei/n0nQYXgmli3quR3HTKUkvPTmdozD6ZnIdrnxUBn9AnfvcHOBhjHTaMOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709004030; c=relaxed/simple;
	bh=wvuaH0QCnjuos4nSIuVMUtAnMQrPcv16Sf4LpBfby18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BL4gFa9dZqRI+5zKZBr0VdRo71DI9wZsebquIgVdAN/XZlk0chBN+4gvK+7xBazzeUlW9fkJmIgyS4zNlCAYOqJ3I7o0yhUqptV6ir8HQlNwlRE3Gl/rFnCZPHPXKwvZoVYWT6JUthVl+TBKEHG2N1ca6jzQChwSh4gx62YEUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7lGF3BF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 829F6C433B2;
	Tue, 27 Feb 2024 03:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709004030;
	bh=wvuaH0QCnjuos4nSIuVMUtAnMQrPcv16Sf4LpBfby18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S7lGF3BFiQQW5xCZBe6dev9BXxcp8fyp7UjdyFI7ZIrBJf5zP8eZz6pwG45CEMwxG
	 sfsNtyM9GJ0H2yUFR73HtXhs15WoE2CWkhK4f1W75yXLgD2iZUAJQwGk2yoqTZQn19
	 bME7e/th4KQduD98+ICnlFTPLizYwGr1/vYob+5YhBeNsDTZu2vaW1S6SUufVelr+2
	 CNddQDGuQV9nFhnPSEVZZJVmNGrvDLCBn4Hmpe8ZuQJl5NdZCfVoL9wJtmpsjRzNf4
	 MSrmjKDUDj9joQbFwcYbTZMDiU34ro0uOzATfEKD4oL+OJPBRAu60k+kkqJWrgRvQe
	 0c5EMtJEB0p9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EA58D88FB5;
	Tue, 27 Feb 2024 03:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net/vsockmon: Leverage core stats allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170900403038.25082.7588895436249883033.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 03:20:30 +0000
References: <20240223115839.3572852-1-leitao@debian.org>
In-Reply-To: <20240223115839.3572852-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, sgarzare@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org,
 virtualization@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Feb 2024 03:58:37 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/vsockmon: Leverage core stats allocator
    https://git.kernel.org/netdev/net-next/c/bcd53aff4d0c
  - [net-next,2/2] net/vsockmon: Do not set zeroed statistics
    https://git.kernel.org/netdev/net-next/c/3a25e212306c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



