Return-Path: <netdev+bounces-270830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKrFDeTfwWnxXQQAu9opvQ
	(envelope-from <netdev+bounces-270830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:50:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 908DE300054
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E478E3019190
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084123EAB0;
	Tue, 24 Mar 2026 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTlGDpZA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA41FCF41;
	Tue, 24 Mar 2026 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313419; cv=none; b=PZfvp6PwBH1Z7dQfp9rR79KXzpiN66RgDqSAFgR5Xv7rxJ0uvYigBy9Ne+w5sDpxhl3UglJKFnN2+e8+/NFm5KJQ3ZLFCyyLelB72s2Swz0hQXYYLiD9O6g9Bu1xafJuwSdCZBsyJKslBmjOD9mUHOl/vEdfxMDeHcEUUbAX/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313419; c=relaxed/simple;
	bh=99lmIgZHaCLqW381BWoAR3SRmhq4gGskVXvw8QgOoiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CN7eetOV9MVWQPvBEQRxPfeI29tNLMhlhS8tBM0iDFIKcNj6Tw9SZdKYNNg5FrjTmKXSoGk+oMcBd3GIAe+0jSTyvXSVwlTpbJfPb3E1/d8CYs4H+5tjBPeKKrq/GX8ckM0lYswf+4ZEMZnMBv7ggvorSd9EicvwyP97eccxfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTlGDpZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3F5C2BCB0;
	Tue, 24 Mar 2026 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774313418;
	bh=99lmIgZHaCLqW381BWoAR3SRmhq4gGskVXvw8QgOoiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lTlGDpZALVk6rxPuLs6em8DVzEk6iuVgl2UgOTnKHMZIk0Ba8jK9wFCMypH0AeopU
	 kx4EyYj2n/2jsmdTMWQDHM6vZDWRciNJs7VMALXytal8UpYrsUYrFdLsP3cgOStGDW
	 4/XS2lmsEy1v7yjjmAv+ez2mN+ypa9niW+LrqhIdNZLeLC0JwCVecNj3xtVXg2lJ32
	 hY2scNCRMSvJHg6Loe7S+nZZR/IIgQ2UuCRdNrnCtze0n1/X56UrrqSeSsWSFtaUCS
	 VjLodO4hAMln5qUQuR4YDNtpbeQY/8+NqxNgJACnmz3LK5Sk+rD2YyRa5uzDQpkrVt
	 jgiWwAIJODkSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F083808200;
	Tue, 24 Mar 2026 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: b44: always select CONFIG_FIXED_PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431340679.395707.17189306552308152932.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 00:50:06 +0000
References: <20260320154927.674555-1-arnd@kernel.org>
In-Reply-To: <20260320154927.674555-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com, arnd@arndb.de,
 vikas.gupta@broadcom.com, bhargava.marreddy@broadcom.com,
 rajashekar.hudumula@broadcom.com, ebiggers@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270830-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,arndb.de,broadcom.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: 908DE300054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Mar 2026 16:49:19 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_FIXED_PHY=m but CONFIG_B44=y, the kernel fails to link:
> 
> ld.lld: error: undefined symbol: fixed_phy_unregister
> >>> referenced by b44.c
> >>>               drivers/net/ethernet/broadcom/b44.o:(b44_remove_one) in archive vmlinux.a
> 
> [...]

Here is the summary with links:
  - net: b44: always select CONFIG_FIXED_PHY
    https://git.kernel.org/netdev/net/c/3f0f591b44b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



