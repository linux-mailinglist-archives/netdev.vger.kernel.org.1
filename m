Return-Path: <netdev+bounces-210219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D381B126C2
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F491787FD
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171DE2586CA;
	Fri, 25 Jul 2025 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8EXD8pR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BED25742F
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481828; cv=none; b=R5nPKQLd8HUztkXc0p0fWG/EKffmR34CfSlZJZVMcqctV5KrXWRg7vCz34XEiSePRZRpwA/79ufKZKwjsoimWsaKPtSXNGIOmQ5q67KM1hFAZIYcaa0jOhJtnfFzFs0l/znqYwdMaWajjdNqq7fFwHHsWTttpLYLYttExhPhVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481828; c=relaxed/simple;
	bh=VXg8+zCO9LTq5Cfa5Xw2AKpxR9HK7gLPGqCNVfuhUng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pFU+tmcBNAajbuRZlRTQgXI0uiOry6LcES3a3atrflyyZWj89Gm1nxhIiVZCQ+hMiOgyyx/hd7reMHzEvCkp/L3onZX66wmlGeU4j2hcotVOKJBvCaR5cw9Iq0q1w3maAgDB9lML2raiu4A9HTUB0/7VZa4pPA6Dywus72I4ynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8EXD8pR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B87C4CEF9;
	Fri, 25 Jul 2025 22:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481827;
	bh=VXg8+zCO9LTq5Cfa5Xw2AKpxR9HK7gLPGqCNVfuhUng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J8EXD8pR8gIQHRG8Oh+Z1QL08qQ/vaxrEbNhZfYdnFk96C/VxC/DXQBNLHfmuY1Xl
	 IuJBaiF++Ag9aOo0P1Q7sU5TUHdyPbHUOcOgdpTXUuEJnFJW+HSPxttgnoyEHn2vUo
	 16e350UzP4KYMW2t+JQCgcrin2jNO3J1Mj6RM6NujTVt7s1+fTG1JAc2wddzqNtdQN
	 Q0wgYV+gE2mTnEI0XmrWLDw08Fal/9qDUdFqMTv2I3BBvpPjVLOV8Qks/LSsf3xCAv
	 k/DryHo29erQfrZnOzJZLLa3F8zdjBBJUYgn81J/SmnzGTKi9cpyCPdomnCYHyTUdm
	 TWXoSwkgvLSfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF1383BF5B;
	Fri, 25 Jul 2025 22:17:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] neighbour: Fix null-ptr-deref in
 neigh_flush_dev().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348184500.3265195.14222572943753775652.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 22:17:25 +0000
References: <20250723195443.448163-1-kuniyu@google.com>
In-Reply-To: <20250723195443.448163-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, gnaaman@drivenets.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, oliver.sang@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 19:53:59 +0000 you wrote:
> kernel test robot reported null-ptr-deref in neigh_flush_dev(). [0]
> 
> The cited commit introduced per-netdev neighbour list and converted
> neigh_flush_dev() to use it instead of the global hash table.
> 
> One thing we missed is that neigh_table_clear() calls neigh_ifdown()
> with NULL dev.
> 
> [...]

Here is the summary with links:
  - [v1,net] neighbour: Fix null-ptr-deref in neigh_flush_dev().
    https://git.kernel.org/netdev/net/c/1bbb76a89948

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



