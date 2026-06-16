Return-Path: <netdev+bounces-299975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 92UBNCHKMWqRqAUAu9opvQ
	(envelope-from <netdev+bounces-299975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:11:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF26958A1
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:11:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jKbwD3o2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299975-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299975-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE35B303D57D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7845E3ACA4E;
	Tue, 16 Jun 2026 22:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9103ACA41
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:11:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647902; cv=none; b=MZCqN4jq2Klic8wE91CM8mcvFCXs5QoCpea6VuB/UDgzsM2iCAytB13UUvHMgbQ0K/i5LiOg8ww6ygdqEnc9X2JfBNXYPv+yZVbQ1N63Bk7yu5Ux8FKuug5SWTcb5d6sbE0+sZQVfcMImOzuYvvIUV/PEZ+EVG8JJ9VsPOiDpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647902; c=relaxed/simple;
	bh=CYQaBUlulMIk0QXaU1x6EL1nxwi+M7Uq7HKmMyVAJV0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JonZqobPHQ8kcKMzPheajV7Ozm4QHUGGRtz5oNdzBejnw4cw5xGcDH2hUELyylFey5oOusIjUT98L6bbK9Xs2oX0mm6izCsyYEH4iTEMsx2UC8Bw0UMdvnInr1GIkFxxSITMu6cerUeQZdGYzCmcdBKb3KU5mfAcEqZbEX+3DGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKbwD3o2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ED41F00A3A;
	Tue, 16 Jun 2026 22:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781647900;
	bh=CQD2Rea8tT9Evki9cBF/txLTFbUp+ukuW+gnffNHODw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jKbwD3o2tt0FtNHDpOTzRUzaNm7iND58wdAcyq2/wDBecABCppjOk+AP5zWhoT9aE
	 RV3k8vVvAe7bz0DyGUraz7LSLLvBKbQ8F1LyVmL+mnQB/Gl0fXBimKpdX8JO9ZgbAY
	 Vv1BawSJWEfYBTR4544VerFG7Av+DSFEvT2aPGzyDeiKUzr1fqytuq2b4x/eI1J4EL
	 SbW26dbJv0EnNQx8EgOeskhqro30dm3avZICvfRxZQrBt1NRABe2wy59sNSty+Lbpr
	 ts208rSiN33hkJmT37/qJ4aiFUCRqGm70mKf4jPaQUrbZb7pzJM01B7HJHvYsVaQ82
	 1tLPRuYjDNwMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938533930C2B;
	Tue, 16 Jun 2026 22:11:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] [net] net: airoha: Fix QoS counter configuration for
 Tx-fwd channels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178164789527.1259509.13170564105480598534.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 22:11:35 +0000
References: <178161132384.2164449.18407700117859190327@gmail.com>
In-Reply-To: <178161132384.2164449.18407700117859190327@gmail.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299975-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DBF26958A1

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 18:50:29 +0800 you wrote:
> In airoha_qdma_init_qos_stats(), the Tx-fwd counter was incorrectly
> using register index (i << 1) instead of ((i << 1) + 1). This caused
> the Tx-fwd configuration to overwrite the Tx-cpu configuration for
> each QoS channel, resulting in incorrect QoS statistics.
> 
> Fix by using the correct register index ((i << 1) + 1) for Tx-fwd
> counter configuration.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: airoha: Fix QoS counter configuration for Tx-fwd channels
    https://git.kernel.org/netdev/net-next/c/1402ecccf563

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



