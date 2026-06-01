Return-Path: <netdev+bounces-293690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKWiG4BrHWrqaAkAu9opvQ
	(envelope-from <netdev+bounces-293690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:22:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C161E401
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 611B9304AABE
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9F63A3E78;
	Mon,  1 Jun 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ0g1cOe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D23A3822;
	Mon,  1 Jun 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312848; cv=none; b=NO/6sks9ehJgA14DaMGqMWvT9TPEWvcn2gMXFufXqzyAV7YSWZMr5D9xkHIEoEQDU82lLvZvPIL9IekQxJLQ+FlqebJSw5n/KBTSEx7vtQSsAq+w8XP+7kWBbiF/pwAvw0lI8MK4oY/AcCFYFZ5ZFDJF9mfOW8/AHP91xaDTN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312848; c=relaxed/simple;
	bh=XPIUY2I5ceNWn3ztFYdTudKf7IWJ5vll6brJyXFxmAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZvTWrNgPGQtT3HP7zPF8niHPipNFTfNqaeFOUMY2Wd8lQCxZFrXpLiATNSV0KNLVeyirOlv00YRXdlRnXfPoXPMBXOLBCTkLMHkPmsLbx6qguw0PcPPbqQ0YN+vNIgnmGaElXVLUCdcpEGEqqJPgtpj9uY04zHDFxj1kcJVHQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ0g1cOe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BAD1F0089A;
	Mon,  1 Jun 2026 11:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780312845;
	bh=hdgZIA68WvPARQIRFeHCRS2AXCrY5O3OZhsXthXGdss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WQ0g1cOe6/dwDPx8311IJz24wnKyPkLh7eELZInCUoNg5t4zkLMz0PZT4YwBuZR9Z
	 WSZlJ0JHcwuzZi/0DtZsHery3FvO3wJB3qJLExMvanQq7T6vn8K9cwf3vWm0gdBH5P
	 41USAg+0xedh8qCEHpvNlfOWylHO3NMhbNkEAldhV0tejudAfMCpBYdhbKNcyrXZGr
	 +DXkusW4wemKOGi3e8JMvIoV+MuGWcf3GrndKLdtAghKEbdKyicbyMu1QN1+YjTFbo
	 5H/CEAWmkv33OoWldTY2nnb+Vj8gv7UeJHaS/LFHgzdFFMZqod6le0pbjEO3fAXN+Y
	 u2IAevP+jDZrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C338119CC;
	Mon,  1 Jun 2026 11:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v7.1-rc6 (part 2)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178031284790.3629264.6252934778726012474.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 11:20:47 +0000
References: <20260529210255.4017083-1-kuba@kernel.org>
In-Reply-To: <20260529210255.4017083-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293690-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D87C161E401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 29 May 2026 14:02:55 -0700 you wrote:
> Hi Linus!
> 
> The following changes since commit 3e20009988e2470063824c58b19d1c80816cc46d:
> 
>   Merge tag 'net-7.1-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-28 13:13:48 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v7.1-rc6 (part 2)
    https://git.kernel.org/netdev/net/c/f3be0c984ecb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



