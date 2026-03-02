Return-Path: <netdev+bounces-262711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHwDLMqwpWkiEgAAu9opvQ
	(envelope-from <netdev+bounces-262711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:46:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A701DC1E4
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6040C3000515
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD263FD15F;
	Mon,  2 Mar 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej5RzryF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9791A2C0B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466005; cv=none; b=IPuBtG+rei18AELWfsB4u79tQ4UJAfrbIIMOaWLQfW7jW+goS4hhZtd0m+idmWtZRfjnej2iMRI7Lltx6fnbIaMhiLhzzf7l+ohwLCOv1uP2VwXb4+3N9oV/sic+9jkry3D8BQBY5Wol9cJnNfy7R3XOi3M+JrZmtyIgr6goZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466005; c=relaxed/simple;
	bh=DdxTTElwDNYWHjAp3aYYb6EtGUL5ViIOYxk7oyjbiMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SgJZSmEqCZQaDztNo4wyhTZ6zvsisKaV0sRr0kmSfsIPYom3E10AyBoP53WqwCQOrYyKavDI4rNVc6TumSxWzgc5JrxzO+AG+BYpOSEj1SeEzDBuCoT2B2kRFKXPfRg0SKJlmX7n8xgSdb7zGvw1e/EuFiIxevz7n8eUbWhQodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej5RzryF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F08C19423;
	Mon,  2 Mar 2026 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772466004;
	bh=DdxTTElwDNYWHjAp3aYYb6EtGUL5ViIOYxk7oyjbiMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ej5RzryFUSnHYNU2KoxIusMi6mWgUNxV/wHoW0Soosau3F/PBiMXp/cEw+Vcejjy8
	 jJ/L/QvntH7Ajh36K2ah8Ht0WNjNSeTdoaBAnSKjUMUIN8pGE0scdqBVL9soh3ikS1
	 YpseCr0Zo0bLkF9BslFPxEV6GuUTStNZiDMKmpj7VJrRkkm+gnURDIOm0qozSUDqkB
	 sACDzfNJz9aV+QwWloC1sJ3pHQCiPY9EQvFaY5Yp6LGsDwTa6OQ2Io0ezEgEC0oCrh
	 n6oqYYijCZ4/5XoDq9Ha3ufO5OjS5CijguK73qI0oHRwXWBy7H0BA7VZXe8EK8vgrW
	 P54ZbhQZtdIxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D89393089A;
	Mon,  2 Mar 2026 15:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 iproute2-next] iplink: bond_slave: print actor and
 partner
 churn state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177246600680.367674.4544648974792192730.git-patchwork-notify@kernel.org>
Date: Mon, 02 Mar 2026 15:40:06 +0000
References: <20260226033844.18244-1-liuhangbin@gmail.com>
In-Reply-To: <20260226033844.18244-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, stephen@networkplumber.org
X-Rspamd-Queue-Id: 42A701DC1E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262711-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 26 Feb 2026 03:38:44 +0000 you wrote:
> Add ability to print both actor and partner port churn states
> (MONITOR/CHURN/NO_CHURN) via netlink attributes. This provides
> visibility into the LACP churn detection state for bond slaves.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> 
> [...]

Here is the summary with links:
  - [PATCHv2,iproute2-next] iplink: bond_slave: print actor and partner churn state
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e092ff4c9b1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



