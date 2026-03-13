Return-Path: <netdev+bounces-267248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGU3Felhs2lcVgAAu9opvQ
	(envelope-from <netdev+bounces-267248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:01:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB62327C20A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9F543141CE3
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53E328631;
	Fri, 13 Mar 2026 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrXj3o86"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A53264F4;
	Fri, 13 Mar 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363615; cv=none; b=diCXooeiRNniezrC/WNsad1OOVfNqCTcd7h08r/7xt8lXABEjPe/WmOMzJXcxwmARkMV0swUTHJW6FGoKyNuisi51ItIg6zEg92+3a2PHXoFLjc87kF8zpr2MMVw3yWiFskTNnDBbgGAwiZN2zfwtdAJOguFVsegIP6CyyQ3F4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363615; c=relaxed/simple;
	bh=c+ggLTBXT4qBWJvLZCpSD/Csr2umRXaIwc3a+m86BfU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=udbw2A0Lr3VfsnRn4zSnL+u4DzU8hfhsTI3lnAfXr3qHjiGovDrpR28zMbrmnVPw5Ff9HQoim2UxCtZS9YCpdVY4qqcuMaEfzpfyHFwwLGBrRYtaU96NyY6I8MuVBUOCOVews92X+RUsGAIBxYJCGmfNXR9RkDV3sZbSf0QzwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrXj3o86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8880AC116C6;
	Fri, 13 Mar 2026 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773363614;
	bh=c+ggLTBXT4qBWJvLZCpSD/Csr2umRXaIwc3a+m86BfU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RrXj3o86gBoacNQxXxJEwFfMILvVKTIt1nZAa1jnw+r7L9o2fPAIa5smX0ZLPxZew
	 4J9LtrQ3OzXAJNRB1kA1xZFwvP4rcpI4uDsR9/Bl/WR55htKlDqOyKh10dSfxXtHKA
	 gtW13ulo32lsb3NwHtkMHGMyqc+SG6UR/hvjxcbXhGi/N6h2DMuCGqSswomuXPRTbG
	 2NF+vFkKMcv0SrOXvtYMkHK5sOoDfiDTxwuFPdKSzDfDMrWHQ2fNZXw9nqWNgH/4F+
	 wvngLtNF52os8meBcNnVRdf5ViRToNNuM/egxGg9z/Qh8nnfZtOxDizpVT8d2jPh3Q
	 I+4ATzPY2hKoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CBE3808200;
	Fri, 13 Mar 2026 01:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ynl: ethtool: remove duplicated unspec entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177336360979.619871.4052319965056689540.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 01:00:09 +0000
References: <20260311-b4-drop_dup_unspec-v1-1-e0dfa47b5981@gmail.com>
In-Reply-To: <20260311-b4-drop_dup_unspec-v1-1-e0dfa47b5981@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: andrew@lunn.ch, kuba@kernel.org, donald.hunter@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267248-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB62327C20A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 11:22:29 +0800 you wrote:
> There is a duplicated unspec entry. Remove it.
> 
> Fixes: 0187e602c03c ("ynl: add missing pieces to ethtool spec to better match uapi header")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/netlink/specs/ethtool.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 
> [...]

Here is the summary with links:
  - ynl: ethtool: remove duplicated unspec entry
    https://git.kernel.org/netdev/net-next/c/7c52f407f28d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



