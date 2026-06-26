Return-Path: <netdev+bounces-302167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m0FdOh5/PmoUHAkAu9opvQ
	(envelope-from <netdev+bounces-302167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:31:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC26CD73E
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:31:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="EdMit/Ey";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302167-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302167-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8C0A300CC18
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A973F58CD;
	Fri, 26 Jun 2026 13:30:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79C3F4DFC;
	Fri, 26 Jun 2026 13:30:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480640; cv=none; b=Xu5orsc8xJY6pKE/NVJ3WNq1NYxf+W3wJIlKcrexqn3oAjA7s0UE0U2/MIYv8acMXkL4xKhEOKoL/JLEoso6qlIpNKc4jrW1yj0lPUI9cvC1UokyZv9dgAimYWHbkuJg2CTaOlDhCbeT09d5gSqxFpcd7z3DyAcsgQRQPcmHDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480640; c=relaxed/simple;
	bh=EUxHTp2uexX3BlTMGfUqIxasHUqcfSYXguegSouhoF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GIAat42P9YpHzr6Zb9304SvJpm7PH1eF5spntN7FjfWsGb5hogLLVauWjIfzpkDCwlgca4B8Ov4Ie7jcZB0obXZeRJtZUIZtliFB2lbD3+ja9UXoxxgWBTRhnNzUEVPx1hj2jGxf8se5X7Uz0dkxmXqdmYvRjY98gDcBlRd5GX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdMit/Ey; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFED1F000E9;
	Fri, 26 Jun 2026 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782480639;
	bh=ZGQut91I0eyuwdOlMkbQ+Aix1zzIRn5OQIH4JbqR9Po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EdMit/Ey3m7RQtd2f6iu42w5eMWSxDhsf0vmeR448tY4ztHT6RDZoSXxg+LjGljr4
	 48EAD/NY2GUr0BVtj/Li1s84EpOgVVqdtKAAiQkC7Tc8XQYWLIr5Jkfe8+WXYOlErw
	 YVL/bx46I6hjq/M2LjwQKubmCTpDdfioerRSIysCw7PSmQJb1VvBcUcD5+nSTQXmXv
	 zd87COzMLAiujYo2p68P2LrX1oCPfpe8yqJ3T4sj4Kug5ATPS4P93Z3UN7e9CmlRSS
	 oXo+lkgTeLHC3uEPA0D43VyUO3HsR+UPUezHvOiHcrlKaESvJTCF6vVVVrYGr69nE1
	 aIJ2xsZ7Mm2wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9399C39389FC;
	Fri, 26 Jun 2026 13:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178248062629.457674.10289796084912546858.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 13:30:26 +0000
References: <20260618182035.43811-1-jordan@jrife.io>
In-Reply-To: <20260618182035.43811-1-jordan@jrife.io>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, jiayuan.chen@linux.dev, paul.chaignon@gmail.com
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
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com];
	TAGGED_FROM(0.00)[bounces-302167-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jordan@jrife.io,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:paul.chaignon@gmail.com,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32AC26CD73E

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Jun 2026 11:20:31 -0700 you wrote:
> We have several use cases where a pod injects traffic into the datapath
> of another so that the traffic appears to have originated from that
> pod. One such use case is a synthetic flow generator which injects
> synthetic traffic into a pod's datapath to enable dynamic probing and
> debugging. Another is a transparent proxy where connections originating
> from one pod are redirected towards another which proxies that
> connection. The new connection is bound to the IP of the original pod
> using IP_TRANSPARENT and its traffic is injected into that pod's
> datapath and handled as if it had originated there. This can be used for
> mTLS, etc.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: Support BPF_F_EGRESS with bpf_redirect_peer
    https://git.kernel.org/bpf/bpf-next/c/509ca545d425
  - [v2,bpf-next,2/2] selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_EGRESS
    https://git.kernel.org/bpf/bpf-next/c/006b9456e9f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



