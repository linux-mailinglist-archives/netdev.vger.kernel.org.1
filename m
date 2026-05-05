Return-Path: <netdev+bounces-284141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMjRJEtB+WlP7QIAu9opvQ
	(envelope-from <netdev+bounces-284141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:00:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C634C5981
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D2E5300B198
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 01:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A6214812;
	Tue,  5 May 2026 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIQgpkja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BB1C84D7
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942855; cv=none; b=QBZPvdpTEP+LSC/JZKCz22ZwV3dki7zr2ABMNVz+H/qJo9I/RYQtqYajnTn+yFN+nbCkOf5MKV3UxYGDIPRNSdEvUvvA6SPn/+QOuyMBoSymcyrukNnHBZEl9AFfuqiZl9EZNc641mSGCwONZcK0GC8AEU9h/Lz4udJ7j7tvtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942855; c=relaxed/simple;
	bh=HyhFIiORYd/3V7aU3ycWqTuG7Q21rh+0wYyQN0bZ8sA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j77lBLDKUc0S1q6B+0yTcNoxUjw5Q8leiat6XSqvqZgoj4g4+I+tPlJQrJNp6X8+SHHQQdv5r+YcEQWrda2dR6YvG9dYa+Tmumy4ItrHFBAzQsiiTR17LSYSQ0ubLZLU7Daiigb3bI22bDYYVXp+NJ0m//rHWrmx4uIdiyIygKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIQgpkja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6FFC2BCB8;
	Tue,  5 May 2026 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942854;
	bh=HyhFIiORYd/3V7aU3ycWqTuG7Q21rh+0wYyQN0bZ8sA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pIQgpkjaP+GnPciA36VhdzL4sodGAO2HfYZqWW74Ofl5gPEvueC/MPZaoDI8E+l0t
	 dHtcpBBGQxmAwIhMLP7hz1fA2EmK+aobqGDm23xYThHW1GcsGtqUD2UpwgqVZeLotY
	 tv6891iTwDR+U5y8YcYW5XByKPVvLkMwAWl8OVn4pzTDV7vgNY2TLwzh5wd2PzrfkF
	 sj+uq4NjvY2eXQpY+yt4nr7GIU5BEw7tyjhzB3shuRYDewLw2tgUBPpN/3d0SE3gf0
	 WKgOKEIUkbAyD01CMVq9DR6UK6PyGpZpCtUs8jaLZS39hQZOdCRjK/Q1RMEijxvGjs
	 Og+omlEb9RSug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E6A3930193;
	Tue,  5 May 2026 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] tc: qdisc: provide tcm_handle and
 tcm_parent to
 kernel dump requests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794280554.1370682.8963022002603123360.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 01:00:05 +0000
References: <20260503115138.2467123-1-edumazet@google.com>
In-Reply-To: <20260503115138.2467123-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, jhs@mojatatu.com
X-Rspamd-Queue-Id: 33C634C5981
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com,mojatatu.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-284141-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun,  3 May 2026 11:51:37 +0000 you wrote:
> linux-7.2 can filter "tc qdisc show ..." on tcm_handle / tcm_parent and
> reduce dump costs.
> 
> Old kernels ignore these values.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] tc: qdisc: provide tcm_handle and tcm_parent to kernel dump requests
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=0fbce40d480f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



