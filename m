Return-Path: <netdev+bounces-283050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOQzHaT982nj9QEAu9opvQ
	(envelope-from <netdev+bounces-283050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE64A97AB
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD808302A1A3
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888A329B78B;
	Fri,  1 May 2026 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgsNhjTt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FEF264A9D;
	Fri,  1 May 2026 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597855; cv=none; b=E66cnE5q01t8ABQi/QUCaOcmdQ+N6AX7a3rKVh+l+OFFGtnJRXyy0iS5fop/Ldv3953QbacLS8tdatIcmJmJo4omE1gVKMHRmdkMhKiH4xac8QBR29WDcaP0kR8H3ScXWTp7geeQ6BWSCZ8M+UcmUppG6o1MuQOiNSXndG0fZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597855; c=relaxed/simple;
	bh=vmLTIQiX9TJRhVtASF0t/qJzyLgi0syXKAtXCMwtE7k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lZclgeU8ONS3Jyw36Nc7PRp8vpxEeXjwKhqd8tyVgrgkNhDUsooQjM5zAPB+l9dLjckV4EQwTg78flW9FFF0hU1bYPyYXS0idyyqtpLbEt2h2cGV/0F32/nGHLxSxkReqZr6i4Z233RMu5txRcUWOWBbK7X46VViIxJcjPChBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgsNhjTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133CBC2BCB3;
	Fri,  1 May 2026 01:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777597855;
	bh=vmLTIQiX9TJRhVtASF0t/qJzyLgi0syXKAtXCMwtE7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cgsNhjTtjT7SdWoxptk9DSUqZI6b3r98/5apYKxmFxlBpxjcUhAZAeb6yIAWzB9wS
	 bj68o8T9G7BptSr4ekXnfk4ER8eceWmWJEIHU11J8aXBHk5fO7th8H7KDqOfhI1Lf2
	 jZ7OLK992xV2cHNCdpO+zv5zlWahkKrUbhsuVXjsSNF/f5N4YfeOVLZqAl+tE/e39c
	 V8Ynx3Zw6JFzgpRQLjq0nAbwWbISYWVCk5EcCZ0KxkpSWHzbv7ZXNcyiDd+279LEXE
	 2sSmyOiGUEoNnptjgFYtDT5XIGJIEt0TV6/bbA+UgQu5I1OffWbZI5+ezKikPTBz4+
	 uys4RsdUu1dcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6B9EF380CEC4;
	Fri,  1 May 2026 01:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] bridge: Do not suppress ARP probes and DAD
 NS
 unconditionally
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177759780930.3275259.156910410362336088.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 01:10:09 +0000
References: <20260429062405.1386417-1-danieller@nvidia.com>
In-Reply-To: <20260429062405.1386417-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: DFEE64A97AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283050-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 09:24:03 +0300 you wrote:
> When using bridge neighbor suppression in EVPN deployments, Duplicate
> Address Detection (DAD) is currently broken for both IPv4 (ARP probes)
> and IPv6 (DAD Neighbor Solicitations). This prevents proper address
> conflict detection across the VXLAN fabric.
> 
> The neighbor suppression feature allows the bridge to reply to ARP/NS
> messages on behalf of remote hosts when FDB and neighbor entries exist,
> suppressing unnecessary flooding over the VXLAN overlay. However, the
> current implementation unconditionally suppresses ARP probes and DAD NS,
> which breaks DAD.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] bridge: Do not suppress ARP probes and DAD NS unconditionally
    https://git.kernel.org/netdev/net-next/c/fee1fc1d5a54
  - [net-next,2/2] selftests: net: Add tests for ARP probe and DAD NS handling
    https://git.kernel.org/netdev/net-next/c/a3f88d89f698

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



