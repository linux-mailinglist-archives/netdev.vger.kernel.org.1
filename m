Return-Path: <netdev+bounces-138176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1369AC815
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F85C281C16
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672901A2574;
	Wed, 23 Oct 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJfmYLwm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415591A0BD8
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680021; cv=none; b=Ou1jUxW1PrpLZi7FYbfJifI8Gsn8WuLA58A8NfUaHOFYj4bQ05hBvoUZmCBiDJV0Ha0WjA+QVbEkDrZxfbqGk6aWsHng07tYBM78Zq3o6xA+qXo22vO5gtwzEjqnV3qholjoffdmmS2BcsphJmjdAPA1fBOe7/ldqz14mR4lBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680021; c=relaxed/simple;
	bh=0i3l5ekdknN7E5Zf+zmRJm/BgpyN3Vb/RhRE/YShTsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hfHwImlMUgTkUX6X37EcLk4tzNbj/thmYN/trP4WrxhTVnCydUL61T8tPAxaeXDsSA2e5u83a6nPTOP70D8BASHkutm7lJABkBpRc8vdn+sShMUyaZrnX90cApm4jjW6u1HZxauI28d3yNDCJ+B4iqHhZM1RgvbGXwGxk4wjSl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJfmYLwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D635DC4CEC7;
	Wed, 23 Oct 2024 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729680020;
	bh=0i3l5ekdknN7E5Zf+zmRJm/BgpyN3Vb/RhRE/YShTsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uJfmYLwmE9YRCc6vn2PKlkSvvzuUm9gdK3tFfF3bX08kHUCZlqi5n3Mml4KSjuILa
	 of9uiOJLoaeFGcMqz0LDsWpuQfjDdVzGnBwIUQ1mv1y+tMsalO7TLZ+mSL0IOC35n9
	 eYQzpM8+pV+e9g4cMGkbFDqfUiiKPUFoVnwKb+PglYMOL6iCuVWzPX1KDcd1f50XNQ
	 P+FA3mSIS4ZKZe/F/4shl7ZZbJPzzV7ZYOjNw8o8oRN446c4S7jSe3vEsAq9QWg4FS
	 AykYfSfds44oYgW8CRub7HM/XtAbBm/ApzR3ziXASGTtHaOlg1C9RgIH4g+W2giWcu
	 TNECD90VWB/+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C273809A8A;
	Wed, 23 Oct 2024 10:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] ip6mr: Add __init to ip6_mr_cleanup().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172968002726.1558647.1142961342660084684.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 10:40:27 +0000
References: <20241017174732.39487-1-kuniyu@amazon.com>
In-Reply-To: <20241017174732.39487-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 10:47:32 -0700 you wrote:
> kernel test robot reported a section mismatch in ip6_mr_cleanup().
> 
>   WARNING: modpost: vmlinux: section mismatch in reference: ip6_mr_cleanup+0x0 (section: .text) -> 0xffffffff (section: .init.rodata)
>   WARNING: modpost: vmlinux: section mismatch in reference: ip6_mr_cleanup+0x14 (section: .text) -> ip6mr_rtnl_msg_handlers (section: .init.rodata)
> 
> ip6_mr_cleanup() uses ip6mr_rtnl_msg_handlers[] that has
> __initconst_or_module qualifier.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] ip6mr: Add __init to ip6_mr_cleanup().
    https://git.kernel.org/netdev/net-next/c/7213a1c417d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



