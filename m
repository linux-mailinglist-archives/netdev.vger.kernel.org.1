Return-Path: <netdev+bounces-271873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGaDA1PUxGkg4QQAu9opvQ
	(envelope-from <netdev+bounces-271873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:38:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C7F32FF1D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8119B305D4D5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AA93382CF;
	Thu, 26 Mar 2026 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rU9zsLdY"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382E336EE1;
	Thu, 26 Mar 2026 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506820; cv=none; b=VvHpQopGX4bRWzCMvSea+CxMy+zHtXQ0r9YWUv+5KzbLtrnjM8yasyi5PZXgoqOfnZKcKbUj73OPA2HwV70o4af6NNLpqK9p0NCicemVR6c/Vmuz5ksuVSy7ePCMCD78xYz/A0x6GhTt0LgnAji+zYkp70KHMP2F+QECk3xzcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506820; c=relaxed/simple;
	bh=HDl1vN6+C2nBxX3TKFliBhRF/OsMjwcf3NmXLvLkiAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duSf9opG4LI3dWGzevn/XEy+HXVyGKcDuN0U34vRITfg0I68AWuqp1P7PMNlcLvnsiD0N/FbCidZnmlGvv12Wk3SSJsgNXzEjdRVd9VziBFdF4SmKyzSh+tPYl26ANrrMsQgOT5Ve0jwo9St0Jyj5+tWWTJHkk3THL5XGVuSsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rU9zsLdY; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <12cc6b53-d801-4e77-83d6-b2a4655ec1b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774506807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l04fTvJB2+ddcC1WaxKYj6vGmeSvY98dLQzDrq19pZY=;
	b=rU9zsLdYjtEPsrjr9FLee/5cXsgUAgFtjPdQUUEOTCBrkcHX6TL8CR57/RJlMevAEJIgEs
	JfwAH4SpSOHg1SKZT+Y60mwN2DgFvTezwuBj51dQgH416kLlC+Paj9Qc4DRsI8WXwrVQSr
	r9RDCYCr+C16jkj07bwP9LalJ5QaWiQ=
Date: Wed, 25 Mar 2026 23:33:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add protocol check test for
 bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260323105510.51990-1-jiayuan.chen@linux.dev>
 <20260323105510.51990-3-jiayuan.chen@linux.dev>
 <9adc3c2e-0d5a-4863-b3ed-194d8f9fd630@linux.dev>
 <4c27a461-2714-4c27-8604-dedd506a09aa@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <4c27a461-2714-4c27-8604-dedd506a09aa@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271873-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[shopee.com,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05C7F32FF1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 8:24 PM, Jiayuan Chen wrote:
> 
> On 3/25/26 5:59 AM, Martin KaFai Lau wrote:
>> On 3/23/26 3:54 AM, Jiayuan Chen wrote:
>>> +void test_tcp_custom_syncookie_protocol_check(void)
>>> +{
>>> +    struct test_tcp_custom_syncookie *skel;
>>> +    struct sockaddr_in tcp_addr, udp_addr;
>>> +    socklen_t addr_len = sizeof(tcp_addr);
>>> +    int tcp_server = -1, udp_client = -1;
>>> +    char buf[32] = "test";
>>> +    int ret;
>>> +
>>> +    if (setup_netns())
>>> +        return;
>>> +
>>> +    skel = test_tcp_custom_syncookie__open_and_load();
>>> +    if (!ASSERT_OK_PTR(skel, "open_and_load"))
>>> +        return;
>>>   +    /* Create a TCP listener so the BPF can find a LISTEN socket */
>>> +    tcp_server = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
>>> +    if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
>>> +        goto destroy_skel;
>>> +
>>> +    ret = getsockname(tcp_server, (struct sockaddr *)&tcp_addr, 
>>> &addr_len);
>>> +    if (!ASSERT_OK(ret, "getsockname"))
>>> +        goto close_tcp;
>>> +
>>> +    skel->bss->tcp_listener_port = ntohs(tcp_addr.sin_port);
>>> +    skel->bss->udp_test_port = 9999;
>>> +
>>> +    ret = bpf_program__fd(skel->progs.tcp_custom_syncookie_badproto);
>>> +    if (setup_tc(ret))
>>> +        goto close_tcp;
>>> +
>>> +    udp_client = socket(AF_INET, SOCK_DGRAM, 0);
>>> +    if (!ASSERT_NEQ(udp_client, -1, "udp socket"))
>>> +        goto cleanup_tc;
>>> +
>>> +    memset(&udp_addr, 0, sizeof(udp_addr));
>>> +    udp_addr.sin_family = AF_INET;
>>> +    udp_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
>>> +    udp_addr.sin_port = htons(9999);
>>> +
>>> +    ret = sendto(udp_client, buf, sizeof(buf), 0,
>>> +             (struct sockaddr *)&udp_addr, sizeof(udp_addr));
>>> +    ASSERT_EQ(ret, sizeof(buf), "sendto udp");
>>> +
>>> +    /* Wait for TC ingress BPF to process the skb. */
>>> +    kern_sync_rcu();
>>
>> hmm... is it guaranteed to work? Regardless, it checks the error 
>> returned from bpf_sk_assign_tcp_reqsk(). Maybe bpf_prog_test_run is 
>> simpler?
>>
>> pw-bot: cr
>>
>>> +
>>>
> I looked into using bpf_prog_test_run, but it won't work here
> because bpf_sk_assign_tcp_reqsk() requires the skb to come from TC ingress
> — it checks skb_at_tc_ingress() internally and returns -EINVAL otherwise.

Thanks for trying.

> 
> For the synchronization concern, instead of kern_sync_rcu(), I now create
> a UDP server bound to the target port and recv() the packet after sendto().
> Since the BPF program returns TC_ACT_OK, the packet passes through TC 
> ingress
> and arrives at the UDP socket. The recv() naturally blocks until the BPF 
> program
> has finished processing, so no timing tricks are needed.
> 

sgtm.

