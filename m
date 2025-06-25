Return-Path: <netdev+bounces-201344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D89AE912F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288894A519C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74E62F365C;
	Wed, 25 Jun 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIUNhuOA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF952F3651;
	Wed, 25 Jun 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891182; cv=none; b=PH3Ei5BDPKpHcfzZG2+j6idSsytxG2wbMGdn0E0p8Ic3Ub0L9WXproPZpgGfAqEzRGGdLr5FYgPEXltOiohhcNSNJ1O7UM+y8eLZDkceI20WSSkObGFjMsRBibrMzjkAVsEkjMNHGAgPRk+3L3XdHE3tdSjDrsA/q9oZn66lips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891182; c=relaxed/simple;
	bh=KflG/bFntSILaW2n864Y7HOxjPnyzNJWCHuKZyS8TIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ANMPVFUF5n05YwEYu/hLMSQe7GQbl+0zStfa2sqvcQajItRQp4I5eNsz8oi9ouDcZtx8+x3Bpu2IPIlpN73SAQKzIUbwyqeUS5jN7WY0AA1ARH8bsOtFnSj4l5oBYEwp9kqIVa3FPk8JVWkulmobmHReQojXM/2xl3WPzx5fwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIUNhuOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394C8C4CEF0;
	Wed, 25 Jun 2025 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891182;
	bh=KflG/bFntSILaW2n864Y7HOxjPnyzNJWCHuKZyS8TIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RIUNhuOAKQ9zgUbYtX0jCi38HEgaVk6OT0T/yjW3R/+WEEqAaDlCBxOE0gGGZzV9t
	 4G74o+imweSmw07p4yT7yU55RCnP9ixg7eXJiUyRCpeIJ1g+0DiF+2JFWCJm/VgWvS
	 2Nnvs3jZB0WNVJO5w+onI9A1ZNndtnAXEAnt89sUH/s1ET0w+Ayqgfhp7SYFZtYpxj
	 x8AaXR1/wz+jP72tV9UvJlMlMnSaNFfz7z+f1UkNUW6ksoFwmOkPCFAA+J1I6rmzLO
	 QDuY3S3QKSP6/mvoDfvdTGsTjf+stnEmTp+Ek7Y1SuETVQdBOdx/LeJmIGvE8thZsX
	 thHkHRbftmTbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3EB3A40FCB;
	Wed, 25 Jun 2025 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: Correct endianness handling in
 _enetc_rd_reg64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089120849.644002.10005432355573220641.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:40:08 +0000
References: <20250624-etnetc-le-v1-1-a73a95d96e4e@kernel.org>
In-Reply-To: <20250624-etnetc-le-v1-1-a73a95d96e4e@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alexandru.marginean@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 17:35:12 +0100 you wrote:
> enetc_hw.h provides two versions of _enetc_rd_reg64.
> One which simply calls ioread64() when available.
> And another that composes the 64-bit result from ioread32() calls.
> 
> In the second case the code appears to assume that each ioread32() call
> returns a little-endian value. However both the shift and logical or
> used to compose the return value would not work correctly on big endian
> systems if this were the case. Moreover, this is inconsistent with the
> first case where the return value of ioread64() is assumed to be in host
> byte order.
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: Correct endianness handling in _enetc_rd_reg64
    https://git.kernel.org/netdev/net/c/7b515f35a911

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



