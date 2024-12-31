Return-Path: <netdev+bounces-154609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1ED9FEC57
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 03:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5F77A15DA
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ED613D52B;
	Tue, 31 Dec 2024 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX8BGjuI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20AF13C918;
	Tue, 31 Dec 2024 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735611011; cv=none; b=rp4v8pqeEc95Pc5q56evSMmqyXrlzbowx/CLlvJ29gQ+vE6x8i83dFEMUP+ss7KK7o2LV37hkku/gtHoFtHebl4Dkai/ZyX5jrucx2PjD/hAQ/HUUy7FZ5MYn0QYgm4WhbWFuloPFsJKuIUT//kzqUbGQsA/VNz7Up+V40+hAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735611011; c=relaxed/simple;
	bh=uACa4budD4RS8hP+CAygN8N3iO9gZnbLK8aHPZ2ufUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T8szGcEpKDytQHiBuV/Qr6F6ywH0us2spWl2ebXATUzD4sovdQE4XuEmNjy81afOFrFgoOUi886XEz5C9XlWPj5Y0kjQF2aNj89OXCmpMa9yZw+7rvDAygN3bzeOFAYKoYqE2sKq7PxZcy1m3a6Ugpy3bEF0IxGXObiD9Pp36z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX8BGjuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9EAC4AF09;
	Tue, 31 Dec 2024 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735611011;
	bh=uACa4budD4RS8hP+CAygN8N3iO9gZnbLK8aHPZ2ufUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kX8BGjuInzd+SfIEQNfwuCZBccnrLB04HKbzWsYEXgnO6CE2iGzZNuetr8EEumPDA
	 IwwaYNni15nUiM58igGW8ius69E8HQLV4ueRGuuYGkvitk6oDEHBi4ocue+o862TuU
	 JKXTX4tQAYSRW4QQsnlDpV0LL0vk/oCzCWdVjHfdKM0/S7kfHNMl16d2H2iHaTq2JA
	 k8j84JGcVIb5r2jiS4f/7rqLxOTsWr7ZgpOo79Hc0i/v80pFeSo6zc6/pzerm/JF/P
	 FJxOcp/YlKBbWGpyAmpbN6W/7enOfmuYH7n4BTw7jKkyBlW+t1jTBVj+TGvVJ19rkr
	 f96wOmjg2tzqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9D380A964;
	Tue, 31 Dec 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v3] net: wwan: t7xx: Fix FSM command timeout issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173561103149.1487469.7896899204540542630.git-patchwork-notify@kernel.org>
Date: Tue, 31 Dec 2024 02:10:31 +0000
References: <20241224041552.8711-1-jinjian.song@fibocom.com>
In-Reply-To: <20241224041552.8711-1-jinjian.song@fibocom.com>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com, corbet@lwn.net,
 linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, korneld@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Dec 2024 12:15:52 +0800 you wrote:
> When driver processes the internal state change command, it use an
> asynchronous thread to process the command operation. If the main
> thread detects that the task has timed out, the asynchronous thread
> will panic when executing the completion notification because the
> main thread completion object has been released.
> 
> BUG: unable to handle page fault for address: fffffffffffffff8
> PGD 1f283a067 P4D 1f283a067 PUD 1f283c067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> RIP: 0010:complete_all+0x3e/0xa0
> [...]
> Call Trace:
>  <TASK>
>  ? __die_body+0x68/0xb0
>  ? page_fault_oops+0x379/0x3e0
>  ? exc_page_fault+0x69/0xa0
>  ? asm_exc_page_fault+0x22/0x30
>  ? complete_all+0x3e/0xa0
>  fsm_main_thread+0xa3/0x9c0 [mtk_t7xx (HASH:1400 5)]
>  ? __pfx_autoremove_wake_function+0x10/0x10
>  kthread+0xd8/0x110
>  ? __pfx_fsm_main_thread+0x10/0x10 [mtk_t7xx (HASH:1400 5)]
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x38/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> [...]
> CR2: fffffffffffffff8
> 
> [...]

Here is the summary with links:
  - [net,v3] net: wwan: t7xx: Fix FSM command timeout issue
    https://git.kernel.org/netdev/net/c/4f619d518db9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



