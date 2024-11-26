Return-Path: <netdev+bounces-147383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23A39D9560
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DA8B2869E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757161C3023;
	Tue, 26 Nov 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1CI5tB+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49795195FEF;
	Tue, 26 Nov 2024 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616417; cv=none; b=iqKh3UEGztkGJfQ2b0zL+uVRqb5W8AEm9o095wSZxyyQK0okPnA3dGCH2xn2o5zJPicvKddfRUFpDZafIeDecj2HkusmwTTgbHmx71PtR/08w7nM01u3+5a63vfznn48plMKtT7gBndxX6Ymih2FKnugmZ2R0L/WJmz63X+9QdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616417; c=relaxed/simple;
	bh=GQw31RLRUC0dOJjRC3uzMgIMdxNwympXyufBxyCVd4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LEeRw74/iM1B8/44Bpe1A3vGSIpqGXih1D7cnnggrRmfyqYe3W7ZAUaxmZIEvnWD7uRlGGedDWYuLClnMLzIA18q4WarLaVlxfGgC1QN5vE/lsOAbnHwZB48+BjCGJ8NWWx1kdkY3++L3ZgKVt05EYygHczRjF01lJk/fMcZuac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1CI5tB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB742C4CECF;
	Tue, 26 Nov 2024 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732616416;
	bh=GQw31RLRUC0dOJjRC3uzMgIMdxNwympXyufBxyCVd4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e1CI5tB+jHCT7bZLbmJR3R6FDDco1yhk0W116jTTJ5G9R54PSMATdfITRPRcR9x++
	 oMGE9iV/HYbudj0boCG8IXS4JxNbdMdRG4BXYJd5Zzuu9Ratsk91wxytkkL2i4xKLZ
	 0hChVEXxiZYrd3dzcoMprkGtpkT60fLVg0fWEj7KVRz+A9PKMDAtYbTjSDEOFzPcGl
	 XeONl+/lxlPhmSbjOoBuKwJVXkbhGNR6crAY0+7mitDomsmz/SGt5jczTw5Pbszlwc
	 krjfW0P4eK1r7hfEHBT0HidGyveOHf4uICdGRFfKmTnbw9jlMOwrop06eSFLAuEO+i
	 nB8CjKxygvkPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9E3809A00;
	Tue, 26 Nov 2024 10:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] net: mdio-ipq4019: add missing error check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173261642953.338243.1552834819882094854.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 10:20:29 +0000
References: <20241121193152.8966-1-rosenp@gmail.com>
In-Reply-To: <20241121193152.8966-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, quic_luoj@quicinc.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 21 Nov 2024 11:31:52 -0800 you wrote:
> If an optional resource is found but fails to remap, return on failure.
> Avoids any potential problems when using the iomapped resource as the
> assumption is that it's available.
> 
> Fixes: 23a890d493e3 ("net: mdio: Add the reset function for IPQ MDIO driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] net: mdio-ipq4019: add missing error check
    https://git.kernel.org/netdev/net/c/9cc8d0ecdd2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



