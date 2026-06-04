Return-Path: <netdev+bounces-295448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t5DPA4f/IWq3RQEAu9opvQ
	(envelope-from <netdev+bounces-295448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:43:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A7A643D4C
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:43:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lPpCfpYj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295448-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295448-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11208303A100
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A8430D3EA;
	Thu,  4 Jun 2026 22:40:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A972617
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:40:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612806; cv=none; b=AwVnMR2NKAGXrbYORSl5rpPPIUorszfZaFsW3zUl0ExdBir50TmGPftP6MedRjdfdnIbjY1BBlXzw6JftqFzVmIZjdWKmll0PTHkEmzSIs//78vP0A/9h88TwU2yA2Pc0ajxf/w3z4XnwOiMIQizo1wBMm6Rox9Jj1rI3XIBr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612806; c=relaxed/simple;
	bh=ZMromN7JKDIPrlqYgRmCSinVQwQCd2jk8RjqBeqexdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KwVZqr5zauDdWsCbJXgQKmeAAwl8EnYwYKOQjRayz6peKAdlEdSK9LbYuANTM6bqqMGkyRHEwOrvAh1EpH/EGQXX47s7hIj8OcfJqEXxDpXZ5e/1XQ+Jyzkt5+fP4IithP38QU+WDYITiSlxZP7ypclZ577ppqpNBNLlehpFus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPpCfpYj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DF91F00893;
	Thu,  4 Jun 2026 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780612805;
	bh=XTBZlNbx02T3OEi+tUiCJX9XVBdedILx6fMxUo+caDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lPpCfpYjbGP4fJWwM4LTkdrpvs93HWUbYOYqMMZxWhWk8Hp2sUVgm71sd0EQhJYiL
	 MgV4kd7IIUFf6ihJ2KFGNuUgfN5sdgfGdn7FDdtLGOGP/z6l6ssg/Wvbeu8Cy9XaIe
	 DaEevqpv3OI3OtkEV9MX9dRLeJ0ARSheVTQxnPxY4eOptWM0gtGEFjePDJe9dEM8mY
	 HEcGjF9bTXCq3muKX7IMOPY457Yg1cu0PzAbqGrDwyIupypLl2NQN0XnBGrwyKawB+
	 +ChibIcb0M/wRb1SJ9lH5XLwGmdCimORKjI9V4U4hUMIm8n5zkrguy5A30FFNQnf92
	 sU8ysYFMpHJ2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198743930A83;
	Thu,  4 Jun 2026 22:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: try to avoid the very slow YAML
 loader
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178061280565.3052321.1262053609207627326.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 22:40:05 +0000
References: <20260603210810.2636193-1-kuba@kernel.org>
In-Reply-To: <20260603210810.2636193-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-295448-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:donald.hunter@gmail.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52A7A643D4C

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 14:08:10 -0700 you wrote:
> Turns out Python YAML defaults to a pure Python loader for YAML
> files which is a lot slower than the C loader (using libyaml).
> Try to use the C one whenever possible.
> 
> The avg time to run:
>   $ tools/net/ynl/pyynl/cli.py --family tc --no-schema
> drops from 300+ ms to 115 ms with this change (40 samples).
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: try to avoid the very slow YAML loader
    https://git.kernel.org/netdev/net-next/c/07c4bca9d92e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



