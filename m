Return-Path: <netdev+bounces-153767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642CF9F9AAA
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2D31897981
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B68220680;
	Fri, 20 Dec 2024 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA6B3ZYu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF919ADBA
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724214; cv=none; b=s7FA8QrrG9OeCIvHhFBEHoax+by+SZwx/Ab+eUedq0VRtCZaXv2NYxhNtqbTuyr99/agliRZ6saUfVbe69wDlcIxz/1W4/86q0h1QyXFVx7eQPfT9EMG/n19gTFbSdmO68++3BBSjLw/yPGlEFZE7T3M2wVU2GUI0PkoyRQHD9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724214; c=relaxed/simple;
	bh=ycsUOo5wEQM/kvbKOKagEcRDFdW/JpjXtCwrZUSyceA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QxpJebvooUZ8JczCQHLFd6MG2KfV+MG3a3oxguL+AaepbPjv4ohlqi3zqLsmg9nF0L1ZgcOuHS0VyHf1WQfI1OCRj7zJK8BhVUFPHMyU+0NhY+10oKvYPDSNXXO/sqIvz/8MKcGVHRVhDwtlk3yZLBFH10zBCMWm2WBlaCKM6HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA6B3ZYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC09C4CECD;
	Fri, 20 Dec 2024 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734724214;
	bh=ycsUOo5wEQM/kvbKOKagEcRDFdW/JpjXtCwrZUSyceA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UA6B3ZYuOL3omY0Vrni5L/28yqqmHZX6uVVGLC0UEteOomQmHFuvNusFglqFIph34
	 1K8xNLh82kdShtTORLrgu4qpuvJt6zP61YeU5FVuQ6GdUnsb2VcVau3PMNTafsRwC/
	 TuSHnfkED7sGiruvygMWveVi1/9TpjSsxwQwMQGE8ZP7MpsdMGCaZse12Ml8RVk8A7
	 jgam3hpzHU1ajWEcHspM+pqHFLv3Qx5wCne6QmHxNqDrnnH+adomgcnn9rWfjrtUM8
	 QEv5KnnkTOY9GWfareNPth/aFauH/yt7k3vNyo3zFLgnpIk1iVRqJ4527gnKSWFrId
	 cJvgpKfFNTPvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 308943806656;
	Fri, 20 Dec 2024 19:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: local_termination: require mausezahn
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173472423202.3006698.10211382833526789869.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 19:50:32 +0000
References: <20241219155410.1856868-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241219155410.1856868-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, horms@kernel.org,
 shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 17:54:10 +0200 you wrote:
> Since the blamed commit, we require mausezahn because send_raw() uses it.
> Remove the "REQUIRE_MZ=no" line, which overwrites the default of requiring it.
> 
> Fixes: 237979504264 ("selftests: net: local_termination: add PTP frames to the mix")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  tools/testing/selftests/net/forwarding/local_termination.sh | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net] selftests: net: local_termination: require mausezahn
    https://git.kernel.org/netdev/net/c/246068b86b1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



