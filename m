Return-Path: <netdev+bounces-221500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE0B50A58
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F8A3A189B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30620C47C;
	Wed, 10 Sep 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJicyHIg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7114420487E;
	Wed, 10 Sep 2025 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468404; cv=none; b=O/AVcVeH/p/XdKs9iEh2ClSlu2RtxJde2+vOufYHmV23zS8LidilihN1vrHW2TA5dqoB3MCKEW0L4SihbwHDAwQf9U1EdgQ6msSyh4h7zZy9hF7dDzvjepQqUjoe5MXRc2RsQOoEimi1fxWcEd/1tgrgbQbPAYX1pCKMJvli+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468404; c=relaxed/simple;
	bh=v5RKLxiBynoVi6YHdwIwMbyIhGK9zRCHCKwCKgcyLBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cv0lGLRRJz9/fwZWOR9B9tfr1U+VFz0hSBgLpVEKAnYDYzB4DmyohMlaK6DYM2IDlG02qH+FKkn3cxUn5UCP05JLMXMbNsFm/fOyZ7JcQ8cFtw1QoTmOGGiKzlyy4uIQIK6pTPoCZW/gMpEUM9zwMPZMDaKGj0ksMCK7kFpkx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJicyHIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D834C4CEF4;
	Wed, 10 Sep 2025 01:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757468403;
	bh=v5RKLxiBynoVi6YHdwIwMbyIhGK9zRCHCKwCKgcyLBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lJicyHIgE1VEBdLPXGqTcGrgvNT983p19IN922VESnzdjtsFEX8JVFSJnKDVRpN9I
	 5YUlFEtdDiwFdnKW14KTb5rYpMKZQY8svFysf9WRfWhYpybpow5BWdQhRgZJnVIv7s
	 +cAJackXcBje0P5AnVg2H9HQtq31t2Wvauvk29JPhpQXeKeundC6I0OqFlsQAUuO+F
	 KYrqP0tKCUkqdD+UFRRFAOdxM7/oBL5TPu4vJTQGjS6AMtsh4LUU8zbkXa33gr9NDK
	 a5keWuhTL46qzBTh4rLFVhKkcPG+JrQ1P6GY8DoN5uRsLQ6I2ks7u4YpC5ZEZoUM+O
	 zpQofX/adDGzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B67383BF69;
	Wed, 10 Sep 2025 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macsec: sync features on RTM_NEWLINK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746840625.869185.11263601603353258984.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 01:40:06 +0000
References: <20250908173614.3358264-1-sdf@fomichev.me>
In-Reply-To: <20250908173614.3358264-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Sep 2025 10:36:14 -0700 you wrote:
> Syzkaller managed to lock the lower device via ETHTOOL_SFEATURES:
> 
>  netdev_lock include/linux/netdevice.h:2761 [inline]
>  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>  netdev_sync_lower_features net/core/dev.c:10649 [inline]
>  __netdev_update_features+0xcb1/0x1be0 net/core/dev.c:10819
>  netdev_update_features+0x6d/0xe0 net/core/dev.c:10876
>  macsec_notify+0x2f5/0x660 drivers/net/macsec.c:4533
>  notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
>  call_netdevice_notifiers net/core/dev.c:2281 [inline]
>  netdev_features_change+0x85/0xc0 net/core/dev.c:1570
>  __dev_ethtool net/ethtool/ioctl.c:3469 [inline]
>  dev_ethtool+0x1536/0x19b0 net/ethtool/ioctl.c:3502
>  dev_ioctl+0x392/0x1150 net/core/dev_ioctl.c:759
> 
> [...]

Here is the summary with links:
  - [net] macsec: sync features on RTM_NEWLINK
    https://git.kernel.org/netdev/net/c/0f82c3ba66c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



