Return-Path: <netdev+bounces-100963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2134D8FCA9D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A1B1F24309
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62984190079;
	Wed,  5 Jun 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVIk5uog"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB814D6F5;
	Wed,  5 Jun 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587629; cv=none; b=YuphLd+0D8O02xwtDNyjAk1oOQx9ZjGAUJ4wfzkYqLFhcoOLuSFlac1Pk8AnE492Gjq8hsIrYPbV8YrUCTAk9QqiSpIHc9ldUqBUUe9uniNsyyhOF4qbIiDo2QhBZdLfP+DF6fEHc2rY6RoQKuEh9bJL9DeJFVpRVS12A5RqzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587629; c=relaxed/simple;
	bh=XzPk2kxX2dkw0Tl3udIdkK0dzPP3A+FAFYgqBdO6B/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WFmGyRfRbx7k2qsZuztsFMNSqUhVuxrhzvmndE906/5Bir/N3FitN1Gr9yTh0s393CzSoXOl9XDYfGNugY82XLD+IEJT+JeZxxQimX7k9nzDxOQ9Wu/ZmmhwpQyTWub1kjoZEZUGBnPzu2GdSi4sYj0XRrltGMtqnFnb4gTPCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVIk5uog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2B55C32781;
	Wed,  5 Jun 2024 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587629;
	bh=XzPk2kxX2dkw0Tl3udIdkK0dzPP3A+FAFYgqBdO6B/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FVIk5uogYQNcLETq0XSdWxXIjnyxVQusummQUzN00t8IAC0UDcGVVnzBFPEbtCzRe
	 wcLIaOUe0QMUjW/j0WJQo1r9+xAfKn1yteyaDqwwgGixI38pYFvJrQcAIxrA5nFRz6
	 L9qo0RlRLAnpCx4SpsDLOZ+tBd/IKkRQIYCnDxuPEIwiNvqmOMBQ97f+lPaRMoQbC9
	 4Jh2frzGiQWdVjpvtokB4X2gL778WFkw2gH7HYl+zvQNa/zUm1w3N3BUG2Rn+M5OAn
	 HPK4gG0aWBHUHZCzDeIvve2nnjrR3nqv2j1HvgidP7QhvV1JOkKfrxshHpjdA6PqB0
	 tPHVV8fZQlQQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C72B9D3E996;
	Wed,  5 Jun 2024 11:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171758762881.21278.4160920123722638055.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 11:40:28 +0000
References: <20240603170217.6243-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240603170217.6243-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, dsahern@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, kernelxing@tencent.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  4 Jun 2024 01:02:15 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Taking CLOSE-WAIT sockets into CurrEstab counters is in accordance with RFC
> 1213, as suggested by Eric and Neal.
> 
> v5
> Link: https://lore.kernel.org/all/20240531091753.75930-1-kerneljasonxing@gmail.com/
> 1. add more detailed comment (Matthieu)
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
    https://git.kernel.org/netdev/net/c/a46d0ea5c942
  - [net,v5,2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
    https://git.kernel.org/netdev/net/c/9633e9377e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



