Return-Path: <netdev+bounces-211403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442CAB1889F
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 23:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5669916A091
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 21:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE66220680;
	Fri,  1 Aug 2025 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDGdNOjV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DC1E5B72
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083192; cv=none; b=EjcvQ1w5hP/proFJq8awybt7NWjFiqc9w00lDv6uPoAiEoa5rsVf5peVe5PWV0ERdf0UKoY8Bnh//XhSURIFF6nBtGyC58frpSqkUvRTVYTcF6jVqhISnO08XCNbuFw9EIJ3uL8GOGMQ+QCSKlSzHQJsLSknlhFRNrPINvEOXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083192; c=relaxed/simple;
	bh=gJtzu7d9v6hgThSA0k2QkIjkc1nE4oPsz6fRJ8T1YkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bRGeEqxjVkMR1a0aeroruUjMgLatA0/nhMGkLafnetNmdzr/p1FieR7xCRd0tWGF1Q8aIS67Os8XoLNX+x/w7Z32zErXqvIxm7U/fW4ccowEpnW7QsK99IDj8H/ys2qnNhZwu1S4z0Qpt4kYGn3TQwfomA+4TC/NO8n+I13sNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDGdNOjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AC2C4CEF4;
	Fri,  1 Aug 2025 21:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754083192;
	bh=gJtzu7d9v6hgThSA0k2QkIjkc1nE4oPsz6fRJ8T1YkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oDGdNOjVL16FWxAkQLRhyOXUzeiIW2NbKbbXacmPj5E6exkBhrguVVTAKRCojcdsf
	 2f6qmcTEMtyUji0P3EhBOwuhlEjy5hB0lruNzRwobzvegXim89m7gtEPCkCHFGMOoJ
	 PBmCt3Hi4yTesFSqCZ7WPp54YZd+X2gnng2x4waZW34hJ99wuyLplm+jNkGc9I7Vlo
	 sEJClbQyND3Eyh1OCSFLZsiu3S3rUBrmvW61Gfqr27vUnN4hbh5Vr0QWCsYcy7PZvJ
	 PBd0Nk6EmjlgQ+bmmbz1xMdchvnBnCaIwMm2LjMW1bx3SLyCIAZyuWSsCS9LT0g5az
	 bWo/619pAM2Rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE5A383BF56;
	Fri,  1 Aug 2025 21:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: unfix not-a-typo in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175408320751.4079639.7810552009122411425.git-patchwork-notify@kernel.org>
Date: Fri, 01 Aug 2025 21:20:07 +0000
References: <20250731144138.2637949-1-edward.cree@amd.com>
In-Reply-To: <20250731144138.2637949-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 ecree.xilinx@gmail.com, netdev@vger.kernel.org, bhelgaas@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Jul 2025 15:41:38 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Cited commit removed duplicated word 'fallback', but this was not a
>  typo and change altered the semantic meaning of the comment.
> Partially revert, using the phrase 'fallback of the fallback' to make
>  the meaning more clear to future readers so that they won't try to
>  change it again.
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: unfix not-a-typo in comment
    https://git.kernel.org/netdev/net/c/60bda1ba062a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



