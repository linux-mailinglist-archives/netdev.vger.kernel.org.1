Return-Path: <netdev+bounces-208289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527DDB0AD12
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 02:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBEF7AAE7B
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB7972602;
	Sat, 19 Jul 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VETAy715"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7D2F84F
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886207; cv=none; b=d7/qQ8WC405tb9LZCg8FUHBiSqCv8ryDh0s5403PusxEdzzNseU2N85ngAUME5+CP0auZpxz8AHsh3Zt//B2YJjnC+oOxkquu/Wink60pgi4zJrV+fpof5DB/ux5Cas9VBhtsh49o9otLTCloUFdGGUoDfSmldbNOwRfojF6e4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886207; c=relaxed/simple;
	bh=8+Ba12H/vIOwgD/wQKvvBYP3/2wZT5rMqbJyAguIORU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L2jLo+kFsSmC30spwtnzTSRbr0W4fjmaApL3knrX5pTOMosPtNViHkI7PaL8ipXv6to25PQ0wccy+ypzrCh81B0omuLIZ4sLbqaUcwZSFguH9F6wAgkQgl6/lCKxN7bvj2QF1cbxMWhRNd97jsGW2bZ6ttOLS1v12hbyh0wy+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VETAy715; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD84C4CEEB;
	Sat, 19 Jul 2025 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752886206;
	bh=8+Ba12H/vIOwgD/wQKvvBYP3/2wZT5rMqbJyAguIORU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VETAy715/L7GHwZZ0ygiSUTNkso4YqSfFREOM4vGZ1Kwervi6MwG2Nu5SXDLk/vDb
	 fPjLwFRTdv7mnBZ2wQSkZoxr1WNrsDL3bACEQi6hl4IcFfPwybVO39PSVd+T1oCV/e
	 zzJoO87y4oXCXfpSXP1easxeq8w00oC7uXEAVt6ByBuDSWrrHn059op0wyr+ZRf5nD
	 7C2KzkQrE2Fhc7WEjRKdVjRTjMwdP2qWc7MuPEQW/c7aRUhBERcrpcQIhQ4X4LVnHq
	 /izrC0iHtOTrzltuIyd1Ul8KvL+Ey0YEQ6vCPLugggFEd5+kkVNhuQMEjJ4rL9lC0L
	 QAhTNdbu3tzIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCA9383BA3C;
	Sat, 19 Jul 2025 00:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/7] net: maintain netif vs dev prefix
 semantics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288622649.2839493.4444142551804996905.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:50:26 +0000
References: <20250717172333.1288349-1-sdf@fomichev.me>
In-Reply-To: <20250717172333.1288349-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 10:23:26 -0700 you wrote:
> Commit cc34acd577f1 ("docs: net: document new locking reality")
> introduced netif_ vs dev_ function semantics: the former expects locked
> netdev, the latter takes care of the locking. We don't strictly
> follow this semantics on either side, but there are more dev_xxx handlers
> now that don't fit. Rename them to netif_xxx where appropriate. We care only
> about driver-visible APIs, don't touch stack-internal routines.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/7] net: s/dev_get_port_parent_id/netif_get_port_parent_id/
    https://git.kernel.org/netdev/net-next/c/ffea11683461
  - [net-next,v5,2/7] net: s/dev_get_mac_address/netif_get_mac_address/
    https://git.kernel.org/netdev/net-next/c/af1d017377c1
  - [net-next,v5,3/7] net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
    https://git.kernel.org/netdev/net-next/c/0413a34ef678
  - [net-next,v5,4/7] net: s/__dev_set_mtu/__netif_set_mtu/
    https://git.kernel.org/netdev/net-next/c/303a8487a657
  - [net-next,v5,5/7] net: s/dev_get_flags/netif_get_flags/
    https://git.kernel.org/netdev/net-next/c/93893a57efd4
  - [net-next,v5,6/7] net: s/dev_set_threaded/netif_set_threaded/
    https://git.kernel.org/netdev/net-next/c/5d4d84618e1a
  - [net-next,v5,7/7] net: s/dev_close_many/netif_close_many/
    https://git.kernel.org/netdev/net-next/c/88d3cec28274

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



