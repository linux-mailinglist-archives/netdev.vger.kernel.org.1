Return-Path: <netdev+bounces-177250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D97A6E697
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30C51897701
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9381F0980;
	Mon, 24 Mar 2025 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcmcIK2j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7961EF0AE;
	Mon, 24 Mar 2025 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855400; cv=none; b=rZFFbfd8SHuZwa5R89DSFZF5nGW1JA3q96IOYwFZswV5xMyyav8YZeHmrNbpxs/mrIyP2hvCI1YUK7YLY85xlW+4AbmhCwc45myqWnTCPP2N89TkHyT+b+HVzcDEshJ1m7ZZZPrxQPpF6bWOP2tWSwRjszTTmtww3du2CgXyx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855400; c=relaxed/simple;
	bh=X4EfX9qgWirtka/bFgHfRiyMAueVgKbaWpo+MPYkdiU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NvTbsPRZi/BafSNn681NSCVQcB0fwO5q+k9sxq/ME8/D+ywzwMiRe7IRpet9NMz98tA2zp8CoBNVMRCOsHLwzZIsonSgH6kWeqF4KSuchmYoNhNTHtC+AMauSxT8PyziITsM0nyuoxLXzlcTwCZ2J2dPE4I9LN7UksST8/oQQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcmcIK2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04865C4CEDD;
	Mon, 24 Mar 2025 22:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742855400;
	bh=X4EfX9qgWirtka/bFgHfRiyMAueVgKbaWpo+MPYkdiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lcmcIK2jNzYdsH+BSbQCJttCQL9SAqZQXstez+5CVh8GSqGgVhGRz41MZC6AihvKN
	 05bt5y2/6w8vcvWsr0+eKWpnrhf8sj2B2DW9lWakhjrX1KiZhj6MA8o2SFrBqCKTEp
	 ko/IlB4bVrC8mzSYC1KqDBruoyZ1ZgGjQyd842LvTuEEy9gTG4pgbA5Jb+HgmBVj1b
	 fw2R6sWpJ2kYuP+4LLRRGiotaKMNExX5+vkx3q2eOYULHG2KK2XcGGeuDyxSlm6yin
	 PdTC27maueQRb3AQugfS4Q0nIhPH2IuVaQ6XwC5dmLaLOSBSJqP0umysssQFmJYaTJ
	 8NLa0XotgbtBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714E4380664F;
	Mon, 24 Mar 2025 22:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] mlxsw: spectrum_acl_bloom_filter: Workaround for some
 LLVM versions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174285543614.6006.9338081656329375744.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 22:30:36 +0000
References: <A1858F1D36E653E0+20250318103654.708077-1-wangyuli@uniontech.com>
In-Reply-To: <A1858F1D36E653E0+20250318103654.708077-1-wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, czj2441@163.com,
 zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 18:36:54 +0800 you wrote:
> This is a workaround to mitigate a compiler anomaly.
> 
> During LLVM toolchain compilation of this driver on s390x architecture, an
> unreasonable __write_overflow_field warning occurs.
> 
> Contextually, chunk_index is restricted to 0, 1 or 2. By expanding these
> possibilities, the compile warning is suppressed.
> 
> [...]

Here is the summary with links:
  - [net,v3] mlxsw: spectrum_acl_bloom_filter: Workaround for some LLVM versions
    https://git.kernel.org/netdev/net/c/4af9939a4977

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



