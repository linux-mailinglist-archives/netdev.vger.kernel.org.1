Return-Path: <netdev+bounces-300221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g9oMGnbWMmon6AUAu9opvQ
	(envelope-from <netdev+bounces-300221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:16:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4869B9D8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=URrAEFvT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300221-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300221-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0390B309ACC8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0DF326951;
	Wed, 17 Jun 2026 17:16:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E3315D29;
	Wed, 17 Jun 2026 17:16:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716594; cv=none; b=N/rsSshmOfjj8PGh3O14DO7qCZTOV4/0gGEAa7nta2cAFIdIxYEJQc5vvV4PRGdWY+rW/AB6uRIjWoTypN86e+3xE8bOsMf3jCSF6v6fPRFzs32v+MFaLGebofhb3Lve/Rtg+lFheKtuBgI3zafLCdSTusKAfN+C/tZyKI2VjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716594; c=relaxed/simple;
	bh=jU5sPUIFVRzV/S+NmQ/FUaJA2WT/+mvjW8lRLl3dUVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XQWhAbd2xGqLEbpVkjv/CU2CgYSEDp+J2ZVnAbAoDtjoFtebgnZ0KgXaeCRG2UKsVytyXpbhMk6phypJ7Wk37pYBiSOIeU4dOnawr8BgD4kxTiGBHSHX9Qz86Cq4JiwcDgmcIigMYj9xd7lT0NMoUosuN2S1ctF02Gv5WaBESCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URrAEFvT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185521F000E9;
	Wed, 17 Jun 2026 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716591;
	bh=YpnN+aZWUDmuWVEF6Su4hBJKN2v1hZPqPLi1Gv4Sc1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=URrAEFvTLqr2woMUsvX/WZJ8KFfgZZb9g4AdqYwPcQUsKrJ5Md+hzQDuMkob1dzMg
	 Qlg4RaTxGNAy4BTxCWiKneTMj8kg4mMBdJuMRcMofvgVV2yaiL0K25N/2h+w3V0hQc
	 IH3n1WjySgUDJsHnk9YXe5WL8bwYsznrOV6deC+9Z/4xQiBr52Ey2VN7bQ0JGWXnnT
	 y9zbpVXtySaApc/ZN7QOm/4LSCqKALCRMnYQ9fkU6PEY9re15eD1IBz5obbApnuMZ4
	 dtyTJXB6elT3XFfg6e59VJPa4OQoqzUwiDrFVAwSH/qjfXOEj6/LF1mR5/4b75XIWu
	 vPQvNYpkuk+Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568373930F8E;
	Wed, 17 Jun 2026 17:16:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for 7.2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178171658490.1670911.11006545744276535632.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jun 2026 17:16:24 +0000
References: <20260617000705.931602-1-kuba@kernel.org>
In-Reply-To: <20260617000705.931602-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300221-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:torvalds@linux-foundation.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3A4869B9D8

Hello:

This pull request was applied to bpf/bpf-next.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 16 Jun 2026 17:07:05 -0700 you wrote:
> Hi Linus!
> 
> The following changes since commit 22e2036479cb77df6281ebbd376ae6c330774790:
> 
>   Merge tag 'net-7.1-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-11 10:17:49 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for 7.2
    https://git.kernel.org/bpf/bpf-next/c/b85966adbf5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



