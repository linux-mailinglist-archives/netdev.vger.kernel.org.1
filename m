Return-Path: <netdev+bounces-168721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA612A4044F
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDBC7AC11C
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D9682890;
	Sat, 22 Feb 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTpWYApF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E980604
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184803; cv=none; b=tGmzfUeI2UbXHpXVonJqTUH1uT4D3Fs7yXHJWZMCUPvpECAud11fwcfOazqdYJpERF6ktFWPBgNJNICSKIin15z8u+zjuWdMry3QquEWzSFmKbBgoJizMu8gfKWLz8rEVy3Xax1krETkoklEzJgq27G2yijp2igqtwh4xoMeTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184803; c=relaxed/simple;
	bh=sAAtJ9WJKO3y/ycRI/4LWSJ50D3a/Xmh503GXnKCN7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TRwOqFiEJ+oiYKdgjCeBSgHQdkTzCgwdng+3SJoWlRYZXIW8i4H94NmyA5xcqNQGtm9prtgmGej1v1JkfKcmVzUdjnB5ovKVSebe5KwS+2wn0aHo7ifKf+KUSJIrNelWaQeLx4oxtuu0wOEWT05bUWz6BEZIqPLlZS+Z93Pc4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTpWYApF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F128EC4CEE4;
	Sat, 22 Feb 2025 00:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740184803;
	bh=sAAtJ9WJKO3y/ycRI/4LWSJ50D3a/Xmh503GXnKCN7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oTpWYApFuSo74HJDW5BBMpf/PXBn9wTNqsKRuPKbFJMn8sC/K+F6+p14suAFcjmb0
	 XGlqNEUyzgmi/0mZl+CfIcoCspyYRrxJVk+g/pQSv7tcFG2SEmVMY8i6unQfRNpV3n
	 1ZVSSyRbOephwtJ7Qg7DtVQ5jQCpuKYxpomn+bBbl/cKkHFyR7VQC4ewTC2Hn3WVP8
	 OoOX4oivc9XutkeN20+d5F26zPN39sVWYga95W9tL/89pUX/ciZt/3SrzqNQvwVZw5
	 k/ex87ZQH8pH35u7/EAb2AOkPNg+isV6ck4jyTZrBrYA9LH53av8DTbx4TAoYVFVTq
	 CrXCiM9A6g5NQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34201380CEF6;
	Sat, 22 Feb 2025 00:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: better track kernel sockets lifetime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018483374.2253519.6479884431062849848.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:40:33 +0000
References: <20250220131854.4048077-1-edumazet@google.com>
In-Reply-To: <20250220131854.4048077-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kuniyu@amazon.com, eric.dumazet@gmail.com,
 syzbot+30a19e01a97420719891@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 13:18:54 +0000 you wrote:
> While kernel sockets are dismantled during pernet_operations->exit(),
> their freeing can be delayed by any tx packets still held in qdisc
> or device queues, due to skb_set_owner_w() prior calls.
> 
> This then trigger the following warning from ref_tracker_dir_exit() [1]
> 
> To fix this, make sure that kernel sockets own a reference on net->passive.
> 
> [...]

Here is the summary with links:
  - [net] net: better track kernel sockets lifetime
    https://git.kernel.org/netdev/net/c/5c70eb5c593d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



