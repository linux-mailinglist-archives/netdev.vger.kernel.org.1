Return-Path: <netdev+bounces-154096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE66D9FB410
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3059D164AFE
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3601B415B;
	Mon, 23 Dec 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH34cGi7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B761C3BF2;
	Mon, 23 Dec 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979228; cv=none; b=itcup0tYpebWrB+f7V355sQ/da2k3wRMUuBTVOj+GhO5V7f4A9jY3ZzhsVJFzOfQRAYZt8nspJgsT+cBw4bzXPLM2Qkt2GZg/j7hP6wj1nTxaGXwV3+6QtGTxECdkbnh09od9LIyB6M6XIZX/snS9Niz1V91FNkETuKRzD1GU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979228; c=relaxed/simple;
	bh=zc18PitYyNFj25E/Fh2M4NoFqTRafxGESx8OzhpScvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cl5lig8CkjvZD1ks0mkzv5yIh1p5G+Hd7bI1xb/zzXrE9u+bhnEBMNB4XZ/iv3CecHExPQY/BBCWnSC3sFPvC+ZpWS84Qn5EeTzoGTZfsE85lwSTGEWvRouXl3bFsgKSUS+rqnKzugmjBxNtFTzTNEuEEWeUwyHAUTd7r+YfJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH34cGi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06500C4CED3;
	Mon, 23 Dec 2024 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979228;
	bh=zc18PitYyNFj25E/Fh2M4NoFqTRafxGESx8OzhpScvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YH34cGi7LluNH7RL1ET1gG6aJslaiQaLAte1+UiW2Y2J4kIL+RO6w37n7FKfDGdbc
	 szOh/7jxN0fzTU0VeHMuYckNGf4Z3TaPFxXXyPaDjocQ1YJ7aAjMQeS0roqmNgR/tA
	 Qztuh6jOCuKeg17dK09oS3TmhCuHpNbx+1Ff/F7IFwiYOjFsQzeU+urMZJBqHIBA0u
	 pMOf2+DHwyPTYHMbiSYoAO08VSVdSm5+oX5JkFouu+CBlM/bvQv47ssUwMxXcFzAM1
	 Gp7riDhP2rltRgfZeWHrteVzzRE6GaAyZo60SmFBJcd4y/RWaNZDm/fDP0/PzuMgvP
	 HcBZj2552G3Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE533805DB2;
	Mon, 23 Dec 2024 18:40:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net/bridge: Add skb drop reasons to the most
 common drop points
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497924627.3927205.16787669909128619677.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:40:46 +0000
References: <20241219163606.717758-1-rrendec@redhat.com>
In-Reply-To: <20241219163606.717758-1-rrendec@redhat.com>
To: Radu Rendec <rrendec@redhat.com>
Cc: razor@blackwall.org, idosch@idosch.org, roopa@nvidia.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 11:36:04 -0500 you wrote:
> The bridge input code may drop frames for various reasons and at various
> points in the ingress handling logic. Currently kfree_skb() is used
> everywhere, and therefore no drop reason is specified. Add drop reasons
> to the most common drop points.
> 
> The purpose of this series is to address the most common drop points on
> the bridge ingress path. It does not exhaustively add drop reasons to
> the entire bridge code. The intention here is to incrementally add drop
> reasons to the rest of the bridge code in follow up patches.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: vxlan: rename SKB_DROP_REASON_VXLAN_NO_REMOTE
    https://git.kernel.org/netdev/net-next/c/46e0ccfb88f0
  - [net-next,v3,2/2] net: bridge: add skb drop reasons to the most common drop points
    https://git.kernel.org/netdev/net-next/c/623e43c2f502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



