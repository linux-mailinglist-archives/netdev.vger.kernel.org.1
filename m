Return-Path: <netdev+bounces-299696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WkgxHSunMGq+VwUAu9opvQ
	(envelope-from <netdev+bounces-299696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:30:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C144168B44A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:30:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X5NSVIO4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299696-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299696-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B2D3302E42F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4493F37B027;
	Tue, 16 Jun 2026 01:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77930F52B
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573417; cv=none; b=Ka7GpcvXK7zWgToKO7Dg0zfqFzwcBqQ1kfz5qjCY0Ra2mIMmeUaImYiQG4I1hreI5GPZ+NI9BzpRcAOtCA+mZ/NpyBTUyI2Y6dlG+i6q3zY0d3jV7Vpd5ydZIt8fGj0KNcdT0gQ6VveXXHBHBClPeF5zPp6ledzNB3GveFgE5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573417; c=relaxed/simple;
	bh=7tgIoyYODY/BcVOQywpimW35OrDcuCMh7NuqZORYX8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FYqB7EWbqKMDgMfW9Gch0EQWKQ3ygOtfLUqlUEd47lP5357olK1YT+fwuEAmeu+GV4eA8fb1awZ1I70xsS53HDYKSqBtMhGJ4HZ6W7dgNKYWSV9uhwYoo6yDcav6j69vTwnET0qIUpi4sJs+rKbczzQA9BQJMR4HvGwYo6JMgOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5NSVIO4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E314F1F000E9;
	Tue, 16 Jun 2026 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573415;
	bh=tyKoNQR3ohBhu5b5Ioy1rXURzyGmCi/6JkUJw72EXGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X5NSVIO4WCxJhwP1E2lZ/LPhkhDIN5wdHcS5G+iC2YdQYhGYE0f7cBrmBCG9TWKFk
	 mOhWLzcm1oEr923ny96e0IqccujTfjm3wFIeu03TLfmTlqzZvaiF46UcPBRYgcTEr9
	 eDR5bFLX7bIAtp2Qkf8Z2RDE4He/WU5XPE5I3PjBV7Wcn6F9bJo3YZDF9uLwUfbui8
	 JcPI4Wn+B7c/MqS1L164mv3olwncn8MB4Y0B49tKwtNF/VTY837pa84/d3IJ2MclSV
	 OOqOEMEFUATWyT8fe0O/c4epxs6bolXywdJvIdYd/ZyOlmEQWa7mRVaJTao2gJBSKP
	 +TKSTXfHufCkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198363839A26;
	Tue, 16 Jun 2026 01:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/5] ionic: Expose more port stats to ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178157341089.377752.10955268074897440883.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 01:30:10 +0000
References: <20260614205303.48088-1-eric.joyner@amd.com>
In-Reply-To: <20260614205303.48088-1-eric.joyner@amd.com>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nikhil.rao@amd.com, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299696-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:eric.joyner@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C144168B44A

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 13:52:58 -0700 you wrote:
> The primary aim of this patchset is to support the reporting of new port
> statistics (and one old one) that firmware sends to the driver; these
> include general FEC codeword stats and the FEC histogram. A scheme for
> these extra stats is introduced in order to prevent devices that don't
> support these new statistics from unconditionally setting them or
> reporting them in ethtool.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/5] ionic: Fix check in ionic_get_link_ext_stats
    https://git.kernel.org/netdev/net-next/c/7678e69079c1
  - [net-next,v5,2/5] ionic: Update ionic_if.h with new extra port stats
    https://git.kernel.org/netdev/net-next/c/433bc5008149
  - [net-next,v5,3/5] ionic: Report "rx_bits_phy" stat to ethtool
    https://git.kernel.org/netdev/net-next/c/cb683ff6ee07
  - [net-next,v5,4/5] ionic: Get "link_down_count" ext link stat from firmware
    https://git.kernel.org/netdev/net-next/c/3277e605ac01
  - [net-next,v5,5/5] ionic: Add .get_fec_stats ethtool handler
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



