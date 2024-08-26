Return-Path: <netdev+bounces-121825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69695ED84
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8320D1F2107E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D81C14375D;
	Mon, 26 Aug 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAnXSIUW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020C29A2;
	Mon, 26 Aug 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665229; cv=none; b=hgv/YqC7VwlC2POQNTuIhd/IiPP0SH+qnptzLEY6T004b9Uxt9UWNJZMJVBLzFWT1wvaHRh8fe5MfR7HcWtEfQ6gFTTdWXvjTHkmirnoqcBpGhtMeYMqiggaeqRqcvtyJq+H5bkR/soHIpHxFbA0TjYt0O8zgHZw50QytcBmnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665229; c=relaxed/simple;
	bh=zoQTpjZ/kfoCrrvulN+2vY+bZNbMRmN/zamfZeSFnjg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bdlWH4iQJflxCb0HPuoslmEanFL6kT29jq3Hnv5xmnolzhvLgPkjA8m10naKGtFO1YjDGYvsgf6yaiNppcRAgF9mfGrEw6u8YGUvzD/Oez0LSOR0lX48KRtrnUJtzpuW588zovPo/Xv1W8ZumtDdYw9eY5xM2ReliS2JiQqqmr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAnXSIUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79849C51410;
	Mon, 26 Aug 2024 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724665228;
	bh=zoQTpjZ/kfoCrrvulN+2vY+bZNbMRmN/zamfZeSFnjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BAnXSIUWQK9Qk4r6ZsQ3HxssN+/CgJrPiqfTBh0Job8Im/bidDZjKe6SM4q+L7EJ6
	 96FoXK4D1irDvOL5AA5dKEH4M0xzzaXEHWSHUfWg102yIWts7c5PsUxchUG/8/T3cm
	 x5WAmJrUAg908tR+ZFd4HcSxSqeLL0DOFb3xxE+UHs+QyLXjGEUpaSx6hmZfbBeHO+
	 qEu8VeC/KCFpG/39t+sAgut+XHS54sI5h+r+L7PE+vz0lQ3J/9JOtunMN3vnZ/S+dg
	 T8fHJRH45E8grpp0AKH93MiATfv0RD/BJaqcetx/oTjN1t+QWK6LeQQBbYKhsOIWD5
	 r6T1owep0ZvBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE124383BAC1;
	Mon, 26 Aug 2024 09:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netlink: Remove the dump_cb_mutex field from
 struct netlink_sock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172466522733.3853017.7184168867429321948.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 09:40:27 +0000
References: <c15ce0846e0aed6f342d85f36092c386c6148d00.1724309198.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <c15ce0846e0aed6f342d85f36092c386c6148d00.1724309198.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 22 Aug 2024 09:03:20 +0200 you wrote:
> Commit 5fbf57a937f4 ("net: netlink: remove the cb_mutex "injection" from
> netlink core") has removed the usage of the 'dump_cb_mutex' field from the
> struct netlink_sock.
> 
> Remove the field itself now. It saves a few bytes in the structure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - [net-next] net: netlink: Remove the dump_cb_mutex field from struct netlink_sock
    https://git.kernel.org/netdev/net-next/c/18aaa82bd36a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



