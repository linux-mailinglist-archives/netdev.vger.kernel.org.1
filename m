Return-Path: <netdev+bounces-307719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CgTJLudQV2qoJAEAu9opvQ
	(envelope-from <netdev+bounces-307719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E10E75C66F
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:20:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kAudLFSa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307719-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307719-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBEDD3003D1C
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435CA423769;
	Wed, 15 Jul 2026 09:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A941D65D;
	Wed, 15 Jul 2026 09:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107236; cv=none; b=VJVZPAu5NNRXFTwvtAczw8ZG7AOmGIV9HVrAJIiprnvSvNVLa06GtrY40avD3fjk+7cudg/qqa/aV0zgl/qHNMVG66xAr+AdUWXxhmxky/U/w7D7d6wPW0dLOPaGUSEIlSG2ZsT/72pHKJz2ksLVOC6C7s1ct4dwLTwJGtlH/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107236; c=relaxed/simple;
	bh=K3lc3/SJqlFIf+u1/wXLZhZwPtLLwAmXLFruIwBFY5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M6o460lXGzaNIdMgZRUaxgQo9mczMbobOd9uKl+HRp81cwae1dIV7bygCEzvOrOyN7XGlPMdkrzUXG+NnFhCL++2vHyI0g5D2B9AJsXR62G4CfEmivo92t8HWK2VGdjlBOLznnMhpUwM/pztJ6mRoIzL+eAgvBBFNnZNNvxBObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAudLFSa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93911F000E9;
	Wed, 15 Jul 2026 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784107234;
	bh=BvW5fMXW2I+0++iWJ3nKKN2dWxiW8VsR77HyEPA+1KQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kAudLFSaTK7FKUkJlIQ1eesZNmS8g09P6PxxZFjV/QRpY2UvASF1GK0LuTlpkSPvG
	 UxYOj0myM2OazqUuL6vOk714kT3Ju6hnY6zAPi3PQ5L7ZjO6xz3E38C4qhHBv6cDJC
	 mh5zwcUvIJ74uLZQ0fxY0qqAGoEtQt0vN/aE3L/G2v3DECaBGDR1sDKl75H4aZ6nQA
	 c5pJHp0ck9rV4G4JO1ifUK7GFqdUAyIrGjVcd5zQVeEVMZ9AXFUYDv2dYTYFT3FZo2
	 OxJqk86ONJk82oq5ac6AyXTNw4AzrJq2NXrOfZuJx5FuB+j19twDEhnn4cSlwfvgv6
	 i4NntyXcTbLaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199553938E8D;
	Wed, 15 Jul 2026 09:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf, sockmap: Fix FIONREAD for sockets without
 a verdict program
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178410720889.3980181.6978995644978494942.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 09:20:08 +0000
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
In-Reply-To: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
To: Mattia Meleleo <mattia.meleleo@coralogix.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, john.fastabend@gmail.com,
 jakub@cloudflare.com, jiayuan.chen@linux.dev, memxor@gmail.com,
 emil@etsalapatis.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,etsalapatis.com];
	TAGGED_FROM(0.00)[bounces-307719-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mattia.meleleo@coralogix.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:memxor@gmail.com,m:emil@etsalapatis.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E10E75C66F

Hello:

This series was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 08 Jul 2026 18:54:59 +0200 you wrote:
> Sockets added to a sockmap/sockhash with no stream/skb verdict program
> attached answer FIONREAD with 0 even when unread data is pending in
> sk_receive_queue. Fix tcp_bpf_ioctl() to account for the receive queue
> in that case, and add a selftest.
> 
> Changes in v3:
> - Remove unused sk_psock_msg_inq()
> - Link to v2: https://patch.msgid.link/20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf, sockmap: Account for receive queue in FIONREAD without a verdict program
    https://git.kernel.org/bpf/bpf/c/04af4efde58a
  - [bpf,v3,2/2] selftests/bpf: Test FIONREAD on a sockmap socket without a verdict program
    https://git.kernel.org/bpf/bpf/c/a42f05cc4c1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



