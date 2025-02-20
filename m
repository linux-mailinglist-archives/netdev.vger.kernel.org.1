Return-Path: <netdev+bounces-167980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C7A3CFE8
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999F71898EBD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28781DE2BB;
	Thu, 20 Feb 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp2HdoPo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AEA1DDC3E;
	Thu, 20 Feb 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021012; cv=none; b=pr6VpruRakRGSOg6aTyZwH8XNS3qRc8jOXCpVTH8O52iTvrCB35khmPLYDmQqwvt0DCZMQT4RsnqGl79O9qyz9qVD8jyM7VptdXsvgpz/uCkzY+v7QaHxFwXfR4bxh7yaUR8K2zWDHwfkOcgU1s+u+O6jS4LmnQE42zcTSzSq0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021012; c=relaxed/simple;
	bh=adfJvgf9iLXqqrtyW1al49ovvy0Sv0dclbulEIE0uhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L1wxYRlb34PsvfARu4lHXYGFQxcyCdV8tgaFOF0/2otjiCNWJ89/z+FbWTFf8MMMZF4X4iraJ6pRG2cRizqVMDEa/v92Cd6AccZzRGL+pmIoAAcGaNiYgny81zdvwb7/CeYtmHCxCR+XgTr/UbAPZjl9cIphtinr7/Sa233+xFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp2HdoPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEBFC4CED1;
	Thu, 20 Feb 2025 03:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740021012;
	bh=adfJvgf9iLXqqrtyW1al49ovvy0Sv0dclbulEIE0uhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pp2HdoPop6Vy0zwZt1ne0dHNimfajQ3y6lysyHurKfb2LUHuCVLgi6kGyDKR8rwBO
	 mr6x4JK83N8hVVyFIfw2N5VBWibBoJVMXCutmgcRwhwmpdU8XvIelDR8Cj5FbF1Qpt
	 ZBncI068lM8I8oBMweCsNWyBA8FUgW35CCDUWosoYIcrFm88w82koUxlUYrG4WD/qG
	 npr+/jitnvWsVk1BAI5bdi2Jjqs283Ij7+m++ic+QYY4FZ4Jf0dHYlyN4I5rvNA6w1
	 ZkLKPoJVpXx61WADq9UiJNAKOy3veeHKzqbYwrdsfFC/2JIlaAR8fQrdiur8Pkvpu5
	 X2ISp7vjZxwKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C87380AAEC;
	Thu, 20 Feb 2025 03:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] mptcp: rx path refactor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174002104323.825980.13872067512718891782.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 03:10:43 +0000
References: <20250218-net-next-mptcp-rx-path-refactor-v1-0-4a47d90d7998@kernel.org>
In-Reply-To: <20250218-net-next-mptcp-rx-path-refactor-v1-0-4a47d90d7998@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuniyu@amazon.com, willemb@google.com, dsahern@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Feb 2025 19:36:11 +0100 you wrote:
> Paolo worked on this RX path refactor for these two main reasons:
> 
> - Currently, the MPTCP RX path introduces quite a bit of 'exceptional'
>   accounting/locking processing WRT to plain TCP, adding up to the
>   implementation complexity in a miserable way.
> 
> - The performance gap WRT plain TCP for single subflow connections is
>   quite measurable.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] mptcp: consolidate subflow cleanup
    https://git.kernel.org/netdev/net-next/c/c3349a22c200
  - [net-next,2/7] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
    https://git.kernel.org/netdev/net-next/c/f03afb3aeb9d
  - [net-next,3/7] mptcp: move the whole rx path under msk socket lock protection
    https://git.kernel.org/netdev/net-next/c/bc68b0efa1bf
  - [net-next,4/7] mptcp: cleanup mem accounting
    https://git.kernel.org/netdev/net-next/c/6639498ed85f
  - [net-next,5/7] net: dismiss sk_forward_alloc_get()
    https://git.kernel.org/netdev/net-next/c/c8802ded4658
  - [net-next,6/7] mptcp: dismiss __mptcp_rmem()
    https://git.kernel.org/netdev/net-next/c/51fe9cb9213e
  - [net-next,7/7] mptcp: micro-optimize __mptcp_move_skb()
    https://git.kernel.org/netdev/net-next/c/e0ca4057e0ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



