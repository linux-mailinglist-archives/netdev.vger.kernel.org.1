Return-Path: <netdev+bounces-299284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OWapBk9ML2rQ+AQAu9opvQ
	(envelope-from <netdev+bounces-299284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:50:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 613EB682A9C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:50:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Vz7rW4iy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299284-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299284-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C380D3006B6B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 00:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56A1E5B64;
	Mon, 15 Jun 2026 00:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D527DDCD;
	Mon, 15 Jun 2026 00:50:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484615; cv=none; b=okcZoOTU2unttdb1labQZpRXliw4vMrv48TiB5hJWzqBTCoLqTI8GBZjnIRDKR+g7C5RPS56nIGAn2usyyaHBuRvRI2Ouvjodsk/abvhylT5fxWZnwSFWv2WBUN3iJBxAkfU349EfpRWiwwXg74jYoouIvYT4KUG8AHvzo9AYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484615; c=relaxed/simple;
	bh=rSxKc/N/tH+uwzNkiWE4KIoX0y7JGcbdRUe2EnBy/a0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WiWVF+A/GXGIKbQSk+r32aKqT34UZX9yb9MifMNNIlG6Vys9OXAyIekTNzsDCceJX4CqMK+F8NQWsQxKyTa05/DkMKZc5gZaPjTMdA5cKRcKbajVi1ouxnPRfZpWqfLGRKYJGiFv7dn0TVMrnwFvx8yERCXdaV9eHW9z9IAMfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz7rW4iy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981361F00A3A;
	Mon, 15 Jun 2026 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484613;
	bh=YWWI/90L+aoxO/PYplJC9Vjepxw4Tfe3yAFXN/NOWHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vz7rW4iyAmd8NnKTk18OuCKtmHSw9nNa5HzS5blMaZysarw1hwtIZINA4L7yCMD2I
	 ui8X7z61b9DItkWuLvbgCq6M269HoIQ91UNOuOeAeEzp7P9SgEipG6ng5qw8cMt37F
	 UjfUykk+ex3RT5hXttcr+Pa4Ew6WvwKVwIu9rGO8M6S7KlOqeuV7DmE97WsxcuiHAw
	 RUj7QI6DxJwe5/lX8EhyEz05STGDOH18+mXQXR6t+OysjQevsYx/Pi0SYxBNiK5FIm
	 T+zxEBnKRh3XFpml+feigYemg1rBvbv4MKDCcgjTgqgkyeDYPhnKqxWDruoF+QaGit
	 xBW6VDXBr+Scg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569653A566D2;
	Mon, 15 Jun 2026 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: Fix bpf_get/setsockopt to tos for
 ipv4-mapped ipv6 socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178148460889.2365545.16232674085836025115.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 00:50:08 +0000
References: <20260613162443.60515-1-leon.hwang@linux.dev>
In-Reply-To: <20260613162443.60515-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, ihor.solodrai@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,fb.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299284-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon.hwang@linux.dev,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:ihor.solodrai@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-patches-bot@fb.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 613EB682A9C

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 14 Jun 2026 00:24:41 +0800 you wrote:
> When TCP over IPv4 via INET6 API, sk->sk_family is AF_INET6, but it is a
> v4 pkt. inet_csk(sk)->icsk_af_ops is ipv6_mapped and use ip_queue_xmit.
> The tos sockopt does not work for bpf [get,set]sockopt() helpers.
> 
> Changelog:
> v3 -> v4:
> * Add 'sk->sk_type != SOCK_RAW && !ipv6_only_sock(sk)' check.
> * Re-implement test with LLM assistance.
> * v3: https://lore.kernel.org/all/20240914103226.71109-1-zhoufeng.zf@bytedance.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket
    https://git.kernel.org/bpf/bpf-next/c/ca0f587c029a
  - [bpf-next,v4,2/2] selftests/bpf: Add test to verify the fix for bpf_setsockopt() helper
    https://git.kernel.org/bpf/bpf-next/c/5cf2c21ab090

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



