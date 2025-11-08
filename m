Return-Path: <netdev+bounces-236943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FFDC4256E
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95F24E89E6
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36D2D3733;
	Sat,  8 Nov 2025 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2rK2lmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289AA2D29D9
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570859; cv=none; b=bfwibN3CuIvJhspjpSI46Tj/xh/mL+ehCu3HPxbGaWsoK4RhMRUII2tjSswmL5fN/DoAA+O12fIjGqFRzm3LR5eDMg7o/QCf+maekYZcf6h/h6lv8qzHrDDhndff9hjfc0MfWzVj9BFr12C9tXWQotH3x/0VCezyZ+4/MTrpwj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570859; c=relaxed/simple;
	bh=rZlVwWejjNz8tJOJ3iq5pAhNOMHk9Cv3r2GiUz8riEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VEEeJC/KF0aZmxGFKaF80uV4OD6zteNhmvvPVrLU212EquZ+59B2RQY7YZuZwsuJm1PmkT9ttdjDePxzvJz8Gjs0GAGJ9fWj4RkVMlcrkfWR/ZEtBu9BYTmSjw5rvY3Yy2mK9aqwY+vuyMzwaTgihVF3YBV8oUOFD4VLf+0Tbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2rK2lmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2E6C4CEF8;
	Sat,  8 Nov 2025 03:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762570858;
	bh=rZlVwWejjNz8tJOJ3iq5pAhNOMHk9Cv3r2GiUz8riEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A2rK2lmp9haCm4Q5SWWJSZnx78InBt8pO/UK7cqiCf11MD/REQk3Bri72JA/5XMCw
	 prGeghBHOcmXyduv/8TAyGk/WylMuvyL8Z8bVfgaV+RIKJ5bHJYO6rxUf5OF0SiyyQ
	 uxIhjm6OAQjSNKdJFIslDmU2xEo3+7AvtoKxPajvJxqU+ih1ajpk8aUKMeBsD20Rgq
	 mdiT0edJD8oFvT7rXMu6FICPilRkoBD8xCV4J5lxNNgwghs+lzwaajhWi6rSV3pMxX
	 VmRqRrCzBX4O+vQii+qZS0f0MYK8pmD7Vs10UB2hmmy7dAjaTHEVjlMwKecP+6wHJu
	 aJ0I2rBVOwBfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBFC3A40FCA;
	Sat,  8 Nov 2025 03:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257083024.1232193.11420274166835007060.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:00:30 +0000
References: <20251106115236.3450026-1-edumazet@google.com>
In-Reply-To: <20251106115236.3450026-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 11:52:36 +0000 you wrote:
> TCP SACK compression has been added in 2018 in commit
> 5d9f4262b7ea ("tcp: add SACK compression").
> 
> It is working great for WAN flows (with large RTT).
> Wifi in particular gets a significant boost _when_ ACK are suppressed.
> 
> Add a new sysctl so that we can tune the very conservative 5 % value
> that has been used so far in this formula, so that small RTT flows
> can benefit from this feature.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
    https://git.kernel.org/netdev/net-next/c/416dd649f3aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



