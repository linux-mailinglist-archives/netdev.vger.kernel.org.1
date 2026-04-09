Return-Path: <netdev+bounces-276790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGvhG1MS12kSKwgAu9opvQ
	(envelope-from <netdev+bounces-276790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:43:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5053C59EB
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F32AA3011BC0
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182436A030;
	Thu,  9 Apr 2026 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6DSNMF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7036828D
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702447; cv=none; b=gP8598J7O37iuf4hQPb2J9BgsOzlV7UzxQ1S6RqjnpiQAbNKVvChMv4PqSr0TVyZKXVY621lBIRzbpzGSVuxy1lb5IymlKyXCV2/GktsNN7EH7Y4cjq9Yjh/9GlraA+pqe2oKLNn4lJ5DkoBA82aV2xwpdupTywTw/XKYSNo4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702447; c=relaxed/simple;
	bh=2d6W+P0LANdG6BILzwQrAsYx43NnXup0FNqCJvX3/Uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xl/OHzCFW6U6hU8EfDNshKeFfIS7Ji0SA6mbvLOG87ZFbL+XVmHeoaRn32m/ZhHcak33iCEyVFifQA2UpYGxhJRnx9CG2dFpRGTF1PdN3IcDzrxlS+fYKAZbOSpGoGuPUuAkUM7X6+LoBIKYFv0gvge5vxdUt97HtIddLkOioFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6DSNMF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EC1C19421;
	Thu,  9 Apr 2026 02:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775702444;
	bh=2d6W+P0LANdG6BILzwQrAsYx43NnXup0FNqCJvX3/Uo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m6DSNMF4qVxow3JzViwGhSvbl+GlNFF1DxWqeW1mkorfnrfUFMDNoTev9h08J35w3
	 butrX83/JerEeH3oEtq7V6mWLFq6JGHJf/2YWX+i9KQK9JfyBHUppxz0/7NyFxQGOw
	 Xi0uNRRw0JHNJsMLi676T8MqcKseSrIEcEpI10qmgtMhW8eDF+YqBUyw53NqEt8usG
	 TWcx3TrbPZjuVzUU2Kw5HmwKPn+4e02qOU3/E3+a3GmYbxCutD/k4pnl1sq0pjGglz
	 8DiaibDTdc8vB0viOijO8qNN5w+Jts6XikP9QO8gD8gfMPz47x8lXmiuXKLiBphjYP
	 Wh8eqFCT7XwsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CA93930793;
	Thu,  9 Apr 2026 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: dropreason: add
 MACVLAN_BROADCAST_BACKLOG
 and IPVLAN_MULTICAST_BACKLOG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570241979.964658.15758373630480158516.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:40:19 +0000
References: <20260407150710.1640747-1-edumazet@google.com>
In-Reply-To: <20260407150710.1640747-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 joe@dama.to, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,dama.to,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-276790-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB5053C59EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 15:07:10 +0000 you wrote:
> ipvlan and macvlan use queues to process broadcast/multicast packets
> from a work queue.
> 
> Under attack these queues can drop packets.
> 
> Add MACVLAN_BROADCAST_BACKLOG drop_reason for macvlan broadcast queue.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: dropreason: add MACVLAN_BROADCAST_BACKLOG and IPVLAN_MULTICAST_BACKLOG
    https://git.kernel.org/netdev/net-next/c/202ab599413c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



