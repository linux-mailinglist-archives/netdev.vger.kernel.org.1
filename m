Return-Path: <netdev+bounces-239810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4A9C6C958
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C9C34F0D66
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64782D12F5;
	Wed, 19 Nov 2025 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh3OpeHF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35622D4E9
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522445; cv=none; b=GU2oE4DXNmNiEsmwlTvJoA3DBF8B97Dzng8BGHgqNE7O+XjhoxGk5U++jt3OkG3bNAe1GyzOokO9/TBGvjerUhlb0AKZHRcpK+kZ6Hqhwo/A3EGc2cuShn9sUQQdy0WRLW1p84nOXfeaPRkXn2Dp05P9RvAPjsqRBb0gkA/haHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522445; c=relaxed/simple;
	bh=Iy+pAYYczLncXEiN4CdvzIIP9olksYVR1RsGX3O1jTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nO9zl5pdsanF91Xacw7ktgdgjY4d/OgsI/a42paWLAe7SaWieyd0DtRWhrcTTgTzvi5wKPflDBYtV/AzPeuj/TubCh39dsudgqKuDqb3ooxDb5hqMQOj/499hdJD+f4bmlYRrzQLXmyR9oqRvYOi2vK11u0sbgVxDD9jdfuW11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh3OpeHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC93C2BCB4;
	Wed, 19 Nov 2025 03:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763522444;
	bh=Iy+pAYYczLncXEiN4CdvzIIP9olksYVR1RsGX3O1jTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jh3OpeHFfuFZOMPKTzTqFLCWTC52fQ5OenGhlNJdDhn/fgzWA8Dr+5WxX5ro+TwP/
	 xFZc0Rj1PbNPoUkjqV3fkLf2qNJoKM/YqtPYdSLlzcJxb7Y56KbFlPgA9PakPlq1QK
	 tRKSF9rB3vyFe5zNDuCrZgqdYLe0M/9aAp3FiiahjYh2YMW4xPM3JP8DaLLypGs9Fq
	 EgXvq3mBqwh6cC10vM/LMV/X8zaa+o8QC7Of9I43K89IVV6qTXVcK5lrBaV8MMpaYA
	 tBGv6QlOPgZ71h6Rd7cd1+v8tAoLUvoGTsekKDMdjo7bFApDidXFbpP9ucX3uzqpaC
	 NgQL1BNE/FRVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FA6380A954;
	Wed, 19 Nov 2025 03:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] mptcp: fix a race in mptcp_pm_del_add_timer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176352240889.205878.7139998360016920447.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 03:20:08 +0000
References: <20251117100745.1913963-1-edumazet@google.com>
In-Reply-To: <20251117100745.1913963-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 matttbe@kernel.org, martineau@kernel.org, geliang.tang@linux.dev,
 fw@strlen.de, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com, geliang@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Nov 2025 10:07:44 +0000 you wrote:
> mptcp_pm_del_add_timer() can call sk_stop_timer_sync(sk, &entry->add_timer)
> while another might have free entry already, as reported by syzbot.
> 
> Add RCU protection to fix this issue.
> 
> Also change confusing add_timer variable with stop_timer boolean.
> 
> [...]

Here is the summary with links:
  - [v2,net] mptcp: fix a race in mptcp_pm_del_add_timer()
    https://git.kernel.org/netdev/net/c/426358d9be7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



