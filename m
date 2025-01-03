Return-Path: <netdev+bounces-154868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17EAA002A9
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D12D1630A7
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D0D1A4F09;
	Fri,  3 Jan 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utXJD7Gp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008D19E968
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735870814; cv=none; b=eQjzPYysGTE1WhfQxWymmLnQyzv2ciT8zQ0LjmkBdA0L3+YGPTz+8lx23baa1GMVq1kWUw/WQ7NsvhZCYPMVk46baPW9Jb84v7LW7SWHB8kBb3IR/PZ4vGd0NYI4zk9J2WA66UxSRYMAadwRhPH2v8S0451Xp8FO9+eQ3Rybpv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735870814; c=relaxed/simple;
	bh=ON9+xw7K7ygV9QlhSnuzl4rHaK/Yz8nbf8RJ1ht6Hq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TE6Tkx1GwpypgfZX7zsWbw7S+JjikhR/gGTsWnCIhWOXX2KdY3+jOOVfKwyoSC6QXnDgeXIfEpkuYOq3O2/xun2H2XDhcJrF91Jsusa/bBUxt+vsSLlYA5W1ONjlPB4nIFMSIb/XsGIebpeosxhPbIRE20rO44wXwboEU6XxwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utXJD7Gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24DEC4CED1;
	Fri,  3 Jan 2025 02:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735870813;
	bh=ON9+xw7K7ygV9QlhSnuzl4rHaK/Yz8nbf8RJ1ht6Hq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=utXJD7GpGc/6NzTs7MKMUte87gH9zJd+S9Ml+8OmGhZ+fES8SZEIiFqm0/PIPtFgf
	 YbJBQRL1N/MYf5GIFFTnNOxb+5+pVNi0KqsejzDFxeEHAAKZGyKcNQg+nOkcmYXmaB
	 TjQVTDZ9qnMByYBHjx503GyZRe/T8VZZg4LGO3hDLgBGqgqNOrGmbf84B+PfRiwFGa
	 YQVpCeuDmVz9xktrROUi+YnozX6lUyQoQwzgYB8R5yctrUA9+eV+x4IVBKT6d7x9wT
	 O4fkfb7GRs+AaYVfDYTn6tbRhTNgUzMXfH5T+m5/aAx33VJ/HrF2uNTmEAou+3qYps
	 Pd24O0CdgTsFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8A380A964;
	Fri,  3 Jan 2025 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: restrict SO_REUSEPORT to inet sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173587083425.2085646.7961549365556248789.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 02:20:34 +0000
References: <20241231160527.3994168-1-edumazet@google.com>
In-Reply-To: <20241231160527.3994168-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com, kafai@fb.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Dec 2024 16:05:27 +0000 you wrote:
> After blamed commit, crypto sockets could accidentally be destroyed
> from RCU call back, as spotted by zyzbot [1].
> 
> Trying to acquire a mutex in RCU callback is not allowed.
> 
> Restrict SO_REUSEPORT socket option to inet sockets.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: restrict SO_REUSEPORT to inet sockets
    https://git.kernel.org/netdev/net/c/5b0af621c3f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



