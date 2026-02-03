Return-Path: <netdev+bounces-256058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLkJFm9LgWkPFgMAu9opvQ
	(envelope-from <netdev+bounces-256058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:12:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C645ED3414
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97930304EA7E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A2121B918;
	Tue,  3 Feb 2026 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5o0C39T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9121DB125
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081019; cv=none; b=pEtzPYHTlizxGo1HFA4KqeScnAyDE+5QwKMQfY//9vYDcWeH4ktJCDpiv4+cqrcgquXbSKe47crgeur34/70WUE3HMH4BzzCVBjIBKw7R8QH5nB3u3shmPVQZypkIJRyPKRGPuvzqN8YFPP9ItECa5VbgUAa20vYi6vdlaRf6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081019; c=relaxed/simple;
	bh=Q+lV1n+Oyx/gFvcrMTeu3krmIc44vvcH+yvdHx4EHy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rp2yEzy5UNAq+SiMglkTV6dxCZ9VoJC/zsTz/PVS0/pszMpXSWsWQrdQb5Tsyg1iaYFTj9rAujLmRdUX7dfr6opMVGMdo6YI0LHWDPoMF7xaOgcU5hLvrJn59QUanOFs7PNz2+i5+qEl84L6+sx7zD6lPmZqOtzTM3NKdpJcZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5o0C39T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1115CC2BC86;
	Tue,  3 Feb 2026 01:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081019;
	bh=Q+lV1n+Oyx/gFvcrMTeu3krmIc44vvcH+yvdHx4EHy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q5o0C39TELHXAVZELHuMUjU33LT//UPe9JaL3pCLxvNFzGFiwZg3LWbSpfGXtnkNe
	 iyBHtCcQaaILf9fUcfah1f3plBllWg/3QeSCjwrZQg3/v0rfJOMsoF4bVFqz9QXLlK
	 qwmdthkGO/f23BrQigLAEfK55tNAlEc5k5SpFIN8Ped5nTj7oUGNTuleFu8BPHfqv8
	 6Y5nNMRgPOFtbLY9jwWhMqpLkO+2Nucoi+55eMXy8H+8OLdm/Huqhuolh1ckj6AgeN
	 lzTU0vLm1/jvvCJGLBGMp/5kZbZsDT2IkyRwnP2MTX6/06G85B/8S50RLtL5nzTJEz
	 f/hfQfZ1mSgqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16C1F3808200;
	Tue,  3 Feb 2026 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: cli: make the output compact
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008101562.1258089.5728890809462033826.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:10:15 +0000
References: <20260131203029.1173492-1-kuba@kernel.org>
In-Reply-To: <20260131203029.1173492-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, gal@nvidia.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me,nvidia.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-256058-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C645ED3414
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 31 Jan 2026 12:30:29 -0800 you wrote:
> Make the default (non-JSON) output more compact. Looking at RSS
> context dumps is pretty much impossible without this, because
> default print shows the indirection table with line per entry:
> 
>   'indir': [0,
>             1,
>             2,
> 	    ...
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: cli: make the output compact
    https://git.kernel.org/netdev/net-next/c/71a58ec6672f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



