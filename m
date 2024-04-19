Return-Path: <netdev+bounces-89481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA98AA631
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 02:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDC228314A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C119E;
	Fri, 19 Apr 2024 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhNj5mUK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698997F
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486028; cv=none; b=t/LdnxGihEWLA81OlS1f++EQmQJ0r8KIwzrc5SjVuYrpWYKkIBj7rNwk07X8sL9MnXexa1kdkIkhzMe01UxI7A2jlbqivN/9Q1tWh02mA1b1u7p1oMd17a1vzgiiytgT9H4CG2ryKwZ8Z/3HUeM9A9LVd5pb9+WCE8Fm5HC+yrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486028; c=relaxed/simple;
	bh=ltvmE09EipZAaX3/5BuhhkvllUr9Gw9Srvj9ucXDX5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nBem0rcjhwnqfrs97Zhi3S8etJIgSvt0oBYHY4w6bzgLtwNTryy8xoyBAHDrqb8UVklZ9KFIbXNA9Jb0RrEJariC+8L4wBIWnug9M3oTFTQLJ59Uo80MQzBcAdQeCma81B/XhdQpERj4EnQtgmIgnNOvq4iXsSOaUvMTneSWCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhNj5mUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1265C3277B;
	Fri, 19 Apr 2024 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713486027;
	bh=ltvmE09EipZAaX3/5BuhhkvllUr9Gw9Srvj9ucXDX5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FhNj5mUKKMU4cs0oDC9pKqqfdg5emOoe2KlkCBmTc4evmUbQ9BhRx6OXR4z15paDG
	 9SxHWaoruDIuzPYSYEvN3g549rfUy4TdlWkHYdGt0L5QH4ZOqGrlu0RBrI1OFUzjks
	 9x7YvrEPux4AWFpO6UaVTgUBPZg5nGcEEi+Climgc9sPk77z8iwaIpD5uKn6dL7N0P
	 ae8ybNxazPQ3VPMv/Fc2j5b8pBjIAU84LrKwB5MBYiBeirdFNMefqymNRIDoDiSoun
	 si6DRlJAW8BQQxWHG1IciJ2qmwNSiN6/TwCzA+UzfPOTMOgsb8lPZOJ6qrOtG6FkgV
	 JG5QwYxdC7QgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B087FC4361A;
	Fri, 19 Apr 2024 00:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2][pull request] Intel Wired LAN Driver Updates
 2024-04-17 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171348602771.2289.14328377393143875523.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 00:20:27 +0000
References: <20240417165634.2081793-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240417165634.2081793-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 17 Apr 2024 09:56:31 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Marcin adds Tx malicious driver detection (MDD) events to be included as
> part of mdd-auto-reset-vf.
> 
> Dariusz removes unnecessary implementation of ndo_get_phys_port_name.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ice: Add automatic VF reset on Tx MDD events
    https://git.kernel.org/netdev/net-next/c/cc2a9d6c03b8
  - [net-next,2/2] ice: Remove ndo_get_phys_port_name
    https://git.kernel.org/netdev/net-next/c/41355365d252

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



