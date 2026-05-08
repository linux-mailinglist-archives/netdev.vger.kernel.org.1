Return-Path: <netdev+bounces-286014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBBvMCxi/mnCpwAAu9opvQ
	(envelope-from <netdev+bounces-286014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:22:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DDD4FC50F
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97A153037993
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A4391E72;
	Fri,  8 May 2026 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhmc5L3e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA232DB79F;
	Fri,  8 May 2026 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278857; cv=none; b=ugSuKhAJZ8m88SVHsTjG3bhqhvR0pvEr3e1PFSfUGT5VT/WGeGnyLd3CBNAJ5G7tQtKudXmXfOLq5GC6id5ucy4lmnekcgFLj9YcjoIGQXWDXVI2Llo6zHCbFze7bbL2bPHERutxidY8p6zxTXYlB4zAsA1SoygmdD7WSwYrB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278857; c=relaxed/simple;
	bh=3c6mBX0SMHIoXIg5ZScaD2+vigKCzxlLsrjdG4XgaNs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YYZ30T/Irz5GVr8smtv/cslA3iNBuTM77+Y8XSL9E2YY6xECUTdN2AYPF4kUbGDJQQRVduDY/NBF7mzjN1GUYY9koWhL4JaNukUkg6KXAJQ0sYI1edta/uv9umVxBSXU3+Hcj466UFXn5chJ2AT9FdRhNtXB8U4S6j0lZXjpVQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhmc5L3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546CEC2BCB0;
	Fri,  8 May 2026 22:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278857;
	bh=3c6mBX0SMHIoXIg5ZScaD2+vigKCzxlLsrjdG4XgaNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nhmc5L3eH/rwvdAWmTPXAE6658pB1a81AYWK9Nl/YnO0dsrjjqi2LNNWQcYtSpbv0
	 xLfa4uf6owExL564oD9K5erqVZJYBEw2tDoY0IGi395tpgSHu9C85uiFTNV2uZDdKX
	 gEzB+Sr9SC7ddjGWFX3D1UaUsjmQsU3LEiFgFzZQi+cH99E6VytLl9mAqoZrhmv2GJ
	 TjJ9BlGMu8N2cb+eCY1PygyiN76k6Z4JrilUe/9Wz1pqgguumYbitCon8OPXbFo/3a
	 gaLeXcsWEZ2PqVr/YehRy1bRwR3u4HaJICCWqkM6FgbvuDFuF39Mp+nz9OqKTocPy6
	 PYTWcJlrZnjZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CED38119D1;
	Fri,  8 May 2026 22:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: lan966x: Accept standard ethernet
 prefixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177827880555.872167.9312279380032564115.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:20:05 +0000
References: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
In-Reply-To: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: herve.codina@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, horatiu.vultur@microchip.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Rspamd-Queue-Id: 30DDD4FC50F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286014-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 07 May 2026 11:26:01 +0200 you wrote:
> The dsa.yaml and ethernet-switch.yaml bindings recommend
> prefixing ethernet switches and ports with "ethernet-" so
> make the LAN966x do the same.
> 
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: lan966x: Accept standard ethernet prefixes
    https://git.kernel.org/netdev/net-next/c/4374fc0b89ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



