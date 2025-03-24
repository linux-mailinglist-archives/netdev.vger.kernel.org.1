Return-Path: <netdev+bounces-177180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE48DA6E33F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794631723DB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA9119C54C;
	Mon, 24 Mar 2025 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKbNpEuC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A1192D77;
	Mon, 24 Mar 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844000; cv=none; b=ZxKFmKguLLoVDHM3eL8IxQKBCk1rILyksjH9kBqybg9I2NEDOkrD8e6h4Vtuna4D59WYmE3KbZVyc77m35j/LX/4+x7mx1CKxulzpWSQhoco+nRhbkzbSqU69FxYM7xBaIyfauhnFbgM3tUhSrQNuDjVh0PARrjbKUFxiT/Dp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844000; c=relaxed/simple;
	bh=RGnsYNzqSuhW1ytu/VzC9cXgwSxO24DHBmZ735ykH84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MiJjoYweNfAHtE3IF4NjBPPkp6hK303fCphwY8D4KwzoagAfi07Fw5gHy5ZruaI5BakWX0VYVNqOjKHZAc8A1Hp+4gY/WBwBBSJii1fTBjG5Jpo8vsnoU1uETRa0c8hsdAbQ6RX5/w9gccZTmuPpBZ5HGaV8SRPa2T/qijLvxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKbNpEuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BB0C4CEED;
	Mon, 24 Mar 2025 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742843999;
	bh=RGnsYNzqSuhW1ytu/VzC9cXgwSxO24DHBmZ735ykH84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GKbNpEuCLa1JcYM/lE7jGRmjMBzKVLMywNbaOEA9e+WL27uzg05BSDPTBuYh6SIdY
	 q780MVlYiDN/BdMaT/6pgPDJFQ+riiasHEl2U6ctdvk9tJ0kY5RviTlTriju7JHlQe
	 IgKe84Xz1MIKdAZOhNqJekjHlRSPZNtq4Oabb5lbP7eMwXZlXGt4KMSva1W7AigGbb
	 YMHYJ5Vrg9Ss5+nQ9UYPwUkBgVVRZroJzTdBbxR933hxepkngecSBhbXF1i+KrYHj+
	 raJmMAA+/O/Rmko86w5uVndCTCsQ/HKrLkFarhIAMqEreduibrhzTcf2L1Skz6VHAa
	 UYK5WyryP3K5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECBAB380664D;
	Mon, 24 Mar 2025 19:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: fix the path of example code and example
 commands for device memory TCP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284403574.4140851.745371503688027549.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 19:20:35 +0000
References: <20250318061251.775191-1-yui.washidu@gmail.com>
In-Reply-To: <20250318061251.775191-1-yui.washidu@gmail.com>
To: Yui Washizu <yui.washidu@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, almasrymina@google.com,
 sdf@fomichev.me, linux-doc@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 15:12:41 +0900 you wrote:
> This updates the old path and fixes the description of unavailable options.
> 
> Signed-off-by: Yui Washizu <yui.washidu@gmail.com>
> ---
>  Documentation/networking/devmem.rst | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] docs: fix the path of example code and example commands for device memory TCP
    https://git.kernel.org/netdev/net-next/c/f8e1bcec62ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



