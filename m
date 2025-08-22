Return-Path: <netdev+bounces-215855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D70FB30A7C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A3918997E8
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 00:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11421126BFF;
	Fri, 22 Aug 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcROCPiR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFD74040;
	Fri, 22 Aug 2025 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755823796; cv=none; b=nHA9WX9tNyy4wPX+IiRNYJ/hOtlZy0WwYdJOsa6q2Ho2zpU9RtNPQ5YvhKQj8Hj7NF7nt/+ek7Dq9Z15k06hN0LGvQ25ACWtiBfITd0lFXBxr9lGtZOhz7WgLoCUr6WqT9skVEopgCRTys9HTc04ikJi4UoUNyA02DVzEUlI5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755823796; c=relaxed/simple;
	bh=arnBqAHfj/kHyqgyi2DswugplEKtCPcVqq34VWJ1tvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FAC1nsk4fKDs5ueigHjTO6Pcz9d1BSyWyGsYS6q7jfBGFnhtwVjfohb+65rXWdNSF6AqXbuPM+00GxmiPbgTuXCXybF1NW+I3iMS79Xbp/NnnSGYa4qgTMqvPUYTBmBeQ+IpPo+hC8z38dl6ZJd9pnzNWxZ1iRkYHfgXtEhUDYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcROCPiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52152C4CEEB;
	Fri, 22 Aug 2025 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755823796;
	bh=arnBqAHfj/kHyqgyi2DswugplEKtCPcVqq34VWJ1tvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KcROCPiR+ge1c4zsL3zkqzUtJfhvgHD7H2INxEsbGTrIJk7aS4OZjpkKbvbw6t7+3
	 irI1yWq2jzPIj0Dmxdg7pJDlWEKrIHeUsf7exsUSCuf5Hi+S5CIVJ+uMQ4IF07/CKr
	 o7pBWKXwdFN2Pa63P4sAD/s/wFJUYAQQLnFEfFsXeeC71aPKQ/ob2eq8+/6k7SnGjo
	 Bc5UkWMNTBBeYhQ1Sq9ZuoMiP+lEFjOE2Blg0DWlUhhkxPhYDmMFNUZEQV4+oRo1X7
	 QckjiwQ/fbh8TXNaplaf03pK8j/afT/XwfuD2cyHkSdU2W997o1ShzxdWok4WdONx8
	 7TBKO9j8y/Yjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD19383BF68;
	Fri, 22 Aug 2025 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] gve: support unreadable netmem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175582380550.1256377.8748570016233109275.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 00:50:05 +0000
References: <20250818210507.3781705-1-hramamurthy@google.com>
In-Reply-To: <20250818210507.3781705-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, pkaligineedi@google.com, joshwash@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, almasrymina@google.com,
 ziweixiao@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 21:05:07 +0000 you wrote:
> From: Mina Almasry <almasrymina@google.com>
> 
> Declare PP_FLAG_ALLOW_UNREADABLE_NETMEM to turn on unreadable netmem
> support in GVE.
> 
> We also drop any net_iov packets where header split is not enabled.
> We're unable to process packets where the header landed in unreadable
> netmem.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] gve: support unreadable netmem
    https://git.kernel.org/netdev/net-next/c/62d7f40503bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



