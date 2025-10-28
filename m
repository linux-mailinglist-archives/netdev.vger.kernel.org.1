Return-Path: <netdev+bounces-233375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F40BC128D4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646951A664A4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB4A23EA80;
	Tue, 28 Oct 2025 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDvniMJB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADCD23DEB6
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615032; cv=none; b=kNRUSVI9oIWFFUwWke1AUTXIvB62ROsL64S0q7CtCTn5+fpx4Ch/PEdFhGG6BOVRfzZNMrn8K4G9gf8eZRX/J/cgjCn17vhIzrTkltJKKEI7NokDuDfekXj2oQoQnKbY7TOBL2yLSwuhCT7ldduKX1qh+NeZsbwJhNnGpLZKW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615032; c=relaxed/simple;
	bh=NjS652dVWdKcwmC61KOT8WQNtU2PN55Ava/w7XYS6Vo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hmB39IIZ47giHVQfM3fD3NpLNJ062BazOgZwPIFxC1Ec/ZK1H9mqIWWWNeXxj/sa3L5WHSQTManSaFY6Izasjjb0qJDNqwK/f9xMV1Srrd1SAqJN5j8RtKTJHbN0n127xtYrigRqbrnvRjEpM7WhYCItR0uaY0BfbbvYClecBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDvniMJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1535C4CEFB;
	Tue, 28 Oct 2025 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761615031;
	bh=NjS652dVWdKcwmC61KOT8WQNtU2PN55Ava/w7XYS6Vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GDvniMJBKAyOFq5KZWu4OHk8ProSqaPUo1JQKGMzFaKKuqMwwpmA8F5vhny1B4xEs
	 6wRtk+Zzeq1PLCiSLgCdmpTztFR/Su+R0zQRWNXJmLaNI1+NpCCISiNbuxPkBeJd4V
	 hNFPMhul2TiQALmpsMxHxRCfRjP3E8JTWggKFOJqmFU7qRtHc8mvpECFV+aJsEa7Da
	 pDBQIMjPKEgSTKGFhH9YpOQjeV1VHmjZYTCXOS/E84tadAdU3FM59GvsMT0ZYn6q8L
	 ng5bSbWshtIkFTNua6jz9m2aRooupdD+aFLUgGtVQq7dP/7BB8qOPBaB+8Kg7UDeMI
	 SbbQMph1YhWLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB15539D60B9;
	Tue, 28 Oct 2025 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: avoid print_field when there is no reply
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161500950.1653952.7576979335694136643.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:30:09 +0000
References: <20251024125853.102916-1-liuhangbin@gmail.com>
In-Reply-To: <20251024125853.102916-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jstancek@redhat.com, matttbe@kernel.org, ast@fiberby.net,
 sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 12:58:53 +0000 you wrote:
> When request a none support device operation, there will be no reply.
> In this case, the len(desc) check will always be true, causing print_field
> to enter an infinite loop and crash the program. Example reproducer:
> 
>   # ethtool.py -c veth0
> 
> To fix this, return immediately if there is no reply.
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: avoid print_field when there is no reply
    https://git.kernel.org/netdev/net/c/e3966940559d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



