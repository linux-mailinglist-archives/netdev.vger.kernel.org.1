Return-Path: <netdev+bounces-141365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A59BA95B
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E9C1F2127B
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3002718D62D;
	Sun,  3 Nov 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpuGG80e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1503433AB;
	Sun,  3 Nov 2024 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674229; cv=none; b=GXPtPyvqYCrs+Td0vg8PXHDixT1l5yDVegW3AjdqYpdpP47fIzRT3tj6wJkFK74ip2yZaXGc0EDPA8x1KKC6jsbzyAZHDoIGlzPUFHjfCJgJNzoXlrOVAClSjZ53kb4Jqs6NfIjHdZhrDeBZ10/hEA1m8O5FKoYvLTjAbbcpz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674229; c=relaxed/simple;
	bh=X69aYaQPY1p1zrw0RsL/G3Dwr+PLLoq4fnyMayEKkFU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TghyNc7eH51krhBIDcJy0/oKfCDrTDcK4XWJ2bpmWe7y33Uh9XIxERCrRyAf6UBzWpaS6TkAnRF8ZTY3UBg0qj1yEg/ebpxT3H1ZEyPTTGSKKIZrnRuvZ2gDYjAB2WOq/uuKo1rIn7dc6j1Wd6kNaVWxA9Q+D4hUh6qZyVmZ+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpuGG80e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C48C4CECD;
	Sun,  3 Nov 2024 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730674226;
	bh=X69aYaQPY1p1zrw0RsL/G3Dwr+PLLoq4fnyMayEKkFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VpuGG80eXkrjQJQDXdwCOGo8ZZOWybSe0F5/SY9TwejYPsviHCJ26LhOqR6Yk3wiZ
	 etCTRb7SR6OZLCnl436/9wfK0SzOVm2Q147sLI094ONj1byXluvzCr07hiPVKN/3u/
	 kTnYeRjX3LLX39Rm2GS9IAg+DtgShud/srvJnO+Fk+15DJb/vu2k09FgJ5V0fc6tlA
	 2hFfm1ln4mdQtu9HzX8B+yx6E5bYu7M0qMr6oGwHwg302xC9fvAc1NscWWQFitNSCN
	 B43eXgnnuGyAjgkHnv25Rv1K2jc8ShDw1EiUTiKIS5N/5svNwtKcZCZ5Z5iyfcdVDo
	 ULjW4Uby2Sh0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9838363C3;
	Sun,  3 Nov 2024 22:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: snps,dwmac: Fix "snps,kbbe" type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173067423473.3271988.8001663009790702380.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 22:50:34 +0000
References: <20241101211331.24605-2-robh@kernel.org>
In-Reply-To: <20241101211331.24605-2-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Nov 2024 16:13:31 -0500 you wrote:
> The driver and description indicate "snps,kbbe" is a boolean, not an
> uint32.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: snps,dwmac: Fix "snps,kbbe" type
    https://git.kernel.org/netdev/net-next/c/d847548c7ef4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



