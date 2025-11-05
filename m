Return-Path: <netdev+bounces-235658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D800CC339B7
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 551284F3E77
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1F5265606;
	Wed,  5 Nov 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4qL5/aU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB4253950;
	Wed,  5 Nov 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305045; cv=none; b=hZrI+ui06wt5VRJ55quywIAilAJeccNfej351ySvoZdR52zPUTHzi5ARGDsMISivNYAT9XhhmbjIWpHq92Gxa9JwwU+JHBxT/cuwZAa4zofi4Rh8SNwdfLTMKQqvMKz0NmYMH1ZIgk7yDjzCzoASUCZpOViJMV0doxKLvXpZSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305045; c=relaxed/simple;
	bh=8129RKep5HIM82xGArLdPHS6TTFvteoIGapcBdGg4hQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ucC6fUCw9yZ6bnL0DWsfOqwuukFELNLhRPz9TyQ1jtWT426b1WdCGuCoVO4c8O8VvYIvWVev2RFcdbCF1F4VvSpbxYKc+ijHQA0oYNHWtT+he7KGVFpFjB8G6flGwNBWTsBVxKQkFjaI9lMMNFhgE1MRZ+PrvN39+6KskPRsCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4qL5/aU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27435C4CEF7;
	Wed,  5 Nov 2025 01:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762305045;
	bh=8129RKep5HIM82xGArLdPHS6TTFvteoIGapcBdGg4hQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M4qL5/aUO//l5yLmLOV0B7hXtdNSLEW9UAoXIfm4dp2cvQuH8ov3fpKCbbpasBjiI
	 Oa8Pn0HannJwbu3kQJZIkfebV3o2Vd9+WLdzlBlQ11gSg8YLsVtXUGaizwU1N4/vF2
	 nSi6MWPfIJ2x5Gry8wOlGxqji6qPF7tbvcjYYJg9PJAAXVwzr4qM0+crdj/o3VVWyn
	 fX4kKJ1+tbMDb3h/HU7BYEWfydsDnC/gHloMWpytZH5lJd1m9BcMht5Eig5P1idfxR
	 MvQkUQuFFB2bZz4tQ0GIiNXYuFZRtFcTJ9UyHW6/wK4sgVgD/akcsBsJwKrcJKZbRR
	 e8OW5bEzzbDQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E91380AA54;
	Wed,  5 Nov 2025 01:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sungem_phy: Fix a typo error in sungem_phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230501899.3047110.8555323116296371221.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:10:18 +0000
References: <20251103054443.2878-1-chuguangqing@inspur.com>
In-Reply-To: <20251103054443.2878-1-chuguangqing@inspur.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 13:44:43 +0800 you wrote:
> Fix a spelling mistakes for regularly
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/sungem_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: sungem_phy: Fix a typo error in sungem_phy
    https://git.kernel.org/netdev/net-next/c/96c68954cd3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



