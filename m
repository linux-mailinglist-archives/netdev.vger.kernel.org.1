Return-Path: <netdev+bounces-299008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qcpRMRiaLWp/hwQAu9opvQ
	(envelope-from <netdev+bounces-299008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0667F408
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:57:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="J/qMNSnh";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299008-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299008-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B3913002929
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEAD2EEE75;
	Sat, 13 Jun 2026 17:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477F1EE7C6;
	Sat, 13 Jun 2026 17:57:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373457; cv=none; b=CWK+QJ0j6cuvySJyaczGY3r0WYNTftCHNTbdKG9XLNjIvUNr9iAcLOeA7bHOIpCBzp4yEqD0q4JdbhkvjL6Fc8Pw1zTipHGcMC6OAFNgoD5CRM6nNlPB26MsgzFJemj+BQSPykVDviMYZbkjo9P3y3wZGsBcV3uAm7+AfGGikQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373457; c=relaxed/simple;
	bh=0I3ayv6ho7ohDsu86MiInZfnNSI36midO4rP1U2RRFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pync1FiX8m7k7syQRwCqjdZYoYBah16ZoB1zQibqSjQE6ff76u3XknWxlCmQwA8kmnLRUpa0pj2wRbmAypu10FQ8XPbTMxEPj3EQMI2NIaCNQMukT/N9wkjTQmR61+dkEBEVpLlRhFkftGOIeCkv4EdRmguBGm1xetdSTOjm95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/qMNSnh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212F41F000E9;
	Sat, 13 Jun 2026 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781373456;
	bh=BUkI9enXuk0j6Qx21MiFpOjmemi5aUpGoG7sEJMhKYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J/qMNSnhSN6gIJDL4xadpy+V2774Tz3PqKZwY5facwaJZEb6I/0hu9HQjARW7BT4m
	 evnnqnF3EHQek1O3uEK7VbOTnEdQHTk8IH3ulcRBuOcKwNDF1DZxxQ2u0QZAfr+g0C
	 gQkHtqjbhoW3Rg3LJn1Z9Quv9GzIT7/1A6OeKyoJ7SHC4Wle+8GaiJpER549jFD90k
	 EYAis9jmh6Q/LqRF6vZF6SM1C6d4uds1YOzMlIQ/lBW8hwTg8xBf+qNmKDbXaI7TiN
	 n4bLrpY7v131GFX4EP1D8x7nRFaQ3+ldnEPmg6GhLYCW+mRRLMjn2A9rYDbTR8viWB
	 YKoTKKYzncJ4w==
Date: Sat, 13 Jun 2026 10:57:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Network Development
 <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan
 Chen <jiayuan.chen@linux.dev>, Hemanth Malla <hemanthmalla@gmail.com>,
 zijianzhang@bytedance.com
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
Message-ID: <20260613105730.0ca1ca07@kernel.org>
In-Reply-To: <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
	<CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299008-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,cloudflare.com,linux.dev,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:xiyou.wangcong@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:hemanthmalla@gmail.com,m:zijianzhang@bytedance.com,m:alexeistarovoitov@gmail.com,m:xiyouwangcong@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2B0667F408

On Fri, 12 Jun 2026 09:01:43 -0700 Alexei Starovoitov wrote:
> Just saying that the code is free nowadays, so whether it's 1k lines
> or 10 lines is irrelevant for the discussion.
> 
> As far as the idea goes, I think, it would be interesting in pre-AI era,
> but today splice and friends are a prime target for bugs and more bugs.
> skmsg and tcp_bpf are reeling from unfixed bugs too,
> so my take is that we should not add any new features to skmsg
> and instead deprecate what is already there.

100% agreed. There are so many unfixed skmsg bugs it's hard to know
were to start :( Kernel "intelligence" to help unoptimized applications
is particularly unappealing right now.

