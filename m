Return-Path: <netdev+bounces-264148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMqsDnztqGnnygAAu9opvQ
	(envelope-from <netdev+bounces-264148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:42:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC80120A471
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BD4530A6EBD
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3726738D;
	Thu,  5 Mar 2026 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iin9fweg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9000265CA8
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678440; cv=none; b=Dx4sBgqm10BZkll0DA+UMTZtxDHEXZigZ9FHg0Y4MPs51+kYRiviWo0DCt1t6DEnuvdtTUrp6o8gZpHDqtELv/vtfWv2emMoSGxpvnXrJxK36VEM6XOnwc8B2eXzR66G4nyLu7g6WXh5Pq2GlumE3H26Pm1XRB6lif2jq+YbJu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678440; c=relaxed/simple;
	bh=FLd89eFvpiF6CFvuc5sjxFxbyTHvhm2szt6IPiDTRxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ahn0KqMtZ8WIMMjHnqYTjDa63kkJKgOjDiLvATtbcC7YM5MQmT5E63B5GKrDnhQ7msf8hZ5kt8nDbbIJgyUlKoFCiCjPqdx2ww4d99bwWC2l8RQ/w/7GJYGOfzNzJYjVz0+DQJ8ikp3QPxs9Gzr3nl7PBXLxM+NO2aqfFmTdxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iin9fweg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64094C2BC87;
	Thu,  5 Mar 2026 02:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772678440;
	bh=FLd89eFvpiF6CFvuc5sjxFxbyTHvhm2szt6IPiDTRxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iin9fwegq5SMZRzyQAgUR1IAp0OJ2aXaOPtQo1bTLMeGR23XO/RvB8u6ppgIUH6ig
	 B1XDUWHSmeaHgLA7zRbSn9MWY2D0Sct91/tAjSl8LQBucvvuHsTOgGDL10DRnrRXsS
	 4yh/lKY6ZYd9bwZfKFmB4CKgn+KN3WbOpT7hLiLwFP+EnZ1RkV4pizbCG6k46DU6xf
	 DzsSKEbh3JN684YTN0O6cH7k6bKfrgsAx78sGw8/WuQCz0kOaQGDwumekzE0IqaXR1
	 fwOF6C5LqRh17YXD6ejZjoZvJnRblwk+N+0GYKb16uDYFS2lcwn4kSKrHk8aFC5pH3
	 1MWr/6XwPUJdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C943808200;
	Thu,  5 Mar 2026 02:40:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: use ktime_t in struct
 scm_timestamping_internal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267844054.2487871.3980699289563846661.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:40:40 +0000
References: <20260304012747.881644-1-edumazet@google.com>
In-Reply-To: <20260304012747.881644-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: AC80120A471
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264148-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 01:27:47 +0000 you wrote:
> Instead of using struct timespec64 in scm_timestamping_internal,
> use ktime_t, saving 24 bytes in kernel stack.
> 
> This makes tcp_update_recv_tstamps() small enough to be inlined.
> 
> The ktime_t -> timespec64 conversions happen after socket lock
> has been released in tcp_recvmsg(), and only if the application
> requested them.
> 
> [...]

Here is the summary with links:
  - [net-next] net: use ktime_t in struct scm_timestamping_internal
    https://git.kernel.org/netdev/net-next/c/c66e0f453d1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



