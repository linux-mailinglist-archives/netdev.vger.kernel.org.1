Return-Path: <netdev+bounces-251297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E29D3B857
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5FF930239FE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CA12DF145;
	Mon, 19 Jan 2026 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVug9K0/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A32DC77F;
	Mon, 19 Jan 2026 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854616; cv=none; b=bpHgEvpx5DdaO7UjQLmMnoepXMUMxRYSlRz4dvLvcQdstbnqeCudIZKiUC5YSdynYJ+akJXWyzdVzt6VV+byqSkxvOiF1uhPYBXzcFoPOPFGVWXuyte7tG0oj7UMBaOWrZ3qaa/Rk0M8hGeVg+4TJci4NJ02/DiklFrGD+sw418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854616; c=relaxed/simple;
	bh=ydzjBvmnKdzIvzUyQo/qJIzP4lAWUJ+KR/umVPvkwFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q21Zrjl0X2YTMeGgCFe+nov53jvFZap00wqk/k5AqEljyCZUyovR66Fyy+5KZdkaa1mjVWTvl1f+bMoB+ia0n5a/I0SVl5jNXk6sPldaHmficec8+bpn/6iXG98WEXK+qMlw8EsK03Qo8DZP/Xsd0idQLOF7smXkslUDQZ1BmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVug9K0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE42C19422;
	Mon, 19 Jan 2026 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768854616;
	bh=ydzjBvmnKdzIvzUyQo/qJIzP4lAWUJ+KR/umVPvkwFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EVug9K0/av5P4uqrxmpRVf6R+mJ5QvaTBEHEokZpTBjlFkl8IwqcmprZUJ7Emsjkc
	 CM7fBDCcEMq3qvm3WbNdHEy0YFbHX3dmBk33Afe5ArRSUECFL5DufPiixHPcRiPBsg
	 UdufJzboJ5DXX3fIcBQKFCO0Ygh7xou4iKVuZ8P91SZRzkSsYxnpNliBfcYm5FY0HY
	 Vd4vTEXbkyUPkq+R3n0mGpqw3bIWOuqyHdAfZe1WO4aQAWeP2y66oAmVGPkdXEYLlw
	 20VdDtTOrEr+mCtEz1EXbjDQzAtoFFEYxX2Lk1Kco3/qw4CT5b/kBuNKeF6vslGDi3
	 AA1ULMtktXvMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B8F983806907;
	Mon, 19 Jan 2026 20:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] octeon_ep: reset firmware ready status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176885461428.126985.6504890946393399736.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 20:30:14 +0000
References: <20260115092048.870237-1-vimleshk@marvell.com>
In-Reply-To: <20260115092048.870237-1-vimleshk@marvell.com>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sedara@marvell.com,
 srasheed@marvell.com, hgani@marvell.com, vburru@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jan 2026 09:20:47 +0000 you wrote:
> Add support to reset firmware ready status
> when the driver is removed(either in unload
> or unbind)
> 
> Signed-off-by: Sathesh Edara <sedara@marvell.com>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v4] octeon_ep: reset firmware ready status
    https://git.kernel.org/netdev/net-next/c/3b85d5f8562c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



