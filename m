Return-Path: <netdev+bounces-251296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 295F7D3B855
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2874D301934C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F802F0C67;
	Mon, 19 Jan 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb2D42D6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7F2E92A2
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854615; cv=none; b=X54eID/SF0HQYHXIOyUWWZF2QildzLl9pR+WQalGot7Z8PmZHvwiV25DzSjTBncJw9AJTY7DbwY5xSUWh1KWXwSlbTCG7THIYaL30MrusynhahKpSdCpp12d9dpFHBLLDMQf9NXQsaRjbdZK9JzqXYYhnxdKUHhv9m/BinVizCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854615; c=relaxed/simple;
	bh=b21/rIO3QmPNlAdDrd0MJstW5bOOHgX8OQtKGiqUmzY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tUxelbziOMV4vkd5vsUvCXoKRlP6YXNrO7XKAUZCRcPNIdDAEyhWyyKujzGlx2nE/yIZ8aYEitLJiQ8L3f6VD0rgfPeazX/qy8KvJIzn+SVTxDDZcGSLDSv7LCNgkVHdjcAEZ3rD7LpHY0YqSPotfgF3bgmML2lZfp1cm3UwGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb2D42D6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283D5C116C6;
	Mon, 19 Jan 2026 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768854615;
	bh=b21/rIO3QmPNlAdDrd0MJstW5bOOHgX8OQtKGiqUmzY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bb2D42D6kJoTen0u5lOilHxIm5eYAPi0iqaNMUXuFo3G4if8CkRvESAU3xBlWADVF
	 OxI3dwQlEmhX1BDb9s+q97TnRNljvXgqaaRZhl3qSytmVmbf//gs4uAqwa6ANw1Gzr
	 NC3FRY0JkyDHkQrPb6xuiVfOKohApMtG0vpJwoKNR6joCWZQXstL6pSrzsKczQFr+y
	 UVUbyCJHBEkbjxKz7xqYwHj5GYWuEQFS4Dg5rFMybuEee2BrqSLL4BudBK/ToX6W5A
	 +WwN4OGsAg6w5LgaZJKJ/OoOrIYb9bngwpCan+iqVuOCjFyQ4dNv+o+JnlKGYkM666
	 OMeC1sFwiJz/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3EEB43806907;
	Mon, 19 Jan 2026 20:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] net: thunderbolt: Various improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176885461304.126985.16522587980109226601.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 20:30:13 +0000
References: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, ian@netstatz.com, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, YehezkelShB@gmail.com, horms@kernel.org,
 carnil@debian.org, razor@blackwall.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jan 2026 12:56:42 +0100 you wrote:
> Hi all,
> 
> This series improves the Thunderbolt networking driver so that it should
> work with the bonding driver.
> 
> The discussion that started this patch series can be read below:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: thunderbolt: Allow changing MAC address of the device
    https://git.kernel.org/netdev/net-next/c/8411d7286bcb
  - [net-next,v3,2/4] net: ethtool: Add support for 80Gbps speed
    https://git.kernel.org/netdev/net-next/c/a9927022c449
  - [net-next,v3,3/4] bonding: 3ad: Add support for SPEED_80000
    https://git.kernel.org/netdev/net-next/c/2e62e5565bd2
  - [net-next,v3,4/4] net: thunderbolt: Allow reading link settings
    https://git.kernel.org/netdev/net-next/c/7a3d3279a566

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



