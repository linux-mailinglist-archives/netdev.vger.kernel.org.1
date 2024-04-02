Return-Path: <netdev+bounces-83884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92C894AB3
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F5C286B15
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944017C9B;
	Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHscOdeq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD117C7C
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034029; cv=none; b=tFJhK2gPTx1L7/80OFjP5WjrwYRB9vS+Tuf7J8Ax45F6TT/BHBnUA+q0TGUR87cIof68UJKyk4UJESNH6nTUnhTXEC5WzesnFsUhgX4x1pLMGQgD+huz8/N8xG5WkEpRi+FIxwVuae2SK4rpuWP6tcR+rY0c5rutt53HQqlb/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034029; c=relaxed/simple;
	bh=HWL9flNheJcA+w3kaqCYuBzzCA4mGw57vDgmCHsfmy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EShRfSC98Ru3Gsm7jc3NNoB6LbvBQ71QVk0LOPUMVFF4/lbjaZELQ5PAZi7jZgv4xjzmEcZF+eqMaaB3eHLchGu2cgOQndjaaiUdzKWUoANEJWXJQs5glEtAZRri//cD0DbzuDvx11S/d4MrfVjMRwPuFfzw/i/+USJjQM0ZNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHscOdeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CEC1C43390;
	Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034029;
	bh=HWL9flNheJcA+w3kaqCYuBzzCA4mGw57vDgmCHsfmy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nHscOdeqYccsU4spmbzbJNpMrezNfCisz+8kKG68DT4fL6rJEMdZQF5RZKi0fXIW+
	 Tb0PXYFVEcRLoGvAf29K9JgWsLct7E7BHC90SacaAIbBdXp0u0EntCSrDAQy82rz2f
	 Gdp7Ep9jA2j4yI/piLt/bAX0sq6xiwut6+wmSa+UH8sBLxCYvpd47cX7fgF4QXB+6n
	 /kFZ15hwPwGAZQu4ugMn0EiDRrN6Zg9iH5xYD5lgC+XNI1szbYfgJhuRa+YFF2ubEN
	 2UfQqzQ471ulyExXLdCWTWBtvjOwhjNFlIyHISMUf1W5Gqi6ac/A+nEnl4+aeoijhp
	 BDJvOfDldS+wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CBD3D9A156;
	Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates
 2024-03-29 (net: intel)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203402917.17077.1793675277084228711.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 05:00:29 +0000
References: <20240329175632.211340-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240329175632.211340-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 29 Mar 2024 10:56:23 -0700 you wrote:
> This series contains updates to most Intel drivers.
> 
> Jesse moves declaration of pci_driver struct to remove need for forward
> declarations in igb and converts Intel drivers to user newer power
> management ops.
> 
> Sasha reworks power management flow on igc to avoid using rtnl_lock()
> during those flows.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] igb: simplify pci ops declaration
    https://git.kernel.org/netdev/net-next/c/47220a1e0b70
  - [net-next,2/4] net: intel: implement modern PM ops declarations
    https://git.kernel.org/netdev/net-next/c/75a3f93b5383
  - [net-next,3/4] igc: Refactor runtime power management flow
    https://git.kernel.org/netdev/net-next/c/6f31d6b643a3
  - [net-next,4/4] i40e: avoid forward declarations in i40e_nvm.c
    https://git.kernel.org/netdev/net-next/c/ee4300b24a32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



