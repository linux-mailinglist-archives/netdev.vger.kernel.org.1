Return-Path: <netdev+bounces-173188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69500A57C4C
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 18:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AF516C98A
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53671E833B;
	Sat,  8 Mar 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwUtgjp0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC118C933
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741454409; cv=none; b=UXaaAiXSKLIelPQ+bGO75wIuE0OHNQuII5GA/O+MkXJty9vfW9xoAQDqMZN67PQrHaWKpio6kpAlmzD5avaiG8UV8OocVHqFHzue2gOwo9iJraTCEhx0sm2EEbphntemBXWPsy5C16to4Q66o5k0wfIt3qGZltgYsQHrGIusMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741454409; c=relaxed/simple;
	bh=grTUabYAJMwL50TxuuEoI2VI92HZ1OfxnXitDwBKIIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MM5mG+oLon4/DNpf6OQEHcveCaxinyBOaNJwvg/rDS6kAasjU3LTouBUxdLPimvEsfHMf6Kgfaok77iooTFdRxs4tYDPl9504T4idVe7gjnnqbpwY7reKIktsv9YEei6AKrOLX/kaqzNiE8sw48KK3OeoWmb9r2bccZS6KxBjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwUtgjp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B663C4CEE0;
	Sat,  8 Mar 2025 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741454409;
	bh=grTUabYAJMwL50TxuuEoI2VI92HZ1OfxnXitDwBKIIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XwUtgjp0eUlR6FCmSvV8rKhOLvx2qJF8dvHo4Nm8JvycUQb/htyZ3jSMRBB8aK3ig
	 n7/JMwQ42nMYFqvipw4CcvkEpQeq4sWH0I16UUAL7NA0m8JeisdEcq+s+PgZBvjpnu
	 xkz0gACN+sE554xQ4lAaloawkL4EiwQodVisE5n3bUVCl7e3TXJe0VGB+3FJ9HJymG
	 RR3xk7wmBbqwU7HTWTzzgekdaU4gJFfHikm0nuNBXlSDCJIUtrtcBygnlcpn3w4PXp
	 bZE143as55b+BT16idX8fcrDriUud7rRCbKCmjFWKNWj61cBv+aP+hFEJGooGTbLYd
	 UnFVtrpAvUyBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE9D380CFDC;
	Sat,  8 Mar 2025 17:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] hamradio: use netdev_lockdep_set_classes() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174145444259.2698227.2304483118401579408.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 17:20:42 +0000
References: <20250307160358.3153859-1-edumazet@google.com>
In-Reply-To: <20250307160358.3153859-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sdf@fomichev.me, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 16:03:58 +0000 you wrote:
> It is time to use netdev_lockdep_set_classes() in bpqether.c
> 
> List of related commits:
> 
> 0bef512012b1 ("net: add netdev_lockdep_set_classes() to virtual drivers")
> c74e1039912e ("net: bridge: use netdev_lockdep_set_classes()")
> 9a3c93af5491 ("vlan: use netdev_lockdep_set_classes()")
> 0d7dd798fd89 ("net: ipvlan: call netdev_lockdep_set_classes()")
> 24ffd752007f ("net: macvlan: call netdev_lockdep_set_classes()")
> 78e7a2ae8727 ("net: vrf: call netdev_lockdep_set_classes()")
> d3fff6c443fe ("net: add netdev_lockdep_set_classes() helper")
> 
> [...]

Here is the summary with links:
  - [net-next] hamradio: use netdev_lockdep_set_classes() helper
    https://git.kernel.org/netdev/net-next/c/9bfc9d65a1dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



