Return-Path: <netdev+bounces-19331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BB75A4F2
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E121C212A6
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D5E1FC9;
	Thu, 20 Jul 2023 04:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75C717E9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EB8BC433CA;
	Thu, 20 Jul 2023 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689825622;
	bh=Asw33ccJGt+82XG4DwTLLFE/7jX9zPKbdust7yp+7zo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T82iKtVh2/i6QbhxfzzhypcrFBwq6I4+pUDf3qD4BugGzMEhLOFAkh4XuryqIaHKO
	 5PtMH/12pLabp95FXlLv6ixoT4Wx2Cp50Yx+cONhno+Jv1CrpuEKbiznlhKFYrnTmM
	 6pBIhUbrzNTVF/Te3c5vQy0X1IXp6XQ4o6HoYAG2WLWU6jZpfqAPzEbVSK2LDBbQhl
	 ChnIIS7mPDVdGdhB+1/fN5SDnsTzmcQlBfVtHS0fTbVH5K/CCTDb7SpnVgRvQkYWZ2
	 kpNrr6hF3zHDc5lMfM6NNb1bAMEer1Bvqwze3pLlCKaxuifl1sYf138y9DpNc+e1wN
	 UEZgA+dPKQ1sA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDB11E21EFE;
	Thu, 20 Jul 2023 04:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: add default 'input' for
 clock_in_out
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168982562196.4243.14007279822210402667.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 04:00:21 +0000
References: <20230718090914.282293-1-eugen.hristev@collabora.com>
In-Reply-To: <20230718090914.282293-1-eugen.hristev@collabora.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, david.wu@rock-chips.com, heiko@sntech.de,
 krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jul 2023 12:09:14 +0300 you wrote:
> 'clock_in_out' property is optional, and it can be one of two enums.
> The binding does not specify what is the behavior when the property is
> missing altogether.
> Hence, add a default value that the driver can use.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: rockchip-dwmac: add default 'input' for clock_in_out
    https://git.kernel.org/netdev/net-next/c/51318bf44395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



