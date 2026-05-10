Return-Path: <netdev+bounces-286352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPFNF72+AGoCMQEAu9opvQ
	(envelope-from <netdev+bounces-286352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:22:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07746505625
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53946301ECC9
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBFB3B3C0D;
	Sun, 10 May 2026 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0N4qA7Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AF355F28;
	Sun, 10 May 2026 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433677; cv=none; b=dkhFMP4obx5yzRRGPggUNNJV3h8dp4sTWUTadxeIlSmpZgzxb142EbOxKJ+zJH92QMObm7I3V0kxkOiW7IeL02EuH5p3z4XenMk/vRYwyFyEeaSqO4AQmy01cb57z9DnOYrCMoR0R3uhd25NiViziB7W/1HxonCGaEyLaqijLGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433677; c=relaxed/simple;
	bh=iMNBtNMM6qK67zwkQsw5VnancBPqyT2EurscxBqQCOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BPJ/iFdU8nuXIb6UlecHyoevQ2Yn0PA4MxRjhY5jOZfjgN9FaU3g+mV9OUtlCKmpoLkOdSEpSlYciLjKoft6LpDw5bDJLzdXpA/aQ/QfQ5o7jWQybrGJqvos6LVVjhQGvTJIESFlrF2HaN5QqRFdYRhJNo4n4+VfK1egDL9jPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0N4qA7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ED6C2BCB8;
	Sun, 10 May 2026 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778433677;
	bh=iMNBtNMM6qK67zwkQsw5VnancBPqyT2EurscxBqQCOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I0N4qA7QbwGWoD4CtVz456cj0a70u7R//UibTHhRrXuth7qeqE3okkXArNkFTS8oV
	 x4jOgYU6Lz42HeUSy5K2EmnxSy7r2lrSIQQPD+7NjUML3N5x8r4J05fua4DDIdsHjD
	 rms6Dx9Bq/cFAcj4lAAhPCQ3ThnN8lHM0H9grtdYUHw/2/BaGzgcmL2XrOtXJY8MUK
	 PA3lk5+RxPGd1Z8BtmFPq4S6vD6q8dVw8OHRzTpjbgizKCA48bmJNRHaWMpwfZDce2
	 QHnbuSTDPnurupjPVAclG2ncdHUKnU5mKCeKV7OhvBKSCPXVUOa0wSOIzKoP8v0a+I
	 qDkr/6veUYpqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EE93930020;
	Sun, 10 May 2026 17:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: convert four more protocols to
 getsockopt_iter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177843362429.1437390.7026110472657102659.git-patchwork-notify@kernel.org>
Date: Sun, 10 May 2026 17:20:24 +0000
References: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
In-Reply-To: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, ms@dev.tdt.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-x25@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com, sdf@fomichev.me,
 bobbyeshleman@meta.com
X-Rspamd-Queue-Id: 07746505625
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286352-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 07 May 2026 03:57:49 -0700 you wrote:
> Continue the work to convert protocols to the new getsockopt_iter API.
> 
> Convert four additional getsockopt implementations to the new
> sockopt_t/getsockopt_iter callback:
> 
>   - MCTP
>   - LLC
>   - X.25
>   - KCM
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] mctp: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/85f22f66f303
  - [net-next,v2,2/5] llc: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/e0a917bca147
  - [net-next,v2,3/5] x25: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/447edcb0e4be
  - [net-next,v2,4/5] kcm: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/8aaaa32a7965
  - [net-next,v2,5/5] selftests: net: getsockopt_iter: cleanup
    https://git.kernel.org/netdev/net-next/c/c8c2bd2bcf67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



