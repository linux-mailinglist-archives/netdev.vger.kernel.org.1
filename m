Return-Path: <netdev+bounces-65806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74B83BCF0
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7851C28BEA
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420211BC53;
	Thu, 25 Jan 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+IcFut+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B31BC50
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173826; cv=none; b=n92zVb1O79XAKi1qwfKWYok+1uhqrjqjk9xd3T1mb1jpvoRyWLSfuOUKlE41UNPkvCHxvZZoXT7+bOlHTPJ82jow+/Jqzs/H9SBrPLnVj0PwYC1LwuWfyr7/v6qWLYwA0mI1clDiKfjbjx8N5Uu6a7K/rv6j9vCKgAKDWsSTnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173826; c=relaxed/simple;
	bh=nQjMBnIfo3IoWr/8bKPOURsjAXmTyEF/qGDYFMgzKzc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rFl6OXvWrZ+AmvGnr23NPR18npN59SgqagG0GAgAsxG1urvt/LTFkmjsVvXjW8ra4JK7LRFiOYh3zaoBgR2qM+AbKsX+OxWYEuZEFfySbLq3E2oo7z2ZT/5Fa5HribOcJpUw8oprX9OyfbwL8uLDOKYBJBff0jpUq6HcvbrhZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+IcFut+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8239DC43390;
	Thu, 25 Jan 2024 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706173825;
	bh=nQjMBnIfo3IoWr/8bKPOURsjAXmTyEF/qGDYFMgzKzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M+IcFut+0WzmYOZqkpW6hklhQ7upXHv9ANybAgC/r2Y8B5TqYQp7Kv5fltnFppxhI
	 +2U4gjKsyvN65o5uEi57zqGF2aAc5OkJRRz0TowmTMpurjEEuZe395nM5O99VYy29r
	 RSbceuMTI/zjuJykFj/tYEhQTpD8Yt7VLN9kGF6qduYW/AniG4BBAhxlkhNx1LiPHm
	 +bUeXIbadKhxCN23RQA4zmHMD/Oys+p6gFf6oqrupBcjRvD6dcN2mGE61v26cUWdrP
	 /2Sg0jqHjyjCyjvVfdEKp0G8Av2mQ4RWSbr/vC7DzQ9zyihCzwlHMzX4iRsJyF0sIy
	 dzUSuLBpioQVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 684E0DFF767;
	Thu, 25 Jan 2024 09:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: bonding: do not test arp/ns target with mode
 balance-alb/tlb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170617382541.5384.17654606318169314487.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 09:10:25 +0000
References: <20240123075917.1576360-1-liuhangbin@gmail.com>
In-Reply-To: <20240123075917.1576360-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, liali@redhat.com,
 jay.vosburgh@canonical.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 23 Jan 2024 15:59:17 +0800 you wrote:
> The prio_arp/ns tests hard code the mode to active-backup. At the same
> time, The balance-alb/tlb modes do not support arp/ns target. So remove
> the prio_arp/ns tests from the loop and only test active-backup mode.
> 
> Fixes: 481b56e0391e ("selftests: bonding: re-format bond option tests")
> Reported-by: Jay Vosburgh <jay.vosburgh@canonical.com>
> Closes: https://lore.kernel.org/netdev/17415.1705965957@famine/
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] selftests: bonding: do not test arp/ns target with mode balance-alb/tlb
    https://git.kernel.org/netdev/net/c/a2933a8759a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



