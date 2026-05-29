Return-Path: <netdev+bounces-293259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOHmLh33GWos0QgAu9opvQ
	(envelope-from <netdev+bounces-293259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:29:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA786088BA
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5180230A1C08
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3793AFD16;
	Fri, 29 May 2026 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHPuVBSf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448123DDDD0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086025; cv=none; b=uZhia0/lsYR/ZoekB9tWWHuxg0cuS8Mn08h+kF0VLQSvt8KxFj/OWLnaBRx8Orq2PHvCU/ZVgoQzEexO4+x32eIZsZpqV/1ReJChBP2HglafaVPlD17GixBi9k+gWEyvVBCZftbKG+IIM33vAgVwteF0i6Cs/No7TKuB80ZUzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086025; c=relaxed/simple;
	bh=nf49gS7eX3DKJi1ypov/TgrNzJNr1hWa7aD7giMMypQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LEkyFri5m4oOns35YTs5UmvGpzb8aoX2ezU2vTdiqj8uhqujRJQvqdu79t6N9E93v+rfenvh159O/kIb7xBtA3KZf2HMh3HY+5OEPMCIukomHeeBqtY2Si2mrQyb9T+usqTOvBaLKsdCdkGtMhv2naMjLD+FWfMBUM/AuR/aOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHPuVBSf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0841F00898;
	Fri, 29 May 2026 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780086023;
	bh=d80FK9vKxa+FSFDmA/wlHfJdvdn8QtpUTEDPBDmLPdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eHPuVBSfFWmEvZb+DmA2PrbTNVV7thINwah7n3YQvisl66DDmm8qgAtMEXHmPESis
	 EIM8xEAadQgNGJjRyokez9Qz6TEDuf1k1RuZCQjwDgVrmZD8O0VOGxUNBpvphhY7ys
	 /8o3WpRPOrRtRww4Ld8LyCNXFaJR50XeehL/ubpjUV4D/hnvDsd/UEuRO93oqmIYlh
	 QUE8yPvTJkMLHtVLPi48IrYQDIEx0XOXAnAL9MP6JIcOk9MEQIxb+2Mp+StKQg/Fo0
	 556PT1LjHdxEUGpSm6KjQLOwtCYeu3vEM/e8HQUxDXUJQAxY/lREQzM0HUB7oRjnFJ
	 BTR90sx8b5R0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A9E39301A0;
	Fri, 29 May 2026 20:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] WireGuard fixes for 7.1-rc6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178008602713.1951456.15370609139220938983.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 20:20:27 +0000
References: <20260529173134.3080773-1-Jason@zx2c4.com>
In-Reply-To: <20260529173134.3080773-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-293259-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CA786088BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 19:31:33 +0200 you wrote:
> Hi Jakub,
> 
> Please find one small patch, fixing the order of adding padding onto a
> packet, to ensure padding bytes get zeroed properly.
> 
> Thanks,
> Jason
> 
> [...]

Here is the summary with links:
  - [net,1/1] wireguard: send: append trailer after expanding head
    https://git.kernel.org/netdev/net/c/f75e3eb08fe3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



