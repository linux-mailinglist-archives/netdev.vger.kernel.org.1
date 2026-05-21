Return-Path: <netdev+bounces-290166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AijIrlPDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:20:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2174559D410
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6442C3076B3F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AFC22157B;
	Thu, 21 May 2026 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4Mmkiwu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCC202F70;
	Thu, 21 May 2026 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322798; cv=none; b=b5ONBbtHYl9Lh7h+G5D8SnJLisjSdNWFpNmlhe+a8dhmHYXndnRAK2BXWmiWA04Kj4GBC1r2a6sM88t5M6xcJyOaoJMfw2Ruo80tNGCscUBoLh9w59vXQ6HHN1kgUoCJIYRSUmmh81h/XiYnlYNKfJemA08jDDvis7yw7bFBFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322798; c=relaxed/simple;
	bh=tdv106NsGNZE3KOsaVsKBIXypxo3f/tbjJuHC6npBcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JeD30bXhdweeDkGR4Y7YyDqAIChv0lS/ET7lJDzgrx7bzccWPLVMlJhk1EABcWzyF4jeGJj9y14nxZ4bqoONXuq5O7IJKSXLsSONHRWDYnQtMX2dQcNuMCu9ggXVvr2CyI/5OvuNmQ13U/MsqJRtYkZbY75QT95ekMb9fm4MBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4Mmkiwu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7131F000E9;
	Thu, 21 May 2026 00:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779322796;
	bh=DXT/XakK7ZXPHFleNMPrKtaA7v+xAbQFoAwgecdd/mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q4MmkiwuI85EAk6HpjXUdVaC8P2fDP6NETceuuFLhIkyf8XS/SSkmzICtmwd14WNv
	 BqlkLsMt7Fgbk7QXMidSb0PvtVtBiA+FXUYeQXHSKC9d0kd0WAYwx8iAlShxFntNMJ
	 y/iDQCkfaN+eVUN+1dIXTr/CZN1qeeuoXjUc3AeKLyY2SfCmFA19Y23SYfJJeIf8Ni
	 HxPYJ1E31mZ6vPTStqDlxsMWoXHSBgLSRDPFFE21nUvslX6K8btjEOqo4UVatpUQCk
	 Q+q0JCCUj4OqhJE9MKLGt7W9HZbEj1TpZpjAw15IpwY1fumEWtCkLHBApEi/hUalKe
	 6Rder3S7vZhKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1979E3930C25;
	Thu, 21 May 2026 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: spectrum_ethtool: expose per-PG
 rx_discards
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932280665.3806355.5077784295396573616.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:20:06 +0000
References: <agqkMwgM1PdkyMUR@juliahub.com>
In-Reply-To: <agqkMwgM1PdkyMUR@juliahub.com>
To: Keno Fischer <keno@juliahub.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290166-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 2174559D410
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 01:31:31 -0400 you wrote:
> PPCNT group 0x10 (per-priority counters) carries an rx_discards field at
> offset 0x78. These counters aggregate up into if_in_discards, but don't
> show up anywhere else. Since there are many things that aggregate into
> `if_in_discards`, having these counters helps distinguish what caused
> those discards (in my case they were caused by headroom buffer overruns
> due to inappropriately configured buffer sizes).
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: spectrum_ethtool: expose per-PG rx_discards
    https://git.kernel.org/netdev/net-next/c/a2b5e31b668f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



