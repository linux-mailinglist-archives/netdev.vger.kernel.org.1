Return-Path: <netdev+bounces-161208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FDFA2008E
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6D0161E6E
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7891DC997;
	Mon, 27 Jan 2025 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btz07TZM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D71B532F;
	Mon, 27 Jan 2025 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017010; cv=none; b=jEluoh/fk8jGpTFhDMYkVKMeWhq9QOgFmSJM8iuNySSpmyuk5funOuzICHgTUWCZsaE4zNxYdeRIWPiG8BqbaITcVO2taCXkvDbxTF2uq8oVHq9ymw3DKbvYkLnfWSKGOa7TWM0xb+1dLKFlHcgF4DngJ1MlAYmZT2TFrbQ4m7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017010; c=relaxed/simple;
	bh=uVyF+iM8txokJz+INAukJ3y0f8c/h/7FwFDcbNVg82s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QEFVel4gXztgIN1KWy3iqJw9MlmDI4QBiEvYxhkc4b1IjEUeZIMwvNVoEvjkRnnPvI2J7cBNDaWGeVrlV7RYCgcCdABGULanaOMEtZnBFO/nzpVUMZUU4Sps5vQ2XCQvSAjhBVHr2kEXlhQKzwvb+qPc7877f2KUSgo6pwErmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btz07TZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE89C4CED2;
	Mon, 27 Jan 2025 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017009;
	bh=uVyF+iM8txokJz+INAukJ3y0f8c/h/7FwFDcbNVg82s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=btz07TZMw15++T/MdHPpu3V0DBVpl1/w1oBwMsbtwOzifV7hKMSKpY1iIRnq6Mzwt
	 +qekfsLB/U9LnzlqxIvuzdGQLfWltOUgVQo/zOJRaOlnrLlkAglvAs1f5ZRDzbKDsj
	 ptIatjhGgsgi9HQLStLyUKzmlF1HaLEbk2+HWQ2dNKcXQ5QqbVOtzvNkwxBjMPwhPh
	 WZzz/r9QHAbZpS1jukdkIRa9rwkL2f3mUaHzxH1mEwOOZ3VotEsu1paHuWTuVgJ7XZ
	 i9wN5yHxEzGFsBPvxOx5GeVf/vj/uYL5qdQAHr5R04JZuL+UEza5R5cS2ztSwTRzg9
	 UfF2VwFEdq/LA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7202C380AA63;
	Mon, 27 Jan 2025 22:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: the appletalk subsystem no longer uses
 ndo_do_ioctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801703523.3242514.9823171949879631193.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 22:30:35 +0000
References: <tencent_4AC6ED413FEA8116B4253D3ED6947FDBCF08@qq.com>
In-Reply-To: <tencent_4AC6ED413FEA8116B4253D3ED6947FDBCF08@qq.com>
To: XIE Zhibang <Yeking@red54.com>
Cc: netdev@vger.kernel.org, Yeking@Red54.com, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jan 2025 11:57:03 +0000 you wrote:
> From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> 
> ndo_do_ioctl is no longer used by the appletalk subsystem after commit
> 45bd1c5ba758 ("net: appletalk: Drop aarp_send_probe_phase1()").
> 
> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: the appletalk subsystem no longer uses ndo_do_ioctl
    https://git.kernel.org/netdev/net/c/09ebd028d6d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



