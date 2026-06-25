Return-Path: <netdev+bounces-302070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k2C/ItiGPWqe3wgAu9opvQ
	(envelope-from <netdev+bounces-302070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 21:51:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2319F6C86F9
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 21:51:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fGuCmW3D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302070-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302070-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDA5B30230CB
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F895342C9E;
	Thu, 25 Jun 2026 19:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7D331222;
	Thu, 25 Jun 2026 19:51:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417104; cv=none; b=n+C1n5rpJMKLDXSoUsX6VkYP9lzZMffxwi2iNzoeACvnRvTHBLl0LRqe3m2QFTM1dyrFAm3cUJhjN2vXeYDYoRvlrQPm6BxFaDxIdinvonSus3soPlpSb0nWphy07bXV02YghlJ1nStwSn+slHnF8FYHqaEZhMsr05H+x36iaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417104; c=relaxed/simple;
	bh=ZMbRWDGYT2cMePAsL7p6001j/gyCaAcSvb+BhxpAgHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3rzp4LsaUaq78SmN11ey5Z+RfAjDyr4nfaLBfEuYocYAP4CiEuWA2XvzUIrW+3RzbsqZRYMGMUO+lBCor8kiU86Q+owAXz9zWKeeACcMPBURm5vCn0wjgPzuKdMRaYNVQtlp31EPqe9CHucrEDQZOD/qLwnN/7w3UgM5WFCQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGuCmW3D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02BE1F000E9;
	Thu, 25 Jun 2026 19:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782417102;
	bh=NVuojCEUe0/K2hHnFIrBmEZ2b/x4ky5BQMjFmpLmFuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fGuCmW3DsN0FWyW9BonBzgkdavVrvHUrJDWTaoAc/yyIkYvQljDnrLgSNBSp/TrKk
	 p+2chAs7RvalD+HQ+Yc5/zot2qAPMx4VaWlRJYUMMmkLyqLxwwkOALyt5HzagS58Bh
	 0ayHCvTPTSahDVD9lzCFij0JgXeZ3MbQNKVLKo05btntGQifLAqmLd8yUPg/0G3/d0
	 g1RAqI9jKUdW4UoJpuEw60e/f2GeCQ3dmPairHGrdHG1JerqXZ8ET89XyXzH6iWY+B
	 1y2QW+YI4V2pRFpEvRWiiXhsXmr6M0BP4ln70/MD2r4bw2rjCxEXz3wyeVE9yCug5J
	 dz2zupudaEuNw==
Message-ID: <bcc3414e-f3c4-40c1-b9e4-f864bd875a2a@kernel.org>
Date: Thu, 25 Jun 2026 13:51:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Initialize the l3mdev field for the
 fib lookup flow
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Avinash Duduskar <avinash.duduskar@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Mykyta Yatsenko
 <yatsenko@meta.com>, Leon Hwang <leon.hwang@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
 Rong Tao <rongtao@cestc.cn>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
 <20260616223426.3568080-2-avinash.duduskar@gmail.com>
 <87bjd9h6yh.fsf@toke.dk>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87bjd9h6yh.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302070-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:toke@redhat.com,m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:eyal.birger@gmail.com,m:rongtao@cestc.cn,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,kernel.org,iogearbox.net];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2319F6C86F9

On 6/17/26 3:06 AM, Toke Høiland-Jørgensen wrote:
>> The helper already initializes the other flow fields the rules path
>> consumes (flowi4_mark, flowi4_tun_key.tun_id, flowi4_uid and the v6
>> counterparts); flowi*_l3mdev was added to that set afterwards and this
>> helper was never updated to match. ip_route_input_slow() likewise zeroes
>> the field before its input lookup. Do the same here.
> 
> So how about we explicitly zero-init the whole struct instead of adding
> more fields ad-hoc like this? Otherwise this seems like something that
> is likely to happen again if we ever add another field to the struct?
> 
> -Toke
> 

+1. Piecemeal init of the flow struct has been a known source of bugs.

