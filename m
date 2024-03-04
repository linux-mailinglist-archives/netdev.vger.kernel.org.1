Return-Path: <netdev+bounces-77042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3886FEEC
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CE21F258EB
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3B7241E5;
	Mon,  4 Mar 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efPi1qzf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EEF3A1C1
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547645; cv=none; b=AWYsodDX44BUAtdAsldQ1SzYtPRGVXFbTCTqAZp7mUCXVfwb4iNT/AJZSw0f1Y2F/szT75pBtNO+Z+996ASuMC7KE0ThHyF79Rpl/wrOUoffpa4zZWBXsGcb2pHzXbdP1Ea/H4EVEfS1i4v5TeJix/+fTrZ/PNpuHyvt/Bi6k5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547645; c=relaxed/simple;
	bh=mE6Z4TE8eVvQAqRKo3jygBk9YFKpqg6HOUFh/jqD2Z4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BfTpAQ9XolVrfgGPMSkjHDO0NHqMaSObLi+Go6tZUbxk2BeqhZxPEGWV+/OlWyhar5PGsimcIa/fOYR+x3jk0NisQQumszQpZZnvLTBhQ3bFM6qtKp2YEIkt0XTVFzxyKpJqBROonViiB3tl+Kq8Qjat7mAAgE2O9bjpQoOJCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efPi1qzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64517C433C7;
	Mon,  4 Mar 2024 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709547644;
	bh=mE6Z4TE8eVvQAqRKo3jygBk9YFKpqg6HOUFh/jqD2Z4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=efPi1qzfo2JzkWHOnc5/PdHVmT9p7zbFUW8bHJyltdhza3u1ZsP0kR3lM0dfw/rH8
	 NP7Ax08NTZyrtsTQnUrjV7YNb4eMF20ylzIkVnlnJNzjtF9cPEYucPusVKNZNAPvtD
	 8YLREfgFt4G/Zu8ZGo6jsi5209PDQSWwTwTqNk/ljKXqzFDAv58epEh6bUGv2O/Jf3
	 YNFi6ivYLJwoqTRcPpp4vXe+G2GIKmQsiU+q3qTgMlG+RmwSSMJN05DcLSEi98SVml
	 JGgLvpLrOjbw5zHB7kYMrCppASCO2q1UMzn5vVrjaL6NsatrkBPfsuWp3s6JeyacCR
	 /zkdC2CGkP3AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 492C7D9A4B9;
	Mon,  4 Mar 2024 10:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] page_pool: fix netlink dump stop/resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954764429.3200.12395088986530153313.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 10:20:44 +0000
References: <20240301011331.2945115-1-kuba@kernel.org>
In-Reply-To: <20240301011331.2945115-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, hawk@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 17:13:31 -0800 you wrote:
> If message fills up we need to stop writing. 'break' will
> only get us out of the iteration over pools of a single
> netdev, we need to also stop walking netdevs.
> 
> This results in either infinite dump, or missing pools,
> depending on whether message full happens on the last
> netdev (infinite dump) or non-last (missing pools).
> 
> [...]

Here is the summary with links:
  - [net] page_pool: fix netlink dump stop/resume
    https://git.kernel.org/netdev/net/c/429679dcf7d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



