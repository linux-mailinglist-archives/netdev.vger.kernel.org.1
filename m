Return-Path: <netdev+bounces-167597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93394A3AFCA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601491632EE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C01191F89;
	Wed, 19 Feb 2025 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+41AaFn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDF28628D
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933401; cv=none; b=Ju11TmrZhpmNU18Avg5tSRGSyeifVL0dDubxFUzRJSqmX5/2Z3A6BcFjd7aRBws7qCI8RzqoMUrkOTkxX3VsqMPhGa5eDrXrma+kYKOBy7OmNsGXXrfdmaDkApBwQyJe+vvZTT9R6MdK0a5Kl6k/uztoWWQmHTwsdBnqczuis1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933401; c=relaxed/simple;
	bh=cRqZEEtYI6axd1FQ0thNKjEowABZgqDrTshigLVnpag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K8WtvqO4bUqvAuy5R0Xa30M3wkYgC4T2DCYI1Az0Ks6fxjyjs8NRSD9wS4xjryOgB7YvFJ/flckI2VMQ6rclvDegFxpWfvlhWqJbOssvnDheItBBmvwqYLfqdFM5mL7wSkd9W+wHXtMlxSrn63UbKoliCwVEpfwjoqM0KXd/2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+41AaFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73F5C4CEE2;
	Wed, 19 Feb 2025 02:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739933400;
	bh=cRqZEEtYI6axd1FQ0thNKjEowABZgqDrTshigLVnpag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z+41AaFnYeT5U7aZlMAMJM15jCSHLcV3zhViig8XahjxPatf1zQ0N8rNplwfuqUlw
	 hwIG82od7GPBSQnDBtrs3kuraRIsjtZRr4ig1MR/MW6JgKVGH7G4WE9eE8OmvQRbxT
	 f+0mARs8dKPiDlep629s1mPp0kMUULZ8iCtODwAxgWf7gdbcdsFlX7fGB4ROI56u/W
	 0t+OtI5LFt2CsxJllkPTTxNjk/m7IB/pRt7HW1AGRYk6VMV4OU+S0IgcZxnwjGqyLD
	 Jd5kVUqVu3LRD8jccFxebn+9ZjFCD8cnhyhzaopBylDaDTxcvy5vRJGMMQdVgk1cdv
	 ucowICAdxhQ0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E6E380AAE9;
	Wed, 19 Feb 2025 02:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net 0/3] net: Fix race of rtnl_net_lock(dev_net(dev)).
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993343131.113122.17012975803921573195.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:50:31 +0000
References: <20250217191129.19967-1-kuniyu@amazon.com>
In-Reply-To: <20250217191129.19967-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 11:11:26 -0800 you wrote:
> Yael Chemla reported that commit 7fb1073300a2 ("net: Hold rtnl_net_lock()
> in (un)?register_netdevice_notifier_dev_net().") started to trigger KASAN's
> use-after-free splat.
> 
> The problem is that dev_net(dev) fetched before rtnl_net_lock() might be
> different after rtnl_net_lock().
> 
> [...]

Here is the summary with links:
  - [v5,net,1/3] net: Add net_passive_inc() and net_passive_dec().
    https://git.kernel.org/netdev/net/c/e57a6320215c
  - [v5,net,2/3] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
    https://git.kernel.org/netdev/net/c/65161fb544aa
  - [v5,net,3/3] dev: Use rtnl_net_dev_lock() in unregister_netdev().
    https://git.kernel.org/netdev/net/c/d4c6bfc83936

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



