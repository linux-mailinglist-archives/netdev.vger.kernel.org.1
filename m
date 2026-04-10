Return-Path: <netdev+bounces-277477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGqSEBoj2WlrmggAu9opvQ
	(envelope-from <netdev+bounces-277477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:19:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7813DA4A6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E184530FE845
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1C53A75B9;
	Fri, 10 Apr 2026 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHb1lwk/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043C3DBD71;
	Fri, 10 Apr 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837220; cv=none; b=gm0FvGAQNrFU2V40m4NMeSVK7kYC0LWgUPC+LyX+9RN7Lh4OOL+en6QYLRM3X9LFsjwl9ZEVHcKBUKH0au41ZpMIfBj0qA65XGIOPpBeOpBzhcUeEUiceXVIuYhIXv7y4/gLpoR6YShYDk1lkW1eKA9cNgVxeX/v9Oae2Xwtxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837220; c=relaxed/simple;
	bh=gDVUzSQEJ7258c+nJSVFbnKG6DnW+kb64w9kEfWKOW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DYNUzCgqdLaqRT+V1LsTzgl3bwF4C+WLGE++FPYWpp4nBPhNUPcaTC1L4SLZ4hTG0vuaEmwjo0plTZBLdt5gf2XZOvgIRZixM92MkrKQaWwkwYXtwQIaR7erFXkO9BPLzHKrd2hgEaCzSEzr/Pl1Jpt4RTI21NFsUxNt8uGKE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHb1lwk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A514CC19421;
	Fri, 10 Apr 2026 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837219;
	bh=gDVUzSQEJ7258c+nJSVFbnKG6DnW+kb64w9kEfWKOW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cHb1lwk/3GWtOqdH/m5MqvNI9GvP17HeMWL2s2B/p6/vQktuX5tNJn+OaiGRZ4dXC
	 +Erx1IPBgRWgK89c4MoP7qkw9y5/f5EqcCNdl0uPp0zpuzRHG2ujv0UWxYBgg9mwrP
	 DRBZKNYyJlCgjjpwlm6Y4cgibebzJMAPJcbqDl8EvJxl4IwvvcdWoBxU5UT45B8b6e
	 RemLju/nrALiZvAYzi8y7IvOzJTVyhGbWid4l5m5bo/hTgH5A18xr9U0oT6pKyrzSw
	 P2eFnRIsngPEvFOLI3Zh5f5IQJ8AvNBgGLn2MasyEAcbkXI26UzkGDDYcL8tdLHNZv
	 CQfzHn7bFWdPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD6C3809A87;
	Fri, 10 Apr 2026 16:06:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-04-01
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177583719431.2534919.11683704772155829682.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 16:06:34 +0000
References: <20260401205834.2189162-1-luiz.dentz@gmail.com>
In-Reply-To: <20260401205834.2189162-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277477-lists,netdev=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C7813DA4A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 16:58:34 -0400 you wrote:
> The following changes since commit 48b3cd69265f346f64b93064723492da46206e9b:
> 
>   net: stmmac: skip VLAN restore when VLAN hash ops are missing (2026-03-31 19:45:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-04-01
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-04-01
    https://git.kernel.org/bluetooth/bluetooth-next/c/6d6be7070e90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



