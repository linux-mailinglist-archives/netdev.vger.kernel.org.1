Return-Path: <netdev+bounces-258192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 41AoL9cFjGmiewAAu9opvQ
	(envelope-from <netdev+bounces-258192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:30:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F3121381
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA0B13009500
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFD53542DD;
	Wed, 11 Feb 2026 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPyLQxn1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4CF2EC09B
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770784213; cv=none; b=mTZ1lS46x+0Roksx4z1lUiIZn2uKH4yEHKR9gfKUYkUERwPuGdGjkJXpfxMInGwLilkFYsXv3h3pzOcxapiFQb0ocwYaunu/krSVbutSXa9/DMAzOkVHeULRyIxFt2vDCYzOw5L3PMzNsqr19ql6VX5L1rs/eXOqRqgP1MwlFpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770784213; c=relaxed/simple;
	bh=EjEgfsjPb16eEdeXpwi/ufKgrcButhrI/c6Fs9UdCAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XWyzA8TMsn+IiXw6TjasiLf35pqmeil7WU2Y+ZyVZr2w8npjKGDDm6+dLJh1xGjCMmxxGryfRLzTC0G+s0zIePQ5u4oSaKHQHk3LitOjxy0VacedLG18UADocT9ALKtr/TG0qYchco2RxgD7VCooDW1B5+aW1tAX590jm3V4o0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPyLQxn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB137C4CEF7;
	Wed, 11 Feb 2026 04:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770784212;
	bh=EjEgfsjPb16eEdeXpwi/ufKgrcButhrI/c6Fs9UdCAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FPyLQxn19ANFc9kbB33nlgDFAsTcW8xPFbZVj5evkpz0NpCiII1uOBCCRqdNF2gZk
	 EpGkgngV2P5Fd+mPQ/RmcS4cEPHK+RHeq5bXG2uSaSewrQq29321C/qoitlaRBpEW/
	 9imxA1oO5McnzawkE6iaQ7Oz0d3zyWULHED9BRH8FhFZpbWSOc2HwO/OC4YzjqfT2P
	 LBTtowflbAL1HtOcwDrs51UmwSO19vi5jyNwS50MZrnkK2XayFawXVMStxtG6EDswq
	 wzwItWx8AcpDSc/kG6jAOJ1tDZXn5rIH7ku3D97IhBeaHmmmaGozbeDzZF2byjfxI9
	 evQvMdQGXu/Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B07C380AA50;
	Wed, 11 Feb 2026 04:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] bnxt_en: Add RSS context resource check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177078420783.4194295.3293083983118159892.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 04:30:07 +0000
References: <20260207235118.1987301-1-michael.chan@broadcom.com>
In-Reply-To: <20260207235118.1987301-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-258192-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F5F3121381
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Feb 2026 15:51:16 -0800 you wrote:
> Add missing logic to check that we have enough RSS contexts.  This
> will make the recent change to increase the use of RSS contexts for
> a larger RSS indirection table more complete.
> 
> Michael Chan (2):
>   bnxt_en: Refactor bnxt_need_reserve_rings()
>   bnxt_en: Check RSS contexts in bnxt_need_reserve_rings()
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] bnxt_en: Refactor bnxt_need_reserve_rings()
    https://git.kernel.org/netdev/net-next/c/5a2f3aa2896f
  - [net-next,2/2] bnxt_en: Check RSS contexts in bnxt_need_reserve_rings()
    https://git.kernel.org/netdev/net-next/c/b9355ad52b38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



