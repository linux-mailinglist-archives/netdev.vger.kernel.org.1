Return-Path: <netdev+bounces-176490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D88CA6A8B7
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9036189AA35
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AD422424D;
	Thu, 20 Mar 2025 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I48yVIVG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FFA224229;
	Thu, 20 Mar 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480999; cv=none; b=q25HKTHOmvzkT9uacSC6d8O1gUhGUdyfU3eZhr10hpxnekK/DB7iCsKGM5uBgYhWN/ldhMvjDMV97slaSBBiov03+CBj87ZK2ZDL5Ru07Z4YWjditVhhzl9UIL9uGEgnKHs/xJ2jgD02sAetwvrCMQbp8/fO+HQ4QPTxcZFdFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480999; c=relaxed/simple;
	bh=xhtDGu9Ya2b18H9haGczeuzs8xmahBrg06yrw41lY2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f5EBO/PXg5zAowhIW2dwzDKLfkenAsT7eyh9Y6rnMYiiO1juUiyi51Mw4dKkdNhihPY34IFsbfuiQbVc1HWRu/zTgldTK73xIwaE5mjSEx/TfHZAhuK6Yjn90kgUmM0/ouAVlpeQqq5/qV40D2a98Qmsg1BiffLiypypUHGHhno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I48yVIVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B35CC4CEE3;
	Thu, 20 Mar 2025 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480998;
	bh=xhtDGu9Ya2b18H9haGczeuzs8xmahBrg06yrw41lY2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I48yVIVGB8uI6noqigGaUfEMbjDtQwXgcxWL8XLRo33+nSuGrH6jVorAHixf3g1Fi
	 bCwWzV54O+tDX8NFLf6O/9smaktKx3ilDu3Cup7LB+NIiRB2a5ZZlzY6YTt8NoJV+l
	 FWhwgBUytkz4dSdCwX9HEtaA+y7R7mPiMSlhPU5JZlOTnYT9ziRHXe/OXul1OW1ZFG
	 kgizV6cIZVdOyezOPqsTiM40RCwnNUuIbc88s8QkbOravxgpwWOrIX3XIZvVqVxtfD
	 eQOqonTCYreuwzlY/kTJpmWDIKzdhpWwr6wzeGP4nhljCJfrfgCCUEHBVJUl1knR9T
	 48eH2MQQUBYug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34BD23806654;
	Thu, 20 Mar 2025 14:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools headers: Sync uapi/asm-generic/socket.h with the
 kernel sources
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174248103400.1787925.2424951740008508533.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 14:30:34 +0000
References: <20250314214155.16046-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250314214155.16046-1-aleksandr.mikhalitsyn@canonical.com>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, kuba@kernel.org, vadim.fedorenko@linux.dev,
 willemb@google.com, kerneljasonxing@gmail.com, annaemesenyiri@gmail.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 22:41:54 +0100 you wrote:
> This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
> 
> Accidentally found while working on another patchset.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> Link: https://lore.kernel.org/netdev/20250314195257.34854-1-kuniyu@amazon.com/
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> 
> [...]

Here is the summary with links:
  - [net] tools headers: Sync uapi/asm-generic/socket.h with the kernel sources
    https://git.kernel.org/netdev/net/c/23b763302ce0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



