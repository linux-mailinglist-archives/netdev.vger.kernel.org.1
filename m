Return-Path: <netdev+bounces-178924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15315A79918
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFBB3B586C
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1071FBE87;
	Wed,  2 Apr 2025 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfSbx01P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909E1F8725
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637205; cv=none; b=Yopi/9eeyNpKb2SuUXvgXcM7pc25m30tXtN+YDBCZ7D1kfCJ9/e7TrSW2qzsUmuEw/4tQd1rCanaKhkRTid/pOZnQXo5gqQBT/ow6SmNkySPxfVx+iWpRTlhby6OHmHHwStEusZNttz9SJYDCH4ewYYbjwyPyJs9XGDIkZ3ugwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637205; c=relaxed/simple;
	bh=zAmMwzFxqTlBJ1o+nbHozCL71L3PaWKgrvnw4T0F69U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z8PvMXFMdevHbQifm133RdGfqKly9VLAUwACUZWFJHCUOTgXQ01TCg8w0d/qeTEFKjBG6AOpp9d2N/Tw8PYoDdLv40pcPTkm66EoixaqfEmJtpzijh+a6T5TbzYVvSHmXD9KmPv3ZGBYorpJVkzRGnlIYL0dlGe//8iclWI1Tr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfSbx01P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975FAC4CEDD;
	Wed,  2 Apr 2025 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743637204;
	bh=zAmMwzFxqTlBJ1o+nbHozCL71L3PaWKgrvnw4T0F69U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DfSbx01PGBNPSaCHQYBr3LeJ4ooNG0XJ2EqhJjwNmOcYeBtSol1bkTIFHKwups+eV
	 g2E4zWuQ19NEAx+cvSC31D1q/CJhQTLTxQUNNMNM6yEpyrIuuDG4TMN0xYtwasrpRm
	 hsrhM5y/KDfv3/k3xRPN0evsyt64sMJkuAs1fbxdzJkGG/435l9N9vzfeJ8Didj6Bb
	 ifoz2Oitm6Zkv5fJJwn+4XfuGFRJUJz5gMaDeR7KHcWE0mbsKxcp2CESeaoXfPTO4N
	 zUU8Q0uYGr+e2RFPFeaDcQ31aE3SIqPKdKSD66I3i1RwreGAOy6jvzEQBmQ45D1I4T
	 FhT+FzC8vA8EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9B380CEE3;
	Wed,  2 Apr 2025 23:40:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix ETS priomap validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174363724124.1716091.3922737593747248975.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 23:40:41 +0000
References: <20250331-airoha-ets-validate-priomap-v1-1-60a524488672@kernel.org>
In-Reply-To: <20250331-airoha-ets-validate-priomap-v1-1-60a524488672@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dcaratti@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Mar 2025 18:17:31 +0200 you wrote:
> ETS Qdisc schedules SP bands in a priority order assigning band-0 the
> highest priority (band-0 > band-1 > .. > band-n) while EN7581 arranges
> SP bands in a priority order assigning band-7 the highest priority
> (band-7 > band-6, .. > band-n).
> Fix priomap check in airoha_qdma_set_tx_ets_sched routine in order to
> align ETS Qdisc and airoha_eth driver SP priority ordering.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix ETS priomap validation
    https://git.kernel.org/netdev/net/c/367579274f60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



