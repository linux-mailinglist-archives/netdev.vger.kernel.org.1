Return-Path: <netdev+bounces-215449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5A7B2EB31
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84A25E5E9F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342D245032;
	Thu, 21 Aug 2025 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGzV4jHL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5851242D96
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743401; cv=none; b=KXwyJsgFm4dsA+WKDFopsgLa0Zu3mE4C4Rcenzy2suRLzH4VJm6xQjtPiHuyBKjCPczQ7uD4KurqMAmnzs85Zg4woknRSLhV9krvluFazPeohxf1NazdZnK3HdtFAEUHF7jRt/hpWsZsxTaoqfNF3P++nRxjUM+Fq8m4xsGptKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743401; c=relaxed/simple;
	bh=dKEH2vQ/xfw2hBX8TdhMZliwxiH6CRsPZ8NbFjG/m0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MiIfiWLIZEVp7DpZ78bf00msYHJWdL3g4qqix9kIt0I+WeUg3oi3iFeKVASDC8VgnBopBLWLc1d71TrFFr1VgW4clh2TEYEtp4nwXe1NiCUJzPDIu7k3cYlm9U8YSDA/JmuVjyPHT2Q9j7gHlztYL57NgDk4DZdkV2fwqQC5ZaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGzV4jHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9E5C4CEE7;
	Thu, 21 Aug 2025 02:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755743401;
	bh=dKEH2vQ/xfw2hBX8TdhMZliwxiH6CRsPZ8NbFjG/m0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IGzV4jHLpY5yJRS9mNG9cybFACpeYVApgz86r92Ke+kYKG4xsux2UEDAQKKNk6/2C
	 ZbSeahN0H8VUYkYN+L1KlgxB4PdJwfaXjeUHYmYfE9EBPz5pvkrn0kGW/pZZFH9cBZ
	 u5y1uGbgOF7ha8ljKyBggvT61O563jJsXE5Dfr+XZ997lJE5Kch1I0bdL5eUDlb9Pe
	 0nysd1CbaJysAu9lyuodv8Y8q+9TcGTakRS158goRQfxL6X140rKBZuvusSnw2EVCl
	 5qa7odxCjNkbQhTldj9eEdt8VukqsE1dDfFw8tHO4WHfZAIvr0lQqf5H3poE4BgKLS
	 6ALtPdiThIPJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BE2383BF4E;
	Thu, 21 Aug 2025 02:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/5][pull request] Intel Wired LAN Driver Updates
 2025-08-15 (ice, ixgbe, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574341026.480425.13944704403834523616.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:30:10 +0000
References: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 15:19:54 -0700 you wrote:
> For ice:
> Emil adds a check to ensure auxiliary device was created before
> tear down to prevent NULL a pointer dereference and adds an unroll error
> path on auxiliary device creation to stop a possible memory leak.
> 
> For ixgbe:
> Jason Xing corrects a condition in which improper decrement can cause
> improper budget value.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset
    (no matching commit)
  - [net,v2,2/5] ice: fix possible leak in ice_plug_aux_dev() error path
    (no matching commit)
  - [net,v2,3/5] ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc
    https://git.kernel.org/netdev/net/c/4d4d9ef9dfee
  - [net,v2,4/5] ixgbe: fix ndo_xdp_xmit() workloads
    https://git.kernel.org/netdev/net/c/f3d9f7fa7f5d
  - [net,v2,5/5] igc: fix disabling L1.2 PCI-E link substate on I226 on init
    https://git.kernel.org/netdev/net/c/1468c1f97cf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



