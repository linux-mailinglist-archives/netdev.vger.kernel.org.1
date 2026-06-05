Return-Path: <netdev+bounces-295556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VusoHy8sImrcTQEAu9opvQ
	(envelope-from <netdev+bounces-295556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:53:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C07676448B2
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:53:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GpSFTi+A;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295556-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295556-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1E1308A947
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB09739A06B;
	Fri,  5 Jun 2026 01:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959C3D5C1B;
	Fri,  5 Jun 2026 01:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623628; cv=none; b=aOFOQ12GKXJDOmPR5NhREYS0bFI9meWDQ6vrINknfhjnzIxPz0ym6o8dVVjsBVfBEfKHGPpTZd4+GwyOGP+YZOaDAzF+kHFned8N4l4SZlNx5HNsiyb9nGjEoJqwuC1jNCjptCVkXqcfo3toJ3qIrxwJ47lhXdE4DN0id+lJRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623628; c=relaxed/simple;
	bh=+zinyzrA8XoP3Nsg3fIbFLi/iU9M8rxdk3fHo/0+mGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AZryWyDi/NEwFNaWSRdSGDIL6WEO8l7ErzA6VyZYSbA3J2cGt0ORhkL/RGMT+HG2+cWS0Yq+h/6OaSEEuYmYzsWHXtuOlQCp54MMxbRklDML5X0wI/a9E029QrYoFV6mQz1szZLQ5oeY2lHGNJL0cFMCQydZNJgw//z6IbtW1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpSFTi+A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E141F0089A;
	Fri,  5 Jun 2026 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623620;
	bh=4pfn9JYoJyI0kDiXq8yrzgV1kwHYVOZnecHsEPykLUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GpSFTi+ATuOAikeh3fq9kx+astKK90T+CC15OkwxK09znoQsLp28ZOh4GnEPN05KE
	 ZlLw89odIepgutO0iJoLqqIQr8AmcN/6xJSsWVZDus39PJvgCTsqcTAMRI4XVgLkAw
	 LiKmgw5fSNPVDBcuuWJn7Zac/EQR+Rw/G1Zf6R7g2gK8S6VgxACQBquRwW6T2nl2dt
	 BbeBmwUlzvvrQgfZdhWYr8lnvVebeYQC0kfjbkuhr6frnEWN7a0cQ/L57dw2EgM64v
	 jkoOtb1K1nAUD0jO+0vhAzR8nUqqnKqFGFj5Hyf1JQUOxwnA2YT01Tih5sB2KaDXjd
	 sifSobfeCVWvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B4A3930A8B;
	Fri,  5 Jun 2026 01:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062362089.3097022.14883090293149597815.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:40:20 +0000
References: <20260602002506.1519901-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260602002506.1519901-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, edumazet@google.com, horms@kernel.org,
 david.laight.linux@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295556-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,google.com,gmail.com,vger.kernel.org,seu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:edumazet@google.com,m:horms@kernel.org,m:david.laight.linux@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C07676448B2

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 08:25:06 +0800 you wrote:
> ipv6_flowlabel_get() reads flowlabel_consistency and
> flowlabel_state_ranges locklessly.
> 
> Use READ_ONCE() for these sysctl accesses.
> 
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
    https://git.kernel.org/netdev/net-next/c/f425c55cb60e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



