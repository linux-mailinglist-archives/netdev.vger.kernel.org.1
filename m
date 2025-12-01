Return-Path: <netdev+bounces-243068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2278DC9926B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9430B3A4663
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C7288C2D;
	Mon,  1 Dec 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1BH/00A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7539288530
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623599; cv=none; b=pOWhiHiKeXjOhXaeXWr8ti6z8gLI792wdclFC59Vpncm63SBcLcnedq+X7rzbZBudD+A5pPyu8ssFdntNsMlHFoOCluis/Oe0KCDtiIydYOQlIqQNEbgPXuQQFb/0DXdWPJVLNFpG/qH2uO34/mG5jN0njif9EKf+YilJ5QbTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623599; c=relaxed/simple;
	bh=ElsOcnCZPLLbT4KcM+sIwfo2YjOcJMZnDXDsgSF/OeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JwC+Pj0sEOfKdCXCeetChrDKADc8H+aAo984aA+wpuIPx+3sRyRLvEtIoitk5QRFmWS7GYOXgcLvq/e01LyshLORQtCy1pIQ/L2U2i55//AVfSrSLLfUbWS1aqiKgKRI0YBX+YZxhHJhfb9pYVOdmr3PPlAovxoDRqf7L02zNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1BH/00A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D78C4CEF1;
	Mon,  1 Dec 2025 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764623598;
	bh=ElsOcnCZPLLbT4KcM+sIwfo2YjOcJMZnDXDsgSF/OeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J1BH/00AByLmDPsRbikhQwW/kl3zWglUhtP8f6UQMMI8qZL+SvteH6MxIITCW1IjX
	 w1xiuqX4RfCiQ8kSeEybYGnhObMtumVEzAKM22MJCdp0+GfPCKimsFiG8WWK/Dq8+N
	 sLyNwv5vPCgg3y1jbW1mWDPsV2Ev0tChd329lCCIYfy/FVxxD4m0En1lsv0kJKcXDW
	 5hvup4zMKZRnBFgsnCo6X8ZXvJ/Q6yaZI/CYJLoN3VO9phSIF6PLEh5zJMZh0Us93l
	 QnTSIbAqMfZCYDfAavBgVLwURSiqOzGTywiyPi8AYwp15wae8No4KUtuPM90t0wMyO
	 SRhXmrvg7mv5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5E16381196A;
	Mon,  1 Dec 2025 21:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] l2tp: correct debugfs label for tunnel tx stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462341853.2539359.12042081372728246909.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 21:10:18 +0000
References: <20251128085300.3377210-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251128085300.3377210-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Nov 2025 00:52:57 -0800 you wrote:
> l2tp_dfs_seq_tunnel_show prints two groups of tunnel statistics. The
> first group reports transmit counters, but the code labels it as rx.
> Set the label to "tx" so the debugfs output reflects the actual meaning.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  net/l2tp/l2tp_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] l2tp: correct debugfs label for tunnel tx stats
    https://git.kernel.org/netdev/net-next/c/09339d0d8310

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



