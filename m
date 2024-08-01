Return-Path: <netdev+bounces-114784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D239440EB
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DBB1F283AF
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5013C67C;
	Thu,  1 Aug 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtxa7xyO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB953370;
	Thu,  1 Aug 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477632; cv=none; b=iwQEBBmxJ4YVXLByHj2APGt4hKMSlYkBnzz1v2fYBUd43AbJTm9cSpqum5/S1iQquGQqpagZr+t7rawUWoxajSxIzubf6LrDidYJodJ1l6vDYaBp8jbeyGX3i8vl1AOIefY/41gHkLpbNPtNLxQNQ33dYjuFLFU5X3oAyH0sQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477632; c=relaxed/simple;
	bh=c4VVDIrpQ49/Wu74qIadqShQnSJTNewMl4uUxXiIlhE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kl3HqQcm5YhbyYhAD69dAGDvb39nNmZn9EKePZGolDwwJis/L0T3XwsZI9uRTV6wuBd0VANVLmX1IPhvd2j/Wt/fWZI6wVyjMArN2YK2XpuxgEX+lPwOHSIfCAUTnxY1QXa8PiQxDB/rOBbsH32kMyk1+UjdkK5aPrqhnmmP9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtxa7xyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A28E8C4AF0B;
	Thu,  1 Aug 2024 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722477631;
	bh=c4VVDIrpQ49/Wu74qIadqShQnSJTNewMl4uUxXiIlhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qtxa7xyOzNv7CF4LEOHz+zbrvp4eKf44SX+iBmkP5YoI3FQGRLKFzZP+UqmxXGyVU
	 Ncsy3JerqzFe+wr8PzTeCz5QPcO8q7WQfELcIp891oY7Ryg+AFJueoqh/mZ75ucYj8
	 PvjTVrEpzJ0nbqdaCUW5nHR4JcnR2P5zTIfSR3GQKCf9g61XDUqSjmlojj4eulMz8I
	 WRwI2aESFCL+7PwOL/nWN2t6F8ZGzKTH2sOMwPwlaTBMCqirL5MNlqUFpQjIlidfai
	 E3wze513CUc6g9X3ug/OHUKOGb1VccA2Bi062dDpsnJdgqCQvmGAJZIdUPN+WFhWYV
	 jCnDKJDHxebuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9268EC4332F;
	Thu,  1 Aug 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: MAINTAINERS: Demote Qualcomm IPA to
 "maintained"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172247763159.18900.9912211459590082169.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 02:00:31 +0000
References: <20240730104016.22103-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240730104016.22103-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: elder@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 12:40:16 +0200 you wrote:
> To the best of my knowledge, Alex Elder is not being paid to support
> Qualcomm IPA networking drivers, so drop the status from "supported" to
> "maintained".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> [...]

Here is the summary with links:
  - [net-next] net: MAINTAINERS: Demote Qualcomm IPA to "maintained"
    https://git.kernel.org/netdev/net/c/4efce726e0cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



