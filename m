Return-Path: <netdev+bounces-262251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP9OG25so2nBCwUAu9opvQ
	(envelope-from <netdev+bounces-262251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:30:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF321C9832
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E3F8301469A
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A187363087;
	Sat, 28 Feb 2026 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZQ46xHn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FED35AC07;
	Sat, 28 Feb 2026 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317802; cv=none; b=jaUOI9BrGXLg/M4EkLTjCh9XxVU20UqtzHVUfrYvWC2Y7Tv/9LaipoXBT8YoAOtt3ZuAGAk6GOdAPF270YofXGwycbcUmL4nlSa9BbHZ6Oc7Sf8xhRHRTR4blbqd5bfa3JZORhv6UC2MohbgyUhlkxJ3jwN7WCMgeR/Ac6eyv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317802; c=relaxed/simple;
	bh=2/TNXlXKLYIuXvVa2y0wj3Jx5F4yk/6Zl7Los27eihk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r0jlzXM0jrL2ueb9edsSCKodQsX/4K/dlMjY9W6tRznVoNj3gniMgZsydiPkrlS8QyHQPk4im84Fpon5zw2EsEJo1H6tBvoGmJT3ZvON8aglkqklThHsInwf+lFcoLydBBYj4fZOEyQhrq/GHXiSvUn1ySUYZ9DtsfAS7E4T7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZQ46xHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0572BC116D0;
	Sat, 28 Feb 2026 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772317802;
	bh=2/TNXlXKLYIuXvVa2y0wj3Jx5F4yk/6Zl7Los27eihk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZZQ46xHngbxd2GNqgUrYKcSmSVife/N+uyusJyF0BKRCar8O6wYB9f1xL8F0dkL5y
	 3wfPAMduOIKQppDMf6m/AxnQjEEPuB/FXzVLAzrh2r+p2364ORE2Wx6INXEVjnuB3M
	 OmkUqbvigfGCFh4wukTs9bPzaMipJRFGm39/kW3j/5sK+JAoK324ADQF4xIt6jovbv
	 oFGks/isyQwaPC19oYRxeo/UxYaDlu2BLq5jpssX0L/gDZAUvTZVqgsjm6eMwtHLJl
	 ZgeHMQjXCTZDGzCRi6f7zR4JV3vgpOfrLz6J5cANd72FhOf0kwoNpTWD8uieqXD26i
	 jJHCXLcNsfGNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEBF39F2024;
	Sat, 28 Feb 2026 22:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] amd-xgbe: fix MAC_TCR_SS register width for 2.5G and
 10M
 speeds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177231780505.3147597.8625597502733570293.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 22:30:05 +0000
References: <20260226170753.250312-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260226170753.250312-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, Guruvendra.Punugupati@amd.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262251-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDF321C9832
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 22:37:53 +0530 you wrote:
> Extend the MAC_TCR_SS (Speed Select) register field width from 2 bits
> to 3 bits to properly support all speed settings.
> 
> The MAC_TCR register's SS field encoding requires 3 bits to represent
> all supported speeds:
>   - 0x00: 10Gbps (XGMII)
>   - 0x02: 2.5Gbps (GMII) / 100Mbps
>   - 0x03: 1Gbps / 10Mbps
>   - 0x06: 2.5Gbps (XGMII) - P100a only
> 
> [...]

Here is the summary with links:
  - [net] amd-xgbe: fix MAC_TCR_SS register width for 2.5G and 10M speeds
    https://git.kernel.org/netdev/net/c/9439a661c2e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



