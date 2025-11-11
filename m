Return-Path: <netdev+bounces-237645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A457C4E543
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8C33B4C52
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB00342528;
	Tue, 11 Nov 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fExFan+R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77D341678;
	Tue, 11 Nov 2025 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870247; cv=none; b=je4X7fQMmv+qRyU56TP3SlxxXHkv+e21LSmwJ3qXqnJpIHNduHjuQ+iXlJDjcpj/o8fCXBImVk7ftPN5rgV9nJwNKSdDe8sooJwERxI4YrjTZGUJKkACvOi0r3vSzQ7bVofh9mncR4/7DuKYMZ6xetpopJb66mtZzwH1DVSYlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870247; c=relaxed/simple;
	bh=AMwr8pk0zm8H2SuijsXtu51hQ2CfQt6DuQAHmonpzi8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KMy+5H0wle8qCFV3KVXZ/LR6dJUUsWyKVNuovWEb9ECleH1F5Kd8A0xC7Uup+7JS37niuTMZeLYL0rpY03ONbRH+QXEs4m9Nd1cAEJefxglG6oo+U2z+4TFwYMpCxuuX/h9Zh+v6s7pQwqzlUXQk2PQAD7Izenlms6Zd7jCoRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fExFan+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703E8C19421;
	Tue, 11 Nov 2025 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870246;
	bh=AMwr8pk0zm8H2SuijsXtu51hQ2CfQt6DuQAHmonpzi8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fExFan+RQkgrFFg7ZaPt95NgCFkXSkL9hseHWN9g9+JAKFmLiulIwyQkuBG89GcdY
	 4vHdDDMbk3sYu35ShvCK/c9Z2sN+uEzIV6KgeUUX+4CdYI3+LzwvYxXqJn543hU2sb
	 HFTEkoOomtgA2PPwxyDcj6F1TALSA1umHlqLruYKATF4uzRBz1X26r91dX9YPLtbzt
	 fZUpneMcwRj/xVlhgIE2C9La51OfjsrML2eXtH/+wxvaTp8zhaq58HPCD9Ep2YiG6/
	 hEjoCrXO/bRTCqiMfSW8U3NuVWuoe8U/jKC4GxGj8dV0T00cFBWygYg+A2OSCr8BFw
	 GMwEwKlotv+Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB017380CFFB;
	Tue, 11 Nov 2025 14:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net 0/2] net: sched: initialize struct tc_ife to fix
 kernel-infoleak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176287021649.3454241.10927980913848832965.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 14:10:16 +0000
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
In-Reply-To: <20251109091336.9277-1-vnranganath.20@gmail.com>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, david.hunter.linux@gmail.com,
 horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, khalid@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  9 Nov 2025 14:43:34 +0530 you wrote:
> This series addresses the uninitialization of the struct which has
> 2 bytes of padding. And copying this uninitialized data to userspace
> can leak info from kernel memory.
> 
> This series ensures all members and padding are cleared prior to
> begin copied.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
    https://git.kernel.org/netdev/net/c/62b656e43eae
  - [net,v4,2/2] net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
    https://git.kernel.org/netdev/net/c/ce50039be49e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



