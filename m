Return-Path: <netdev+bounces-282568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJeoNC6q8mm8tQEAu9opvQ
	(envelope-from <netdev+bounces-282568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:02:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B8249BE5A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFBF53048F38
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E524BBFD;
	Thu, 30 Apr 2026 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwzZVpuS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C7247291;
	Thu, 30 Apr 2026 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510860; cv=none; b=dLemPPSksvWIYcNjQzx29P9XNEeUxoUqKwtvkcUR5T9uDIRVCYUt849d8kQsSkAyhVeG7mYoEccxsxwKgF8vJDsZqAjsKbnip2675ohAMv34Q07MZjkZLBKt/CbQm7tnJkZLtPLpfSNYe5VeCVK39HjwpuzgZYYvryNxJodg7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510860; c=relaxed/simple;
	bh=zE5Db1JOGYu8x01qkIIi7F5we9s05iV964wPXzcIyVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eJs3qBXmzMiRjvBWegrHRZXq8Fc1Ct7yc7WZr+lEUbVbkwx60DZdda0NSeAAUTTErDB/MkrvCg1RDi5j+BGhREllsd0Cn0SXKsf2BjGhIsSUWwKzPU4UR9JoRkWGNMdo6eWAJxVSPr9aglF+dbs24XI7dlTeGCdQFCzOC2fontk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwzZVpuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE29C2BCC4;
	Thu, 30 Apr 2026 01:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777510859;
	bh=zE5Db1JOGYu8x01qkIIi7F5we9s05iV964wPXzcIyVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qwzZVpuS0YXun3IQKyhTE/yDT4+CaRuTAIJ41tOe4A3RcbXIJ8jzBEUP9o0SrqYfm
	 mKlTiipH9FkhrU83kbJ7GNV7B/23YY6nNPJ18GoM7v3Cdl6NFI1fJXZbtcNDGHUhu6
	 alPHJGr9GNMu7QWGr75WCZCO3A2rpiaIL6UOwZHxwFGX2n1xLxP5rqRxg3vO8H9m1A
	 4egUV2Tb537TVnddPRWxGSQYeE1Skxz8zXyNyXvpWdI4v029pdbOax9crIOhb2xbJ6
	 hUuD/LPl1BhEKj4RL9SNUeUiTYTf0kPxWg4WehytZiCKsDIWNSt0A00Nfjncbig1Gx
	 bJsTnwT2R1AMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400453809A33;
	Thu, 30 Apr 2026 01:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8152: Use ocp/mdio test and clear functions in
 r8157_hw_phy_cfg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751081479.2244169.324712113730417132.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 01:00:14 +0000
References: <20260428-use_bit_functions-v1-1-6eb5a3507610@birger-koblitz.de>
In-Reply-To: <20260428-use_bit_functions-v1-1-6eb5a3507610@birger-koblitz.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 hsu.chih.kai@realtek.com
X-Rspamd-Queue-Id: 57B8249BE5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282568-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

On Tue, 28 Apr 2026 05:44:58 +0200 you wrote:
> Replace explicit testing of bits and clearing these bits by existing
> functions ocp_word_test_and_clr_bits() and r8152_mdio_test_and_clr_bit()
> to re-use this code.
> 
> This allows to remove the "ocp_data" variable. Also remove the "ret" variable
> which was incorrectly used for the r8153_phy_status() return value which
> is a u16, so that the remaining "data" variable is sufficient.
> 
> [...]

Here is the summary with links:
  - [net-next] r8152: Use ocp/mdio test and clear functions in r8157_hw_phy_cfg()
    https://git.kernel.org/netdev/net-next/c/b7ebbf9f7aea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



