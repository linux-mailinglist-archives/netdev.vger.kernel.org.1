Return-Path: <netdev+bounces-279213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIbzIvie4WkQvgAAu9opvQ
	(envelope-from <netdev+bounces-279213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:46:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0033416510
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCD0331984E9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CE8308F15;
	Fri, 17 Apr 2026 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k297crOu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16586306B37;
	Fri, 17 Apr 2026 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393652; cv=none; b=lcsm5rffj9Z2YgLiClMl5TPVnaOiM2NTzIpaSYx+Wzq2vYKxAPB8YPFbhdakmF9zBYDHNSouPU8u4zTDR29NLoEC4RrfGYnpimHFmcM3YQhF76eMp0AvtysYQIFTqwWWW4chuIuq60myHg2DZ13pYWwib/1vnPQH3zTKsWcOjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393652; c=relaxed/simple;
	bh=kffito/ls8Hc9Kh2cCr8+omLT/wvGSLzVyFGXK9VvBE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e5OhkVfDxEmWHXR9TusOPZlPE7mBAlmZe9SEFQnfg7BVRmSKRuxsrUu9UMVtw6HT/UUwYmpIQWSS6gwoZds0okaSg45J0xVOANbHwhyvnXIjnA3QeYmIawzaeCFD309VC0z3y+cSoDMJLU8K6081OA5EKFGZ1vxxSaaBMhGMlAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k297crOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9B5C2BCAF;
	Fri, 17 Apr 2026 02:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776393652;
	bh=kffito/ls8Hc9Kh2cCr8+omLT/wvGSLzVyFGXK9VvBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k297crOuxcE5Y0y03Ai9pnJcVPliSpZIm8E8ddIz+uw+ubMcZf1IgGyDtfKQ5njx0
	 2mT9VxPYILB/XwM21PDWMu04TBCpRCntQMI9BtiGLtze6BGzfRg+Dq4lc/WCi/4URz
	 CNAXmEOpElCtCeOkqt1vYbmrmFZcKb9Ujx4oOuYmUzi2/8QlKmvVnjUJtF4iBxg2GU
	 HlqBwj9htEDAHmZ48dWSfdlkGzvFUQOeekyqVZ+AEpPSrYOC4nwydjCUqC9BQRPQm7
	 muJKOZWyCjY3fLQubJugxAqZH5GveKO5y5dtcvk/B9v/PUODx+JjLq1qrmBnjMrnXM
	 5k1tngsabNVMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC01380AA76;
	Fri, 17 Apr 2026 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: add missing CMAC to tcp_ao config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177639362004.3490984.2914709149470297319.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 02:40:20 +0000
References: <20260416010439.1053587-1-kuba@kernel.org>
In-Reply-To: <20260416010439.1053587-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 fw@strlen.de, antonio@openvpn.net, matttbe@kernel.org, phil@nwl.cc,
 linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279213-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:email,nwl.cc:email]
X-Rspamd-Queue-Id: D0033416510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Apr 2026 18:04:39 -0700 you wrote:
> Recent changes to crypto and wifi made CMAC no longer
> selected by default on x86 and tcp_ao needs it.
> Add the missing config.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: fw@strlen.de
> CC: antonio@openvpn.net
> CC: matttbe@kernel.org
> CC: phil@nwl.cc
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: add missing CMAC to tcp_ao config
    https://git.kernel.org/netdev/net/c/82c21069028c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



