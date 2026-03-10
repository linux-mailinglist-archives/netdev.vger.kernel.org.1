Return-Path: <netdev+bounces-265879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHCcGtKJr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:02:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D06CF244908
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12A893135A78
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36293A7855;
	Tue, 10 Mar 2026 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCKniEuH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1D34C130
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111643; cv=none; b=TqpRoJPlslb/VoX0r1zrCeq4uwLV1v+CwWVeTdWUsAM+0oARfQIj+5STqtdZ3EsU5Fnk1S9Hvs9wHaSf3el3veYOFoOaoSwCsHFjdCXB72Tf1Y2QR9rM8VdRw9JfLmbLxhcjLKtpZT73fIHBzxK94V1RyPo5JmkVA7WEFLNLY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111643; c=relaxed/simple;
	bh=YM4VHlYHZeV/VlHEHVfQnap5mDWqb6a13CQDyjVMGTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TJfFc/xCVjC0NEDDTLfZDStRU+0ZGSuOXcpYosVilpQ/VdwLAZ9oRdZ/LDrjCm9NJVX04DDGWl5zJMUy+66oqIpDfWtoha1tRpgb4nAiS26SYK/YHIeiqBenRxkppq2DkARwv614ZJi2Wvtg07MDa5sXCFXxRraXA3NSc61NE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCKniEuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DFDC4CEF7;
	Tue, 10 Mar 2026 03:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111643;
	bh=YM4VHlYHZeV/VlHEHVfQnap5mDWqb6a13CQDyjVMGTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vCKniEuH8QGrilujVW7sMirCKy6hb9lNEymqM1mNllKkKJZpWrZ590TJNdDZ7aToI
	 4COyZI+8M+8zXJwbz4XwTBDmYZ7RD7gxMsChXiYZoYdHBu3kPgNCTi0LV2FVV9YUlv
	 zOC8loyBaq5GFDkMCquRQOPvw6HIZJpRxe8i/t3MEmdK1F/f9TMdz3a4PA1RKC/ocA
	 RMR/IzP2erE9+H3p5PWQ8ZaC6JJ28tAE1P6xaSQnihDuJWxLSwcsFY2j72RqfZy5w3
	 kADBQzNA6jyGM0G5l0b1/SxgqLfwAii0BI5JuNLacQ9YskiqaC7GqaU7d7B29Xr6Ps
	 1/38lTzbmbXKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DC23808200;
	Tue, 10 Mar 2026 03:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/tc-testing: Adapt test's output to
 HFSC's
 iproute2 printing changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311164054.2039470.13670480314698242530.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:40 +0000
References: <20260307220724.2501212-1-victor@mojatatu.com>
In-Reply-To: <20260307220724.2501212-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, stephen@networkplumber.org, pctammela@mojatatu.com,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: D06CF244908
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-265879-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 19:07:24 -0300 you wrote:
> To make the printing of HFSC's defcls consistent with HTB's,
> iproute2 is now printing defcls prepended with "0x".
> 
> This commit adapts test a4c3 to this change.
> 
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/tc-testing: Adapt test's output to HFSC's iproute2 printing changes
    https://git.kernel.org/netdev/net-next/c/56acc7f51974

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



