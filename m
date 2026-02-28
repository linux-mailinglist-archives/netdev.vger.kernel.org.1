Return-Path: <netdev+bounces-262265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INy9Ith8o2noEgUAu9opvQ
	(envelope-from <netdev+bounces-262265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:40:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE81C9BF8
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B511302417B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E20326942;
	Sat, 28 Feb 2026 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GilDwZHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502C430BA7
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772322005; cv=none; b=k5ctVwopX7BfmPqGM/UDjzEMEzF5aWrlZso2Yri6LTEtwieS2Ecj8/etLQMx1WRN4l/UzhJMvjvGQ2QdSm0OSiFqzTL5V70dB75HEmR1HNHFZ5O9Ovw2WOhzNWBUaBj5jPhDdo2oWjh2BD88YrGzIDPNjIu13RbeRMMbmEQOjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772322005; c=relaxed/simple;
	bh=IwdE6wom4mcbJNKyzW8NO9f1DOajLByYqNJip8cCx8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qdG8ETGX/NjUyES22jNOVBuzol69A6N5C9Er3d6Yl4jpFJwlWpaliGiq962hJEyfHgjahraFpBpuToEnb5joajP580AtMHCk1Wd4UcIuTniFoSqVSldqwanvOyoaagSi9hT7NPXMeUscjTeKXM+ziH8tFVLgAOi9aEKz+wbleVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GilDwZHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46813C116D0;
	Sat, 28 Feb 2026 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772322005;
	bh=IwdE6wom4mcbJNKyzW8NO9f1DOajLByYqNJip8cCx8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GilDwZHMMbkpCI9F+wRDJo+BQwJq8lxvGgJxYffUpefyjhjTDzkc2nWlKkAnnsGg5
	 i8FCkleof2WDOuKQtViGhpECcJRvqVm49tfLDAmMQtmPXDuyX+KrBlpgSW72CF8plN
	 lDE357raKVQYgCdWd4FVe6HP6rlx3AF4dTGJMYO46SVjw8yClw4WHBvccMGyTtIpju
	 hze43pjEeJPYU3AcOSN585sr24XDartDINn6iqFzimd1mUeKBrt/q+g7ZXzUIigUc4
	 WBLRd/RVcOMWo+VdSeqW4H195a9/irU+TLarflmsmK01eDwLH4mgw8ko6g0rLkG9ZS
	 0bbe1iBkrcWow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE6239F2024;
	Sat, 28 Feb 2026 23:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] icmp: Fix icmp error source address over
 xfrm
 tunnel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177232200830.3160001.17229886409888016665.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 23:40:08 +0000
References: <cover.1772101380.git.antony.antony@secunet.com>
In-Reply-To: <cover.1772101380.git.antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
Cc: kuba@kernel.org, steffen.klassert@secunet.com, netdev@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, herbert@gondor.apana.org.au, shuah@kernel.org,
 devel@linux-ipsec.org, tobias@strongswan.org, horms@kernel.org,
 sd@queasysnail.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262265-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDCE81C9BF8
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 11:29:51 +0100 you wrote:
> icmp: Fix icmp error source address over xfrm tunnel
> 
> This fix, originally sent to XFRM/IPsec, has been recommended by
> Steffen Klassert to submit to the net tree, since it changes ICMP
> behavior.
> 
> The patch addresses a minor issue related to the IPv4 source address
> of ICMP error messages. The bug only occurs when xfrm policies are
> configured. It originated from an old 2011 commit:
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] icmp: fix ICMP error source address when xfrm policy matches
    https://git.kernel.org/netdev/net-next/c/595da751c822
  - [net-next,v5,2/2] selftests: net: add ICMP error source address test over xfrm tunnel
    https://git.kernel.org/netdev/net-next/c/5b43d35e571f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



