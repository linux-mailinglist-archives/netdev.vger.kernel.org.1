Return-Path: <netdev+bounces-238555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7831C5AF2D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A3A135209D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84EB22F75E;
	Fri, 14 Nov 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYxiToFw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32375B5AB
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763085040; cv=none; b=smTrhPnPh0ZEmItW6Gr7VtAmzm+Znp3oSf0FnrZ57P1/WciJX8ua2vKr30Thhh9P7J+VZAelZWPc2BQq+MKWuRORY8i3o6VJRqx5PveLUS7DwwlgWq3f/cruQJBu8K156Mcao8BixC/MR4AHt7ArfeEX8DzxmS/dMgEG6IQEGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763085040; c=relaxed/simple;
	bh=MjejStzeENykaPHKV1turDkqL/oE3Bju/H0W5Tzo3b8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RNUbWOl24ygt5KDrIflH7zuIP4VbLLV2JxvnsdScsdXy2UbwuNc90h3VExDIuA2RKCS8CyonXkQCX9wzqvnp//E4w6YLycyQv5KavtG1+6jK1vlBR3jurQu+fIhu6/o7Cz/SU8gTmnrGPAnf7OD9bYPOEMIr9gj3k7XiUnCHMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYxiToFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4D7C4CEF1;
	Fri, 14 Nov 2025 01:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763085040;
	bh=MjejStzeENykaPHKV1turDkqL/oE3Bju/H0W5Tzo3b8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fYxiToFwPbcEw40J6Lespxn9vp/mJM4sMZq1V2BskOcGeHBbW6UBxaWH1Jn37w/at
	 /WoNCV91C5W4eXV7IdRSdxyO4YZLMgTAf3Lqrf2F6J//okxkFW0zlPIALSCtiXC3hR
	 zznM/wenBoN8rO6swJvsDgAUroUrA4VtXaHmHkTb9RVZlpniNzywSi/S05Src69p/B
	 S+FvzeQL4KYx8ypDVRWbRs5qH7DBRVsff7P1trHaPJRn+TSDmT+pmoYvAFIfxv3fnk
	 DLygrREIoFHE2Wb7lPX+waAibRYgtYpG/ukGI5yIXtEE2C/2GQYRNeJN9bT3Lht3Zp
	 MYpSvrdT7dP2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F283A55F84;
	Fri, 14 Nov 2025 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: specs: rt-link: Add attributes for hsr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176308500929.1080966.16549265991450881438.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 01:50:09 +0000
References: 
 <926077a70de614f1539c905d06515e258905255e.1762968225.git.fmaurer@redhat.com>
In-Reply-To: 
 <926077a70de614f1539c905d06515e258905255e.1762968225.git.fmaurer@redhat.com>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 18:29:53 +0100 you wrote:
> YNL wasn't able to decode the linkinfo from hsr interfaces. Add the
> linkinfo attribute definitions for hsr interfaces. Example output now
> looks like this:
> 
> $ ynl --spec Documentation/netlink/specs/rt-link.yaml --do getlink \
>     --json '{"ifname": "hsr0"}' --output-json | jq .linkinfo
> {
>   "kind": "hsr",
>   "data": {
>     "slave1": 15,
>     "slave2": 13,
>     "supervision-addr": "01:15:4e:00:01:00",
>     "seq-nr": 64511,
>     "version": 1,
>     "protocol": 0
>   }
> }
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: specs: rt-link: Add attributes for hsr
    https://git.kernel.org/netdev/net-next/c/c294432be150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



