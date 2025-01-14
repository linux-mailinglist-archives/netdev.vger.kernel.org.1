Return-Path: <netdev+bounces-158046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99DA103AD
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762F21888FD7
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0281ADC9D;
	Tue, 14 Jan 2025 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZyIjV4o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411D1ADC6C
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849417; cv=none; b=ZRP7KLsvwpXwJBTCVow6DPO12wJl5efI/8Ffp5LHCaRu327vuR3fBOTXVHePcDnbtXUIkqi4m/K8fNnXejFPTY1Zv6TrpvMTFXLO34gWL03LSfaUNMuM5eQJvrrNWM4Cdxj/EKn5J5klXAI7cKiSOAc9i5rw1X91wkcE+05v6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849417; c=relaxed/simple;
	bh=fVjByIFc36W/gBc4kpbVE6JGj+YvOYZdL6DcuJANWIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KEsInaBPW04CgLkrcaYTb7JLI23Mbd2Zmw4twm7WACpARK5eniEnHaEvEYUnqBv28dNH4ucM5HwKtWU7xXzWxHdqHgXinuuAQIYuedEHuxEEvfGdg4jRyIb6FANsGGQMddj8TE5FSrT4Ja2p4sRSkPyHyLU9+3XNK67ig2xhxMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZyIjV4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C54DC4CEDD;
	Tue, 14 Jan 2025 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736849417;
	bh=fVjByIFc36W/gBc4kpbVE6JGj+YvOYZdL6DcuJANWIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SZyIjV4oxKPEXHbNnAffivgiSwBwP7dX3uYuoHvl5sBIHfz27/RlRDUwYawqcxHHN
	 u+PpepCOffkCQpVHA0IWr6kXDMZ7vTVolBg880VEJLw19nubfbr8yX25m/caocpOCA
	 xjXANEYv5pxSxmt0fPeadVfedszfs7NBS6jO4WijW6Wf9xeNWmg8LhjR2Kx8696OXI
	 7BWLPcfGwXIQ3OkBD6t8fAyx876FpnhBrAhNVy41CHGGOc1kRZ3oE+SYzmzmjevf58
	 VBCCFWF/6J/aKDU8Ei+842K3H1xBSNjMem+i+CocgHZ8HXYQwqCJTFQvHU9rD+WtlN
	 odLTYyhKS2mYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBC18380AA5F;
	Tue, 14 Jan 2025 10:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] udp: Make rehash4 independent in udp_lib_rehash()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173684943977.4121334.18177605028961522329.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 10:10:39 +0000
References: <20250110010810.107145-1-lulie@linux.alibaba.com>
In-Reply-To: <20250110010810.107145-1-lulie@linux.alibaba.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cambda@linux.alibaba.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jan 2025 09:08:10 +0800 you wrote:
> As discussed in [0], rehash4 could be missed in udp_lib_rehash() when
> udp hash4 changes while hash2 doesn't change. This patch fixes this by
> moving rehash4 codes out of rehash2 checking, and then rehash2 and
> rehash4 are done separately.
> 
> By doing this, we no longer need to call rehash4 explicitly in
> udp_lib_hash4(), as the rehash callback in __ip4_datagram_connect takes
> it. Thus, now udp_lib_hash4() returns directly if the sk is already
> hashed.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] udp: Make rehash4 independent in udp_lib_rehash()
    https://git.kernel.org/netdev/net/c/644f9108f3a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



