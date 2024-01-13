Return-Path: <netdev+bounces-63386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9FB82C91F
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 03:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877A92847A1
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 02:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC2184D;
	Sat, 13 Jan 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZGFFHmW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F315BA
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 02:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5311C433F1;
	Sat, 13 Jan 2024 02:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705113027;
	bh=aM5q1ClA0SFMXoF6LKANr73MzzkVOddQj0vXlq2k54s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cZGFFHmWOqzcBA4t2jnyJhIPGjSwTnb1wwWpvTUboWXZiSxVxUpri2JSs+6s8ZW0u
	 DVA5VO85bHWyndTf9t1nyJvxiJPtwYmsZekzVaILTbhIk1b1kMxG8Hnhy4w2107JYK
	 FMzSi/RXsXf3FfNilf4VlTcq1GmDctFeIEBTChTEqvcjpg2M89xHwPxvykCSla4rhr
	 /mCFgXT6IAMJs0fOpGvw5AsIeIbNEBRoFsox+r6j869uOpguqhrVgynQHlLUa6fknV
	 8MR9aHOsYfALDTIjxfE+hZ4V66T8wjEgwKEo4igZIxWn9xXCkXfKhxF7IOBoHQwFAi
	 9YS5DkSUpS0gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8C17D8C972;
	Sat, 13 Jan 2024 02:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: better validation of MPTCPOPT_MP_JOIN option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170511302681.16465.8256134005841066371.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jan 2024 02:30:26 +0000
References: <20240111194917.4044654-1-edumazet@google.com>
In-Reply-To: <20240111194917.4044654-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 matttbe@kernel.org, martineau@kernel.org, geliang.tang@linux.dev,
 fw@strlen.de, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jan 2024 19:49:12 +0000 you wrote:
> Based on a syzbot report (see 4th patch in the series).
> 
> We need to be more explicit about which one of the
> following flag is set by mptcp_parse_option():
> 
> - OPTION_MPTCP_MPJ_SYN
> - OPTION_MPTCP_MPJ_SYNACK
> - OPTION_MPTCP_MPJ_ACK
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: mptcp_parse_option() fix for MPTCPOPT_MP_JOIN
    https://git.kernel.org/netdev/net/c/89e23277f9c1
  - [net,2/5] mptcp: strict validation before using mp_opt->hmac
    https://git.kernel.org/netdev/net/c/c1665273bdc7
  - [net,3/5] mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
    https://git.kernel.org/netdev/net/c/be1d9d9d38da
  - [net,4/5] mptcp: use OPTION_MPTCP_MPJ_SYN in subflow_check_req()
    https://git.kernel.org/netdev/net/c/66ff70df1a91
  - [net,5/5] mptcp: refine opt_mp_capable determination
    https://git.kernel.org/netdev/net/c/724b00c12957

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



