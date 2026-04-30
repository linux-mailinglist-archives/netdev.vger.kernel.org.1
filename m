Return-Path: <netdev+bounces-282569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIqyL1Gq8mm8tQEAu9opvQ
	(envelope-from <netdev+bounces-282569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:03:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AF849BE68
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD0E13058678
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28B426FA60;
	Thu, 30 Apr 2026 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPrPpskL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8926ED46;
	Thu, 30 Apr 2026 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510861; cv=none; b=NEGcJUcG38cq0In+HGfl0xSumEGAODTG9gyF8mzozgfsntnL3SYh8ZwbHKaMDP1Vw4bR4vjMcwoxqQHSa7YFvAVpE3l0ecRQhf+/uRblNS5RgqLDoY2Yag2VyMf7Vi/StIGQEMvBnqSYVzrert8qqSAmrgt2QLzKE1wvOVmeniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510861; c=relaxed/simple;
	bh=IsFQPTi1H47wzoR8EhcJ9tkO9M4yeT8mb5aj+6cHZdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gs1I6+myTrLdSzJGSpmqzxIe/YqwAM3VRqelqCGNuMw1Nu2nTJZZ3qMCY7oZa0pY9X/DMZzGNSUy9fH6yxT0LG/LYD1An8J/2r7ACj7VCe/IGt+I3N7prtNMSJCGLic7lUc/KHF026FF4IYVSbLYIJ8srmDwT2GnhhWTaiW4lSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPrPpskL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2FAC19425;
	Thu, 30 Apr 2026 01:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777510861;
	bh=IsFQPTi1H47wzoR8EhcJ9tkO9M4yeT8mb5aj+6cHZdc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aPrPpskLMjUXvudD1o3m1VODTnxOYiogcWSgaBHKz6rNOlGW3eeVjwC24IVVKJFG5
	 Hrd3KheGe9YEXldUGcHKW7gD+pgEyTSdvGXpq2EZoVaeknZHB876rHXoObo/Mlk0Ck
	 58/VBu5jkREfu/g7ad4/jSHYqFY/PltT/Ku3jUIaywm8YWzR2ZXBbBaJQsoehWOh8Y
	 V9dyiMBdnNtJGmcfl7AKehpMDeE/bH8UgtXX7diteD3llYl8gNnC/2eaaw9mjSHHts
	 OksG+xWvyEup3IV7YT03HMpcLLKSK1jbG2xLSZOSwGzMCEsjKr7Pmksuq7/Ss/8u15
	 OlH8cKkCI6NlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDAA3809A33;
	Thu, 30 Apr 2026 01:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8152: Fix double consecutive clearing of
 PLA_MCU_SPDWN_EN bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751081629.2244169.9497125151740458569.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 01:00:16 +0000
References: <20260428-patch_double-v1-1-27c830a9eb2e@birger-koblitz.de>
In-Reply-To: <20260428-patch_double-v1-1-27c830a9eb2e@birger-koblitz.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 hsu.chih.kai@realtek.com
X-Rspamd-Queue-Id: 53AF849BE68
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-282569-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 05:43:38 +0200 you wrote:
> Due to a Copy & Paste Error, the PLA_MCU_SPDWN_EN bit was cleared
> twice consecutively using ocp_word_clr_bits. Fix that.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> ---
> This fixes the issue raised in
> https://lore.kernel.org/netdev/8b324f8c-f4f8-4e90-b5d6-9b87ec3daf2b@redhat.com/
> that due to an editing error, PLA_MCU_SPDWN_EN is cleared twice
> consecutively.
> 
> [...]

Here is the summary with links:
  - [net-next] r8152: Fix double consecutive clearing of PLA_MCU_SPDWN_EN bit
    https://git.kernel.org/netdev/net-next/c/115553b80f77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



