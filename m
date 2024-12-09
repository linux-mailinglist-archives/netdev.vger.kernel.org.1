Return-Path: <netdev+bounces-150202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1EA9E9759
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ACF1881A25
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94450233137;
	Mon,  9 Dec 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehEznMEC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D335968;
	Mon,  9 Dec 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751615; cv=none; b=qDPJDQc47Im4ZADK1P+IQBctD0vfYYVYPqwIsuUFW11VSj4/lFbuc/vz5zsn6wbvxgsd8pC7PHFZ+tMCKxu1yyrCiXqv0CAJ7gN9X+yoeI5MPRs0wqrbTnV1nhN4QvTky/Uz7Ds+y+lCuPl4C/THlkgiATp8AENbi+6u6l02neM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751615; c=relaxed/simple;
	bh=Y+YCQ+zTvuOJ62iXxPiywsXkNkqk6N2zkZ56nBO2ltU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SKl8199ZF+zHsf/EPp3Su4/AhzHf7jEMnCyF/QcBVomKKQYbpbA+UUClan4N0ZVO4Nui4dY7Qh/9erPrTQLmpI1uELfbIGPXhjqN7l5PBooPqyvijx7gZXxwQI9bSK7eadX88Z0lmLvx8w8rqVm1Qq4NuQufo1zKkv40sabU1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehEznMEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF348C4CED1;
	Mon,  9 Dec 2024 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733751615;
	bh=Y+YCQ+zTvuOJ62iXxPiywsXkNkqk6N2zkZ56nBO2ltU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ehEznMECpBD6HGgVxZwWztdZdJKU5K7+JTfijNV3sfcSAspYUi3QWP6HwsB1dI26A
	 9LMkM0229KGSKrS3YWRqssUSx/fuwN+X9+UZNeDKKc2wFdW+Zo0L8l1pvXMGYDlpSd
	 VtIEbrtboKWESmTAvmgp6AjQp/i4+2/K+lMXC5AnwlxNOdOY9e5YRo/nNzTmFl8v83
	 8teNszDSmS51+nTmRqLoJVV5mTbc5Lzvw25TRBN7WHxtQgTwzEDLo6sMCsjaWolS/b
	 Fo81tR3ofyv9AxvHNl5djnanW0oQN5b5GGpGCHM6Pwz5u8VHx+70sE2ZyMjc4JSAu5
	 IuoRWlAaQIsNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDD380A95E;
	Mon,  9 Dec 2024 13:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] net: sparx5: misc fixes for sparx5 and lan969x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173375163050.50212.4642950609895270784.git-patchwork-notify@kernel.org>
Date: Mon, 09 Dec 2024 13:40:30 +0000
References: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
In-Reply-To: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lars.povlsen@microchip.com,
 Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
 richardcochran@gmail.com, bjarni.jonasson@microchip.com,
 jensemil.schulzostergaard@microchip.com, horatiu.vultur@microchip.com,
 arnd@arndb.de, jacob.e.keller@intel.com, Parthiban.Veerasooran@microchip.com,
 calvin@wbinvd.org, Usama.Anjum@collabora.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 5 Dec 2024 14:54:23 +0100 you wrote:
> This series fixes various issues in the Sparx5 and lan969x drivers. Most
> of the fixes are for new issues introduced by the recent series adding
> lan969x switch support in the Sparx5 driver.
> 
> Most notable is patch 1/5 that moves the lan969x dir into the sparx5
> dir, in order to address a cyclic dependency issue reported by depmod,
> when installing modules. Details are in the commit descriptions.
> 
> [...]

Here is the summary with links:
  - [net,1/5] net: lan969x: fix cyclic dependency reported by depmod
    https://git.kernel.org/netdev/net/c/1cd7523f4baa
  - [net,2/5] net: lan969x: fix the use of spin_lock in PTP handler
    https://git.kernel.org/netdev/net/c/aa5fc889844f
  - [net,3/5] net: sparx5: fix FDMA performance issue
    https://git.kernel.org/netdev/net/c/f004f2e535e2
  - [net,4/5] net: sparx5: fix default value of monitor ports
    https://git.kernel.org/netdev/net/c/e4d505fda6c8
  - [net,5/5] net: sparx5: fix the maximum frame length register
    https://git.kernel.org/netdev/net/c/ddd7ba006078

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



