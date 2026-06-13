Return-Path: <netdev+bounces-298997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dE3eCf6VLWrthgQAu9opvQ
	(envelope-from <netdev+bounces-298997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:40:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5798E67F2F9
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:40:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iNgSVq6L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298997-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298997-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29583301F9DE
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAC1331EA5;
	Sat, 13 Jun 2026 17:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA81B85F8
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 17:40:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372411; cv=none; b=WfjHYfg1aM/AWMailExjJ8bH+BJHTOdjmBY2JgsBERW5IiU+f4VAgVCCU3g3JJhuXrZVQ6AL0wk0TZWclgYhER0cI3kEtKveEsujNHDWq/lKKmZ0dXAehtdp5WdC4bqT1XV2hENg8dsXzZcP6bcBgXVHi90FGh+B6qtTbTsEaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372411; c=relaxed/simple;
	bh=8spSXLuYRkoVD+gxCQj/xDlUZ82o46s+bxxrZCwq90M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tsw6h6FypUqSVdFCEJgH0WNWpwZjbck7MqdR8pGpL4oQmY9a5wTfOQATl9FCuzMvuOQClH30Stcs7crsEREtHOG/Lk9yVVZBvSdLPoyDpZahcSyPBIBvJulEYjr8/WHalBIHj0Yy0lEvfMjlGkoLFWr6Zl9pVAK/rbteLEEbz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNgSVq6L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F3B1F000E9;
	Sat, 13 Jun 2026 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781372410;
	bh=KPuwksocBMVjZiBCm9XmF4wYAizizjpxFEw/IROWOF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iNgSVq6LBZLSSfUuHVqPXNtVGtT7sE7jPfHpK/CQ7/s/rVRv2H8rmUv3KB+8KpSNo
	 eiWx14T/FcXWeQJz6JxGYfljkWmbNQwrdjIRvfEAcZjYgaOahyU/JnibEU27EkEnz1
	 TaYllza2zkN7vD/mIg0nUM2d5VDlXHine+wyJZe6QKKbC0l3pPEKDQkJ7ceRY3AclB
	 E+EfZvkgHE2jvJHBRHLos64Vgfx7J2f/Mx2yZMqh5YKFV2qES5bzrpUlbxo2CunTZI
	 U9ilaclzU8NPuW5i7zboZSnoleamyA/ORk60jxg5y7uOw4KfAD1Nj2IResMKHTg86b
	 zhiidw0jlw5qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09833A40FD9;
	Sat, 13 Jun 2026 17:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: airoha: Fix error handling in
 airoha_ppe_flush_sram_entries()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178137240639.1545867.1534966931117017277.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 17:40:06 +0000
References: <6a2bd37a.4034e349.1b41bb.1caf@mx.google.com>
In-Reply-To: <6a2bd37a.4034e349.1b41bb.1caf@mx.google.com>
To: Wayen.Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298997-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5798E67F2F9

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 17:37:00 +0800 you wrote:
> In airoha_ppe_flush_sram_entries(), the outer "err" variable was never
> updated when the inner loop variable shadowed it, causing the function
> to always return 0 even when airoha_ppe_foe_commit_sram_entry() fails.
> 
> Drop the outer "err" variable and return directly on error, propagating
> the error code from airoha_ppe_foe_commit_sram_entry() correctly.
> 
> [...]

Here is the summary with links:
  - [v2] net: airoha: Fix error handling in airoha_ppe_flush_sram_entries()
    https://git.kernel.org/netdev/net/c/d7d81b003013

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



