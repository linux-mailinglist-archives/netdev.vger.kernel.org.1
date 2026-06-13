Return-Path: <netdev+bounces-298993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bsnSH4yRLWpfhgQAu9opvQ
	(envelope-from <netdev+bounces-298993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:21:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FD467F258
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:21:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VEvW9C3t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298993-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298993-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37EBD3003833
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70FE3F787B;
	Sat, 13 Jun 2026 17:20:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF33F7AA9;
	Sat, 13 Jun 2026 17:20:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781371250; cv=none; b=TvXTH7ghog3SVS9M0iTmcqxA1uhWEixcq5GMwOP0Ou1G8UDgl521xsVh8PEFW9axHwlr8dZg1yeB3W0vFR85SNGz/fK1BVbM+B2o98KM/vNr+NhwBaJWMmA+17XBODT1UgutbpJNDOyxG8BcKVYWg2s1nb02By4DvQeMNd7E7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781371250; c=relaxed/simple;
	bh=hfk5YAAsiowp1e92uAcaKnJUV1q7hmOhlevtJ1ZDvWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5CDXy6fKTN7VuUG5RM5XGpQ5aXLyLdwMFWh/Ho9Dw7bAHGD1z5+sqhKbwWkDBxvE1Ixjt52xsSODN9tcamWQ7sY/a8VIbEwyMWAAwWxKYTi6hIF9wdN2SG0Pyn5N1aF8AH76rBqRJ1mWYg7SqRWLLv0UfHUEwXBGw5KwS6oGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEvW9C3t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9681F00A3A;
	Sat, 13 Jun 2026 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781371248;
	bh=FoVaSKJSHc5duMbhcL5wvJ7B8xalCf3jU1lyZ6ND/SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VEvW9C3tdLdhJJh/2/ibZxdf1mGm7heCaLMrwdHrIywbvu+dnV6V4u/nVczs/Wukd
	 u3ysLU0RmEkYOcuR59h8NK8pqaHsxwSXrngEYSn68PPEAymrCtvbx50bolSeYfJfs4
	 7omFPj/96fEDCpEeHeCHMFsHInUddFbB37DRzU77JAoNwr/BKKRha5I6qo+ShXNP8A
	 ifxdgfwBkuU4cwkjP+FwfEfHhhQoJkJxf/L/fi7rnaV/b/raNg4P+8+02lR0UW9Ga/
	 hpado6xpG1fd2m+xiGMWfmb5Mc2VvTZ0BATxs6+GikkZlsWpz471q4zNIt/gJ6iPb1
	 v0BMPg2l4pe3g==
Date: Sat, 13 Jun 2026 10:20:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Stanislav
 Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp
 proxy.
Message-ID: <20260613102041.55e3b50e@kernel.org>
In-Reply-To: <20260613010039.1362312-1-kuniyu@google.com>
References: <20260613010039.1362312-1-kuniyu@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298993-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84FD467F258

On Sat, 13 Jun 2026 00:59:57 +0000 Kuniyuki Iwashima wrote:
> When standard socket applications are run on these hosts,
> a userspace proxy is required to mediate traffic between the
> hardware and the applications.
> 
>             +---------+                 +----------------------+
>             |  proxy  |                 |  socket application  |
>             +---------+                 +----------------------+
>               ^     ^                               ^
>   userspace   |     |                               |
>   -----------| |-----------------------------------------------
>              | |    |    +---------------------+    | skb
>              | |    `--->|  virtual interface  |<---'
>   kernel     | |   skb   +---------------------+
>   -----------| |-----------------------------------------------
>               |
>               v
>        +------------+
>        |  hardware  |
>        +------------+

The first patch looks kinda nonsensical but then I saw this diagram.
Looks like you're vibe coding an integration that makes it easier to
treat netdev as a slow path for a user networking stack.
Please tell me if I'm missing anything otherwise add my nack if you
repost.

