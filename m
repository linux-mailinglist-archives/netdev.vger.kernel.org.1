Return-Path: <netdev+bounces-122222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B909960689
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1B31C228FC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F6A199221;
	Tue, 27 Aug 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbQEXGbf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC60156C40
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752830; cv=none; b=TTOvc0T2pz3ZDvBXzVicwS1DYkgkP6MigP0YIgQ7Ua3u0k07sZ/6kBUQpbOVdrJY70fHkBvxrV14rpzws9OxMr0BZ1EpfV6DP+VPHc49/GsY+Aw+kRNYONeQl/aptLPfYHiB5+Wvt3Qeq7WKGti8/Iqlxu4hdJZAJpLXeRy+9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752830; c=relaxed/simple;
	bh=1PZuF9R4xkPnaGSbBc71oOmfyKssAqZwwUfht5/7CYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U4pgle2iPvsCXBfPzbrzBUwk2oJcpv4CmcQ7d87qlIvkbHkk3g3s4NKcJKsC9GfZL6T7C0tGmYY95IkyPwa4NIr1t1rEEwtMGv4NEvoCTYHQiwF6FXVIlGWiNHjMKv5vahN0mECJUoE7aVX4OIc8QvnAiSOdLXLma9CKmMPn0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbQEXGbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CC0C8B7A8;
	Tue, 27 Aug 2024 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724752829;
	bh=1PZuF9R4xkPnaGSbBc71oOmfyKssAqZwwUfht5/7CYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbQEXGbf0M/3UIqgvadJ8DmSG5g7sNjCkS2li9/lpW0PjX2r3O/lp+oR90jn4Qiy5
	 m1gMMq5PV+GkZ8Wk1LxtinE3clBYqmgCJaQQ4AMwsbINJKOEAgF2PwteCPZ/ZXyELT
	 XUzPYJ4JuiPJJPcfGkCgNveSZXaqJXI9Qoq8KUc6YCUQ79fUACod2Vv7oPr73aLJDE
	 aBtwbdcVFAP6OB6fYM5KUl1+lO9DdYpvZk+lzTzGq9CSNzDTO82XUEE8aq2leTzvuf
	 YDxj+4zoS1JJhIWB7cdMe40aujmm5iCKCE7Lv//8evrZz0HsS00ldybcVw5I8nc/J8
	 072m2YD+DNhtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE7A3822D6D;
	Tue, 27 Aug 2024 10:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] tc: adjust network header after 2nd vlan push
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172475282976.574013.8467556089733967730.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 10:00:29 +0000
References: <20240822103510.468293-1-boris.sukholitko@broadcom.com>
In-Reply-To: <20240822103510.468293-1-boris.sukholitko@broadcom.com>
To: Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
 john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pshelar@ovn.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, willemb@google.com,
 asml.silence@gmail.com, almasrymina@google.com, lorenzo@kernel.org,
 bigeasy@linutronix.de, dhowells@redhat.com, liangchen.linux@gmail.com,
 aleksander.lobakin@intel.com, linux@weissschuh.net, idosch@idosch.org,
 ilya.lifshits@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 Aug 2024 13:35:07 +0300 you wrote:
> <tldr>
> skb network header of the single-tagged vlan packet continues to point the
> vlan payload (e.g. IP) after second vlan tag is pushed by tc act_vlan. This
> causes problem at the dissector which expects double-tagged packet network
> header to point to the inner vlan.
> 
> The fix is to adjust network header in tcf_act_vlan.c but requires
> refactoring of skb_vlan_push function.
> </tldr>
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] tc: adjust network header after 2nd vlan push
    https://git.kernel.org/netdev/net-next/c/938863727076
  - [net-next,v4,2/3] selftests: tc_actions: test ingress 2nd vlan push
    https://git.kernel.org/netdev/net-next/c/59c330eccee8
  - [net-next,v4,3/3] selftests: tc_actions: test egress 2nd vlan push
    https://git.kernel.org/netdev/net-next/c/2da44703a544

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



