Return-Path: <netdev+bounces-277934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACPkG8ch3GlONAkAu9opvQ
	(envelope-from <netdev+bounces-277934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:50:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9903E6541
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D7B430028CD
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAAD3264CC;
	Sun, 12 Apr 2026 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEHhfQpI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783E3242B1;
	Sun, 12 Apr 2026 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034241; cv=none; b=YbntT3+eZ5SIy7MtC6cs5n8E/IVNamjSggo35poB3cwqEI4BPxfQ5b+83JHCkNBf3Ga1g5B4FiopScLz1lFsxeMWP4/8wYMHqk4Moy0T0zSoVM7/klhGgYWsNP/D2L9I+y8C2UsDLekDwJuJ6zrVDfFdoRJbG8EsYNv8/SlhY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034241; c=relaxed/simple;
	bh=AE0Trs61tSgDh/Pcbu51eZL5ciMR9aruQTmqkMMl/ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pHzzScz500slOa04U7c2LfB3mnwpaTUjvOBR9wOvJgky80oe40XkMxMTe/fsVswiZHI3bCLZwMo7OyT7n/f2Ys9Te05WFTd+KtrF93R220/nh5UmJqY3wBoBCmmkd2M0auROVntQsyHMC1G8fvVxjVig7Qe+K3AUUZBK+ODJgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEHhfQpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061B6C19424;
	Sun, 12 Apr 2026 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776034241;
	bh=AE0Trs61tSgDh/Pcbu51eZL5ciMR9aruQTmqkMMl/ow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hEHhfQpIiSimgI0j1P026Zhb4fbwCrZue/ATOd2O++mwNJ3er4H6VA/YTaWeEPWZA
	 H/JrvZgbScF6Ar4rGoqmkbfH619UGqje6hx7LmMh/F6UodISTh2EAmYMo6e3TwHgOh
	 wYdY4mY0122EqSO8P/gGb631vZLQV1WI8aQ1QvR5yDW6Gc5BJDye3WrK4WylalsPii
	 XfMDdmx1O77onsvgv+96gHRbi++YQ5Of52js6Lfb0xBE2bsa8yVtEM/8NPwVQNJubn
	 GoWNEaD1KmaAEHJSiy2nSHZ9HX9Hs1hBUAFFcuS8LDky68BuZvIIHxMPpLOgTZKjeh
	 HagBA3dx2fNWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD6A3809A8C;
	Sun, 12 Apr 2026 22:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] bpf: fix short IPv4/IPv6 handling in
 test_run_skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177603421329.3846122.3103968416452888308.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 22:50:13 +0000
References: <20260408034623.180320-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260408034623.180320-1-sun.jian.kdev@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277934-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com,linux.dev,gmail.com,fomichev.me,syzkaller.appspotmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	RCPT_COUNT_TWELVE(0.00)[24];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5A9903E6541
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 Apr 2026 11:46:21 +0800 you wrote:
> bpf_prog_test_run_skb() may access IPv4/IPv6 network headers based on
> skb->protocol even when the provided test input only contains an
> Ethernet header.
> 
> Fix it by rejecting such short IPv4/IPv6 inputs before accessing the
> L3 headers, and add a selftest that exercises the reported
> bpf_skb_adjust_room() path on ETH_HLEN-sized IPv4/IPv6 EtherType
> inputs.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
    https://git.kernel.org/bpf/bpf-next/c/12bec2bd4b76
  - [bpf,v4,2/2] selftests/bpf: cover short IPv4/IPv6 inputs with adjust_room
    https://git.kernel.org/bpf/bpf-next/c/f1cc94665df9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



