Return-Path: <netdev+bounces-179331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE898A7C045
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469A37A74C5
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7FA1F461B;
	Fri,  4 Apr 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTUwIruW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C81F460F
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779399; cv=none; b=Smrj7jhuuWEQD3HH00SiGXpPniaOLUtnU5i3zK9d2BwqOiXY69hqYGpYmYiHs/cU5MrOillkJr8k7WxiMFmA7h1T4ioHXUPEhd9ASyVATLOpPh0Um5Rd8G5fEvjU70LFACimXkdz31PiUKZPftNoZjvKBQMSDeYVcUlQVMLnwVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779399; c=relaxed/simple;
	bh=3wT/+nd3TaVjmmVfI2u8Rai3Y5/Xm0FEgZgmwoHSWW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WM7ZZcNKXYw8I7TVvCt3kH7qk1JDxqBqPQXO9HZaRiz/riWemoe1SQyFhes33cufGCBSaWVy93vOBZGRgdk/TfUH2BkI9AzKA1y2tTE+pTSiQyvU4lvZikNSROg6sRGdHA1qZzpz36H2ENlAowGbctOKKR+tHv+v2JAaTXgSe94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTUwIruW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDC3C4CEE8;
	Fri,  4 Apr 2025 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743779399;
	bh=3wT/+nd3TaVjmmVfI2u8Rai3Y5/Xm0FEgZgmwoHSWW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oTUwIruW6scK+ii4pl6DPbjgrDu3WI07WUEGvdn1yYojUe4Oq0kpbkI6RK6n88dEv
	 aEcVPkK6gH9y+Uegd1zzhzoombGiapbEaEQMTDjxtQBv6Om48oNztP1v7P6+8uGkFk
	 EAiG8sb2HdGu/ukdAjxMVyp8vCtTuP5Ux3lQMaTii8d06HZ/I3wWzTcMd4cAFpg8E6
	 qoEXQPto9cQp7usCBig0v/icKV2ABe6rgHLzL6n/ljfxSExEPmfP/I5uPKPkW3KOQy
	 vZouJ0UFOkx6a5yIL9hHTLPAEl18YyzF8KhZV2MhmIXYC6xUfcgKrkD8dybkuX+4/W
	 +g9PawB1SM+Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0723822D28;
	Fri,  4 Apr 2025 15:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] netlink: specs: rt_addr: fix problems revealed by
 C codegen
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174377943625.3293273.12224629792815197216.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 15:10:36 +0000
References: <20250403013706.2828322-1-kuba@kernel.org>
In-Reply-To: <20250403013706.2828322-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, yuyanghuang@google.com, jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 18:37:02 -0700 you wrote:
> I put together basic YNL C support for classic netlink. This revealed
> a few problems in the rt_addr spec.
> 
> v3:
>  - fixes from Donald on patch 2 and 3
>  - patch 4 is new
> v2:
>  - fix the Fixes tag on patch 1
>  - add 2 more patches
> v1: https://lore.kernel.org/20250401012939.2116915-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] netlink: specs: rt_addr: fix the spec format / schema failures
    https://git.kernel.org/netdev/net/c/0802c32d4b03
  - [net,v3,2/4] netlink: specs: rt_addr: fix get multi command name
    https://git.kernel.org/netdev/net/c/524c03585fda
  - [net,v3,3/4] netlink: specs: rt_addr: pull the ifa- prefix out of the names
    https://git.kernel.org/netdev/net/c/0c8e30252d9f
  - [net,v3,4/4] netlink: specs: rt_route: pull the ifa- prefix out of the names
    https://git.kernel.org/netdev/net/c/1a1eba0e9899

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



