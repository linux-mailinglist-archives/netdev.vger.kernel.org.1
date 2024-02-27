Return-Path: <netdev+bounces-75179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0388687B1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 04:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE8C1C21ABE
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 03:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDBA1DA21;
	Tue, 27 Feb 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO0zQFsU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C91B28D
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709004030; cv=none; b=RlxXX+lu0kgE/L5tZ2++sUYJ9i9HhzoqZB74w4I6AnUf6Kmy3K/qblVpb7daeEtoLuhdmEUVD2X72T8weIc+dut1RqP0xpN78Qz1KQyVoE1uZkDq2l4G1ev94hySa9II5Y34bfckJ5KlQ3nQhiXXAp6yz3LTKa7fWRixbbuUGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709004030; c=relaxed/simple;
	bh=aRRmDl5mIEDIT+q90DMIJihUK07ODUjPpKpGtw5eXJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ABPhmvdAwulYTRfxkTWECCYK/zUnUkkmImiIcJfjF4rHEY+V42wsTb1ojMk3sfHIRuqUwGP9nsYPTaG1H1FVaIH3NdmIdTsQhrdlTViQciuQ1GgAah9Nz+evc0Lkk9jxHbB4b7azHZqf3xxaqMwBGKfdo2XIhGTuKDz5b8lxgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO0zQFsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FEB4C43399;
	Tue, 27 Feb 2024 03:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709004030;
	bh=aRRmDl5mIEDIT+q90DMIJihUK07ODUjPpKpGtw5eXJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KO0zQFsUfN1PW1S7CQxZcosklbqzdtuw2SYco23IEjFK4HxM/WloNtcFnmqmx/qDW
	 Ch9HJ35lYg1jaka44tTwbKNib1bEEyOYX+XMgXQvZqpbODAaPRld07pKybYd2nh9g9
	 CgGI9kkZeCgO5Sd9V2hUzKlMFsvnrWVFw9eqwasDZB4qynqQOZNKns0WUnCi1SSDwH
	 g6oA2miqCK8HmHtnXv0CNVOA/SkbL3j3QZymQThlqCmxaHC1cB4EC65KRgqsZTxf/M
	 r7gBxNuEC7jdsyH2XaaMtvmrbPw/eJ5dq78TIm/3Z3AIzKgOTNPbhoATsllWpQ8cK5
	 HwMYTHMnLibmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F089C39562;
	Tue, 27 Feb 2024 03:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: anycast: complete RCU handling of struct
 ifacaddr6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170900403032.25082.2080537927072119269.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 03:20:30 +0000
References: <20240223201054.220534-1-edumazet@google.com>
In-Reply-To: <20240223201054.220534-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Feb 2024 20:10:54 +0000 you wrote:
> struct ifacaddr6 are already freed after RCU grace period.
> 
> Add __rcu qualifier to aca_next pointer, and idev->ac_list
> 
> Add relevant rcu_assign_pointer() and dereference accessors.
> 
> ipv6_chk_acast_dev() no longer needs to acquire idev->lock.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: anycast: complete RCU handling of struct ifacaddr6
    https://git.kernel.org/netdev/net-next/c/c3718936ec47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



