Return-Path: <netdev+bounces-142178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D009BDB4E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B6F284AAC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A2F18C92A;
	Wed,  6 Nov 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blDqvl6b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF918C91B;
	Wed,  6 Nov 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857230; cv=none; b=XIxna78D2Tpe3Y5blxTS94UALitGdnOj3VOGFU15c1MHAv9LO6w+hifHZNxCAyS690npYsG+gFwd8Bx4olcM+8OzwNUYoWc4upvvWEOyf2Sq3ELfZQcWYqEjKD9UWq9wIlDtBUSPi1iT09v6o7z24lpOXoiIeLKgBLXNRjwkg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857230; c=relaxed/simple;
	bh=ltKju4GAlP9Gq8YfEV6X+ob93p7WotTATx4nxuTTo4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AeAlO2IHr3O7BiY5a578XC3t/88BlXwxaIiBNqIjhberziMA+fRGFGDaRPyBK3QTGZonB0qBPl4UUKkTI2J47kJAArHVqbmvj/7G30u1GMCO8HtnUW+qbDLliaMGTQLEu4irr8Dhfh5BK5iYSJflHmrZVtOZ/Q79A9zWQ8/HP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blDqvl6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563BFC4CED4;
	Wed,  6 Nov 2024 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857230;
	bh=ltKju4GAlP9Gq8YfEV6X+ob93p7WotTATx4nxuTTo4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=blDqvl6bEqEmVPyAwhYvo3MoqVWHowXcZuI/fJlKaGuQHMAsjo1lSgUx6Z6RbCQuu
	 Y9L31LMGn4O7zLBPza82T3AsZsVdTwf3+MITc1B6u8XRiDV8qf1sPqaXpyvhlz1KMy
	 npWWY+LUytOVNF5LE8yAQH3xrf0WXCkxG10uXCB3UPhdR21OdbZg2S0gy73pX91P0z
	 KXZ+VcCIz+rtI2AeykTU4uIKh2hAwbG5TI7EG1rdTOf6wdirvXendEDnvuavxbGAEG
	 9msxuwcZiitcSicTnTwAvTb/OWYylZ+bj5tF/Ua1QorhtpG4nRnVdKd0AjZedC/FQM
	 psBBoC4WQcPOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C883809A80;
	Wed,  6 Nov 2024 01:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] A pile of sfc deadcode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085723899.759302.4593884648959376210.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 01:40:38 +0000
References: <20241102151625.39535-1-linux@treblig.org>
In-Reply-To: <20241102151625.39535-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 Nov 2024 15:16:21 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> This is a collection of deadcode removal in the sfc
> drivers;  the split is vaguely where I found them in
> the tree, with some left over.
> 
> This has been build tested and booted on an x86 VM,
> but I fon't have the hardware to test; however
> it's all full function removal.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] sfc: Remove falcon deadcode
    https://git.kernel.org/netdev/net-next/c/cc4914d90479
  - [net-next,2/4] sfc: Remove unused efx_mae_mport_vf
    https://git.kernel.org/netdev/net-next/c/70e58249a646
  - [net-next,3/4] sfc: Remove unused mcdi functions
    https://git.kernel.org/netdev/net-next/c/5254fdfc746a
  - [net-next,4/4] sfc: Remove more unused functions
    https://git.kernel.org/netdev/net-next/c/d3e80070b5b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



