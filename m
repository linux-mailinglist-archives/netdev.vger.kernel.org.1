Return-Path: <netdev+bounces-102434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D24902ECF
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 05:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC4F1C22683
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 03:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737F57E782;
	Tue, 11 Jun 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emfqem0i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD03307B
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074833; cv=none; b=JQ/OHZQIxVxdHdFa8IA6Fp7oiYYaiRYmD0NBQqp8/29E+/4eRCA7KZ/7WypYvmwks6koFitExA9tTqM7Br907bKzcIrj7Ed0H4WGv9mTrrvZGtSg/HNV1k6iNolHeexauU8ItBqZpVkFqo7ABvCCECLiNWt6Qp2U2Emx2cnD65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074833; c=relaxed/simple;
	bh=REJ5ALOALpaJLFtRFRmV/BfWAsXrlGInyh7JCBIdlVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QUliR2sS9ae5gWkfwuZG0TPxFIDQeE16FDB0q0N6n7pPGfc6JuD2h6xEkXw0Q9c1DbEjQGXEDkd60qcg3Gz4e/pYfHrSWxZTMCFKpCF6a3OddN4P628WfGNkGPPjYMoqltDlnGH3aiCWa6oweInQQnUvu2+F7dKiVPCrdn3AMpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emfqem0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DACC6C4AF48;
	Tue, 11 Jun 2024 03:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718074832;
	bh=REJ5ALOALpaJLFtRFRmV/BfWAsXrlGInyh7JCBIdlVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Emfqem0icuaMehxOvL7lj9uf4mrR9AloEoh2kG8YbNchNRe6jZYaTAmF6dX3Bmelv
	 xrmuC0czMyHLJHgW36zoG0je2n5c+7NoyQWBvQyVdjB0DCjYAejJkXwxJadDLWe/vT
	 pXcMmwxQczQsaaTtlLfZBH7s7+IGxq+8C9KkXqIobnI6oubnrk1r3iVBQZogeYFnLM
	 tVwkkzWEA5X2AF64XJQRxzcLPKgOCGJjiGx+IqXYjktazeNuSk+NIdWopfODozg5fM
	 dt0oq5FU1Ml8vurtR4kyKZoHr70U0M5+fsG08ZfqOx26YwyEdbut2GY3oGoyp8w97d
	 K1ThB19EaJs7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC71CC43168;
	Tue, 11 Jun 2024 03:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171807483276.24718.7759930547771829374.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 03:00:32 +0000
References: <20240607125652.1472540-1-edumazet@google.com>
In-Reply-To: <20240607125652.1472540-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, ncardwell@google.com, eric.dumazet@gmail.com,
 imagedong@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Jun 2024 12:56:52 +0000 you wrote:
> Due to timer wheel implementation, a timer will usually fire
> after its schedule.
> 
> For instance, for HZ=1000, a timeout between 512ms and 4s
> has a granularity of 64ms.
> For this range of values, the extra delay could be up to 63ms.
> 
> [...]

Here is the summary with links:
  - [net] tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
    https://git.kernel.org/netdev/net/c/36534d3c5453

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



