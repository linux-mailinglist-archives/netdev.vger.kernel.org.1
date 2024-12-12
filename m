Return-Path: <netdev+bounces-151351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1979EE4E1
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5151887021
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DDB211701;
	Thu, 12 Dec 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU3kVr6V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF12116EE
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002416; cv=none; b=p998kUB0JOpjdr8uFwA9Y3XTmiRvW3ia/tLR2at4D8j2ojAfuWtIFd1gNxJQH3X3PhA3Rd5+YQn1uJpH0dqiSkPhiad/1rN0dS4TLQMfp/RJEbImXB9HGAwCGnSaLmj/Xvj/5dc+7A08r0VazpS+LoqIg9Xwz0tX5dWmLyQdlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002416; c=relaxed/simple;
	bh=WmOPlyEe9pWgc+IqFYekDzdjZztmTDeHIXjp0b2nK0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NnXOT4OXYCDi6+BEUbvL+HKeSgZZx4gi6+EXC1VmV8FqCPwtiWYBjMJM0VABQfk3oEoj6kY9xXL2EFS3VclCxLVnwZA7rVbEF9jNSyDhWoYTFwCLbWP+rC/LdVsrqnwN4vNJfA+Azv+Xpn1SvB1PAP5YhEwuH1ofcbMiVqc2x5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU3kVr6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88616C4CED1;
	Thu, 12 Dec 2024 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734002416;
	bh=WmOPlyEe9pWgc+IqFYekDzdjZztmTDeHIXjp0b2nK0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RU3kVr6VCkSBkXYeNHzZUbttRL71VDnWDYgqREQI44wzcRCqOY8lI1ycY9zCB9+bA
	 Z40ODX3mJmv5laTOdVQ1VQXEN4fct2qYFGUiP258iQmccFkW69AVaOxQHkdU0CKI/j
	 O0gdAhDr5AdxkI2JE4XYng+TNFTDmBr5N2QO6EEmwPwaa5MmnfKvlYojQz99bfCUfw
	 QIgRu3a/Nk2y30zIik+AVlhKMWb+rOs7R5HdcQHjTK+QAY41Xec/7cVjLYWGlLaU9A
	 e5uIebW3LohEHNtSF5Phtgp9Lton4/BpWneaBR1yJhhjcLqy88ogOgx0Obn+AvtN1k
	 6uLD8Wrauiy9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC5380A959;
	Thu, 12 Dec 2024 11:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: forwarding: add a pvid_change test to
 bridge_vlan_unaware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173400243274.2263704.7641246846550604885.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 11:20:32 +0000
References: <20241210233541.1401837-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241210233541.1401837-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, shuah@kernel.org,
 petrm@nvidia.com, idosch@nvidia.com, ansuelsmth@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 11 Dec 2024 01:35:40 +0200 you wrote:
> Historically, DSA drivers have seen problems with the model in which
> bridge VLANs work, particularly with them being offloaded to switchdev
> asynchronously relative to when they become active (vlan_filtering=1).
> 
> This switchdev API peculiarity was papered over by commit 2ea7a679ca2a
> ("net: dsa: Don't add vlans when vlan filtering is disabled"), which
> introduced other problems, fixed by commit 54a0ed0df496 ("net: dsa:
> provide an option for drivers to always receive bridge VLANs") through
> an opt-in ds->configure_vlan_while_not_filtering bool (which later
> became an opt-out).
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: forwarding: add a pvid_change test to bridge_vlan_unaware
    https://git.kernel.org/netdev/net-next/c/a3b16198d3df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



