Return-Path: <netdev+bounces-296766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y07BECZHJ2oauQIAu9opvQ
	(envelope-from <netdev+bounces-296766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:50:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DFB65B14C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:50:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aqUoIdU0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296766-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296766-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67581300B0B1
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095243B2FCA;
	Mon,  8 Jun 2026 22:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB642F9E8
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:50:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959008; cv=none; b=Z+z0tA/TNhOuTbJbhmBDXdTHDuIyZi6H1lBcR3HiV3Y925p3F51a+3O9TpDCKyONCWJOfzTKZJqT/MlP+7lQYEutzs8i3VU9UJtJwRjKwOqJVSAtd2bky20HaODDV/VGsXrM8uVbBklCL3kkVDyePjyKFX8tBS/uDPReLZKDNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959008; c=relaxed/simple;
	bh=Y1ezw6yh0lr4QriJVKf17QhYu3Wwtnnx+mt0/gpws9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NYsmmGsgvkKw2UncOkRnGAZuie6HBBRLbX45vu6iE1RsKpYi/fu9T9lsBuCjKModrVC/g5x8Vm92p+/28iQUHhMMN8v4xQTv+KxShpQcBopkKqyCTVs1mY5XNyxqHjgJkMeQKv7wU4/kDCTcvzVfkkWCin3SZfsD2tNDj5SLRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqUoIdU0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655DA1F00893;
	Mon,  8 Jun 2026 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780959007;
	bh=qDweXOGn0LK9hKT0UPLLnXfT2GFzAHxHj1i23DQ3Uj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aqUoIdU0omLx+mIMZTm7kLyBWpRgJX6xCER2b0/gAShRZxwKEUMxGHHorWSKnZDwJ
	 n/lsgOUv0Ocge17ek4GyM/GEkNWbB5EqFH8kzLyDagEKP6ve/j5vsFJbIYoiyy02UD
	 cxNLe8cCO0KI4xFRSkalrYzmgOVYqTjMixprC671v/DO9CaD29exJTH9FwG/AaVSWx
	 0ddMtLJ3NeuZGBWwYTBzhwebX13mZzkSye4SN1yfr8FbmYkKGVjRhyq/usZiUjgaQz
	 bz3ZgELRniujBJJAFNZ1Zm3qAmA4c07+DLdiiHf9enBvPca6z79nJ5X/0Vn7TwW0Uj
	 N2Vmep3OyAQEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568FE3812FD9;
	Mon,  8 Jun 2026 22:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: restrict SO_ATTACH_FILTER to priv users
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178095900590.1702157.2907124553708857115.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 22:50:05 +0000
References: <20260605112134.3642413-1-edumazet@google.com>
In-Reply-To: <20260605112134.3642413-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, tamirthesis@gmail.com, aksecurity@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296766-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:tamirthesis@gmail.com,m:aksecurity@gmail.com,m:willemb@google.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ericdumazet@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31DFB65B14C

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jun 2026 11:21:34 +0000 you wrote:
> This patch restricts the use of SO_ATTACH_FILTER (cBPF) on TCP sockets
> to users with CAP_NET_ADMIN capability.
> 
> This blocks potential side-channel attack where an unprivileged application
> attaches a filter to leak TCP sequence/acknowledgment numbers.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Tamir Shahar <tamirthesis@gmail.com>
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> 
> [...]

Here is the summary with links:
  - [net] tcp: restrict SO_ATTACH_FILTER to priv users
    https://git.kernel.org/netdev/net/c/5d39580f68e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



