Return-Path: <netdev+bounces-275466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AEoOH6Q0mmtYwcAu9opvQ
	(envelope-from <netdev+bounces-275466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 18:40:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AB439F009
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 18:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E61FB3006B27
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5201519E98D;
	Sun,  5 Apr 2026 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWhxmsJy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F51E40DFA5
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775407228; cv=none; b=Um+fSymYmYSUDF6GJZ/4yj3MhN7N0cvTQrdTzHO3do7JHkK6l8oR9Kcieh8E10EYfSbl4qVBmTokCR2RK516Imm0sA77LW0iRlSVyVkAkbMXJyw4KF5pi5BQscjxH7w3m/NqDaThM+IIlRv6sCWsO3OJoUWLz9CEgoymNfUWkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775407228; c=relaxed/simple;
	bh=1HKpano8jtxyT+x9AIUi0ZxGgSRnx76Fott+p3SMSNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nc36sYuGGGRc6Ktr6DSMF3+7r3j2iAo6748PxbsjgZbRjvataXIblo8Sb4XnbWdpjLZ0cGhDu3PU3Ley2yCWiIrFqlp5vKi4qdzWLvVgjT8rfBKAXYp4bIitRo6QT3TcGOEB5hVZD4oN8yO7v6W3ThsahPzJw2EuUkbvfgNVh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWhxmsJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F48C116C6;
	Sun,  5 Apr 2026 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775407227;
	bh=1HKpano8jtxyT+x9AIUi0ZxGgSRnx76Fott+p3SMSNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nWhxmsJynAK2jwzSXT9p9MkjQrcnDkdGyedsHVUNXExmgvVCUjbrinR8PNj27VBiS
	 HrGqb6f/2t5k5rSM6M2hTRO1ZhOtofMfWZv7aaRD3YRcqirbfilAMINFNWpxGbeCV8
	 y1UzlaeDGr7iJgv0k1BfCvwyWYoo/1QJOMyEYZ4vZ7nIO4MGnY6yxilQvhbFlFGTQR
	 sG8H/LLHRqZI+ZPKg/4MkU4k+rfSoZdz0uaqMhxCa2K/XBeYIHB6jgt9idwW4M75Ue
	 gt8/KwHFhCiyOjh9vGSHzLdi01i244vRBRlVMvTOOIMY2zHkQyFctJhgMBdtP7+MmB
	 uuQfiNGErLekw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FA53809A22;
	Sun,  5 Apr 2026 16:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] tc/tbf and tc/htb: Allow 64 bit burst 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177540720754.1989033.9642319274974127990.git-patchwork-notify@kernel.org>
Date: Sun, 05 Apr 2026 16:40:07 +0000
References: <20260323092918.11010-1-ioana.lazea@canonical.com>
In-Reply-To: <20260323092918.11010-1-ioana.lazea@canonical.com>
To: Ioana Lazea <ioana.lazea@canonical.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, stephen@networkplumber.org,
 dsahern@gmail.com, jay.vosburgh@canonical.com
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,networkplumber.org,gmail.com,canonical.com];
	TAGGED_FROM(0.00)[bounces-275466-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 42AB439F009
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 23 Mar 2026 09:29:11 +0000 you wrote:
> This patchset updates the TBF and HTB queuing discipline
> configurations to support burst sizes beyond the legacy 32-bit limits.
> As network interface speeds increase, the kernel’s internal
> representation of burst (calculated as time at a specific rate) can
> easily exceed the 4 GB threshold. These changes enable userspace to
> accommodate these larger values where the kernel API allows.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] tc/tbf: enable use of 64 bit burst
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=063071c4a8ba
  - [iproute2-next,2/2] tc/htb: enable use of 64 bit burst
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=f6cb25efa1b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



