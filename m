Return-Path: <netdev+bounces-156118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3EAA0505A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B46D166B8F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE45E19B5A3;
	Wed,  8 Jan 2025 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDFltGKU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4691DFFD
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302217; cv=none; b=I0Be9fc7JY+YS7N2AYqtaoKls6QL/8RKWpfq+WKTc7rz3X1iOeTVKAEejvUrG/Cgi+OrOZaf5DaYQplohKkmSLaz7tHfSUbKCDewxXKxwksTvE9r3mETVSN4FGpxZDK3v6BinLAcF4VOW0tKhSAjSCMqedLOAsBeYIy6l7dh7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302217; c=relaxed/simple;
	bh=+e6L+axJULdmMksFGwzJBTQehBk6zcL/tjHAnl9FXys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iLrQn8QDgzOhhNR04/Y4KEYDZmC/qikHSMxiVyAOG3ebQ/EO9IXtC75MkqbmnmqUnFe8VH4C2eT5q8FLY9YF/ye4O/Zau8BcF3o7NDgB6HAN/VfS+PPvXUkA8MTgMfZaC6gZHDo8Ww/5p6AzEF0nK26GbQSpDE4Vaj1605ZwaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDFltGKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EC8C4CED6;
	Wed,  8 Jan 2025 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302216;
	bh=+e6L+axJULdmMksFGwzJBTQehBk6zcL/tjHAnl9FXys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hDFltGKUh6JiCIFnsY70vF2UJna9Ns2srMO7zfZ1LF3vEcgMn+DWI4Ymug4UWCxRV
	 SrttMVOGtv0pq1DmES3RWIMyvGLJjRcQbU9byI6QxU9BrjySoS96ajtYT8/DStNM3Z
	 Mun59hL7OWVs5rW0bd5rDI2ko9USnP9+D8wchggDkPAEp2y7jzLgDc6ksdiB0evYOQ
	 1XMF8HnW7VXtAbFwR2N73PLqAFBL7xYaInTaxrLhLJ8yQS5G2TBZIlprKWxkFoUE+m
	 1bVlEAV9nOo5hL1sTeVDTVh1YsKrQyIn0k6AabAo2Nsq2j349M4htG/elz6Lcnpz2R
	 vn9581W+9EtTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB204380A97E;
	Wed,  8 Jan 2025 02:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: Hold per-netns RTNL during netdev
 notifier registration.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173630223773.165659.5953862815944638534.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 02:10:37 +0000
References: <20250106070751.63146-1-kuniyu@amazon.com>
In-Reply-To: <20250106070751.63146-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 6 Jan 2025 16:07:48 +0900 you wrote:
> This series adds per-netns RTNL for registration of the global
> and per-netns netdev notifiers.
> 
> 
> Changes:
>   v2:
>     * Drop patch 1 (leave global netdev_chain raw_notifier as is)
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] net: Hold __rtnl_net_lock() in (un)?register_netdevice_notifier().
    https://git.kernel.org/netdev/net-next/c/a239e0625097
  - [v2,net-next,2/3] net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_net().
    https://git.kernel.org/netdev/net-next/c/ca779f40654a
  - [v2,net-next,3/3] net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().
    https://git.kernel.org/netdev/net-next/c/7fb1073300a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



