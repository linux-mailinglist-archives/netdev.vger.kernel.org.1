Return-Path: <netdev+bounces-276799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ4vBusU12kSKwgAu9opvQ
	(envelope-from <netdev+bounces-276799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:54:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8BD3C5C2E
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0653040229
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7B36F42D;
	Thu,  9 Apr 2026 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNfRRbo5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D054211CBA
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703075; cv=none; b=BzXsgSx/gCFNwTLxkPtMIBd8Wn9+9l6wGM1ywrLYeoVJvFh/odmbNXPbB9yzBwlev8vokArI03PEEufxia6LNoTUDB9MVl0Rdf3Wn9zfnD8V/r+mi5QRZi2H0G+6J0WF7kP+mBr718qPg8Vhu+TGboarF1bOZE1Xhyo3gV9yzwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703075; c=relaxed/simple;
	bh=CYbnMMRzAq5s7gToaQXfDIRBSEj+aeme7maJ4JTdJqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ootwowF6+zhS6gJiHXrIdJ2bZV3pgi/cpKZ/GUqUDKyCquwFgNqOlgOmET0gU6Ui/9t7KrzX0burhPvxqW4BgX24hTQP0vyxHQAmnVBFg229H5hJatx00MGpZ5YFUXQRGje7oTyQdIuHLRpqJpjdvd1Cl9nvI8DEcSOtkhqjej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNfRRbo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C8FC2BCAF;
	Thu,  9 Apr 2026 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775703075;
	bh=CYbnMMRzAq5s7gToaQXfDIRBSEj+aeme7maJ4JTdJqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gNfRRbo5tGMvLkCUByYS6kOOaY5HZMrJW27XB4im2l8Qwu2x01JmXiz8e4a4hnYfT
	 UzwFLpdJcOt/v9Zhu4ioajDZ5atfZhDUBBnRoXOUaul6QSpFMrLWnUR1Dyn6/tDHJD
	 wr05GGf81cHuuzZHi1Afg5QKSL8V9EpwPl+y/I2sH93pfrh0l2RPPIToB5uTiKnLpf
	 A89eIlqfPdfCSuzyBVnXq1q4sU+XafsOQ4jMbqzya/gNL8YJgTd5XgwoF7R6XmcvYV
	 CRiidrHz/XyLdc/r+bFevE1m4YfzifZcgSf3cdUw6pqvh8IC8rIIZ6LzRqqwkb52v8
	 rHUmHWX/1zDFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D7B3930793;
	Thu,  9 Apr 2026 02:50:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] af_unix: read UNIX_DIAG_VFS data under
 unix_state_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570305154.968772.2978003434220801333.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:50:51 +0000
References: <20260407080015.1744197-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260407080015.1744197-1-n05ec@lzu.edu.cn>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, kuniyu@google.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 xemul@parallels.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 yuantan098@gmail.com, bird@lzu.edu.cn, enjou1224z@gmail.com,
 wangjiexun2025@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,parallels.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-276799-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F8BD3C5C2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 16:00:14 +0800 you wrote:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> Exact UNIX diag lookups hold a reference to the socket, but not to
> u->path. Meanwhile, unix_release_sock() clears u->path under
> unix_state_lock() and drops the path reference after unlocking.
> 
> Read the inode and device numbers for UNIX_DIAG_VFS while holding
> unix_state_lock(), then emit the netlink attribute after dropping the
> lock.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] af_unix: read UNIX_DIAG_VFS data under unix_state_lock
    https://git.kernel.org/netdev/net/c/39897df38637

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



