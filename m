Return-Path: <netdev+bounces-277829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JTmGnbG22lHGgkAu9opvQ
	(envelope-from <netdev+bounces-277829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:21:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAF13E4BAC
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59DD53011792
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8165A2E0B58;
	Sun, 12 Apr 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/Sjs7X1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3EA2DEA68
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010846; cv=none; b=ry3ONKUQu0dCK2S+xH0baITbkHoELJGNcXuATIVKkuCWsJo9Ot+haFJvhSL5Vi6D/bWYJ03RaDHCHY06YfnZkXT/3OohTCxXwvsIAMOXBBro3FM2ubA8YCTissSMMYURlvh85ohXMLhomX0FIA5y8GAnb+vn0c6MB48vBUVSw0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010846; c=relaxed/simple;
	bh=lqFV9YxTkgT8IPPgkYpDWX8qK4ULVySggFuZjRa/LDk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bxsLCC8rUMpF/l+bfA0y8wt+FsGlDL70Kg3Xzh14/wqAKXtIMcHUmRZl9RfBKcmfA+qCH7B4W2uwZyvXihj6L3Ctlwv/z/fWyLg7/kksXFCsSUMZM2liZ+b1sWFVWZLyj4acEFUiOS39Zmo2SZ2dS7dA1x4nVKHtzL4nub3+Acw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/Sjs7X1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3943AC2BCB1;
	Sun, 12 Apr 2026 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010846;
	bh=lqFV9YxTkgT8IPPgkYpDWX8qK4ULVySggFuZjRa/LDk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j/Sjs7X19DYMosF2AeInKyiv3m9s2FJL81tM3pYkew1fUOlgCUVHICHmehAuak+pM
	 X+/drElnXiPP8GD2DameemppY0nTZpoTd0Q13BcDTILJvrZ+yKnUgcrOhEVu6nms9M
	 j1M8L8CZbNw+T5HtP3Wm6huNAGQUmtrjkDsuPb8GOh/j1KqqelLLI7Ry4ogL57eydM
	 5J1dUSYzNxU2k/UohOZpoBZOFeVv971Kreq69XhW7hoNAhj4UEIT+gnjBCqdCc993y
	 uY4buPMxIMmDqMFpQBYUhXKwgl+Wl9wrfD1/pkcPbyGXuBxN0MC/PZ53NIqe+ydVuQ
	 27GftUQp0xd7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02B8B3809A8B;
	Sun, 12 Apr 2026 16:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] ipvlan: multicast delivery changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601081878.3330556.11524591978379423620.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:20:18 +0000
References: <20260409085238.1122947-1-edumazet@google.com>
In-Reply-To: <20260409085238.1122947-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277829-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBAF13E4BAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 08:52:36 +0000 you wrote:
> As we did recently for macvlan, this series adds some relief
> when ipvlan is under multicast storms.
> 
> Eric Dumazet (2):
>   ipvlan: ipvlan_handle_mode_l2() refactoring
>   ipvlan: avoid spinlock contention in ipvlan_multicast_enqueue()
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ipvlan: ipvlan_handle_mode_l2() refactoring
    https://git.kernel.org/netdev/net-next/c/441ec8b5bdcc
  - [net-next,2/2] ipvlan: avoid spinlock contention in ipvlan_multicast_enqueue()
    https://git.kernel.org/netdev/net-next/c/6dd82499fa6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



