Return-Path: <netdev+bounces-272969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBYVKtp0yWmxyAUAu9opvQ
	(envelope-from <netdev+bounces-272969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:52:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F188353AD4
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6719F3013A8E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD983793A4;
	Sun, 29 Mar 2026 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVn8JdBv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2C32E128;
	Sun, 29 Mar 2026 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810236; cv=none; b=CcXCp9whaRJrySxXCQJcyQdKZsiwfyatVWmeacDZIYAUD6eXnM8jGBNS2hisLF0jZg3r4Bt7pmaTP+coRzrt0yKYGzD3W+UPSUH8++om6nS6wkP1NIL4wavzml1mM48HaVGTqeaFpFCmY1hemBJY8ofzuCJDswM3kvKMVULYmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810236; c=relaxed/simple;
	bh=is+DC8Ch8ND99RenSXI5iRDeSTC2yF+mLuIofAsvA8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=il878G+4RHMIoiLlSReHu6tewxHH9TAqsqcZewvhR0imkcMhcGAvGOQbSnI98SKaFhHAk91rg2n2D21BF3EAjP0QuFppl4HTSKq17w+up4h2PwVJwSeEi48mCZvll3BsW5sAdjCQnDGgta+1fD0cUIKO/c6dqpBZ47lkyYB2xNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVn8JdBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D423C116C6;
	Sun, 29 Mar 2026 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774810236;
	bh=is+DC8Ch8ND99RenSXI5iRDeSTC2yF+mLuIofAsvA8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rVn8JdBvkBq1eDvR+DiAoSlH8lSw4O9MAP4zf0Hf3B3l2u+ZQHFWH+rscayLiP51V
	 fe34o55Uz/6x/XWIyLyrOIea0J6URoYt/ljfKVjvvCevKtXMUNGc8e1AILydRufg+R
	 +6LRgKLuydHMew6h5ViwmnXZseCpTIUMV21VJ7Oh6kFNfIyUgGRlG2tgP26CxA6nmf
	 u3iuT2+OY0DZdEnTTRYsab2ZAqgOCcbP2y6T7ieEdyY8MhC/QtlDhManwxpasjs9QQ
	 hvosvPVkGblIJU4b2RlqEHzBd3bBmXwin48AZhXjGtKKDj4vmeLK7ptZB7Ikrluhi3
	 t1ns9eZ66prSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE4B3930012;
	Sun, 29 Mar 2026 18:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/11 net-next v5] Convert CONFIG_IPV6 to built-in and
 remove
 stubs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177481022104.437043.4701702729362150355.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 18:50:21 +0000
References: <20260325120928.15848-1-fmancera@suse.de>
In-Reply-To: <20260325120928.15848-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 rbm@suse.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-272969-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F188353AD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Mar 2026 13:08:41 +0100 you wrote:
> Historically, the Linux kernel has supported compiling the IPv6 stack as
> a loadable module. While this made sense in the early days of IPv6
> adoption, modern deployments and distributions overwhelmingly either
> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
> entirely (CONFIG_IPV6=n). The modular IPv6 use-case offers image size
> and memory savings for specific setups, this benefit is outweighed by
> the architectural burden it imposes on the subsystems on implementation
> and maintenance.
> 
> [...]

Here is the summary with links:
  - [01/11,net-next,v5] ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs
    https://git.kernel.org/netdev/net-next/c/309b905deee5
  - [02/11,net-next,v5] net: remove EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL() macros
    https://git.kernel.org/netdev/net-next/c/0557a34487b1
  - [03/11,net-next,v5] ipv6: replace IS_BUILTIN(CONFIG_IPV6) with IS_ENABLED(CONFIG_IPV6)
    https://git.kernel.org/netdev/net-next/c/fde39f7df10b
  - [04/11,net-next,v5] ipv6: remove dynamic ICMPv6 sender registration infrastructure
    https://git.kernel.org/netdev/net-next/c/d2042d35f413
  - [05/11,net-next,v5] ipv6: prepare headers for ipv6_stub removal
    https://git.kernel.org/netdev/net-next/c/4b70b2021504
  - [06/11,net-next,v5] drivers: net: drop ipv6_stub usage and use direct function calls
    https://git.kernel.org/netdev/net-next/c/29ae61b2fe7e
  - [07/11,net-next,v5] ipv4: drop ipv6_stub usage and use direct function calls
    https://git.kernel.org/netdev/net-next/c/d98adfbdd5c0
  - [08/11,net-next,v5] net: convert remaining ipv6_stub users to direct function calls
    https://git.kernel.org/netdev/net-next/c/d76f6b170a10
  - [09/11,net-next,v5] bpf: remove ipv6_bpf_stub completely and use direct function calls
    https://git.kernel.org/netdev/net-next/c/ad84b1eefe28
  - [10/11,net-next,v5] ipv6: remove ipv6_stub infrastructure completely
    https://git.kernel.org/netdev/net-next/c/964870b4b901
  - [11/11,net-next,v5] netfilter: remove nf_ipv6_ops and use direct function calls
    https://git.kernel.org/netdev/net-next/c/b2c981e7c465

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



