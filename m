Return-Path: <netdev+bounces-70411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A584EF01
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6812A28AE3B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863E515C8;
	Fri,  9 Feb 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYTgzMJe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629D24A28
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447027; cv=none; b=oIT1UiXadq4unbJjE1we4eZX97GnC0RxvpatO0U4E44oo8heEQ43ix/7Lkmx683127FclEm+AFeMM3PD8aS+u0pWPjLDNIL5NwApYuzJDRKMZbqdWt/dvO5oUFZnBw8RInlMHze4Amy9/Fbsvvtq53ki37ESfnZ5QvT09XvVVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447027; c=relaxed/simple;
	bh=pBi56z4657ZASIZsYVftAG4D2i5LoWK+ygER83eonTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HH+Mro0dCid8nxFpOEb/4o+0vClewC/AbaXN+siX8n1Y47KZvbInAyhZtx/jDiTIFtnEqyIlyHq+XY6lbnJEsZHadFE7T0eqVp438DPjbcZfBgaoLk3PaOIlPQC9y1Wlxj4zPEaO+edAVOvQc9VdPfFBAl0zQqRraZIoNOQvem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYTgzMJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1A57C433F1;
	Fri,  9 Feb 2024 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447027;
	bh=pBi56z4657ZASIZsYVftAG4D2i5LoWK+ygER83eonTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nYTgzMJeIMpN0GstIFf6+nbv6Iai6YFIKhnU+sEr7rhmL0RponPqBBEclf1M99evc
	 +SkVPbwSHJyded97+lqsiPZ2/3qAj2CPicmaz4YZofA1vil8TnOaLRp/HLz9NP/enP
	 R1iGNIbdckytTyQe26/Z+Rawf3+i9jusTGOJOtDhKwMilaicDbLs9M4XW0hArN7TCj
	 3m8BiG5Fo4lW7eTCtL1i7DBoPeiBcaIR0GH0hnOZ4gropLpt5ybucdZP2i0qY/FJKJ
	 8F3Bx0ahJRXk8Z72ACkoWOGz8fWkVP96YoIZnP7aZz3vKZC3H9oZ8jsF7L9NbTXJ5+
	 +oL9jCTFXJ/oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2352E2F2F0;
	Fri,  9 Feb 2024 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net] net/mlx5: DPLL,
 Fix possible use after free after delayed work timer triggers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744702679.13594.7451076824637775499.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 02:50:26 +0000
References: <20240206164328.360313-1-jiri@resnulli.us>
In-Reply-To: <20240206164328.360313-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Feb 2024 17:43:28 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> I managed to hit following use after free warning recently:
> 
> [ 2169.711665] ==================================================================
> [ 2169.714009] BUG: KASAN: slab-use-after-free in __run_timers.part.0+0x179/0x4c0
> [ 2169.716293] Write of size 8 at addr ffff88812b326a70 by task swapper/4/0
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: DPLL, Fix possible use after free after delayed work timer triggers
    https://git.kernel.org/netdev/net/c/aa1eec2f546f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



