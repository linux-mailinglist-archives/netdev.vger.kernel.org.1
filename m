Return-Path: <netdev+bounces-235657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E79B2C339B1
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DF9C4F2889
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9147F25F79A;
	Wed,  5 Nov 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0fmUh5r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683DC25DD0B;
	Wed,  5 Nov 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305044; cv=none; b=PeyvLcClzOvAEu3VWWx8uQVTdwqc4Vj7akWAJPvYhxqtpEsAKjUMV5Jyp9fc3m22dFDk2TzFQS8iBkkIWDveUQU30d1jhN2oHI1uUeaJIp9Jh87fyhYP7ePTh0aDiQUSUoJoI5WwEfCVwXdivYWn/zN33dKP5bXgQgRhgrHfxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305044; c=relaxed/simple;
	bh=FB5DHE6oGXpWCDWyeXdH9dCZxHQsOE6KUu/K0AdPtH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qAc9UgvBn1zOr4iDeaWfsh2i64CEFxviAzXblvKGKOrxvbk0Bv6X5VyfXxQY7/3nHf2NnBCZAx9+2R0EzgpeeTvSjnHPUy6Ysa1+ISCvOfzb0Lq8suC0L9j5GAq0hFeNE7ZDAi9ce2v6X/dTqo/SfS+Y+TPMUdGSkqa94b/o/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0fmUh5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBDAC116D0;
	Wed,  5 Nov 2025 01:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762305044;
	bh=FB5DHE6oGXpWCDWyeXdH9dCZxHQsOE6KUu/K0AdPtH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M0fmUh5rPge7O8CCstWCL0yUjnPtQxBrNrRcHAI+vBitPBwqLiyM+gkKx8FzAEiyW
	 +MpWn+ZcoN39QjijfQ4QTg1W2j5OGsT6bAD1VEvfRMSxED6y5UcLfkWw9ST6Pzsezv
	 5BmIqM6vgagjcTSsb2wvW9My+urTyeTj2twoyv5U6OX9p2vu5TDRoHOMm1kJe6JsJ4
	 vA/4w3d5SRsJAH1gvmeTghL3TC59epz9fNUZbz5rfx1lzzxbE8AuCJA1ta/nftkMKZ
	 h4/55vlTiwdi0jYIJNidS5gECI5RC0rIiOZjyHSGm/NonZYXuGRnrlZRLwbiDXL0l1
	 dPYQIej8dN70g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC59380AA54;
	Wed,  5 Nov 2025 01:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gtp: Fix a typo error for size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230501749.3047110.8432950785737055135.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:10:17 +0000
References: <20251103060504.3524-1-chuguangqing@inspur.com>
In-Reply-To: <20251103060504.3524-1-chuguangqing@inspur.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 14:05:04 +0800 you wrote:
> Fix the spelling error of "size".
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/gtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - gtp: Fix a typo error for size
    https://git.kernel.org/netdev/net-next/c/2428803d5eef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



