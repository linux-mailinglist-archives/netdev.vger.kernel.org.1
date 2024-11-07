Return-Path: <netdev+bounces-142601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C3D9BFC34
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056381C224D9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259D38DC8;
	Thu,  7 Nov 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8T6zy5d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAAD31A89
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944828; cv=none; b=tvk6NM55A7vfnNnf3GA7lpn7HHwCnhr8W2ePzmu+2X4c/44aAxe/LsBu9Fc5Suq3In9JVRvX+ZKrcfSVw6HaZp1smfmI6HkNvbGjaFLCU50SPrsQ9+Mz1tpp/yxwavkoU0IG7YbHlkqK6XLmbIR9omGjQplHh3CXN2IvO83YV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944828; c=relaxed/simple;
	bh=rIJ6GWbz2jz1BmKm+twCqI6tEQQiGPjQ9jYAuDsFt0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QQX8tE1+u6tEwkgNL5SXrMq3AJKNg36t7eweZJm7vnCW1qNbLAaRxVYohaSVW5OyXQvtUfRXBk/MBd0K1qcdQbPLwThDkS7RCfEFB8Upf3+zVWCEaydSDpoyBL9RG/9r/6PvvqFKI25WJEr8ZtLgNzLzKH1dzEIRyuGSYYGHE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8T6zy5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6237FC4CED3;
	Thu,  7 Nov 2024 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944825;
	bh=rIJ6GWbz2jz1BmKm+twCqI6tEQQiGPjQ9jYAuDsFt0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b8T6zy5dLHrqdN8VJDhOiMAjfY703cgubC+7JfpU3ZsIfTDXKCKoZ6tLXZ2lkKlpb
	 /hILpGx3e39WCcFn15qL5Ts2YojSMKqVTLmZnBG3SOQqNNJRdofbncwAw8aO4oJiuM
	 ia6AMB83OOPp7SwFrhlllNW8dnzEgCiPac1fRSKM+p09HwQUHzuDd62SQ2/pGuwtcS
	 3w2OyyMEt7FvQFMhtLtq4sZgpNMDUTIncCr/5UemoyZ23UGp+AnOpcLcAF4LV6Ac7s
	 oIZ6rD4bvmET5C2Mj258sX3cdjZotQF/CFXphZxx0PO8ICtB0gjnB3kEn6FYegN7Lz
	 c4MqQqaCe8Yag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5A93809A80;
	Thu,  7 Nov 2024 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] net: add debug checks to skb_reset_xxx_header()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173094483424.1489169.11205033813383224228.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 02:00:34 +0000
References: <20241105174403.850330-1-edumazet@google.com>
In-Reply-To: <20241105174403.850330-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Nov 2024 17:43:56 +0000 you wrote:
> Add debug checks (only enabled for CONFIG_DEBUG_NET=y builds),
> to catch bugs earlier.
> 
> Eric Dumazet (7):
>   net: skb_reset_mac_len() must check if mac_header was set
>   net: add debug check in skb_reset_inner_transport_header()
>   net: add debug check in skb_reset_inner_network_header()
>   net: add debug check in skb_reset_inner_mac_header()
>   net: add debug check in skb_reset_transport_header()
>   net: add debug check in skb_reset_network_header()
>   net: add debug check in skb_reset_mac_header()
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] net: skb_reset_mac_len() must check if mac_header was set
    https://git.kernel.org/netdev/net-next/c/1e4033b53db4
  - [net-next,2/7] net: add debug check in skb_reset_inner_transport_header()
    https://git.kernel.org/netdev/net-next/c/cfe8394e06f2
  - [net-next,3/7] net: add debug check in skb_reset_inner_network_header()
    https://git.kernel.org/netdev/net-next/c/1732e4bedb3e
  - [net-next,4/7] net: add debug check in skb_reset_inner_mac_header()
    https://git.kernel.org/netdev/net-next/c/78a0cb2f45dc
  - [net-next,5/7] net: add debug check in skb_reset_transport_header()
    https://git.kernel.org/netdev/net-next/c/ae50ea52bdd7
  - [net-next,6/7] net: add debug check in skb_reset_network_header()
    https://git.kernel.org/netdev/net-next/c/305ae87dafc1
  - [net-next,7/7] net: add debug check in skb_reset_mac_header()
    https://git.kernel.org/netdev/net-next/c/3b6167e9bfc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



