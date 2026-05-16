Return-Path: <netdev+bounces-288523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBT/Id68B2paFQMAu9opvQ
	(envelope-from <netdev+bounces-288523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:39:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D514559901
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8533130065E2
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A76253340;
	Sat, 16 May 2026 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT257aCI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7B2609E3
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891995; cv=none; b=sR7tKDO3jKLjxT8JlHEZVsUtrokB31o29RUarV+CVfNORfGfokGxiYjLT9k/E9VN1De3bC6Ojy+MungEo2afMXHPld9Jl4HuQKabTcSkyT84UmkUp+tQw4EPt1sDWcQccTwmNQyXDykxi++EUlk/BE62SOoBzuSwrzcDdk1FlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891995; c=relaxed/simple;
	bh=EOqSeO3QvugFD35kGK9YlzXpxedFTfucdlbbBqi9v00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s4CgM61DQLyHOAs6hOpXtLg1aBS35JdtpKpa2nCscPv2gRSmJh4E0mmL/UzmMGe2Rsi8hi+eV28Hfc5LtP90kC+EjChhA1A0rkwb3j6qFIt6/x1xIRlnCUKuMTQtjbgFPKmNHBB9iFP2OgLHNyhxqgSR2B0ROwMN9hnfbtTJlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT257aCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C469C2BCB0;
	Sat, 16 May 2026 00:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778891995;
	bh=EOqSeO3QvugFD35kGK9YlzXpxedFTfucdlbbBqi9v00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GT257aCIPnxOifVWgExdG5ZNlkf80+Yihcq7oHyzknu2jZa2AIof5ooKmtEo7rnZU
	 /eyNzVcXs/64lEvSd2Bws4hjqpw3Mxt7Mqtz7omA7m0rVwiLbSOSHAQ6WViVqV1jf+
	 d9J3MhX0PkCHMjYcJFjerh/CKRLk5hVcnaSh4wvtJzXstCpE+i/aZOULqzeVrICsLO
	 NgBWi1U8pOltJ6e7QRG0U3kAVpTx0Y9MzBqoYsZtKcMAjh+IJ8uANKgRhIOY32iqk7
	 b0Lvz3duGkPhwvXkaZIDbXNb2EJDcBpr49P8eL8aPLlHQMx+q8eE9Zgl4iUoM2TEi6
	 80Ba9/MwoVuKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A6B3930A23;
	Sat, 16 May 2026 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net: hsr: strict supervision TLV
 validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889200813.209257.3024065532842824125.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 00:40:08 +0000
References: <20260513182657.20346-1-luka.gejak@linux.dev>
In-Reply-To: <20260513182657.20346-1-luka.gejak@linux.dev>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, fmaurer@redhat.com
X-Rspamd-Queue-Id: 3D514559901
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-288523-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 20:26:55 +0200 you wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Changes in v6:
>  - Dropped capitalization comment changes per request of Jakub Kicinski
> 
> Changes in v5:
>  - Reverted TLV loop in Patch 1 to strict sequential parsing per IEC
>    62439-3.
>  - Retained pskb_may_pull() logic to ensure memory safety for TLV
>    headers.
>  - Dropped Reviewed-by from Patch 1 due to the logic evolving since
>    original review.
>  - Added Assisted-by tag for AI-aided translation and formatting to
>    both patches.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net: hsr: require valid EOT supervision TLV
    (no matching commit)
  - [net-next,v6,2/2] net: hsr: reject unresolved interlink ifindex
    https://git.kernel.org/netdev/net-next/c/85ee970039f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



