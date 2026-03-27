Return-Path: <netdev+bounces-272327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNNrNd3jxWkeCwUAu9opvQ
	(envelope-from <netdev+bounces-272327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:56:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FB33E029
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC036302E903
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124AB2EC0A5;
	Fri, 27 Mar 2026 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QyhOXBcr"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4986527B347
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576389; cv=none; b=oWRkX5pGAFHVdLkxONJ9hPD4meFSPfM2HcD2UKB7VLFCuuuAs14ko4I+0UA4Ser6a4axiy21TLOc8/QJvIdiSFpzyGwTqVOnqcTaiJ6zwl3TmWrdf0kHLfJW9r55MwQubngaYJLTk3bwU/6+ehMZJcKNG2yLD8xMXpCh8FTnQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576389; c=relaxed/simple;
	bh=216TK3RDbNFux8Vz68QqIt77sULAYGcQPaXgVmlrCv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMibOA5fdNGWAXweQ9eRgUNreecoYUrwIjBs0kokW/dpxExREseP8WRl0dGqAJsf9a+YrNyZEO6GlJBLR23AZJRqcbg7no1cGfjbSFUtmIe+S6xeJC2rQzB97F/X/MKZEx2SvIPbOZQdePZS48iy1UyW/Nf6qbSuDqm843Ib8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QyhOXBcr; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ce664e8-8c65-4000-b73d-06a9423edb32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774576381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PFHr0GiOHoG1p9wMnx0nkJpSabI/bYbM+Srr2peKG8=;
	b=QyhOXBcrAJUMoShO9XQYWFJiIZpU3in5ABRAK7G6XsHM7uiknVTQ8anWMzQST41KCQE7uk
	ZtaS2KmmFBIU5RDAvoFli6nZQm6TgDdZXvs5pMX18k6DEb3gDkfefOYsuF+8zm1INXr9ho
	oQSWY2Zz9coe/MuQIuDWt/ZbPbNjXGQ=
Date: Fri, 27 Mar 2026 09:52:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add protocol check test for
 bpf_sk_assign_tcp_reqsk()
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260326062657.88446-1-jiayuan.chen@linux.dev>
 <20260326062657.88446-3-jiayuan.chen@linux.dev>
 <CAAVpQUAKAeU8SXpKQwcQS6P6aFJ_BxmevcrK=Hs+_rf_mnaLXA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAAVpQUAKAeU8SXpKQwcQS6P6aFJ_BxmevcrK=Hs+_rf_mnaLXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272327-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 3D4FB33E029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/27/26 1:33 AM, Kuniyuki Iwashima wrote:
[...]
>>          for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
>> @@ -145,6 +145,82 @@ void test_tcp_custom_syncookie(void)
>>
>>   destroy_skel:
>>          system("tc qdisc del dev lo clsact");
>> +       test_tcp_custom_syncookie__destroy(skel);
>> +}
>>
>> +/* Test: bpf_sk_assign_tcp_reqsk() should reject non-TCP skb.
>> + *
>> + * Send a UDP packet through TC ingress where a BPF program calls
>> + * bpf_sk_assign_tcp_reqsk() on it. The kfunc should return an error
>> + * because the skb carries UDP, not TCP.
>> + */
>> +void test_tcp_custom_syncookie_protocol_check(void)
>> +{
>> +       int tcp_server = -1, udp_server = -1, udp_client = -1;
>> +       struct test_tcp_custom_syncookie *skel;
>> +       struct sockaddr_in udp_addr;
>> +       char buf[32] = "test";
>> +       int udp_port, ret;
>> +
>> +       if (setup_netns())
>> +               return;
>> +
>> +       skel = test_tcp_custom_syncookie__open_and_load();
>> +       if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +               return;
>> +
>> +       /* Create a TCP listener so the BPF can find a LISTEN socket */
>> +       tcp_server = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
> Can you add IPv6 test as well ?
> You can reuse test_tcp_custom_syncookie_case[].
>
>
>> +       if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
>> +               goto destroy_skel;
>> +
>> +       /* Create a UDP server to receive the packet as synchronization */
>> +       udp_server = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 0);
> You can specify the port to get_socket_local_port(tcp_server),
>
>
>> +       if (!ASSERT_NEQ(udp_server, -1, "start udp_server"))
>> +               goto close_tcp;
>> +
>> +       skel->bss->tcp_listener_port = ntohs(get_socket_local_port(tcp_server));
>> +       udp_port = ntohs(get_socket_local_port(udp_server));
>> +       skel->bss->udp_test_port = udp_port;
> then the 3 lines above will be unnecessary,
>
>
>> +
>> +       ret = bpf_program__fd(skel->progs.tcp_custom_syncookie_badproto);
>> +       if (setup_tc(ret))
>> +               goto close_udp_server;
>> +
>> +       udp_client = socket(AF_INET, SOCK_DGRAM, 0);
>> +       if (!ASSERT_NEQ(udp_client, -1, "udp socket"))
>> +               goto cleanup_tc;
>> +
>> +       memset(&udp_addr, 0, sizeof(udp_addr));
>> +       udp_addr.sin_family = AF_INET;
>> +       udp_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
>> +       udp_addr.sin_port = htons(udp_port);
> and you can reuse get_socket_local_port(tcp_server) here too.
>
>
>> +
>> [...]
>> +       iph = (struct iphdr *)(eth + 1);
>> +       if (iph + 1 > data_end)
>> +               return TC_ACT_OK;
>> +
>> +       if (iph->protocol != IPPROTO_UDP)
>> +               return TC_ACT_OK;
>> +
>> +       udp = (struct udphdr *)(iph + 1);
>> +       if (udp + 1 > data_end)
>> +               return TC_ACT_OK;
>> +
>> +       if (bpf_ntohs(udp->dest) != udp_test_port)
>> +               return TC_ACT_OK;
> You don't need to worry about other program sending UDP
> packets in this netns created by unshare().
>
>
>> +
>> +       udp_intercepted = true;
>> +
>> +       tuple.ipv4.saddr = iph->saddr;
>> +       tuple.ipv4.daddr = iph->daddr;
>> +       tuple.ipv4.sport = udp->source;
>> +       tuple.ipv4.dport = bpf_htons(tcp_listener_port);
> and you can simply reuse dport here too.
>

Thanks for the review. I'll update the code to address all these points.


