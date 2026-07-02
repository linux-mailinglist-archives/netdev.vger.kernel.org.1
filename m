Return-Path: <netdev+bounces-304013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t5ITHiAXRmqMJgsAu9opvQ
	(envelope-from <netdev+bounces-304013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:45:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B646F454A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:45:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b="ZMG3bZi/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304013-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304013-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=rbox.co;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E8D130A11B7
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D4394471;
	Thu,  2 Jul 2026 07:30:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D63939BD;
	Thu,  2 Jul 2026 07:30:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977453; cv=none; b=fc+PHAHsZiU2iB8tquNcRmwOTA5dhqChiLGOhxW3nMS/xAbL4IYrQ5gx8/KLRZbVGVpCxKfyTNG6eFte6f7xlPAatMPQ8vJiUJJWvz9Wr+CqRvMbdOE9O4YFSztZL8WTnOyRHJ9Re5a8hmgmVrBuL2Ma1/KZLbzRI1Ej/oEbZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977453; c=relaxed/simple;
	bh=b5Yh/1B5RAfqkXa6kZW8y8XuCwb9JRcdG9Cc6vPOrcM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GNwG/9tia0C3G8WpX3G8Vi9+i6hd318ROAuDSnjQf2zuw7E/ai91Bn1J13VUgwfTI2jVeLmWH4Ubbwg/u+R9SrukyKrhE2NF7y+flnTHRse4it7PlheuG/8Rw2aar37FjMNpsF8tSP8Upu4u6fYpXV9ypwOBT6pWoRMStIIZXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZMG3bZi/; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wfBsc-00BOKQ-T0; Thu, 02 Jul 2026 09:30:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=T0KU9Qlc02n2j5IdAO8aCi86nlSvwxBOmtJy+AvJI5s=; b=ZMG3bZi/7Dml2jz332+5aTfLBY
	U93C5alk3kpGZpnQ7/RMi63KycR4qg86NIQHlX2u+Gev2XzSSjw2IMS8XksWh7ytUpzPFKfeBgMKF
	J+Q9lPmBfakqsDbh527/hbJnUKa2epzoUCkiccyf7keUMXGuOCBc+5UWLaWaqIHE08XCTWHeSWYB7
	EdrhJgL4cGMkOOjDFjRjhP7wdgDQvCMnAE+EPTF3TCvhSlQJzh38cEd+6Cn1NLX65VdX6D/aqWrB3
	TCeo6PWIMwjUaHgmDYW8Kp8xGISIkthV21sGzw3HUASAikRIeGcjMI96E7UITaXvVHNbjFjUMbWuG
	pTFTaXZw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wfBsb-0006gp-S3; Thu, 02 Jul 2026 09:30:38 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wfBsK-003HJw-OZ;
	Thu, 02 Jul 2026 09:30:20 +0200
Message-ID: <352c268e-508a-4155-b597-b0f172c0a1cf@rbox.co>
Date: Thu, 2 Jul 2026 09:30:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v3 3/4] selftests/bpf: Adapt sockmap update error
 handling
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org,
 john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 cong.wang@bytedance.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260702-sockmap-lookup-udp-leak-v3-3-ff8de8782468@rbox.co>
 <03d8ce102b71c68c30e98be36feaebe539055195c2323ec3b3fd84f157487afd@mail.kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <03d8ce102b71c68c30e98be36feaebe539055195c2323ec3b3fd84f157487afd@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304013-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bot+bpf-ci@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:cong.wang@bytedance.com,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,cloudflare.com,google.com,redhat.com,davemloft.net,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:dkim,rbox.co:mid,rbox.co:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67B646F454A

On 7/2/26 02:00, bot+bpf-ci@kernel.org wrote:
>> @@ -93,8 +90,12 @@ static void test_insert_bound(struct test_sockmap_listen *skel __always_unused,
>>  	errno = 0;
>>  	value = s;
>>  	err = bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
>> -	if (!err || errno != EOPNOTSUPP)
>> -		FAIL_ERRNO("map_update: expected EOPNOTSUPP");
>> +	if (sotype == SOCK_STREAM) {
>> +		ASSERT_ERR(err, "map_update");
>> +		ASSERT_EQ(errno, EOPNOTSUPP, "errno");
>> +	} else if (err) {
>> +		ASSERT_OK(err, "map_update");
>> +	}
> 
> This isn't a bug, but could the UDP branch just be `else ASSERT_OK(err,
> "map_update");` — the `if (err)` guard looks redundant since ASSERT_OK is
> a no-op on success?

Ugh, sorry. If there are no other comments for this series, I'd happy to
fix it later in bpf-next.

