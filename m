Return-Path: <netdev+bounces-140592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4C9B71F4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B10285BD1
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779C84E11;
	Thu, 31 Oct 2024 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJCHmppk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039F84A57
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338240; cv=none; b=Z1UnOKkrMLdbjLHi3JWWE4KOnOYKIhfb5Qozkvcmq2C2TupZeu9no3HZgbdkRgPhBxpv6Bh1rYOS2QDvwsOk4BtRDJy/M2fX2uPekzsv/4qte/GmMaOSfY9El164GBSYc6SFsF6dwVD6t6s5n45Jpz3LLn8sw7/MElIVB2WiDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338240; c=relaxed/simple;
	bh=LutcBQWdVtxT1OGEiScZSrhXc7fNCGnqCvDL66Yqy3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S3pnb+H37cvz1KCDcT3epd7yF1TghHER7rUgESd5cCYuU/dg7pe9/YDXGTH9li7GUb5gpMqQaiwlbtgDbcjq22zFXsABUg/I8yJzAKFG5VZtefE8QcK3gzNxcJmbbOdCsq25EhiMgQVOz4wpsU/PvNdZDt/l5GFSNPKV4rjm9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJCHmppk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F14C4CECF;
	Thu, 31 Oct 2024 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730338238;
	bh=LutcBQWdVtxT1OGEiScZSrhXc7fNCGnqCvDL66Yqy3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oJCHmppknDS1F1OLdaMnwx1nY/9cydw5KZbWI4LE6soAlmJ+KRG6G2U0gz6oSezqv
	 uhkHRUkQr5HggxiorbBKEehydJ6biHE3lrfEDvcwogG8694fJ1xhndxpWE8zJb1CZX
	 CyykQ/tATK9uYYQxIAgZW3JZPHWnvka0wtogs4tCIZXRsgYCS9946bfhRwt8Wzi6s6
	 RPpG8ckhez8S4md5AQJx4wYziLf20YH7wEDUwnrmGZjGBH2NbSoLDhWZjA1MCdQEjr
	 lqFFjWiGNAashPzLuzdBXOXqKawdyVHzQZRfSByGoXteDajg445g9y4soWnJe6tthq
	 uWoZ0OcUqcK5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD9380AC22;
	Thu, 31 Oct 2024 01:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mlxsw: Fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173033824625.1516656.828397514085143453.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 01:30:46 +0000
References: <cover.1729866134.git.petrm@nvidia.com>
In-Reply-To: <cover.1729866134.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 danieller@nvidia.com, idosch@nvidia.com, amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Oct 2024 16:26:24 +0200 you wrote:
> In this patchset:
> 
> - Tx header should be pushed for each packet which is transmitted via
>   Spectrum ASICs. Patch #1 adds a missing call to skb_cow_head() to make
>   sure that there is both enough room to push the Tx header and that the
>   SKB header is not cloned and can be modified.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mlxsw: spectrum_ptp: Add missing verification before pushing Tx header
    https://git.kernel.org/netdev/net/c/0a66e5582b51
  - [net,2/5] mlxsw: pci: Sync Rx buffers for CPU
    https://git.kernel.org/netdev/net/c/15f73e601a9c
  - [net,3/5] mlxsw: pci: Sync Rx buffers for device
    https://git.kernel.org/netdev/net/c/d0fbdc3ae9ec
  - [net,4/5] mlxsw: spectrum_ipip: Fix memory leak when changing remote IPv6 address
    https://git.kernel.org/netdev/net/c/12ae97c531fc
  - [net,5/5] selftests: forwarding: Add IPv6 GRE remote change tests
    https://git.kernel.org/netdev/net/c/d7bd61fa0222

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



