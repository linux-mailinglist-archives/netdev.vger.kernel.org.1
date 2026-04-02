Return-Path: <netdev+bounces-274501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDVnE7tWzmnrmwYAu9opvQ
	(envelope-from <netdev+bounces-274501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:44:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 863123887BC
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12DDA30420B1
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17613DB625;
	Thu,  2 Apr 2026 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu3wrKIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580C3CA4A6
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130028; cv=none; b=sWD1tHVHGAH932ux/xYRZtd4RdBXYjlDze1FMHLMKq8npemkKfBWulqOhXzdfiuRzpODxFhZtNx1gYavj2hsDCHnPHx4Z+5rrDZS7y/2kwez20JcmllCCLFwbF3+/ALnQv943Exm5RuH3xjp1xZtDqS5mb1+KS9SMAtUYsAeLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130028; c=relaxed/simple;
	bh=GuLeylq3sP0EuUGjmtKc3s0QlH7edjHBsnf6bevZpVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NrPMAL2dAkRR9QzqV03geuDxF4ypSMfuiS6VrJs8xg1FuMA32hIWWg0HxA5LVpMhqodCDUnlLWh0GGK8mVZLKfIyGMhHBIy7Q6bJ9Wiewc1kZb3Aj9pwYY9K/iJXcGg5zVXK30Wv41J9CVL+/Jm+Kvv+CzZmyB7MForHSYFGiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu3wrKIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE56C116C6;
	Thu,  2 Apr 2026 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775130027;
	bh=GuLeylq3sP0EuUGjmtKc3s0QlH7edjHBsnf6bevZpVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uu3wrKIwAI2uWgDpB4oGT/jI4zZAw2c+f08ewLxPfOJlilqnl3dM3xT+8TAzQiNAP
	 r2GAtxr3IPhLC6gZ9IDbB9s27cJLZcGFeNuqIUqxa7+zp+/epuZLyjiGzVRWw92l4R
	 Hbvc3yFFBfMV/e+Y0ZI0trTOXTcpa4Yc0cUBY/xo/asTH31VntalGcK5FhuHGhOLJ2
	 BGEu8m7OpMhxkMjpyPDEHTLuyjlpcnnMOrTjbQObER7mm16MI9BXbxGVYh6e8tXi/z
	 h1JzUsAxC7RrPUBr4PnQ5S6t55WCCTt5x9UCN5N8+6CDMGDmgkx669G67vsJsVY2h5
	 jDo7iTqu3JU5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D22380820D;
	Thu,  2 Apr 2026 11:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: mctp: improvements for NULL-EID
 addressing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177513000954.4154169.3035958491228761422.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 11:40:09 +0000
References: 
 <20260331-dev-mctp-null-eids-v1-0-b4d047372eaf@codeconstruct.com.au>
In-Reply-To: 
 <20260331-dev-mctp-null-eids-v1-0-b4d047372eaf@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-274501-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 863123887BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 31 Mar 2026 15:41:05 +0800 you wrote:
> Currently, our focus for the MCTP routing implementation has been for
> MCTP bus-owner devices. In this case, we will generally have an EID
> assigned during local transmit, and have routes established before
> expecting to receive.
> 
> We also want to handle non-bus-owner cases, where:
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: mctp: perform source address lookups when we populate our dst
    https://git.kernel.org/netdev/net-next/c/22cb45afd221
  - [net-next,2/3] net: mctp: allow local TX with no address assigned
    https://git.kernel.org/netdev/net-next/c/8af20defc4ed
  - [net-next,3/3] net: mctp: don't require a route for null-EID ingress
    https://git.kernel.org/netdev/net-next/c/0d8647bc74cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



