Return-Path: <netdev+bounces-301829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CqxEKNGLPGoWpQgAu9opvQ
	(envelope-from <netdev+bounces-301829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:00:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A66C2473
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:00:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fOBC0eaq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301829-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301829-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E5DC3015852
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A6A3A759D;
	Thu, 25 Jun 2026 02:00:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BC23A7F72;
	Thu, 25 Jun 2026 02:00:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352837; cv=none; b=isuANyAV2foxKYQ13K6NFETFfWzv+BgS3n5rsj7I6j3BJWM2jEDUCVG0JmE45UuKvwn1czZTudszGmgYpKBZScHk3CirfmEX8+LHMBeQPfzmi6EHBsEJgg4VRGFFMUNC1dAMwrYhKMN9sL7ylu3jB8W/9j3oru7X1/YvSXeY8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352837; c=relaxed/simple;
	bh=975sQuwo80I0EU6ZpZjfglBn1vQTBlLV8RJh06nw32o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nMI8GTX3/5E0/XghfgIvFNCc4XLVB3UsTk25ebhVvcT1Q+DzUFokE3GfRX3mkhn+T7JO+zvh95/T1Y9/DUWz0XBIXNYbgRhKlAjobL3FoLN7JxQmhK2eJoshLrQLLVb0xP5aybrGmxiBVV+mVHnxLSFoaShEIUFpCLXQIXEY8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOBC0eaq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FA61F000E9;
	Thu, 25 Jun 2026 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352829;
	bh=WWNX5zIuzAuAK/UOwrsV7r8JbUomActzaBQdI5UHQcw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fOBC0eaqAwpOrFsSWklf3XRA34/u3ZxodtkW0qf2CHzz8kE9lpP5lO6hR8Ycaj8jZ
	 ZOHdhtinf5+palTviwB6UQRMPF8gYB968Ly6G5MSXNlmEPg0ab89KstUIL8nggoa1t
	 gUy36Z2omzz5H6a3IjGv4pN3Mnm4NS9ZFo7Acm4SB3mnIuh2bwuTKcfHhk7OUuoICa
	 8HfkVmQZhOQlXmiS090R+x0Nq9X0nY54MJd1yiasxQTQVEzLpMi+TFgRTSCpYsA1b2
	 BCtzBkVLxU6ZsL96A307mVg34T7VT2iPNMauBkNH/8qoyVeund4fXFCn1T/OuhLkUS
	 7WXIo0MY6K31g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BC93AAA6D4;
	Thu, 25 Jun 2026 02:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v4] octeontx2-af: Validate NIX maximum LFs correctly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235281728.3078979.15467412971095949192.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:00:17 +0000
References: <1782082853-6941-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1782082853-6941-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 bbhushan2@marvell.com, rkannoth@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301829-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F15A66C2473

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 04:30:53 +0530 you wrote:
> NIX maximum number of LFs can be set via devlink command
> but that can be done before assigning any LFs to a PF/VF.
> The condition used to check whether any LFs are assigned is
> incorrect. This patch fixes that condition.
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v4] octeontx2-af: Validate NIX maximum LFs correctly
    https://git.kernel.org/netdev/net/c/1576d12a3986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



