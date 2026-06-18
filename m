Return-Path: <netdev+bounces-300286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9BreJzg7M2o3+gUAu9opvQ
	(envelope-from <netdev+bounces-300286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:26:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F9169CE2D
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:26:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S1v+LNSV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300286-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300286-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C05B730FFB1E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F8F23AE87;
	Thu, 18 Jun 2026 00:21:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB8229B12
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 00:21:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742072; cv=none; b=JL6B2VfvzEnVoZ5foSs9N16zx0Tpj1Bi62NSMxspFBezAW2kjU77gQGuuY3mQpEdvSHeEWSfHjIVC7IKaN+WAffXOYRVeg2RQA73qAndB+7zO9aQG3XU113Azz0Ts5NVCifEXso9bJsSzdAR6Ktq1jSemUk+JVvt7m1Gohpes/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742072; c=relaxed/simple;
	bh=+JzIY/Q2Uk18g2dTRh3CHOPos0EzYfSik7qUZgnSN7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eVGSzAPT8rlWUz+1Q56ZMohh7MP5QOHYY2xDYwFM4/LIWurtvTYVO4f5E8smhst9/xbBxBUQJAhxnT4N7FTKjGALK7Dm65XSepqL+HDocphWB6tkk6Z9l3pYYjG7BVQn7JoEDz3BezGLOpSAzau5zzaK+uHWZ9VFyYKDZRmulQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1v+LNSV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CFF1F000E9;
	Thu, 18 Jun 2026 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742067;
	bh=LsIQEEMir05U1zmWxLbkqXFus41GhbnRQeBgw2+4dOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S1v+LNSVvgEsli6C+Vl6GxRYSn1dhnypOyrKu+lZA0yfXrPSgagWDSzzWdkpoYC2q
	 cX+IspKu5iafE6fp6oFFvUfH9TczRZS6DGqq/PX/QY496UPJicXU01m/IkKyTtYz3p
	 bZMp6WZKilF691SJ2fbor55FxJdg+vVxIJNH9KC82mSG6Vj4/wSNBszNmD4ygwd4dQ
	 E42mNIulPvJ+vwGlOTmiF9x6hNIq/2OiDcUqGfbsS7lKwiRVB1urC+e54lxjkJqXRM
	 Lxy2Yf/uddC0Gzusmd8Q0EL87B9fql9YTiYRrhqJQKntZLTBsBK1j+bgiSF9Mto30T
	 1uwKbbjcXWMFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ADE393102B;
	Thu, 18 Jun 2026 00:21:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: ipv4: bound TCP reordering sysctl writes
 and
 MTU probe sizes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174206113.1875263.2390720777544662646.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:21:01 +0000
References: 
 <1a5b7e1ef4d70fbad8c8ee0b82d8405f3c964a3d.1781395200.git.bronzed_45_vested@icloud.com>
In-Reply-To: 
 <1a5b7e1ef4d70fbad8c8ee0b82d8405f3c964a3d.1781395200.git.bronzed_45_vested@icloud.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuniyu@google.com,
 david.laight.linux@gmail.com, ncardwell@google.com, pabeni@redhat.com,
 chia-yu.chang@nokia-bell-labs.com, ij@kernel.org, yuuchihsu@gmail.com,
 idosch@nvidia.com, fmancera@suse.de, herbert@gondor.apana.org.au,
 yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn,
 bronzed_45_vested@icloud.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,redhat.com,nokia-bell-labs.com,kernel.org,nvidia.com,suse.de,gondor.apana.org.au,lzu.edu.cn,icloud.com];
	TAGGED_FROM(0.00)[bounces-300286-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:david.laight.linux@gmail.com,m:ncardwell@google.com,m:pabeni@redhat.com,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:yuuchihsu@gmail.com,m:idosch@nvidia.com,m:fmancera@suse.de,m:herbert@gondor.apana.org.au,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16F9169CE2D

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 18:31:18 +0800 you wrote:
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
> 
> Reject invalid `net.ipv4.tcp_reordering` values before they reach TCP
> socket state. The sysctl is stored as an `int` but copied into the
> `u32` `tp->reordering` field for new sockets, so negative writes wrap
> to large values.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes
    https://git.kernel.org/netdev/net/c/efb8763d7bbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



