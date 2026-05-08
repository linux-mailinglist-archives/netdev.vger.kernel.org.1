Return-Path: <netdev+bounces-285988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNduEnJd/mkWpgAAu9opvQ
	(envelope-from <netdev+bounces-285988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:02:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF74FC201
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6839D301F4AB
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A12DECD3;
	Fri,  8 May 2026 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKZ+SNCa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E129B8CF
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277667; cv=none; b=mEeF4Z5sQ9Si/kOivIU0XrrRSgjlaAYxigwItp1hj8XsPggbfeJaHFtlR9TaDZseHkTmZnECXM2m9Czzxnq38U70AhfoLxaP0YIrKukyhOYAlR18ed9Tr5oTVOAF1mUvAx4Blr9r/Yu1mZYBL6Tee2WbXeZ1I3lZ/5Bc1s7BhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277667; c=relaxed/simple;
	bh=tq4A+KtcmkiGy3nu79OqZUF9FgzI52yQoK9ZBne2J3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q7N9gIlX0fyOtzRytmh5K9qROzaFyC078clICtNNUhNBZklEgOPpIp96JypVFpdZzo+VGEq5rHiaS9zJyxcT3TwNNBENXfkn1swzwL9f1mW1BC1QkdL3Z/vcALkGxa1R5GVIPPwyD6GggHYB47EhtnPtNeesPMT2jTjkD8gx2rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKZ+SNCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC61C2BCC9;
	Fri,  8 May 2026 22:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277667;
	bh=tq4A+KtcmkiGy3nu79OqZUF9FgzI52yQoK9ZBne2J3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TKZ+SNCaQH1mTWh7rFZV3ZTXH2csxmJVJNinwg/C5MzponySrVjUZjdAs/ni1fI5N
	 PD1/kLaoYITZwm/vrYBXAvWjXP9mmTZoH70Mnnwv6RNkVVcnyarCCRa73lz7dAslpU
	 zLFm1Q3VBRgYmjc7pTifkH2SnIYvYZbQgTxxLleSRFRjjJMKcxBn0d2yastKhoWdFE
	 z7ATiliTH8nfvFzSrRze/LFnjTkfPOitJ7J5QbHfvxbfP0ykOGQ9hhwW/xsxutbT9x
	 rTuUG3BCxmk5idReajgyi5WQG/E5qth5CcyMeZN8Mu0bL1iU/fjnK8bu65V1ZIhLiv
	 272jJ4PMGMHUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E8238119CC;
	Fri,  8 May 2026 22:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/2] tcp: Two fixes for socket migration in
 reqsk_timer_handler().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177827761580.865600.8944840782684836883.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:00:15 +0000
References: <20260506035954.1563147-1-kuniyu@google.com>
In-Reply-To: <20260506035954.1563147-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: B2EF74FC201
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285988-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 03:59:17 +0000 you wrote:
> The series fixes two bugs in the error path of socket migration
> in reqsk_timer_handler().
> 
> Patch 1 fixes a potential UAF in reqsk_timer_handler().
> 
> Patch 2 fixes imbalanced icsk_accept_queue count.
> 
> [...]

Here is the summary with links:
  - [v1,net,1/2] tcp: Fix potential UAF in reqsk_timer_handler().
    https://git.kernel.org/netdev/net/c/97c8a3c1f73d
  - [v1,net,2/2] tcp: Fix imbalanced icsk_accept_queue count.
    https://git.kernel.org/netdev/net/c/7eca3292cac7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



