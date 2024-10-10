Return-Path: <netdev+bounces-133986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E79979EF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45660282327
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0488D15E81;
	Thu, 10 Oct 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3vDKsI/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF715BE68;
	Thu, 10 Oct 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522025; cv=none; b=k97rfuMdJypmjoeDpZt11nggYYJNHgPWQBjwKwMVoeBvSlz3RTsKEFboZtbZ+I1I6Yrjsjww//LmUuXp3eM5TtPCibNkAsJNCvlIXciuQBaOo/hvCCzqQ63q9PcHHPmaClK7msR5+UplQFhTLFHPQ31cWsDhVtxqTx7I/wGrvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522025; c=relaxed/simple;
	bh=pG2K624uEgi0xR+pggi3+7hy+WagHSAnEj/80vrp7VA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n7P41SBB30EYBJDnkntkaC7nqfOWB1UTOAsTuIydpHQEGf2eydohV0y4dCi+W35OkImx/adCwTPD4qKX6qxjcI0JOcsNq3/9GhQDdkBmZPwO8bDJBT1eslkGFeJcgC9l0mGSGqzfRs0fVZwuUWb3CYn6877ckmunb/smdrwZw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3vDKsI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09DDC4CEC3;
	Thu, 10 Oct 2024 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728522025;
	bh=pG2K624uEgi0xR+pggi3+7hy+WagHSAnEj/80vrp7VA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m3vDKsI/ckTkn/sLY3MewfqfEU2dP4580FqwcCzozAtlcbp2yqhFOw/FnmyLksAeF
	 /NhhY/fEG7MmMJydL5hfmA9qzqK61lkCXdpba0BmfqtfDTJ7yDUCw+Ur12NXQ1w6ra
	 djySIMvuRqV5XnT0l5OyXKV0GTLUpGdhOwM5c7SfuyIJPcY/ZIbceSQd/K/4C9O5UL
	 7CkO8M8MzfRGi369CgfwlIkkoEURG+73INBXEbi9Dn3fuo9olz3O9iZanKTQ68b8Sg
	 FlgjORihI1OSevCaJuBQhX6I6fW4+JX7o9AcrEJVHu4m3Pm8sEk4kBLm6j+KSjRUJt
	 OnURw8u1kdFfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA63806644;
	Thu, 10 Oct 2024 01:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] net: ftgmac100: fixed not check status from fixed phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852202999.1525987.11825427813885563934.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 01:00:29 +0000
References: <20241007032435.787892-1-jacky_chou@aspeedtech.com>
In-Reply-To: <20241007032435.787892-1-jacky_chou@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jacob.e.keller@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Oct 2024 11:24:35 +0800 you wrote:
> Add error handling from calling fixed_phy_register.
> It may return some error, therefore, need to check the status.
> 
> And fixed_phy_register needs to bind a device node for mdio.
> Add the mac device node for fixed_phy_register function.
> This is a reference to this function, of_phy_register_fixed_link().
> 
> [...]

Here is the summary with links:
  - [net] net: ftgmac100: fixed not check status from fixed phy
    https://git.kernel.org/netdev/net/c/70a0da8c1135

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



