Return-Path: <netdev+bounces-276798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AXiIsUU12kSKwgAu9opvQ
	(envelope-from <netdev+bounces-276798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:53:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B223C5C09
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7B533032666
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFCB36CDEB;
	Thu,  9 Apr 2026 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO+zZ4Ew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0E36AB5A;
	Thu,  9 Apr 2026 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703074; cv=none; b=pwbDMej5GQDvm2B83aDPzbz4S8twSVz8aQ23uMyEhZ0dDSBOoyUXE6bxU3IPKeGk8C3iPCZBa4d17KDMHJbtL4ggu1Ab6wnE0eJrcxJi+6CCaf3mqvnnn1jA6w5unGyLBLSwa8udQGFvSWvz3l78MJtgI+VZJKcYqXNFkJFJyoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703074; c=relaxed/simple;
	bh=uxreZopNNdkf+5l4WGyB8d1qFwXSiZYyfTnqUiaaRQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y9+4cdJP5Qujb1UGP/IRAG6B+7oqMyNBLX0oEODc7BgMGvvqpK02l2qk44AN9ha2e6EElbCGIpjR7esDbKOrfkGRnyIye4PG3hhSg2wpTZkovTwQ0Ktnxe3NjzWO4K/0glnCBg2U6wXGWdPNN7PLVKaXuZJiGfxTqXUyjJQWhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO+zZ4Ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C71EC19421;
	Thu,  9 Apr 2026 02:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775703074;
	bh=uxreZopNNdkf+5l4WGyB8d1qFwXSiZYyfTnqUiaaRQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LO+zZ4Ew7hBkZhdDH4oyr1iYA6oHPH0xIsBdFrhMvAgH0y1UtL03hY5zlNlIIqpIk
	 fJ4EM1lcV+t80V9gUCEjJsGVTdpDrXd7HfdOjMoqtlgYwAhNMmknV2RGGJTEwLTcsG
	 YDqBb+H8jn6xvcrt9m85i9a6zbvsKTeFjl4nemuckIrTKQ/TKz/Wq1H2JPmyXZGfdk
	 jReGBpmxNxFxoJXCp41eBTW3nL9lvknBwNFjaYRTTNAAR9K4oS0ydgU30APamsRSfg
	 ZtlfSnPASBjZ7HwXiZt8gHMQNf12AP/ql8mQvXR703DGFphTCBjghAaQhkhWB0chUY
	 jsmxZ4HoMAsGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF0B3930793;
	Thu,  9 Apr 2026 02:50:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Add Prashanth as additional maintainer for
 amd-xgbe driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570305030.968772.14804179031968447185.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:50:50 +0000
References: <20260406073816.3218387-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260406073816.3218387-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, PrashanthKumar.K.R@amd.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276798-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: E2B223C5C09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 6 Apr 2026 13:08:16 +0530 you wrote:
> Add Prashanth as an additional maintainer for the amd-xgbe Ethernet
> driver to help with ongoing development and maintenance.
> 
> Cc: Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - MAINTAINERS: Add Prashanth as additional maintainer for amd-xgbe driver
    https://git.kernel.org/netdev/net/c/30f3b767aed4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



