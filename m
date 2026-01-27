Return-Path: <netdev+bounces-253665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFrEG1AqeGl7oQEAu9opvQ
	(envelope-from <netdev+bounces-253665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:00:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D559C8F51C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7CCF302F7FB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EF22ECD3A;
	Tue, 27 Jan 2026 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyMvAzps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B2238D27;
	Tue, 27 Jan 2026 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769482824; cv=none; b=m8T/gnQkIlq+SOP3X4lsVoSeZvArzLHtKSxAkYwD1vPgREL+kfCazywxtNoWxBBB96PMe+Sd/2Zheo15E19XG4LtPsO8TaVZLMGDTHktQ+qBFQmc6gQb/aH9cEC8feqNk/DmOLtkBd2r4k0GAOUXDc2+oibbrVufBi4e9RwC9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769482824; c=relaxed/simple;
	bh=/N48L5gWhbQH3gw6DdmlSJ08hjNRkbyBFaO6vXGgwcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GBb+LkofY35VF3mDdlIZARp2C5LwXEpe0b2oOd/rh0LVlpG/+gasfFH60cXWz1Eb5t/v1vokQLSkkpO2Uctu2qMAKAMdtgQK+1akqn0UzpaybNRLAxmk+/Snc6AkBUv8m5b7hLhNxjZD8xxkPo8FIKII1KAtrVglnnuYy1m3l4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyMvAzps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D317C19425;
	Tue, 27 Jan 2026 03:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769482824;
	bh=/N48L5gWhbQH3gw6DdmlSJ08hjNRkbyBFaO6vXGgwcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JyMvAzpsNp2wWZl+FmNR2/ewzUcTpyKWdDaSHJA4uyJx2mUVQamc0OedaBcBnnYqU
	 Cl8iWsWGxuGp077TmGeS/65SGrbmOGNXuWpLKIfZXO+f9w+yEk29h9jJeuWQpZr1NB
	 ff1rXjSrhSaee39MH+cc6EEIqpoVrzYh5ZxhUpMbBYe951wdePGRuZPqSMMbSPVNrk
	 Qd1mFt/HC7YlhS8q1l3N57wUUes5Jy+DTnV/jIjJUq8FeP94sCgCKKXLhY5AG4N69e
	 25/CJiZczAtJFiTHU0YWDTeCX6Dz5gOxQimEQCFT60D4J0/2xojUjwTz/WO7wRtNa5
	 lnnMGihUwQmHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BCFF380A961;
	Tue, 27 Jan 2026 03:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: alacritech: Use u64_stats_t with
 u64_stats_sync
 properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948281810.660450.11640086686346413724.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 03:00:18 +0000
References: <20260122185113.2760355-1-mmyangfl@gmail.com>
In-Reply-To: <20260122185113.2760355-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, LinoSanfilippo@gmx.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253665-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D559C8F51C
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jan 2026 02:51:07 +0800 you wrote:
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. Convert to u64_stats_t to ensure atomic
> operations.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/ethernet/alacritech/slic.h    | 50 +++++++++++------------
>  drivers/net/ethernet/alacritech/slicoss.c |  8 ++--
>  2 files changed, 29 insertions(+), 29 deletions(-)

Here is the summary with links:
  - [net-next] net: alacritech: Use u64_stats_t with u64_stats_sync properly
    https://git.kernel.org/netdev/net-next/c/6e9674a980f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



