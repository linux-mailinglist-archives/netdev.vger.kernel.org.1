Return-Path: <netdev+bounces-135615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DF899E733
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0212B28580A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775981E7669;
	Tue, 15 Oct 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r19+K5QP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7F1E633E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993025; cv=none; b=JC098r2IQZasCIFpoikBM83n68Jze9VJ0EIWvzFPcLHRyIjDVjR9PCTe+Sx3Z4dtf9per15df34YNOupaWUuz0Vxb4jFWH3wPeSOubeghbP3W8oVj4MmnstJwqwN8ETXMo/QqEFa6Xvz40KaoG4xWgcYcXYj8dpNbPH7Xh+0r+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993025; c=relaxed/simple;
	bh=Q8VaYfhLChbvlH+uSV7dYqA+HmQYjRo+ISORxScwBA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tLrABxiFj+iNA4737c954+/cmGOSOH8Evfb/3HOdclZH/SIOPdkEvOyJ1DluDvJOu5TNuEa8JAIoig6qgPGBoEvDd5Ps8PHEcgUoJtAK2eqvf8Pobqgi58Ph++3mHiqd83Q/uEymZxNeTF+6wXqrrBAoAIClSh0nG0xil0NMxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r19+K5QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BB9C4CED0;
	Tue, 15 Oct 2024 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728993025;
	bh=Q8VaYfhLChbvlH+uSV7dYqA+HmQYjRo+ISORxScwBA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r19+K5QPXvZ1HVe+/xnSdL6zAs+47IrzZh7Zp4KLJBxvOnHyPNDFupF8uPmD3FrR5
	 psQkVdp+UsNgGsKBK9YJID7XOB86m4kiks8/Ui2tVu4LwCo4cbVc7Dl7NdHT1YgG62
	 gILC5iB7+33eylPEInvBCfDUYJMFbvVOpFqUAABQD8LxQAyOqGeXefm7dYNzWhrEah
	 3HGPPs1E6MviSM02brRz4K4aPM3zuxCtwAqzB7ueYzI8v4qxZhAGTnDClYZvEEHbbb
	 +b9Pd2Az2norzNJCpJsyXgOqFdOrLAzAtJwcN2uJrIS/6TikRmQvjob2CqgvRewZn9
	 klaTfyApW7h1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BE13809A8A;
	Tue, 15 Oct 2024 11:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] rtnl_net_debug: Remove rtnl_net_debug_exit().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172899303025.1133501.7728155874460386316.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 11:50:30 +0000
References: <20241010172433.67694-1-kuniyu@amazon.com>
In-Reply-To: <20241010172433.67694-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Oct 2024 10:24:33 -0700 you wrote:
> kernel test robot reported section mismatch in rtnl_net_debug_exit().
> 
>   WARNING: modpost: vmlinux: section mismatch in reference: rtnl_net_debug_exit+0x20 (section: .exit.text) -> rtnl_net_debug_net_ops (section: .init.data)
> 
> rtnl_net_debug_exit() uses rtnl_net_debug_net_ops() that is annotated
> as __net_initdata, but this file is always built-in.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] rtnl_net_debug: Remove rtnl_net_debug_exit().
    https://git.kernel.org/netdev/net-next/c/bb9df28e6fcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



