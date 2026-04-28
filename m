Return-Path: <netdev+bounces-281560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M9bM7z/72mxNAEAu9opvQ
	(envelope-from <netdev+bounces-281560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:30:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 393EB47C231
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B3F301A1EF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF61F1A9F91;
	Tue, 28 Apr 2026 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O39gvxKa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC49175A72;
	Tue, 28 Apr 2026 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336248; cv=none; b=FlRYtMLfeMoGjJlCv0aLhmDvFV8muuBdqLi/jrJi3Y1Uw7JxjCXij6yFGmbN6cnlbtABSBebxVOxYweO/t/sX1qX0aDtAUrvbHj0AcSD9FsRHhg9dvRCd0YD5eh3hMNTUmMmC2kM4UQ2tTyLx6XrhIqaoRtwvFc0lsqTM1wMAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336248; c=relaxed/simple;
	bh=JehkIcwPgpsn2lY3noIUV3MWLvBYtrNRROq7VgTybgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eMJhA/1DNca/p+FfmwcrcSIHxdRsTNNJWuLdFZnh+/eS/4z+iJLY40Hv1bg5urczMNWoiCsrtuL0X+mzm+nj17v8R5drW8dKvGTxYu3LlzDTLlsDHr+X4QAAjT9UtQAZBmnRJeATn+dZ3+Kv9RhDYegWQowROl5fflNb+5ykrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O39gvxKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEBCC19425;
	Tue, 28 Apr 2026 00:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777336248;
	bh=JehkIcwPgpsn2lY3noIUV3MWLvBYtrNRROq7VgTybgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O39gvxKaz3mUBhMiM/NJo7OsrXE/KY7TN331Geijmr6vmlketS0PIWnLXw2px+VnI
	 2pg2QUnLHiGvXMMZVifeiIBsReQjAZpxWdokv4gVPEh1EyoiqTx6JlZh0/E+DseijP
	 fPrGTT9JzRcdV0/t6Ou9zgb0qXYDLm66ZIcaoy2vl56BbzCsN1y8sRZWcHL7UOmMWQ
	 cnrlVa+D0xsctGEWDLy7j6vkIsdKmgWtjP1K7FB3EC3WECQuUG0invjkir4d69eYi9
	 X1kj8CrWqkh84UTBVeydqvSvaGSm6aXKDtKkyERrwscCIhXu9+AG7XjBMUq8TQPxR7
	 VKaaDwp80Bk2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DC5392FFCB;
	Tue, 28 Apr 2026 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netdevsim: zero initialize struct iphdr in dummy
 sk_buff
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733620555.171020.13636107827535751383.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:30:05 +0000
References: <20260426201434.742030-1-zlatistiv@gmail.com>
In-Reply-To: <20260426201434.742030-1-zlatistiv@gmail.com>
To: Nikola Z. Ivanov <zlatistiv@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 393EB47C231
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281560-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Apr 2026 23:14:34 +0300 you wrote:
> Syzbot reports a KMSAN uninit-value originating from
> nsim_dev_trap_skb_build, with the allocation also
> being performed in the same function.
> 
> Fix this by calling skb_put_zero instead of skb_put to
> guarantee zero initialization of the whole IP header.
> 
> [...]

Here is the summary with links:
  - [net,v2] netdevsim: zero initialize struct iphdr in dummy sk_buff
    https://git.kernel.org/netdev/net/c/35eaa6d8d6c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



