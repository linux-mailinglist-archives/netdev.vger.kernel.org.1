Return-Path: <netdev+bounces-183570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CE3A91114
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BAD447569
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BC1B87EE;
	Thu, 17 Apr 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5I8OXsx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E51B6CFE
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852832; cv=none; b=PtT2PdrcGBCG2OSzEDW/J2ihL3irUB3VffRpmXjeCjUSXVfFni95adP4gfWWZv+SRi8LKKKx1PhOVBeYq+Bd83ccAx/ktolhYXVNBB+d3Y5sHgLrPNC4AQ0gBCABX+ybc/M8rxbLqu93hs3I+frFt9FEy6uUwLI3I7/llHk5i+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852832; c=relaxed/simple;
	bh=+zz5hOkMvPtUZ/Vq61xkGudIFTsEoYTuf2d4HJa6fvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DGL64Dxekk7Qibe6BOGPLHB8DTuex2JyZaYYZuQUUdhyd8K9v26cd8gcp7HW2bra5TKJbEOoPIDLCM0iPrQdFY0moktKU+mpjO61QH9S3XU9uQK3GxT5PON7WBkgVrhkqQH35O+CR1UDxe/70usw81jZhj8mkW/S8nOvRjH3rf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5I8OXsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3211FC4CEEC;
	Thu, 17 Apr 2025 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744852832;
	bh=+zz5hOkMvPtUZ/Vq61xkGudIFTsEoYTuf2d4HJa6fvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B5I8OXsxCMvXRKoAbt1V3+0KKWZ+7duBmuw0SWAUrQ7ZR1nRy0bI9nZmpJUQWWbrs
	 zjLFECheAzWmV+M2Zhg4XRHSkBR6btxExS0WHs4a1gHIRaWqA49v/FxXt5io8T1aTo
	 q8GddUs1pm/ik2wa+HI47ixYF7qvoxX5QoAH0ObYFrs5EZ4mc1ivNV9SFXPUP/idmF
	 xG82eySRc37+M3MIhKztso1JbHi/83GnGGEFI8KPH1g9mVom0ItBjD7aYBXNTlfaag
	 dqXc0Eus9IgCgvKM7vNi+Vd3/6KgCe7rCLLvyNTs/VFD94/7vPFHoRQbHXgrGNo5mD
	 dVqnULR5L3haQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF23822D59;
	Thu, 17 Apr 2025 01:21:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8] ynl: avoid leaks in attr override and spec fixes for
 C
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485287025.3555240.6557411231722803651.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:21:10 +0000
References: <20250414211851.602096-1-kuba@kernel.org>
In-Reply-To: <20250414211851.602096-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, daniel@iogearbox.net, sdf@fomichev.me,
 jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 14:18:43 -0700 you wrote:
> The C rt-link work revealed more problems in existing codegen
> and classic netlink specs.
> 
> Patches 1 - 4 fix issues with the codegen. Patches 1 and 2 are
> pre-requisites for patch 3. Patch 3 fixes leaking memory if user
> tries to override already set attr. Patch 4 validates attrs in case
> kernel sends something we don't expect.
> 
> [...]

Here is the summary with links:
  - [net,1/8] tools: ynl-gen: don't declare loop iterator in place
    https://git.kernel.org/netdev/net/c/4d07bbf2d456
  - [net,2/8] tools: ynl-gen: move local vars after the opening bracket
    https://git.kernel.org/netdev/net/c/dfa464b4a603
  - [net,3/8] tools: ynl-gen: individually free previous values on double set
    https://git.kernel.org/netdev/net/c/ce6cb8113c84
  - [net,4/8] tools: ynl-gen: make sure we validate subtype of array-nest
    https://git.kernel.org/netdev/net/c/57e7dedf2b8c
  - [net,5/8] netlink: specs: rt-link: add an attr layer around alt-ifname
    https://git.kernel.org/netdev/net/c/acf4da17dead
  - [net,6/8] netlink: specs: rtnetlink: attribute naming corrections
    https://git.kernel.org/netdev/net/c/540201c0ef7e
  - [net,7/8] netlink: specs: rt-link: adjust mctp attribute naming
    https://git.kernel.org/netdev/net/c/beb3c5ad8829
  - [net,8/8] netlink: specs: rt-neigh: prefix struct nfmsg members with ndm
    https://git.kernel.org/netdev/net/c/e31f86ee4b9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



