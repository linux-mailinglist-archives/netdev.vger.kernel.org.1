Return-Path: <netdev+bounces-292488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLkMKjaOF2pyJAgAu9opvQ
	(envelope-from <netdev+bounces-292488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:37:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB65EB48E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8320930E22FF
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1D01D5170;
	Thu, 28 May 2026 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKWZhy/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F01A0B15;
	Thu, 28 May 2026 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928208; cv=none; b=auyNK6c6bzHqKWdve6fOzEKQqr7V/R4IZUErO6q7/Po0pskQGyNrfV8SLtbr0RX/aBaLn59YmNzRrpuNhBNtRVi0Kfe6z6TbgtgLD/EG2hTI8/YIriOl2mDpE+zY2R9dNFPRxF51bWq/Vd8cKZBcdxXNOoOwaA5D0FY/Oj/hMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928208; c=relaxed/simple;
	bh=Cl+WCey3503Hpimo3w/zqfEW/ydEQJcAgtb2Ic4F8Yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AW7OZd1uObruscyKnukKDzg8bzI4Xneyudf372izF4BNRPz2Wc0sdjjGfaVFO1gcf8sgyijshvim9WW47YiuuRqVTdvisDy0oxLtSuykTtZ0RO+q9jUCTrpuyMyIV1LE3CBGs0keLWm3sxZ9udPFMKlCFQaC/+5PQ0MHWper+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKWZhy/i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC7D1F000E9;
	Thu, 28 May 2026 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779928205;
	bh=vCljM/Dh6ed/8Ny/oyfstf/pPL8U/xiMjs57EmJhId0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NKWZhy/iS7rjiAU3qap+iQx3N/D2Y9Y/kzZKtf+cIRBk+HiTQS/HYIUR8iDb+geaE
	 vbbJY9WL2a7a5sNo7hs7EDEHhhohNUKJpEMDxlzJGaDaf5l/1dZbp4z6YXksk/W28U
	 WawgxM6hrRuRfgQRWIVz7slAxlWSSv8AI3lu7qI2qx546pwjlLjENrf3bXN/+pIRS7
	 d7efw6os6Xb/JT+9fTKAYkV0ADy9VoXE8Iey/D1eQj0euNuSga6QjHdInxFOw/oC3O
	 K0oKDYaLbSa+hx/ADmsMs7M+VnQeTK7Jbeq0h3sKROoEEiXle22xoHEWKgdcBMzV+l
	 nvCYUsDGl3KAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CE6380CFDE;
	Thu, 28 May 2026 00:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] bridge: Fix sleep in atomic context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177992821039.694601.7451967203555108525.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 00:30:10 +0000
References: <20260526064818.272516-1-idosch@nvidia.com>
In-Reply-To: <20260526064818.272516-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, razor@blackwall.org,
 horms@kernel.org, sdf@fomichev.me
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-292488-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0CEB65EB48E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 09:48:15 +0300 you wrote:
> Under certain circumstances the bridge driver can call
> dev_set_promiscuity() while holding the bridge spin lock. This is a
> problem as dev_set_promiscuity() might sleep.
> 
> Patches #1-#2 fix the problem in the netlink and sysfs configuration
> paths by only taking the lock where it is actually needed, thereby
> avoiding calling dev_set_promiscuity() from an atomic context.
> 
> [...]

Here is the summary with links:
  - [net,1/3] bridge: Fix sleep in atomic context in netlink path
    https://git.kernel.org/netdev/net/c/5eec4427b89c
  - [net,2/3] bridge: Fix sleep in atomic context in sysfs path
    https://git.kernel.org/netdev/net/c/6d34594cc619
  - [net,3/3] selftests: rtnetlink: Add bridge promiscuity tests
    https://git.kernel.org/netdev/net/c/147f3b1f23cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



