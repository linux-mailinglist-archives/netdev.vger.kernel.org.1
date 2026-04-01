Return-Path: <netdev+bounces-273836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIUyLymBzGkFTgYAu9opvQ
	(envelope-from <netdev+bounces-273836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2E4373C9B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3E1A306F5C4
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732EE1A683D;
	Wed,  1 Apr 2026 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQYAdmQl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906E31619B;
	Wed,  1 Apr 2026 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010028; cv=none; b=UJz0RWWq1L4wbyESYGIzGa1JQz59qM0rGf+LAiOZdQCgz/quj/zdnwmyWu5O5GgW91uHwRiC3EVxNu+ub0zM7PVumBx56t3lmHGcS9bScHDNz6YuLr8S975md4UuEaezkpCK6UR7Ly8nWS6jdT9A/YzpXiMaZELkjE8e+HHySUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010028; c=relaxed/simple;
	bh=CI5RmaNghV10CFWvAMoB75BnfR0EolT5I73vk2KIYoY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ikJITKAUnWi7fLcBAv4HMzn9iDKIg576NOyN/lX6up5HQkzjY8IIWRQfkTACLAibqV3mciZUItn6p79bRSfGvoq+vWRMDkds5ycxhRn5BdRQo+qUSBwEnY3HDGfejEL35LCF0JeCbFYT7QaO9NQY6BO0idPn4rI6x3rF3IqXWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQYAdmQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD90C19423;
	Wed,  1 Apr 2026 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775010028;
	bh=CI5RmaNghV10CFWvAMoB75BnfR0EolT5I73vk2KIYoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YQYAdmQlcBpttMlcwX0msOVcafS5QssHRfcVF0Y77DAp/Gr/IcHJnbqthVj/OeL49
	 XEXg4fcFqng2HKipkLhNPM70fUAgKt44a0Tnf2VOInsO2TYhTAKOBYWRzST4PDQdMG
	 hIqgoPqn5l+R3hQsWFxKW/ryuT5VhGXVcUzuqMKJyCF5aYmZiQeb6rT5CFnP4lJ/+Y
	 YOVGtlDLsCr7whthpCzVzfB0kPXzJVyqqjx5oeHLgA2h1an9T5d7TO/929ZC26E+/y
	 hg9lESfDdALpOpgvsq2WmyrauQPG2VnQWRMv9UuxnQHlBQE258JSbz6IA/ECIxKhbu
	 8nVNPjQlgzhJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD8A3808203;
	Wed,  1 Apr 2026 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: update the README with
 variants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501001128.3035943.4643392547486897341.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:20:11 +0000
References: <20260331001930.3411279-1-kuba@kernel.org>
In-Reply-To: <20260331001930.3411279-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, joe@dama.to,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273836-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: EF2E4373C9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 17:19:30 -0700 you wrote:
> Test authors need to know about variants, existing tests don't use
> them because variants are relatively recent.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: joe@dama.to
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: update the README with variants
    https://git.kernel.org/netdev/net-next/c/f843687c3027

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



