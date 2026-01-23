Return-Path: <netdev+bounces-252954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG/FGxjRc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:50:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAE27A4EF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FDBF30173A4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88A2C2356;
	Fri, 23 Jan 2026 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDTiUjWu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BBC279DC9;
	Fri, 23 Jan 2026 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197837; cv=none; b=HljNwsA6V6OVztWjl5mBa6ipPZnrlOYebeS6gSpfNM7aHPRlFnt9M0F6NB6RGSbme/5WY+YMxT2rXH+9SKLRDMaUzysqpos2YQ7lHddVH64utSPy8m8Hq3r+hxbdejB1Cbo+JLlar8uNj5knoENGszqWTCdkVCiqINH5yegslRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197837; c=relaxed/simple;
	bh=toyK7zvTmMEU69165FrqQsI8VeS7DHanxkiZ2wbAWno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqRg307oNypfrajcmfP6CrshgSDP7YnlAwam9I2b/GeXM9vyDoASu4ldabqjH898n5RbCImQLinsCMde0Djqnfd6JTR2c1BvFNGsQBHedgRuXYRrWsyfJeMcaG/8XVWI3cHiLCjGs7vhfXEvNiKC8MzO9wDb6goJCrXZI8Uevb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDTiUjWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD641C4CEF1;
	Fri, 23 Jan 2026 19:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769197836;
	bh=toyK7zvTmMEU69165FrqQsI8VeS7DHanxkiZ2wbAWno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LDTiUjWudqS3ACgoe7+D/CTz8pBoFuw/AuwUo1vvJQKqHBvk3KNvpF3V7BM7Nv1x1
	 ASXQ5J9y2qLxlY3SLPF9nxFJ1EyCQ4r9s0E5YYlkhQFz0AIEFrYFRkZbaDhwldVaKB
	 CDg7nbXiAn9caGcYbueircS1W6ayccrsHzB8islvgKjGFDXJAImN9DnSkxzlwLoXx0
	 83PthFcNMMKVIDhs2oYRZPy590npPgRm1VR+yFwi2C4yHCX01T44ppIk4wFDVOyeHy
	 Dp/Y8OEADBZAGtYYs3JmdKwsNPlauXrVgKwmkxycKcFs3sOrACtHbfyf/RAushLoi4
	 TaQmMwRezJpbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B6E3808200;
	Fri, 23 Jan 2026 19:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/7] selftest: Extend tun/virtio coverage for
 GSO
 over UDP tunnel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176919783234.2695110.8587748919583568584.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 19:50:32 +0000
References: <cover.1768979440.git.xudu@redhat.com>
In-Reply-To: <cover.1768979440.git.xudu@redhat.com>
To: Xu Du <xudu@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-252954-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1AAE27A4EF
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 18:04:54 +0800 you wrote:
> The design strategy is to extend the existing tun testing infrastructure
> to support this new use-case, rather than introducing a new or parallel framework.
> This allows for better integration and re-use of existing test logic.
> 
> ---
> v5 -> v6:
>  - Fix the Makefile format errors.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/7] selftest: tun: Format tun.c existing code
    https://git.kernel.org/netdev/net-next/c/e073c118db02
  - [net-next,v6,2/7] selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
    https://git.kernel.org/netdev/net-next/c/a942fcd72e97
  - [net-next,v6,3/7] selftest: tun: Refactor tun_delete to use tuntap_helpers
    https://git.kernel.org/netdev/net-next/c/82cfdcfa2010
  - [net-next,v6,4/7] selftest: tun: Add helpers for GSO over UDP tunnel
    https://git.kernel.org/netdev/net-next/c/24e59f26eef2
  - [net-next,v6,5/7] selftest: tun: Add test for sending gso packet into tun
    https://git.kernel.org/netdev/net-next/c/400e658aa096
  - [net-next,v6,6/7] selftest: tun: Add test for receiving gso packet from tun
    https://git.kernel.org/netdev/net-next/c/6bdd7ae6059e
  - [net-next,v6,7/7] selftest: tun: Add test data for success and failure paths
    https://git.kernel.org/netdev/net-next/c/87db2fdef5a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



