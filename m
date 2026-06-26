Return-Path: <netdev+bounces-302266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eTezAmbkPmqoMgkAu9opvQ
	(envelope-from <netdev+bounces-302266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:43:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0BF6D00F4
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:43:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b="Oi8VJY/Z";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302266-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302266-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=rbox.co;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 670153013C58
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6767C3BF680;
	Fri, 26 Jun 2026 20:43:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96893BB117;
	Fri, 26 Jun 2026 20:43:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506590; cv=none; b=tidVCxZCqiOBJj6c1xv1XjeXWYSZ+LmGj59epyWIfS+iQhJFoJS3JYUNsp0Hbki5hfIty04RI2gA18JT9PiVetEUyyq9xQbrg+kFC9IvlDSeX+RghokbdNOvLVlkgFn9bY9TSK7uEtC+pZ58SSc1DaifembxaZ8tqHF9o8d96Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506590; c=relaxed/simple;
	bh=8OIk93A1yIg8RtXTheftIilx7caQYAZJV41zNjm/1DA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q7btU/IaqBnNTeVwo4NIPbm38u/1cUj6KHzEQUCp4ZJPdAvxyd3zEVNUuJ1YwELG5BmZR/QYeEc6mL8BGhFajYX0lolUu8K+vxugliNyXpDRve8HvXXVvHFkhyyHOnnRVGiRXvdKRaUNQGTAevBijvQFCfzccDAZNVqzjlmR+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Oi8VJY/Z; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wdDO6-00DCO6-1T; Fri, 26 Jun 2026 22:42:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=n/DYGvtv0ZMjSlvJQCCdtxc5LTPcQ2fzJLG4TjguW0s=; b=Oi8VJY/Zy1oeierb4nNV8eGQDF
	9g4Jj8A5MI19pIms/GcJQdQwLMhjSkcEtj6tVbPlDEW5KXqq6M8AL1ywGt4JwBgJmx1yN5LdzMoGH
	eSF2vjychtf7eIKnwvhx7tNroBAiUkV47ACgRsYlZSM+Sfn0M/VlcMyIlnLRnala2B3IwUyFRPBWy
	9cjoxw+Up3XkJn0edJQwbn8c9yMkt7bQsCfSXttlaaAtNHoR2OMeLdd5/uJWToaFOOxNHdFsNQnJV
	tkAdq9jkQekGBPHU9f8X5RveUQEF2KJ39uZx4mMsTqEwLHm60k2l3815uaTnciKUu7YiZVxQxCLVZ
	BU5y1l1A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wdDO0-0003yQ-Cr; Fri, 26 Jun 2026 22:42:52 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wdDNn-008BEG-3k;
	Fri, 26 Jun 2026 22:42:39 +0200
Message-ID: <c1b17849-e0dd-48a0-a624-db0bb0504041@rbox.co>
Date: Fri, 26 Jun 2026 22:42:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
To: Jakub Sitnicki <jakub@cloudflare.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
 <87wlvoxdq1.fsf@cloudflare.com>
 <willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
 <dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co>
 <CAAVpQUBHMrSiWqn0Zo_D7sUCLFdkKggduoijRdFtHx5CPiSpsg@mail.gmail.com>
 <CAAVpQUAy=EVZcZRmXJPr=neJh7Q+UbYML5L4+nBynVrDPidUkw@mail.gmail.com>
 <87o6gyyjxk.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <87o6gyyjxk.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-302266-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:kuniyu@google.com,m:willemdebruijn.kernel@gmail.com,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rbox.co:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,rbox.co:dkim,rbox.co:mid,rbox.co:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D0BF6D00F4

On 6/25/26 12:48, Jakub Sitnicki wrote:
> On Wed, Jun 24, 2026 at 02:39 PM -07, Kuniyuki Iwashima wrote:
>> On Wed, Jun 24, 2026 at 2:33 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>> ...
>>> Setting SOCK_RCU_FREE itself should not cause a problem, but I think
>>> we should take a step back.
>>>
>>> AFAIU, 0c48eefae712 was to allow putting AF_UNIX SOCK_DGRAM sockets
>>> into sockmap, not to allow using unconnected UDP sockets in sk_lookup etc.
>>>
>>> Actually, v4 of the patch was implemented as such but did not get any feedback,
>>> https://lore.kernel.org/bpf/20210508220835.53801-9-xiyou.wangcong@gmail.com/#t
>>>
>>> ... and v5 (the final commit) somehow removed the restriction for unconnected
>>> UDP socket as well.
>>> https://lore.kernel.org/bpf/20210704190252.11866-3-xiyou.wangcong@gmail.com/
>>>
>>> Given the initial use case, sockmap redirect, is still blocked by
>>> TCP_ESTABLISHED
>>> check in sock_map_redirect_allowed(), I feel there is no point in supporting
>>> unconnected UDP sockets in sockmap.  It cannot get any skb from anywhere
>>> (without buggy sk_lookup).
>>
>> s/unconnected/unhashed/g :)
> 
> Rejecting unhashed UDP sockets on insert to sockmap SGTM.
> It is also in line with disable-problematic-cases strategy.

OK, here's v2 with the sock_map_sk_state_allowed() check reintroduced:
https://lore.kernel.org/bpf/20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co/

Thanks,
Michal


