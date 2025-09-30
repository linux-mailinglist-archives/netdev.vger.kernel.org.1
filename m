Return-Path: <netdev+bounces-227243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D1BAADC4
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247AB3C4AD2
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F961DE2BD;
	Tue, 30 Sep 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZXEQkeO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068561DDC2C;
	Tue, 30 Sep 2025 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195255; cv=none; b=QUBBIHmgDxF1bo93/VPpTlU2ovAbPpnQPU4cNrqpXiqUIWoWe+DX5aSCzD3nV25SDZO0utxz79QVPyh0V28jumfVk9nJIlSqNeGWoehns+6nlXDOUf07jOSzm809NiY5dcf8lBl5gZfgQuNZJd4Yw2/xar7xrBfHXdWeZom3A/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195255; c=relaxed/simple;
	bh=X22pEFpCAgMRW1UK5UodG0zf7Y6uxPShDgKLYOKw3ZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KBwCc/FKSKOtBY72+4c1UaFW05ELT6OxGJTiyZgBE+eslHMnIT9ayWOD8raIf4ABO974IlZbaiVMI9osDeryv5dHNesbdJDcVhdbMuzMR6lbfkWe+9sftDnDUBt/EMxGRvT+1yg32LXzPVKrXFdRu9/L3vKjwCvdzkcebQPkkgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZXEQkeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81021C4CEF4;
	Tue, 30 Sep 2025 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195254;
	bh=X22pEFpCAgMRW1UK5UodG0zf7Y6uxPShDgKLYOKw3ZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lZXEQkeO2EVxyntPgxq6Gql93fRNspkOZNZtbl+lq1HcCX92H2oyukLagXeNja6BX
	 4DDkkDTh73oK4NoG01u8DTfeIjtW62B/F3nHksUOqYE0Ikz0jyXEHFEAVgFZU5Ryi9
	 ACauuux9ZdMqfLx0/QTD9HyfbDKCEE3uCtnnSeEk1qBglr9aJc/BSpZNQlSEsJf68U
	 tlIfrR5E//B4cHQJko8c+fR6qhncw/ghsPML0WHBQ1d3RypmPoK4d6Bcq6jq4AjPje
	 Ud1xR/NDusWUt73DHEwJFJQNzWE2j3b9VKO4O0aypsg+oCLCXkG41Aq1Z8p25T70Fi
	 4AfClI+xAaAVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 346C139D0C1A;
	Tue, 30 Sep 2025 01:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: Drop frames causing HLBS
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919524773.1775912.3053137579146685906.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:20:47 +0000
References: <20250925-hlbs_2-v3-0-3b39472776c2@altera.com>
In-Reply-To: <20250925-hlbs_2-v3-0-3b39472776c2@altera.com>
To: G@codeaurora.org, Thomas@codeaurora.org,
	Rohan <rohan.g.thomas@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 matthew.gerlach@altera.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 22:06:12 +0800 you wrote:
> This patchset consists of following patchset to avoid netdev watchdog
> reset due to Head-of-Line Blocking due to EST scheduling error.
>  1. Drop those frames causing HLBS error
>  2. Add HLBS frame drops to taprio stats
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: stmmac: est: Drop frames causing HLBS error
    https://git.kernel.org/netdev/net-next/c/7ce48d497475
  - [net-next,v3,2/2] net: stmmac: tc: Add HLBS drop count to taprio stats
    https://git.kernel.org/netdev/net-next/c/de17376cad97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



