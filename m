Return-Path: <netdev+bounces-72734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9C8596B2
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 12:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8979B21DF6
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6060EEB;
	Sun, 18 Feb 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNi43ks2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A94F1F2
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708256424; cv=none; b=LwXa38lRhNAK/QnYutZoTIojdNDge854WdS5PKuu6PM6tZg2F4XKHfwu3bL2LA/psesl3t6c2TIZMxQF1NEjz4ZIjXB052MmPD2M7Pb0EgpKqIIrz40cTX5DLfew0OPWK4oEzhQJp/HHtTAWkQ1I7HtJdR2tKY6jIhl8G4XMgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708256424; c=relaxed/simple;
	bh=/SXjJKs2uxa3KZxUglVJ61mEiIp4DEmkDC1z+FxP2JI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DLxmrkZelLNagCHdawNp0sjKXTihvndUpMAhtJes+6AA/jCx8uS8qMLpJeQTg2NLrCtopdmlUVGO8gAk6/16kVEJ6fQxTLY2Xq79ccuQAQ0+PJ/bqk9xMXyc39zBl5IomImuVRyg7rxw7+tGgtg65V0pXELrIpsg9FgbEbX8Lrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNi43ks2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ED92C43390;
	Sun, 18 Feb 2024 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708256424;
	bh=/SXjJKs2uxa3KZxUglVJ61mEiIp4DEmkDC1z+FxP2JI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iNi43ks2elTLgbvEneMcgex96NKYvdUyDQ3B8HCBrfX+qC0SG/pE9syB2Sg/ppdeq
	 ddycXH0UpcgPrjoB+RFgaCcmOl4m9/XrZS/bZQrzsK6jqyHM91QWgfpue0PW8dCZGT
	 F6mY8SmdZdswm+sf4+hD0BdowgiQiMDTkf2qHWu0En2PtqzBSC83Hjk7NjWT0mchD6
	 GwXchg9v+XV8cTiVyxjV7WJAzqQUMmuKmwac5zgGTAbTpkvZGQPVVZM67Lg31T9GtK
	 TJERkqFV1HdsrJnRY5NJtcqP8VKwEt36kdMses0day+pDgioMIpsidvwmdwjo1U4wu
	 s8/FV1bW2ImqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 671F5DC99F1;
	Sun, 18 Feb 2024 11:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net: bcmasp: bug fixes for bcmasp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170825642441.22700.3331479292535975341.git-patchwork-notify@kernel.org>
Date: Sun, 18 Feb 2024 11:40:24 +0000
References: <20240215182732.1536941-1-justin.chen@broadcom.com>
In-Reply-To: <20240215182732.1536941-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 10:27:30 -0800 you wrote:
> Fix two bugs.
> 
> - Indicate that PM is managed by mac to prevent double pm calls. This
>   doesn't lead to a crash, but waste a noticable amount of time
>   suspending/resuming.
> 
> - Sanity check for OOB write was off by one. Leading to a false error
>   when using the full array.
> 
> [...]

Here is the summary with links:
  - [1/2] net: bcmasp: Indicate MAC is in charge of PHY PM
    https://git.kernel.org/netdev/net/c/5b76d928f8b7
  - [2/2] net: bcmasp: Sanity check is off by one
    https://git.kernel.org/netdev/net/c/f120e62e37f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



