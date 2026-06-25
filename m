Return-Path: <netdev+bounces-301811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aVAZJLh/PGoYowgAu9opvQ
	(envelope-from <netdev+bounces-301811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:09:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D036C211D
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:09:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QOeaxYZb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301811-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301811-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C806303FDF0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5E368296;
	Thu, 25 Jun 2026 01:09:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD1329367;
	Thu, 25 Jun 2026 01:09:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349749; cv=none; b=WHK0sC2y7fvMlQpynn2wXs7GVMe7s2viS56P8JKMwv18E3FyI7ROPF4GegiJMBHcLFwQfWUAMJikmr37BpUfYnCJoedQplrgWqMhTdCIBKRGwUzMrPnqYCpWoZhMAOoE4UvliOV23ar9RNnyZO09r5naxl4r4dELjiTY5iYxiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349749; c=relaxed/simple;
	bh=QdpxjdLKQXhd/9c42dttAVfWFHmlS7Ad4Mjy0yCuwDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VPT5jNug6kWeu6sux1iGyGO2z7U4Tk3Gjanx5C5ZmNvXXd5Ssl+jNhKZY8zyHnf/RU0phk542NYiWrPF0MDmZmIjEM0E/AeBnCBO6TBGqDgA7HKkYGx9I+DA7xpeEEmO3SkAaQEOMLcoG+Dsrnt76ej4CSQ2hR9XLcdQbixbgck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOeaxYZb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC5E1F000E9;
	Thu, 25 Jun 2026 01:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782349747;
	bh=aEyxyFWrLqjdUO9HK8isXKGS6z8rSKYj9whMQhaLB6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QOeaxYZbxqGGy3EAb20ZPGcinOJ7InCLIFOS7DPId/hicdCeOyt/66JanGZecvTZH
	 WfESjPjiD6elDgBfev+AADp3QQ4t0vCMaVTV82iU4lpFSyvJYxzhaqKyUl8mLwYyQD
	 Xr3/XUthIBkvSzhS/knUiJYxUP981HuUVC7uI2yYhKMrz4PSu3u5ik7drBaRUzEeyv
	 Jf5qSQc62azXKyxkBSIJjH3INaBRuxKM8wC6i6b0bSNzAf+SkqzGJHyURRIbEPrOyt
	 W1Db1K4oat1JjYRQktIcqziT64Ize8CC8pdgG7xxgtOs+6fgYZ6zNA7Cfc2X0y8RiN
	 2v+SUpwXC9e6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56E533AAA0F5;
	Thu, 25 Jun 2026 01:08:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: dsa: mxl862xx: avoid unaligned 16-bit access
 in
 api_wrap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178234973601.3045401.4338455297838317160.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 01:08:56 +0000
References: 
 <599327521db465a534d277de53ab9b6cac01928b.1781702256.git.daniel@makrotopia.org>
In-Reply-To: 
 <599327521db465a534d277de53ab9b6cac01928b.1781702256.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301811-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0D036C211D

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 04:39:25 +0100 you wrote:
> The MXL862XX_API_* macros pass the address of a stack-allocated, __packed
> firmware-ABI struct to mxl862xx_api_wrap() as a void *. The struct has an
> alignment of 1, so the compiler is free to place it at an odd address.
> 
> mxl862xx_api_wrap() reinterprets that buffer as a __le16 * and accesses it
> with data[i], for which the compiler assumes the natural 2-byte alignment
> of __le16 and emits aligned 16-bit loads/stores (e.g. lhu/sh on MIPS).
> When the buffer lands on an odd address these fault on architectures that
> do not support unaligned access, such as MIPS32.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: dsa: mxl862xx: avoid unaligned 16-bit access in api_wrap
    https://git.kernel.org/netdev/net/c/6b3f7af57881
  - [net,2/2] net: dsa: mxl862xx: fix use-after-free of DSA ports in crc_err_work
    https://git.kernel.org/netdev/net/c/bcb3b8314611

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



