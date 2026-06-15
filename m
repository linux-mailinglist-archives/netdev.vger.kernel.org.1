Return-Path: <netdev+bounces-299643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pVBfN9uBMGq3TwUAu9opvQ
	(envelope-from <netdev+bounces-299643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:51:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A82D68A79B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:51:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HHa0eArA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299643-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299643-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3592C302772B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B977E3AE185;
	Mon, 15 Jun 2026 22:50:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5713B71D3
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 22:50:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563845; cv=none; b=T2fuoPd9yGPUZlDcBAcssWUvytSOGc8xT8ieUowH+swnmmLI4pCdGA6EOakTT36rOp00WWbUoAhqAH8Dwy/zDPdkuOY52zjh0UoPsOJIja1poRyAJ7c0f9yRQ0eTYBViPzVruibNIeNWSUxq8IQO3sZ7JG1LELpi0nNjCnd1CnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563845; c=relaxed/simple;
	bh=jxwMDcfX7TZO4aNaFsfWunNAeaJLT4uomM9+EeSuDjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VEMsp84p2Itvi8bgkOAEb56w/xIcVEIhFBLqprQbJgR5lFETGuSbyad4CKpbiVxtoIVEflW7XDwXLqjWvaQjPWQ54QSSRluz80FqL5/qPOKqiZ4UkAbD6EiujPkC4haHFhyOroUqOJ2pBJ9wJhThHaXY2A3eqsSJUM+4F8ljWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHa0eArA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570A61F00A3A;
	Mon, 15 Jun 2026 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563844;
	bh=T57rr/fexxAyKKAD9vP64yQclmlYeocSTP22QwpKjPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HHa0eArAA6Ld0Zj3yp6vGoxUPOoQmUCKHXCnC0q5zrnsQm2Au5pVRe0UAmhnf5d3s
	 WAdzDrOqCd6R8F5ml/XISNZ6hMDpfSNg/KbovMbsghZlcHVvF+DvS6XBuOWnOi9vaD
	 q8PNpCTF7NFYMhaq2vAosnH6+K207slsGGmNq5SdIhGp1bkGgbzCE17E2hx5jx4d2A
	 48MNWhO90uBx2ao/SMxWin5SvbSeB3d53Q2tumhuluTTu2RVe069D1F11eLUVQO5Um
	 pnrLBUqb+zWiYeYD6DgJ7VyM7CC7ZlCIvnQ8FrM5yqvpOf/A9vNd7b2DrBqcfwZBEi
	 VYwbOqbEz96Aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938083839A08;
	Mon, 15 Jun 2026 22:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: Fix typos in comments and Kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156383913.325968.10885453250477186810.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 22:50:39 +0000
References: <6a2ca74a.c5b1db4e.21a698.01e7@mx.google.com>
In-Reply-To: <6a2ca74a.c5b1db4e.21a698.01e7@mx.google.com>
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
	TAGGED_FROM(0.00)[bounces-299643-lists,netdev=lfdr.de,netdevbpf];
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
X-Rspamd-Queue-Id: 4A82D68A79B

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 08:41:16 +0800 you wrote:
> Fix several typos found during code review:
> - Kconfig: "Aiorha" -> "Airoha" in NET_AIROHA_FLOW_STATS help text
> - Comment: "CMD1" -> "CDM1" (Central DMA, not Command)
> - Comments: "GMD1/2/3/4" -> "GDM1/2/3/4" (Gigabit DMA, not GMD)
> 
> These are pure comment and documentation fixes with no functional impact.
> 
> [...]

Here is the summary with links:
  - net: airoha: Fix typos in comments and Kconfig
    https://git.kernel.org/netdev/net-next/c/a061dfb063fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



