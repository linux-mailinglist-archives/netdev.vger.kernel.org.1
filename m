Return-Path: <netdev+bounces-300616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VVG7OlvjNGqBjQYAu9opvQ
	(envelope-from <netdev+bounces-300616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:36:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B616A4238
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:36:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ZIdlrU9k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300616-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300616-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5989C3025C04
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C53563F6;
	Fri, 19 Jun 2026 06:36:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533645BE3
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:36:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850969; cv=none; b=t47pf5n6/aRIkdJeJ5lmF4h5dhQJlf2s1iya9x5JxwhQ8+76wmcu3lluSaAG8Md4XTj19gOiK5q59THII/Z8iJn16y6JGFUQQdBJwz1+iVlfGY+Kq+Syw6xgse5WOs49Y5td2a2usahfRYW8zYHn5dblwBh0eCetGzUVXC8sFVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850969; c=relaxed/simple;
	bh=rOArnfKPATJkYYumpandljz3xZTiXVcjL/j0XUj+YII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0ATcB1R+XS5P3R3KtAnXKVc4+8zdqvsXwfBEUYX0TYnNX2EjEY+n77/2nk0Z3E7bhB5JxL3OGGNHB9bqEpncOmyFRVNFkFrZ2iyZbaFyXimdi1tVuE9AvetKdLhWpzbZqmG89Hqcd2Bh9sWBRF9YsHgQLC87PI02SI39ofuRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZIdlrU9k; arc=none smtp.client-ip=95.215.58.181
Message-ID: <97e15692-af14-4a3f-99ed-61fda50fe68f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781850966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOArnfKPATJkYYumpandljz3xZTiXVcjL/j0XUj+YII=;
	b=ZIdlrU9kkEk7gMIEDcoZTRyKTmSYK4eElAgHE0eYDq7kdhaPD1s7/wVFKarpoxd0yj4tbY
	ucxkXUZ75D+OIhiICK0xgULYcAy2alParSxDsHCB9mLwKbnaCZNJ1Rzp6YdzsTq8M73Wjy
	anF8szLSmHxjheQNWEr2AdZApi+Wa9U=
Date: Fri, 19 Jun 2026 14:35:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 3/3] selftests/bpf: test rejection of a
 packet-modifying SK_SKB stream parser
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
 <20260619062959.3277612-4-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260619062959.3277612-4-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300616-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,cloudflare.com,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:kuniyu@google.com,m:willemb@google.com,m:shuah@kernel.org,m:jolsa@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:horms@kernel.org,m:bobbyeshleman@gmail.com,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56B616A4238


On 6/19/26 2:29 PM, Sechang Lim wrote:
> Verify that attaching an SK_SKB stream parser that can modify the packet
> is rejected, while a read-only parser still attaches.
>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>



