Return-Path: <netdev+bounces-77004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854F86FC71
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00816B22176
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222D1BC44;
	Mon,  4 Mar 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyP3m2+o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6391BC47
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542229; cv=none; b=BQXenkHrWW/ybqZpBdFur+0Nrg9jfuAC+6sxKozmRQB9jYzaQ0aPT6VB2xeFz+IqN9ya55eJXR4NVA7Qk9/4DNqUnuBRUmvUNor35whNWY4T+N0ETGwCLE4BP64LaHvMjoL4FVcXFy01An+sDi4M67xk/uM1aUrqjMufnhIimQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542229; c=relaxed/simple;
	bh=akRxZhDNHvRv2OahteICyJOMP2hVl11NgNKHUOrooHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q+EBqebPwl7TrKYGwOnKDXOY4lsmmU5gRwU7sUuWG5/9cku7pcFUacNUqxZWrfA0AO9B8kvX6ieBKhfkBWg7GTsrqomYc1QQwyO/1LyOQ1fE4Rd03f7+oCAWmpYKeD6YaBsWrCgrAXTLOdhZAzrCHbcc8KRnuq9BrHDlI9GSODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyP3m2+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB3C8C433C7;
	Mon,  4 Mar 2024 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709542229;
	bh=akRxZhDNHvRv2OahteICyJOMP2hVl11NgNKHUOrooHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uyP3m2+ou7vf1P+MmDVPAnHjiywAnFtNNTGpQ1sqUNBI8LvFC80YGjbDHthEP/Ic5
	 4bn7Qu9TAx3nrcd8ordj0Rz5vPF6MLB37u97VLoqacCO1obrn4rRhmnjwyPNbg84aC
	 Ub+PjNXXlXX+zvMtnBCIIAgLcXIfSf3btiFqaFxI0Ut6XldDsanC1CoTc/ZVwlOReI
	 0RJEWvkNwvBVRvTekRimePFeNSc/w4AhBsMK9DfkEbn+NyVAqs4y3vEVQafsSwHdTo
	 Kpc7nRYu4KQ76iEJnhlcSgjqGR9XtQ4lg2v234ACjikvYJgrcVboxO5IpuVNypqA4M
	 HrfxMfzvEGIfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8CA8D88F87;
	Mon,  4 Mar 2024 08:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: better use of skb helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954222888.29210.1946505746781397670.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 08:50:28 +0000
References: <20240229093908.2534595-1-edumazet@google.com>
In-Reply-To: <20240229093908.2534595-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, fw@strlen.de, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 09:39:06 +0000 you wrote:
> First patch is a pure cleanup.
> 
> Second patch adds a DEBUG_NET_WARN_ON_ONCE() in skb_network_header_len(),
> this could help to discover old bugs.
> 
> Eric Dumazet (2):
>   net: adopt skb_network_offset() and similar helpers
>   net: adopt skb_network_header_len() more broadly
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: adopt skb_network_offset() and similar helpers
    https://git.kernel.org/netdev/net-next/c/80bfab79b835
  - [net-next,2/2] net: adopt skb_network_header_len() more broadly
    https://git.kernel.org/netdev/net-next/c/cc15bd10e716

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



