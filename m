Return-Path: <netdev+bounces-206134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4DFB01B51
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC61B42621
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD628DF27;
	Fri, 11 Jul 2025 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmtgz5KJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DE27A44C;
	Fri, 11 Jul 2025 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235187; cv=none; b=bu7EmkUyzCsQezsH6CF+wjU6PfrhqGyIy8EMCUfILuOxP+8Rat6RrXplXC8vetZQeA2BW/pELkeuDmVXd2Fd94vEZnXbGTuvV34yKitTyj3eBNhbdkQMKG/pgV4IbIxwR2JbuxPsfp8vZwQtiOkMQUWCdlcxkt8sXDcfRh93/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235187; c=relaxed/simple;
	bh=p2ATkh83EA+QGpVpMDHbD3OAgOYQ3HkCHxVe9BUcXnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YhGyjFEgAQvfIIBtwMYk75C2munIPfzkKECndtpgWKsWY821lgqiI6eMd2xwFtfjCGXyDaN4Yk6MJXKfPvxFYAHQHZm2uE0K3jmT3F8r2buZAQr0+QU8vpv1gQdpcSg1BVd+gug3NzXaNJ+lm4dY+Kbq+vUDOY+/eThxY8ffFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmtgz5KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9D1C4CEED;
	Fri, 11 Jul 2025 11:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752235187;
	bh=p2ATkh83EA+QGpVpMDHbD3OAgOYQ3HkCHxVe9BUcXnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dmtgz5KJ4VIifN8Va6QXtrmJm/PRwnBAATg9N0LE8xMTI9/ZFolPGG3ZNeIRPeWMA
	 PHLkF8mPbqoXn1N6KphZkR3e0M/csedgLwe8dyCIkbpOjAuI/BFV8OCPySC7BzNbAV
	 qQIMM8l/nVyOMefCmU/QPatTUZVGEhPI0Pu7v8XUSNvOiKaFJaARs5r2FOS6APBYdX
	 GFV/2Feo3TrJLC1PdMuZGkHNAd1IKb2mzeEPpK04x1Paf9Xo3xQpj2Cybp06Mew0id
	 u3kJLVBvtxBu7UGYPVwOJyWdMYSocbU2OWcVYDkVcIYWFwor4ynPFuYi4YqnVjeYN7
	 RTEl3rXZ6mtSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC0383B275;
	Fri, 11 Jul 2025 12:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH for-netdev v2 0/2] PCI: hv: MSI parent domain conversion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175223520902.2242194.14448724855581573230.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 12:00:09 +0000
References: <cover.1751875853.git.namcao@linutronix.de>
In-Reply-To: <cover.1751875853.git.namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: maz@kernel.org, tglx@linutronix.de, mhklinux@outlook.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mani@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  7 Jul 2025 10:20:14 +0200 you wrote:
> Hi,
> 
> This series originally belongs to a bigger series sent to PCI tree:
> https://lore.kernel.org/linux-pci/024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de/
> 
> However, during review, we noticed that the patch conflicts with another
> patch in netdev tree:
> https://lore.kernel.org/netdev/1749651015-9668-1-git-send-email-shradhagupta@linux.microsoft.com/
> 
> [...]

Here is the summary with links:
  - [for-netdev,v2,1/2] irqdomain: Export irq_domain_free_irqs_top()
    https://git.kernel.org/netdev/net-next/c/a6b0465bd283
  - [for-netdev,v2,2/2] PCI: hv: Switch to msi_create_parent_irq_domain()
    https://git.kernel.org/netdev/net-next/c/5f83d6337c9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



