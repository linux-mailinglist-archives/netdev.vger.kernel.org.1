Return-Path: <netdev+bounces-260710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MbBGohZnmkjUwQAu9opvQ
	(envelope-from <netdev+bounces-260710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:08:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9270A190948
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FCBB30AC263
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD08B286D64;
	Wed, 25 Feb 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCxbxJcz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B01A285CA7
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984229; cv=none; b=kEzuNrjaPs5So31iYylo0qFe8tPa5nvTPhzc/M9RPNFvu5Hi4eaZK6j/m/FQPucHzWaTMfWyDWLLTxypwO2MmPmZnfNiZVPxHbMmB5KoSGVIw7ep4F5wMgTvNSB/WeWVODjvbhsqB+jWQ245KN/n95MHgG4/6KNyBwTUHox2f9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984229; c=relaxed/simple;
	bh=Nsn8w8Sk0iDqJ3FY6TqqYxsIteqNS/C0XZLhgr52ga0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/UxT16EVeiMCh1FitvCPGsenZWerAO3G/LIQmeI+wwBm8UjQxGofC19SQSb0ju8VEsl4/OWs4dNlITXQ3uXUPsvKLzEyZXJVuKu6jkpwB+U4osCJsePuVghJVIW6GHr4WdS3NHht3lZkCqIWzGfko6bWJ2UOA1B31VV6oYGQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCxbxJcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB33C2BC9E;
	Wed, 25 Feb 2026 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984229;
	bh=Nsn8w8Sk0iDqJ3FY6TqqYxsIteqNS/C0XZLhgr52ga0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oCxbxJczgkM8dH0XkQ6EBdyIzBT6IREmGsSlMvrgomaAbM2W2JJZ71Gxb7e+BCTV6
	 oCoHnKiur4GzsNdUR8FTeQFlgcR67Q2IIzJ7a5qDNvkWR4cf+OEKXowq1WyQrfCKGQ
	 opgVADSvi2SObXZTauIG+cN21l2xdEGgGdwoz5SqvzzIIXxshehNklWH2E014yCMHm
	 9q+opRhLO6P1mrIu/rHuodbhcfwov8X0F6C52CmlZRaU7tzAy9N8vlhphWIrbP3LtZ
	 ASj6cDGGg9a4UxHbIxcXu/XLEOVAeFb69BXjAinTEMfpx8h/GVJFHKegInALhwkshi
	 IJBU/JmM7T68A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FD23808203;
	Wed, 25 Feb 2026 01:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] net:ethernet:enic: add VIC ids and link modes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177198423428.31093.10138563715470068624.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 01:50:34 +0000
References: <20260223-enic-cscwi36355-v2-0-63488194a974@cisco.com>
In-Reply-To: <20260223-enic-cscwi36355-v2-0-63488194a974@cisco.com>
To: Satish Kharat <satishkh@cisco.com>
Cc: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260710-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9270A190948
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 02:27:19 -0800 you wrote:
> Add VIC subsystem ids and their supported/advertised media types so ethtool
> reflects the hardware capabilities for the VIC variants.
> 
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> ---
> Changes in v2:
> Addressed comments from Andrew Lunn
> - Removed the advertising of the link speed as we don't support autoneg.
> - Link to v1: https://lore.kernel.org/r/20260221-enic-cscwi36355-v1-0-5a01a6046d5e@cisco.com
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net:ethernet:enic: add VIC subsystem ids
    https://git.kernel.org/netdev/net-next/c/472e079f8c90
  - [v2,2/2] net:ethernet:enic: map ethtool link modes by VIC type
    https://git.kernel.org/netdev/net-next/c/426f1f5b8752

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



