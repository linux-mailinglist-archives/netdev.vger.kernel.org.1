Return-Path: <netdev+bounces-259188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLRQKYAUlWlYKwIAu9opvQ
	(envelope-from <netdev+bounces-259188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:23:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C65A15282B
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A349301B717
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE0271A6D;
	Wed, 18 Feb 2026 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRbBNiu8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17008284890
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377633; cv=none; b=hz94Ci7FLLRk5OEhB5WJQ/ojZbJEKYMT80GTBwnSkeoyUDHeDIpwxe0ZLDK9NN4KN6KVvEKIhHhukOEHT3qVd/yCpd2wa6hwn/+W8SvPCmn/MyC+myoJojU00QsoD//R2u6HZoPaPtvAVovRpgEQLIVhLSDzfD7M52RnKClB78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377633; c=relaxed/simple;
	bh=ZxFjjCS+YnhDU+/oa+kUlpEx8cWUl/P/VDsmNjABpXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wcx8QcxuPZS8Tx50oxGOu1rR3nZjPyfeCYst08SaQ54p8eATQ1fH+jjvIDQYir5MfA9HtxdQ3OwIWqXDs2jwP63/cZus+qyt/ET4/bP4wWuUYZ6iNAIhKyblYx+1CAFUY7vAg8uo7FyNNE2wFUkS2Ic9B9IOFMIInaFsykUgMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRbBNiu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D23C4CEF7;
	Wed, 18 Feb 2026 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377630;
	bh=ZxFjjCS+YnhDU+/oa+kUlpEx8cWUl/P/VDsmNjABpXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uRbBNiu80/9eBuGBkx+Vu1X2RvT3Q9MjID31yL+K4v4cj0hd6zKBfIvXGc7oIOLLf
	 6w/x+wWGBOMRCluauuc+cbtgBToT8cEsne4WgMOhwD1punC8Qn7t3IQkeljgYovLtU
	 +0oqXqmdVcsUdnIeri8Yqw2EBESKCorR7ho4DWog87+mhk4ULbHgQWoK0uUFz/XSQN
	 rQijO22/Fvg55k8tca3yF94eYMf52O6HG23DdLDr/dBRgktkRKLN5ePlhfDlrh7gz2
	 2elryU/fSnQYORmjl0D64xK9gpVuar+ml2e8U/KiqG1SCsaJ7HGk8qPtct21UeL6JL
	 vmwRdbLEfx88A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22603806667;
	Wed, 18 Feb 2026 01:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: do not delay zero-copy skbs in
 skb_attempt_defer_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137762257.765825.11990417995697717058.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:20:22 +0000
References: <20260216193653.627617-1-edumazet@google.com>
In-Reply-To: <20260216193653.627617-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-259188-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C65A15282B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 19:36:53 +0000 you wrote:
> After the blamed commit, TCP tx zero copy notifications could be
> arbitrarily delayed and cause regressions in applications waiting
> for them.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Fixes: e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> 
> [...]

Here is the summary with links:
  - [net] net: do not delay zero-copy skbs in skb_attempt_defer_free()
    https://git.kernel.org/netdev/net/c/0943404b1f3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



