Return-Path: <netdev+bounces-252428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PikC0dZcmlxiwAAu9opvQ
	(envelope-from <netdev+bounces-252428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:07:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA046AC83
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D5132DFF1F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A60D3D5F5D;
	Thu, 22 Jan 2026 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONNqPVKe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B403D5F47;
	Thu, 22 Jan 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098220; cv=none; b=aGxlTiy4QIqCiFt402UTDRYFXzUltcKwCt6aKwrj0mjQ0CxkGsLsuvVo4JhBgJYws9Q8bl1sxC8G3triHJMvJHl+Hh4+CI/RhD8WA7ka3rFo6qBB41S1hKKEJgkVo623k3XMImMuENbLmZ4GwxDt1fEiiNOofYzPop3Wa1UZlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098220; c=relaxed/simple;
	bh=wmN9D1mii93RGtYzMIyn+tXEJM+VpmTs5wnmyGizcfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C1G+4UAb1bHqexyv06vnxA2UVIRyhAXZT0EX+LnYD9LPvJXIDV504TVeqCY6a6U3Q18WnuTe5Tk2ksMRlvaDATAq8ApSBEf18H8T6mr2OJh1jSpP6S6vcLeCOrl/1qM1u+d7m9xOYsS1ITg87TRpwfj2buQ1YOS9nviHr9vFrJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONNqPVKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F26CC4AF0F;
	Thu, 22 Jan 2026 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098219;
	bh=wmN9D1mii93RGtYzMIyn+tXEJM+VpmTs5wnmyGizcfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ONNqPVKewRFdPGPjCpt5p0Sls6sorYSmWPmDsTjtx++vHPC/skp3+L5CYpMyyUK89
	 ebF1Q6C79HJKN6PdkNL9e6RJcTJaDpIfG6XahwOb4ROVHjFWoUpf17ex5Cs9pnAr9m
	 oiI9/Y19ty8ZZcg4Wifqno339mso572sYAcYnYTNYYYaqHfERAOFia5k1ikPqcxo+F
	 Lsb18fLGWJLzweslvw8PcW+s+JnQJdw0CkqJx3fizih0A19nmHBhGlpXVsAwSk5lEI
	 pf+1ttd78B4LTogO1j+qsiCvC7ljKeRQWUKF830LKbMH0BoV91b9WnoteRA4q8Wefg
	 GN3+PZRvRQDIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8E4D3808200;
	Thu, 22 Jan 2026 16:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2026-11-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176909821561.1785789.7612526392222191065.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 16:10:15 +0000
References: <20260122110248.15450-3-johannes@sipsolutions.net>
In-Reply-To: <20260122110248.15450-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252428-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AA046AC83
X-Rspamd-Action: no action

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 12:00:15 +0100 you wrote:
> Hi,
> 
> Some more updates from wireless. The only interesting thing here is
> that there's a merge conflict with net-next, see here:
> https://lore.kernel.org/all/98386125-c0bb-495e-b2ba-2765aaed19d8@oss.qualcomm.com/
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2026-11-22
    https://git.kernel.org/netdev/net/c/9146fe282990

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



