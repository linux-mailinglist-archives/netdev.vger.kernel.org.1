Return-Path: <netdev+bounces-219740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6517B42D6B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC85E7ADAEF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717102F1FC4;
	Wed,  3 Sep 2025 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAI0FHwS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA592EF640
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942203; cv=none; b=SvC/f7vQKMXX9xAlFnliEW9d5SwsYiuRRF0x0CpByyleeW6nAC6C+Dw8WiWAu1opMuISO5S+D/DlO8w9YtiVSsMFx4PD2rV2DZCjvijJ/KnRyo8AxFBehZEYZWMcjzBeupIef+u3IbLWHTWD+vDS+AuFM9se/de+RqAM1KgNGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942203; c=relaxed/simple;
	bh=oYB3rUgj3jXn0dJZFL0NY+LO6zl926frHqB4mtsmvoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y2/9TZXxJ5cVdv2t2X2zEt+o/2FCoCDrtImsxfCp/43r9AQ9kA5jslIVdyK/pLZoge9M8r07ocuZpYd3ReT28cC63ZH6aS/HyIwC7AZES3GIT9gbdQHYZ/I0Dy8fP/Vy62n+7LJuZ/hpAXwduY+dwmrNWn0ZO6Y2vaUuJNcz9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAI0FHwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DC4C4CEE7;
	Wed,  3 Sep 2025 23:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756942201;
	bh=oYB3rUgj3jXn0dJZFL0NY+LO6zl926frHqB4mtsmvoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aAI0FHwSYTYDMKSTEKYWr7lHd/Q+1i0jGnmmMngBwUTmnRbXKoKIBKPyYqMp7ntYp
	 gpOTfW4e33c5vZXHZAkzNHNu28F11PnBKYm6KJcPwgHkAU93fy8JlSePUmGW3GyamA
	 cagA0HgKsJQvxsO8Flz0TK4R45C9aCEPyip8P0sk5GcUWKtWAcS20pKh6yYnT1qfLx
	 uovHYvE1wT8fB7o0yrE2Nb7MGM+kYcwgnRZ+HXVfYDrBy0sK/IqyTCpQm/3Dk7N0Oc
	 MB5TglkThB+2JT0/szzSYdKeUTHGkBxgVSjECt9L7tzPGpUUdBhPSNbe8ixcgK7FBr
	 mzbiZvMeUbMCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02E383C259;
	Wed,  3 Sep 2025 23:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lockless sock_i_ino()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694220676.1235396.7767842725308218319.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 23:30:06 +0000
References: <20250902183603.740428-1-edumazet@google.com>
In-Reply-To: <20250902183603.740428-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com, bigeasy@linutronix.de,
 kuniyu@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Sep 2025 18:36:03 +0000 you wrote:
> Followup of commit c51da3f7a161 ("net: remove sock_i_uid()")
> 
> A recent syzbot report was the trigger for this change.
> 
> Over the years, we had many problems caused by the
> read_lock[_bh](&sk->sk_callback_lock) in sock_i_uid().
> 
> [...]

Here is the summary with links:
  - [net] net: lockless sock_i_ino()
    https://git.kernel.org/netdev/net/c/5d6b58c932ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



