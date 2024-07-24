Return-Path: <netdev+bounces-112778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7593B28E
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B441F21F39
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD8158875;
	Wed, 24 Jul 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egBKb/gF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278B1E867
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830832; cv=none; b=O6RMtgHk7ztPEWN+AbTFTyW7PqmcOP11CMbebZhE2+b3QV2kjE7eMdgLb9Lf9bmNhKY+I+QyqEElvNbfovPslhjhZat410YfnMEwc2ZRgfIvxsJ3FcMLqorxWIZJscqTK0GVJxmk7XDp37kwitP1f/n577QN+nTJtFQFwNm/7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830832; c=relaxed/simple;
	bh=Rukc6O3TUn3kCoKQwcb17Ej01IDzKcNV/0uipcAAcgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KhkqhoRM5I7NJDkMFsXuge42WYcna4QvQUkaR7FeKUShWYckDHhrurwP/D8/++xkn8Qsgig3exWWV+2t3QK0eyT2oiolgMTvfVtlnryICLDkXsEibjwvs8zXdXvv2c4hT2gPPrGvZ/SOxyUK5WROxgcvxK8YJbhRwpcA/qbFb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egBKb/gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3A9CC32782;
	Wed, 24 Jul 2024 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721830831;
	bh=Rukc6O3TUn3kCoKQwcb17Ej01IDzKcNV/0uipcAAcgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=egBKb/gFfr1FDU1kzhsbr04PujEoZb7qvTpIfRAqROUU9ItecReDuSCMd89l1097U
	 /91iq2H794OQaaf+09WrojyHjhFB2lABA1yqSGgeRsSlkra0AqBljZZojOIfsxFBwv
	 oywnreAfvgLOzHkr+NcRisBEjQABIQmlWEjfWwH6N//eiSH6Q3KFSotOF2Tl5qG60/
	 jqEbTM9A+XZJSJA0O8WvwWrb9iIGA4lJDHeuT8ehtBEhv3u8XQSkB6ew56dhVqUZmH
	 5R5eSPd4YzWgIo/M5V1lF26pjXlVSpnKISSsLbwK0x/hPTRNw2p3PSdJmzbUG08Wyb
	 w0m/O2bBlp/cQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFA97C43601;
	Wed, 24 Jul 2024 14:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: Correct byte order of perfect_match
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172183083178.11114.6015166451648250005.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 14:20:31 +0000
References: <20240723-stmmac-perfect-match-v1-1-678a800343b2@kernel.org>
In-Reply-To: <20240723-stmmac-perfect-match-v1-1-678a800343b2@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 23 Jul 2024 14:29:27 +0100 you wrote:
> The perfect_match parameter of the update_vlan_hash operation is __le16,
> and is correctly converted from host byte-order in the lone caller,
> stmmac_vlan_update().
> 
> However, the implementations of this caller, dwxgmac2_update_vlan_hash()
> and dwxgmac2_update_vlan_hash(), both treat this parameter as host byte
> order, using the following pattern:
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: Correct byte order of perfect_match
    https://git.kernel.org/netdev/net/c/e9dbebae2e3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



