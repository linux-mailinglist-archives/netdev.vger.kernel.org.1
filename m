Return-Path: <netdev+bounces-256537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFR2L0i9gmk4ZgMAu9opvQ
	(envelope-from <netdev+bounces-256537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:30:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 523DBE1434
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 269D23019FD2
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426422CBC6;
	Wed,  4 Feb 2026 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gts7s8yM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314853EBF2C;
	Wed,  4 Feb 2026 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770175814; cv=none; b=fOn55ztRvqjTGffNIMmpo2ysCWXYDcUgceZ5eKIoyMnhYujWohGBAwxm7raaIpZ/KV+tuSS2ahhyFWeSdukru8EGu46HZYQThWE8dpR6O6NpFAaJZB3IGloQrg2GtWIWqkor5wo5IQpyNA9f4r8Jgzb8XZBZch6kNMsdhxSNdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770175814; c=relaxed/simple;
	bh=/ltIFtMHxrJoVz6/htqMCrh88VyW+vU0E8kF5ArtNpM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pExMjHXZZe43rLwOlkyJE6W37t1QvtQj6CYKRiGLHrm6rxqE49atwZ7GEmEhZnZ9gp5shIm3lLVi2me9j5v/ea+PIG3zy7bUJCQQAfzLOJcAiGp9fLui+DkBZ8z+Nm7gmGHcNXXXoWxOT88MQK49xftMuVHlv5smpmAOXyHKy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gts7s8yM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C2FC4CEF7;
	Wed,  4 Feb 2026 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770175813;
	bh=/ltIFtMHxrJoVz6/htqMCrh88VyW+vU0E8kF5ArtNpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gts7s8yMRJQf57v+jfCo8QPu0POxlFJZwJUP6fKDsRRSxvAIbTAZ9aIM2HIi5bgl+
	 9lJJXH+q71tCLHLBVDq10j1Q7FO+M+po6cH34bzvwkU4YnRMigTOv/wlJRi+hWdZnS
	 XKQPls5Uty8yG1hzuXPUTMoMdUKdPXIjzv2mVVwii5W/rslUAzvw1vyC7DIuQIE13f
	 QHqZ3ErauSYC+ZzVSM9ZhapnQEDzRZJpLlwwVD5War1V8RfTOsUFw6SMep4/ZAkPRD
	 snVkXSEzPG7GH8zbPKYKjNkwc86LUeU4ePVtjBoyg5fy3jOuyoc49XsephXY/wj75I
	 Uq2fkhf+43ADw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16DF13808201;
	Wed,  4 Feb 2026 03:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: gro: fix outer network offset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017580987.2166000.3434486648244735239.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:30:09 +0000
References: <cover.1770032084.git.pabeni@redhat.com>
In-Reply-To: <cover.1770032084.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, shuah@kernel.org, willemb@google.com,
 richardbgobert@gmail.com, linux-kselftest@vger.kernel.org,
 aleksander.lobakin@intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256537-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 523DBE1434
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Feb 2026 12:43:13 +0100 you wrote:
> The GRO stage has still problems in some edge scenarios when dealing
> with encapsulated traffic: the first patch address an issue there
> leading to bad checksums.
> 
> The second patch introduces a test case covering the relevant scenario:
> S/W segmentation after GRO for encapsulated traffic.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: gro: fix outer network offset
    https://git.kernel.org/netdev/net/c/5c2c3c38be39
  - [v2,net,2/2] selftest: net: add a test-case for encap segmentation after GRO
    https://git.kernel.org/netdev/net/c/bee60ce21b75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



