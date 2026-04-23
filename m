Return-Path: <netdev+bounces-280693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMpnJcPz6WmepQIAu9opvQ
	(envelope-from <netdev+bounces-280693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:26:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABCA450A32
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0D59303F8C8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D6939DBD4;
	Thu, 23 Apr 2026 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO3y7UlT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3B393DF9
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939645; cv=none; b=anZOzuOH6J4OtYZskpXXHz7F/sdYMXnKjuv+u84wZntP/kubGKrAEnsIQLccmg3RtbI1WdSA8fZfcsxe8e2i06AO5ct31g57bxgZSUf2KHR8OUHSoeDK4+9mVbq+0Ak3BMUe5I5QnMomq10cgc9As0TwIyk/CIXf0Az8jWHYE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939645; c=relaxed/simple;
	bh=PrGrCeyBMouX9tyuir9Kgx3+v6Zkg73D2XDlZkdfPm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FrM8fGCYkWqtmD3SEPI+Nsmmx57UzUyckHmSRwfGXrpTeQupILgbo75FrXOrQEedmefkEdfyqeVZoFtL/h7yex0irfpVhCQ/z7kC53NMVSjf+OYzmqLLuno3GX+KaAkIIw5hBuDmwWrG4ORKNyUHxxsoHPQbzb6xgq0I+U3TLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO3y7UlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508C5C2BCAF;
	Thu, 23 Apr 2026 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776939645;
	bh=PrGrCeyBMouX9tyuir9Kgx3+v6Zkg73D2XDlZkdfPm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hO3y7UlTUhnr3h/vrlpZCQCIi05Qa7c505CkgwPXEtkAKQGpkIKJAu+k5In3Btbsg
	 nvA86K3Dn3nemCWuOxcV2niGHUCnHWG3a5dfrXVD6kzgvOWId0mwdr5t5WJkHvN1A5
	 uq0dLxXsga6jHLi9U5tCHQBr44VOS2Xu5ehozL3fS1GpVypdj5s2ZJZfwlLHmXy0z6
	 Zv/ZOguvrAHMsR3ZgthyUeCWUyNVkwV29m+Y/NwEsYepFpO3kBstwcLVcp1EKirxtn
	 fF+F+1Vgt1MgPru2bMuOE3NxpUQ1nNGYGMYEKfl6ksaILpt/7uy1o1U2Dy+gAnx/a0
	 j/0lCwFlgct6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FED8380CFFD;
	Thu, 23 Apr 2026 10:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] 8021q: use RCU for egress QoS mappings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177693960705.95198.14343810737478655925.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 10:20:07 +0000
References: 
 <9136768189f8c6d3f824f476c62d2fa1111688e8.1776647968.git.yuantan098@gmail.com>
In-Reply-To: 
 <9136768189f8c6d3f824f476c62d2fa1111688e8.1776647968.git.yuantan098@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, horms@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, kees@kernel.org, yuantan098@gmail.com, ylong030@ucr.edu,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280693-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,lunn.ch,davemloft.net,redhat.com,gmail.com,ucr.edu,lzu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ucr.edu:email]
X-Rspamd-Queue-Id: 1ABCA450A32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Apr 2026 11:18:45 +0800 you wrote:
> From: Longxuan Yu <ylong030@ucr.edu>
> 
> The TX fast path and reporting paths walk egress QoS mappings without
> RTNL. Convert the mapping lists to RCU-protected pointers, use RCU
> reader annotations in readers, and defer freeing mapping nodes with an
> embedded rcu_head.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] 8021q: use RCU for egress QoS mappings
    https://git.kernel.org/netdev/net/c/fc69decc811b
  - [net,v2,2/2] 8021q: delete cleared egress QoS mappings
    https://git.kernel.org/netdev/net/c/7dddc74af369

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



