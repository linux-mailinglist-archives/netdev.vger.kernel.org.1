Return-Path: <netdev+bounces-96918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07048C832A
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A62282263
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A648F1EB3E;
	Fri, 17 May 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNqutlHp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826811A28B
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937631; cv=none; b=j8jtFpndeTC4YZ1EKNq38DtFYJxrtIG9m0SKb4rMRvWZ1sQ7Wsswa5nEzMZik9X6zcdU7P+H7CK+iYYpUk9vTIo67Cky4TgKXA4LxrPEWVtw5aFtJp+PaTKhhGsknoGNSEsoWiWajv+81JwHiGeq4kyDTWzA/0xK5U5jrOcWJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937631; c=relaxed/simple;
	bh=/kMu0Se6J6gcVS7Gs+teJuMxbpEzG+RkIAOkHcwjdgQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HlBVMbOPQp7wNLo9QyAusXxbueL83Y3n7oNoJjPr59F5LCPPuv+srk0gtU8eBPziwTpnmOtMOIwUgjp+0tmvCaUpdg7m2ZxefXqFOY3VcArocwxKU3i4FnI/c+Q+ceaCB+EHxd0fbw016VIafLhetR/oXupT2aDzcE82od0sWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNqutlHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3986C32782;
	Fri, 17 May 2024 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715937631;
	bh=/kMu0Se6J6gcVS7Gs+teJuMxbpEzG+RkIAOkHcwjdgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BNqutlHpNaETsiJglP5lyQSxjJcYPWJfAZSM4V/EyzZ/nWlzjRgd3k+mfHpB9omDk
	 +kGfPyGynOYYvUiYW66TS4DzSIDBzP7x/xwZk8iFC2aQY75hxDb4dNi3L5lZZrNNwa
	 w+KOOVSS03Uv+plYfZSRsYoY1rYoHx0eDCykzVxJH09m2gLs3K2gpTK6uOoOKZPUWu
	 RIqpCT1gb3LbafT2ovB3gM3ykOP68UQZPyP9XSu4C+KOEU6qSZXp67zgI3tbzJrEVk
	 bl5byli9picFB61y0fRovFbjKs290FPbPC06mlq73GBV+Mz8IPQxyvaTLmlYcJCl+O
	 OIkGAlpbz9oMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1FE4C433F2;
	Fri, 17 May 2024 09:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/3] Wangxun fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171593763092.29282.8564703865399802343.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 09:20:30 +0000
References: <20240517065140.7148-1-jiawenwu@trustnetic.com>
In-Reply-To: <20240517065140.7148-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, mengyuanlou@net-swift.com, duanqiangwen@net-swift.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 May 2024 14:51:37 +0800 you wrote:
> Fixed some bugs when using ethtool to operate network devices.
> 
> v4 -> v5:
> - Simplify if...else... to fix features.
> 
> v3 -> v4:
> - Require both ctag and stag to be enabled or disabled.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/3] net: wangxun: fix to change Rx features
    https://git.kernel.org/netdev/net/c/68067f065ee7
  - [net,v5,2/3] net: wangxun: match VLAN CTAG and STAG features
    https://git.kernel.org/netdev/net/c/ac71ab7816b6
  - [net,v5,3/3] net: txgbe: fix to control VLAN strip
    https://git.kernel.org/netdev/net/c/1d3c6414950b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



