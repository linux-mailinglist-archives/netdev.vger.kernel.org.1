Return-Path: <netdev+bounces-76006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF7D86BF98
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1FF288981
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56784381CB;
	Thu, 29 Feb 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQldcD94"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33427381A4
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178630; cv=none; b=cB/JaSj31zI4lVnjmGtYOzrpMDU4HwyNLT5+6IrR3hpm/l55i8ME7+B+06VLkevonY0h79KOm35NRqMLX4aYf55oDAgl6htPDP/ihqeVC8j3kYscenbWlUEGJNVsv+1E/Uj1cZaGqmYiu+Tw+uQEtivUEA8ET1XLMOuH1ZmF5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178630; c=relaxed/simple;
	bh=YZpd4DKKwtQDVlgbWWjInN4Te4ILAcEl0Mv+TSvRcpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WwGZq8EcB4dQQ9AUMOWq9doQoMR0j9OYyt0xR60w0b+9dPCnK+/ixZnxdNuDqGcaX260JGueKPrbnJsYjYXiFr+oAqk680NWAqCuRx8RwICOZ5Ho4+/yj1iHX322n1JcCAiHuwNGzAIIKG2hqA9px1R09weR2sJRYEiLFFtjvS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQldcD94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6ADEC433B2;
	Thu, 29 Feb 2024 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709178629;
	bh=YZpd4DKKwtQDVlgbWWjInN4Te4ILAcEl0Mv+TSvRcpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sQldcD944mOOaLZUyePT1JB8REp9K+4uu1owM5YboeD0yvAg11zg8alaZpGkzzns/
	 PPvNl8w0QQ9hEYGagLlG0ERjMcdbNVbyF0dWSR0M1SplcI0NfFzCMoZsasq+o2RfTt
	 j/OQuD8Ltbirdu4bggelALm0iKZtW8DuuNDKaePrWDZC1IEBWrjeUC7zbK7J1014Qk
	 LEI/XICwT+ZZF4oiSND0eowtDUGK0PsT/4ycPdN/PaSL475D8C6uEAuRQBS/Z7hjI5
	 pPukj+UQ1D+2TgXnwW3rs3Bxwfd8LlvaqKYeJlPyb118iHRvCKb5to4jH04WtwnFC0
	 6p0beHIJCP4xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93CE4C595D2;
	Thu, 29 Feb 2024 03:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] inet: implement lockless RTM_GETNETCONF ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170917862960.28712.8149681848256737891.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 03:50:29 +0000
References: <20240227092411.2315725-1-edumazet@google.com>
In-Reply-To: <20240227092411.2315725-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, jiri@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 09:24:08 +0000 you wrote:
> This series removes RTNL use for RTM_GETNETCONF operations on AF_INET.
> 
> - Annotate data-races to avoid possible KCSAN splats.
> 
> - "ip -4 netconf show dev XXX" can be implemented without RTNL [1]
> 
> - "ip -4 netconf" dumps can be implemented using RCU instead of RTNL [1]
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] inet: annotate devconf data-races
    https://git.kernel.org/netdev/net-next/c/0598f8f3bb77
  - [net-next,2/3] inet: do not use RTNL in inet_netconf_get_devconf()
    https://git.kernel.org/netdev/net-next/c/bbcf91053bb6
  - [net-next,3/3] inet: use xa_array iterator to implement inet_netconf_dump_devconf()
    https://git.kernel.org/netdev/net-next/c/167487070d64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



