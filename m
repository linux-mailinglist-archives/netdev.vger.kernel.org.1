Return-Path: <netdev+bounces-297376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EuCWOtC6KGorIwMAu9opvQ
	(envelope-from <netdev+bounces-297376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:16:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67637665279
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:16:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dCdqTK0X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297376-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297376-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EF52307BD11
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6781226D18;
	Wed, 10 Jun 2026 01:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F21F03D9;
	Wed, 10 Jun 2026 01:10:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053810; cv=none; b=o9k1KcjNC07sgmN6KkaG4HelM0GSFEZRGoysPz+KPF1VU0a2pbpGrOS6/jPNogU9IJnCmo/t6wdFqHPO70qbmKW0Fd2UuSXEEYHC5PEo0vCDwcrfgUCcN0oY22ftA7Ptut+nl/skzmj3TsFhg45X1xppjrmwxe+rOMc1r/XhF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053810; c=relaxed/simple;
	bh=8QpLpLzPLvPC4uLMJU5INnQrn45q2AVf9oXFrRl7qac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lvmZIfdpXKW3zBRnhT4/aA5KUPtdDXeTkRsqDKB4QMndYXxEU/ShROzfoC+BUVoZHw04yaAxc7O1yWRhwljhkvMuiPFq3HnHVF178QSqJJOZkzQ9s9VEuvQBYWZYV2PCcy5I2cz0+51zRnh72A5RQ+9r6kqpNdYjqg8tTzpFwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCdqTK0X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3776E1F00893;
	Wed, 10 Jun 2026 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053809;
	bh=60SZMLMgoA0QP7uKvpMFPOc2ECgoH/8TsShvrqanNGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dCdqTK0XX8PP4u4ozb579TcFiR9xL4/+aUMGW/xNJCfPSBcLDR7aW09sg3UbYTw4Q
	 UslV7lMlCZw+UO/TMeSlza3fc22f7tsPYJezjfPv3x+Vr/4XbKX3Id0wss9VnFf/69
	 jTt9b6Fhgj91qVg3vFM77876vyWXPTxgThlssbwep4VbY5yn7m4otAXv+yKhqO9cvj
	 U+Vz0AoxBHxPSlxR8frnbaTwOrU9pT6oTn7PhcdnbKbdx68msiWurz6rIlD5FjP/gS
	 Zh7g2T+Pm30v0r/8nfN9qRk6XszMLx+GGbVuiDx0yr7/V+3Q3FKeLgPjj4MUequwFs
	 +VoXbUmk5J1Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C73930A12;
	Wed, 10 Jun 2026 01:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] drivers/net/ethernet/emulex/benet: Use strscpy()
 to
 copy strings into arrays
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105380714.2776665.4095184805807613136.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:10:07 +0000
References: <20260608095500.2567-4-david.laight.linux@gmail.com>
In-Reply-To: <20260608095500.2567-4-david.laight.linux@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, arnd@kernel.org,
 ajit.khaparde@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sriharsha.basavapatna@broadcom.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297376-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:ajit.khaparde@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sriharsha.basavapatna@broadcom.com,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67637665279

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 10:54:59 +0100 you wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] drivers/net/ethernet/emulex/benet: Use strscpy() to copy strings into arrays
    https://git.kernel.org/netdev/net-next/c/9f9fdd88e9f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



