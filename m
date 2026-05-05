Return-Path: <netdev+bounces-284159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCdWDaFP+WkV7wIAu9opvQ
	(envelope-from <netdev+bounces-284159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:02:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E04C5E1E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58B3030277C7
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC992E06E4;
	Tue,  5 May 2026 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9/lcsXp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7A285060
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946463; cv=none; b=KP21gExLL2Bf4YEk9VlxWhFW0ff7o9YYhZ2XK5qKlwtgvHYPm7j1cF94zNQMK50WOttZnxPRy0Oz8CVX4a9Zn0ocuz8BlAzve7LUuXPVyLibr+nfAw6uHYBHPPTmY77c4kmtx0Wq9mTuH7Yrf5uZOpiBzjR/zya1dnfr6b7W7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946463; c=relaxed/simple;
	bh=TBKhhVL+yUWw/LOzKQtEZ7rnX/Cyr+uBhAuyf/mWS/k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l807FyAqrlV+yQVsv4gvHAFUhM/6nNedmPevXQONWzVgAYtoZSRxCbWVE3xE8ecDQnLeYYDV9Ht0KQ645lmeW1hN0WbO5WT3yXPo8077L6iw/SFVhEeq6Qu3xj96WsP2IngXXrCAKAd+9X2xh5/X3141cgiNU2D0H0xgd/QAgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9/lcsXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ABBC2BCB8;
	Tue,  5 May 2026 02:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777946463;
	bh=TBKhhVL+yUWw/LOzKQtEZ7rnX/Cyr+uBhAuyf/mWS/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X9/lcsXpqmQI3ThWMFo6Rc0bv8cDfMs36PMJWs+lDl48tOwoyJ0teM6Q0mKcOZcQi
	 3DcU9jRcoTALrebycoQCzdEqXwy60Jmg0c6A14g7CW/T97Lk0o1RsSYUp2nKnfXEvw
	 Z0KnyTkz3lJGaRF8QCQLAtS5jXR1BVV8AnVpj6UXCBMIMWBQ8koRzY8E4yjDWhm1Fu
	 ja3q9TPYwoZ6Gujl71g6V6Zrp5nGrEh6KGagHqavrbqN9KuI+2Isir5Nx6mABcx+tw
	 wEcAxeeXtzc+9EG9zYNoGVXnQZ/kW1AtJjowWfvgNu+mFtaPGAjPBSNZdwgWiiDhFl
	 FctBzDiPprJjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDAA3930197;
	Tue,  5 May 2026 02:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: taprio: prepare taprio_dump() for
 RTNL
 removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794641407.1386640.12120316097914471145.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:00:14 +0000
References: <20260501064247.2027688-1-edumazet@google.com>
In-Reply-To: <20260501064247.2027688-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: AC1E04C5E1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-284159-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 May 2026 06:42:47 +0000 you wrote:
> We soon will no longer hold RTNL in qdisc dumps.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Note: taprio already uses RCU to protect most of its fields.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: taprio: prepare taprio_dump() for RTNL removal
    https://git.kernel.org/netdev/net-next/c/c4994aee0292

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



