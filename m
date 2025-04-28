Return-Path: <netdev+bounces-186404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD7A9EF78
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210403A06EF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A315267B9C;
	Mon, 28 Apr 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0EvwxCH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A3267B91;
	Mon, 28 Apr 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840391; cv=none; b=VMOM/UmQ0Z5GsBHf9NPobS6uA5KaWfZZh693jibIJfzyK9syg5yLa43q7DSyl2DpFyecT2v4ToOURCR9N7CcSr2Mclq5ZmbqUdvz5EkqTQGQz6BfwaAt+2hhLPSu1izkCh8w1aMrkdhR+BNAIm9co8a3AFghpZMSzw0lrpUsbgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840391; c=relaxed/simple;
	bh=bQQYYw74YDFs1Z4DShazrLKKxfyUq8yNFZGDbTX3Q5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mT9olICXoFgdNRyM8DCCYiqMv6qURZHElaZElPlGGWBEsh4dlkkodT9KSWD6X7LYOSuJJqmg+z0ccYrC3Y8Op57tduTQ/diXFnwZRX3J+JMCLWIox7sKRANQVfpYxtxjcQCIndR05VB5sM9edpBcV8Wbrbz2JQ0hVYLSOHrYQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0EvwxCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D861FC4CEE9;
	Mon, 28 Apr 2025 11:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745840390;
	bh=bQQYYw74YDFs1Z4DShazrLKKxfyUq8yNFZGDbTX3Q5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B0EvwxCHVU8WcE+4K3NNFvG0KdcugDigsDsdbhxeLdtOpjOWbiA1a2u+pd+stbFo6
	 PyYcx1D9QQNB+OMLvqZ4V0Nx8oRbNTfSno8jH+pyVF/tUQpCPYZg4q3QT9+vZCvDY2
	 WhoWQJalq9TFx33tj+VrAvgudc79X23PPfSxRcmE9U8Xp1bZFJZ+XXeVeOGlXtfnfC
	 ttIEZ9yJGJ1kLhnPKvHq/f0U4rSBRQLIupnjde4VSgjkkSzifPnidlf09PgxtCuA8b
	 t5ORBfswvhCWwijDxMESikeu/fK6wb25BM4Bt0SVMgAsypUs6nO4WWclCvOHrFuo8C
	 /KF4dro9LzX9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCB3806651;
	Mon, 28 Apr 2025 11:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net] bonding: assign random address if device address is
 same as bond
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174584042976.546496.2585369633410205037.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 11:40:29 +0000
References: <20250424042238.618289-1-liuhangbin@gmail.com>
In-Reply-To: <20250424042238.618289-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 razor@blackwall.org, horms@kernel.org, cratiu@nvidia.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Apr 2025 04:22:38 +0000 you wrote:
> This change addresses a MAC address conflict issue in failover scenarios,
> similar to the problem described in commit a951bc1e6ba5 ("bonding: correct
> the MAC address for 'follow' fail_over_mac policy").
> 
> In fail_over_mac=follow mode, the bonding driver expects the formerly active
> slave to swap MAC addresses with the newly active slave during failover.
> However, under certain conditions, two slaves may end up with the same MAC
> address, which breaks this policy:
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net] bonding: assign random address if device address is same as bond
    https://git.kernel.org/netdev/net-next/c/5c3bf6cba791

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



