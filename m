Return-Path: <netdev+bounces-302160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GwwjFm5wPmp7GAkAu9opvQ
	(envelope-from <netdev+bounces-302160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF876CCFA4
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:28:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=llGw7a99;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302160-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302160-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B24B13013C73
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86063F4DFD;
	Fri, 26 Jun 2026 12:28:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892A3F54AC;
	Fri, 26 Jun 2026 12:28:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476889; cv=none; b=ixL9JbGqH1o9n5Pc+9eXvHZUeFPfoArHDKmD8nyep6XDRoeojHG9/wyEbYHhMJHrdW4idzFH9BDAcAivf9iZsn5Bav6cVPJwMqSwUeCDbivUhM6zL26gjlHzcH5Sx4VL0npH9n/ZvO02Xj4hXRctWjLso4m2EToXsNubTHKku0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476889; c=relaxed/simple;
	bh=koirBBT/qK2A9zaDXwaGZPBcn7D9UGYI9QUQHY8zqtg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o/SiE6jiRVGq5mGkRE247mvPzsOhhc9GjXnt24wtMEBx+pwW4PcBnMwEfbnQxf/IevC5IxUqeK7iJbHBRDE1qmNAo8xXId78N6f9jzLi0J7NCq2Vg5SzGckucrh3+HsUOYb4c+av2VrlE1qQe/38/mruSDWzapxcPl2rdV8Io6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llGw7a99; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CDC1F000E9;
	Fri, 26 Jun 2026 12:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782476887;
	bh=1JoY8aAZ1FpJcQAZiSMr5c9UvyVZ2LMJPzXpbzCvMYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=llGw7a99nz3mOvWfrA5TTxzCM5nSwx/FZycLp88XIyIXSTm2fmXWQohxIbTlo4M8L
	 rJXlZe8et+Bx9pKXBt8a2r8629IXcnRNt/8ortATwO6655UfXkAR3iu5Re7udBSjlJ
	 NMIRu9bThLW8rQ1l1wSGno8WpUvpS+KiSJz2M35XnG2LArtT+cp+YkfhgPpFjePjKV
	 pC4H44dp4VAQ55EzfxtblGLoZpccSG664uX5CHIOqywDdH5F8TSiGwlak1UvPonvNO
	 h7+zdb9JBaQI38Ge7yaqN1kObEszXNLSz9wB/by5dGVRBkpU8/J4l7QzkCeH2yH+YN
	 vrAy9SrWe/rfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD839389F8;
	Fri, 26 Jun 2026 12:27:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpf,
 sockmap: reject a packet-modifying SK_SKB stream parser
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178247687401.457674.14278516857626852476.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 12:27:54 +0000
References: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 john.fastabend@gmail.com, jakub@cloudflare.com, eddyz87@gmail.com,
 edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com, horms@kernel.org, shuah@kernel.org,
 jiayuan.chen@linux.dev, bobby.eshleman@bytedance.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,linux.dev,bytedance.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302160-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:eddyz87@gmail.com,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:memxor@gmail.com,m:horms@kernel.org,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:bobby.eshleman@bytedance.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BF876CCFA4

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 20 Jun 2026 02:44:15 +0000 you wrote:
> A BPF_PROG_TYPE_SK_SKB stream parser runs on strparser's message head,
> which can chain skbs through frag_list. A parser that resizes the skb
> frees the frag_list segments that strparser still tracks through
> skb_nextp, leading to a use-after-free.
> 
> A stream parser is only meant to measure the next message, not to modify
> the packet, so reject a packet-modifying parser at attach time.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] selftests/bpf: don't modify the skb in the strparser parser prog
    https://git.kernel.org/bpf/bpf/c/22a0cc10dacb
  - [bpf-next,v5,2/3] bpf, sockmap: reject a packet-modifying SK_SKB stream parser
    https://git.kernel.org/bpf/bpf/c/31e2f36d3821
  - [bpf-next,v5,3/3] selftests/bpf: test rejection of a packet-modifying SK_SKB stream parser
    https://git.kernel.org/bpf/bpf/c/05fb34384d20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



