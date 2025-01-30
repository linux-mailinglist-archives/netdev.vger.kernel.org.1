Return-Path: <netdev+bounces-161590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E582EA227C7
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 04:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B0B3A6670
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 03:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827E13C8EA;
	Thu, 30 Jan 2025 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ44812h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B113B2A4;
	Thu, 30 Jan 2025 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738206610; cv=none; b=Fj1k+sgJp3nEb1B30kC9LLpAmRMYqJCMgSmL5sMKChwPc1wwKIBjQihX7pQpZqD4HG68imf3BRZJ5doaHyNeq9jpFrgZaJ8KBr5U166uIcaI6+MIkmAVBEClV/n9u62ISKX+qWd3/97SfUoSpr9tL/hZSXEHNBrMlwQ1lv1w4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738206610; c=relaxed/simple;
	bh=FTykpfDSHwsmAfsJIuLkm40+1RSfTOaRm6aO2J7+rgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sp/kvJd1F7zC10Xqw3boN06+h7YX6d+BL9qTh0B5UmsHPirMr2bixyfZkqOmIEnbNNTEv3pXCTIDcUYPsu7aYcDV4FyJQhqFp4MwD9KdO97aEG56DdM6i0cc6VbsdyEKG9hMyB9BRn7cbpkvAmwS45uS8FxQLeTCCfl+JPNQaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ44812h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EDEC4CEE1;
	Thu, 30 Jan 2025 03:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738206610;
	bh=FTykpfDSHwsmAfsJIuLkm40+1RSfTOaRm6aO2J7+rgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WJ44812hsFQppVs4tYoE9bi0kBVLIa9RObCxMVY3fyt9XgfszNC3GU8uEM6jyfimI
	 SfmJETB+B8bnGPO0sX7DarWW3h/QH9cVLZXKUP+gSQxdnNDuS7l8jltpqAaVACYcPE
	 aAc5NbOkna07Sln0d40BeZ0NYQwMelSEyHi//+RVCtkfbAuaPO7+yqqbj9H37CTVsT
	 JAK7pcc46CLsg+0jS9a6IXvKG+8n5xeqejoeVa5wsruzGV0t1tt1hB3MxE8M8k1jyJ
	 DAh6pRMnAwX7CHS9Hvf4GR45xD6omNgBWQnQYFjJrzg5Hr3NZubH+O/FWaAuE6Fwm7
	 5WEw5rsVNesGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE517380AA66;
	Thu, 30 Jan 2025 03:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bgmac: reduce max frame size to support just MTU 1500
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173820663626.510125.14235788662418434393.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 03:10:36 +0000
References: <20250127175159.1788246-1-florian.fainelli@broadcom.com>
In-Reply-To: <20250127175159.1788246-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, rafal@milecki.pl, horms@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, murali.policharla@broadcom.com,
 ray.jui@broadcom.com, arun.parameswaran@broadcom.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jan 2025 09:51:59 -0800 you wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> bgmac allocates new replacement buffer before handling each received
> frame. Allocating & DMA-preparing 9724 B each time consumes a lot of CPU
> time. Ideally bgmac should just respect currently set MTU but it isn't
> the case right now. For now just revert back to the old limited frame
> size.
> 
> [...]

Here is the summary with links:
  - [net,v2] bgmac: reduce max frame size to support just MTU 1500
    https://git.kernel.org/netdev/net/c/752e5fcc2e77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



