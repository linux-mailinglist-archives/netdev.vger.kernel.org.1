Return-Path: <netdev+bounces-141343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083959BA823
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6539281743
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9053E18DF7E;
	Sun,  3 Nov 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9sf8l5G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3418DF6E
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667629; cv=none; b=PeNyj9dYYbgfu4RufHFJs/Cz+RC/tzumRwURBJMgsVtsAJOwbjmsrNNloxxiPn65m3oLuMQ5MZvXkkwG2WorXbaBSYDCsi4VPMVIQqj+P8mVxRKnLOBgzlOhblJWN+PW08lir8TBU9fMX4FC0aDfqeR1hjoHIugbEfzWiSw84Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667629; c=relaxed/simple;
	bh=4C8C8egVXHHPt9+3j41NEQ0VIgG4HvQ9pgQ+iqbD97I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qIFIbMUrTUbFKFnUhMZrN5txaR9N+8z6DeSchhXKKMXCDMb/fu2a0auGMjNMncQYolEiv+4l2G56sUowQfiaNf5WdiaGpFhc/KwEdiQmmgQ1BZ4VSYMSyQBmJ0MBP2AgGdflerin3xvjE05G96+i0M38YYzTvv1j5yT4mwVIJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9sf8l5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7961CC4CED3;
	Sun,  3 Nov 2024 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730667627;
	bh=4C8C8egVXHHPt9+3j41NEQ0VIgG4HvQ9pgQ+iqbD97I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a9sf8l5GhAVXrZ9kCg1EK1L9HzgRkc29lMLTp6Z2wPR3LiFlH2wwe5MFGKcFmGMjE
	 HLeMYbsFLH2qFcE7UYIBmNR+rRQTmNLw4go8JJzc2cUC/ik9h+Quw2e+8I8Z6VODCI
	 KlKMTa2ikVGJthHB0EkZL9NP5RWzmm/r/vO0v5BQIWC0l4CDTVnsLfjcX2JgOkTlnM
	 g+iv0wyE3H8h5Xhc/JvPEjr2/PWEz2pVAsVlIXiwHb70UI8v+q8TcjGDcV1dseb3MQ
	 tNEIsUaGd3KP9DmciGQolGttt9wwEFLcV+0tWlm8x3yPjia2zx21aF53sQxu62vrGH
	 NqHZW066umzQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DAB38363C3;
	Sun,  3 Nov 2024 21:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dsa: mt7530: Add TBF qdisc offload
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173066763598.3253460.11329332225402731134.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 21:00:35 +0000
References: <20241031-mt7530-tc-offload-v2-1-cb242ad954a0@kernel.org>
In-Reply-To: <20241031-mt7530-tc-offload-v2-1-cb242ad954a0@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: arinc.unal@arinc9.com, daniel@makrotopia.org, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Oct 2024 15:28:18 +0100 you wrote:
> Introduce port_setup_tc callback in mt7530 dsa driver in order to enable
> dsa ports rate shaping via hw Token Bucket Filter (TBF) for hw switched
> traffic.
> 
> Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: mt7530: Add TBF qdisc offload support
    https://git.kernel.org/netdev/net-next/c/2e570cd187e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



