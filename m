Return-Path: <netdev+bounces-128162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8363A97850E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1225C281FA2
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303842EB02;
	Fri, 13 Sep 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfOa6gA1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F3535D4
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242033; cv=none; b=XJOaAFEbHVnDYx2Lh9NWDxCB30rKhqgaT0wXxHNsYjMVHLsbUsPyB/Xca41zp9dsxbx7MOisw7efZfLlH5GEBpy3Eyxs9XeJBlD3jJb1BKKABwBaH1nEBimAOKeBBcEJZSOGTjZrMfUVIIFIctHOPRovrrmmTWpLCFq+ILXxESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242033; c=relaxed/simple;
	bh=bIT6bT/Pg6iXvAfZ6ZNR7IEfmx/sPHPmA5haoDEc5ss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tpFcQtwMVK+NJuhSNHBgLq40sRvUT0YoRu2lCbNj4uW6A80zsF85ooDWfC5Njf0pm0ChM6vAzDrSNPIqysd8gGhDTMqp2Vol7ZLL0mYBUW1J14SIbHrxNZewY/msUunBgnpSe4lSJsFrbBmQxqpYID5AgfUfqRUYm4n6wVLOGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfOa6gA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04C2C4CEC0;
	Fri, 13 Sep 2024 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726242032;
	bh=bIT6bT/Pg6iXvAfZ6ZNR7IEfmx/sPHPmA5haoDEc5ss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rfOa6gA1nebHsUEWlJPpc5qjspMpvVZIRBqif3jET4I1TLa2j9IiEYaIaJNitmIM7
	 d21G8dU7nIFTpz3rtAYi/FpWT3s1QABVyYGV61RzNiCcYQZ6abaccoiXRHasb4K0QL
	 g8p/gYDSad5PNwYm0AmF8+Eqx7POuJA7p0Dgb5KYQwsdT/xG3gYYdbrqijDTtFc4ov
	 PYuMCWPcfLQZE6y0nz5Lh3GFefKDyrxCtoP0YlTda5ZD3JcuEXzvCLJYKVG3do5tO4
	 lxnH7G4E8OIazvJD2QPVNjqwp1pz5+OUJcKDcz6gZvyP5at6K/AIhDPvx80ml668rC
	 O4oWFXhWj5AsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2D3806655;
	Fri, 13 Sep 2024 15:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] man: replace use of word segregate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172624203375.2279687.13318802703337292755.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 15:40:33 +0000
References: <20240912172003.13210-1-stephen@networkplumber.org>
In-Reply-To: <20240912172003.13210-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 12 Sep 2024 10:19:53 -0700 you wrote:
> The term segregate carries a lot of racist baggage in the US.
> It is on the Inclusive Naming word list.
> See: https://inclusivenaming.org/word-lists/tier-3/segregate/
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  man/man8/ip-rule.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute] man: replace use of word segregate
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c70ccb476dcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



