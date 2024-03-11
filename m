Return-Path: <netdev+bounces-79268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9798788FE
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F1628144C
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4055C3B;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggh4nrdI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470855782
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185962; cv=none; b=aO1SsvSWjVVHqGmhX0QDJMkoG5F0FWWxchJRk9+yQhufWIE3KQSFlyFYFzPNluBHDodjwAIZRzJZ/gd31zqNNTXzwQwvjTng/RcIBm/FZ7MPsUaFWaZytW/vZF+H58FKF63JspsxeYn0zIyQqiqS14YFsCL0vnDZedeH9m+mfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185962; c=relaxed/simple;
	bh=gLG8LoKgTqocNcc134bLMPUGMx+Q64xBPlry/1cZe9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rqD6ph9P/G3pYGFRIxYP0QUVUgU0KhDEhJ82E+CnH4B6U+l9WTtjAQY4RjMN7k6YtYgE1+ZlB14wMT7hMaV8Uo3/ECLo7TepDUTmJEh+T8rcGxd/txD6b72VVUyhvCapECUH6jqVc41YPlUWgNg9oZ9WlVnAEvr14uNz+gVoXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggh4nrdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAABCC433F1;
	Mon, 11 Mar 2024 19:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710185962;
	bh=gLG8LoKgTqocNcc134bLMPUGMx+Q64xBPlry/1cZe9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ggh4nrdIWL9JJCqJPna8EiR3t4PrevFFjId00GBKLyyZLBh1I5i6XVNg29xQrNRWR
	 GX2NcWBYKnTRV8pbPTKMLo3oLTE2GbonZ/WX7lxtLQJHaPAa0WvPk5685DQ0b/R+6A
	 r8Kpeavj0Vn/UmNIjufWcp1Nu+tKuuCtwqnfMnWc5jD7pTDfEwkOfyvt8gXOR0rgal
	 iGYxkGviwBlQJsVQyI7c30vBBG8cvq5yuUuSthfJkU+JDCjZNSEQIdku3YBYjslXvB
	 DOpjVKOBUp2tQ9fHjkwlpAJKZiyhd1F7Uunf0Dr3OUlmbAjLlx1LW0cryGoBeTvgqF
	 KWOxI3qTn+SJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D67E2D95057;
	Mon, 11 Mar 2024 19:39:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2][pull request] ethtool: ice: Support for RSS
 settings to GTP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171018596187.1144.11461580698130093223.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 19:39:21 +0000
References: <20240306211855.970052-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240306211855.970052-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, hayatake396@gmail.com,
 mkubecek@suse.cz, vladimir.oltean@nxp.com, laforge@gnumonks.org,
 mailhol.vincent@wanadoo.fr

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  6 Mar 2024 13:18:51 -0800 you wrote:
> Takeru Hayasaka enables RSS functionality for GTP packets on ice driver
> with ethtool.
> 
> A user can include TEID and make RSS work for GTP-U over IPv4 by doing the
> following:`ethtool -N ens3 rx-flow-hash gtpu4 sde`
> 
> In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ethtool: Add GTP RSS hash options to ethtool.h
    https://git.kernel.org/netdev/net-next/c/0ed3bba16d37
  - [net-next,2/2] ice: Implement RSS settings for GTP using ethtool
    https://git.kernel.org/netdev/net-next/c/a6d63bbf2c52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



