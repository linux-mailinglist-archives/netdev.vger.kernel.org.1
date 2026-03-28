Return-Path: <netdev+bounces-272765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOV1DK60x2nvawUAu9opvQ
	(envelope-from <netdev+bounces-272765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:59:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E61F34E211
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA4E30125DF
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584E3783D0;
	Sat, 28 Mar 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="og/Sfe5O"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89B30F7EA
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774695499; cv=none; b=cpEg9pJlZ5+pmnn4OMLcgMnF4kGXUQfSsFYoEbqohazLgBk3HYfrsLJ6PrsLPw97eIAV7dKP7KdYeJjw0tO3IiMdUaUYwUpe39mfj5dhzD3YWNJkxyRpJla8spzcmkKTEO3u4/2fQr53EACBbksaRGlGod58x3WE4z/EGPe+Ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774695499; c=relaxed/simple;
	bh=Qs9M2BFLj6JC0VgLyoL5/n3Xychtx+k20qIwK0szi+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSRN0hrKces/4N9azCZHYC/SG3Eq6SoD7w8w2/p0SkHdePGNCjFwgQMM2uHW8cc4lajI+LQra5jDVeuzcStLpjj6QyonOGk6ai8j8kg3M+pfX5fQonPrq2VmTAZAnbNTI1585ocBw+27iJAmT4moPttPpeJJ0ErFe5mU3JPj1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=og/Sfe5O; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f33c5124-3865-455e-a048-73d87d020bec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774695495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/Uad7Q/uVeLeJuuN70SgP1jYFdyTA6/FyYntF0Zjnw=;
	b=og/Sfe5OCWfjtwrMY2tCj6D8BN2ilfqhEPxEIspem2epvDPllUFb5qJecntjgubCW9jadF
	07c1jQyU+7SrflrNwSnJmiUlXAOB1P99bIwrpar8ZgINJytdI3ua2CQO91ppFwJxgFoZGn
	GnjtBeZiEcgTpu75ecoPkDfG4V7pJCc=
Date: Sat, 28 Mar 2026 18:58:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add protocol check test for
 bpf_sk_assign_tcp_reqsk()
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260327133915.286037-1-jiayuan.chen@linux.dev>
 <20260327133915.286037-3-jiayuan.chen@linux.dev>
 <8d619537-cb9a-4fdb-a440-20b59b7f5088@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <8d619537-cb9a-4fdb-a440-20b59b7f5088@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272765-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[shopee.com,iogearbox.net,gmail.com,fomichev.me,kernel.org,linux.dev,google.com,davemloft.net,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 7E61F34E211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/28/26 3:53 AM, Martin KaFai Lau wrote:
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>
>> Add test_tcp_custom_syncookie_protocol_check to verify that
>> bpf_sk_assign_tcp_reqsk() rejects non-TCP skbs. The test sends a UDP
>> packet through TC ingress where a BPF program calls
>> bpf_sk_assign_tcp_reqsk() on it and checks that the kfunc returns an
>> error. A UDP server recv() is used as synchronization to ensure the
>> BPF program has finished processing before checking the result.
>>
>> Without the fix in bpf_sk_assign_tcp_reqsk(), the kfunc succeeds and
>> attaches a TCP reqsk to the UDP skb, which causes a null pointer
>> dereference panic when the kernel processes it through the UDP receive
>> path.
>>
>> Test result:
>>
>>    ./test_progs -a tcp_custom_syncookie_protocol_check -v
>>    setup_netns:PASS:create netns 0 nsec
>>    setup_netns:PASS:ip 0 nsec
>>    write_sysctl:PASS:open sysctl 0 nsec
>>    write_sysctl:PASS:write sysctl 0 nsec
>>    setup_netns:PASS:write_sysctl 0 nsec
>>    test_tcp_custom_syncookie_protocol_check:PASS:open_and_load 0 nsec
>>    setup_tc:PASS:qdisc add dev lo clsact 0 nsec
>>    setup_tc:PASS:filter add dev lo ingress 0 nsec
>>    run_protocol_check:PASS:start tcp_server 0 nsec
>>    run_protocol_check:PASS:start udp_server 0 nsec
>>    run_protocol_check:PASS:connect udp_client 0 nsec
>>    run_protocol_check:PASS:send udp 0 nsec
>>    run_protocol_check:PASS:recv udp 0 nsec
>>    run_protocol_check:PASS:udp_intercepted 0 nsec
>>    run_protocol_check:PASS:assign_ret 0 nsec
>>    #471/1   tcp_custom_syncookie_protocol_check/IPv4 TCP:OK
>>    run_protocol_check:PASS:start tcp_server 0 nsec
>>    run_protocol_check:PASS:start udp_server 0 nsec
>>    run_protocol_check:PASS:connect udp_client 0 nsec
>>    run_protocol_check:PASS:send udp 0 nsec
>>    run_protocol_check:PASS:recv udp 0 nsec
>>    run_protocol_check:PASS:udp_intercepted 0 nsec
>>    run_protocol_check:PASS:assign_ret 0 nsec
>>    #471/2   tcp_custom_syncookie_protocol_check/IPv6 TCP:OK
>>    #471     tcp_custom_syncookie_protocol_check:OK
>>    Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>> ---
>>   .../bpf/prog_tests/tcp_custom_syncookie.c     |  94 ++++++++++++++-
>>   .../bpf/progs/test_tcp_custom_syncookie.c     | 109 ++++++++++++++++++
>>   2 files changed, 199 insertions(+), 4 deletions(-)
>>
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c 
>> b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
>> index eaf441dc7e79..e46031d0786b 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
>> @@ -5,6 +5,7 @@
>>   #include <sched.h>
>>   #include <stdlib.h>
>>   #include <net/if.h>
>> +#include <netinet/in.h>
>>     #include "test_progs.h"
>>   #include "cgroup_helpers.h"
>> @@ -47,11 +48,10 @@ static int setup_netns(void)
>>       return -1;
>>   }
>>   -static int setup_tc(struct test_tcp_custom_syncookie *skel)
>> +static int setup_tc(int prog_fd)
>>   {
>>       LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point = 
>> BPF_TC_INGRESS);
>> -    LIBBPF_OPTS(bpf_tc_opts, tc_attach,
>> -            .prog_fd = 
>> bpf_program__fd(skel->progs.tcp_custom_syncookie));
>> +    LIBBPF_OPTS(bpf_tc_opts, tc_attach, .prog_fd = prog_fd);
>>         qdisc_lo.ifindex = if_nametoindex("lo");
>>       if (!ASSERT_OK(bpf_tc_hook_create(&qdisc_lo), "qdisc add dev lo 
>> clsact"))
>> @@ -127,7 +127,7 @@ void test_tcp_custom_syncookie(void)
>>       if (!ASSERT_OK_PTR(skel, "open_and_load"))
>>           return;
>>   -    if (setup_tc(skel))
>> +    if (setup_tc(bpf_program__fd(skel->progs.tcp_custom_syncookie)))
>>           goto destroy_skel;
>>         for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
>> @@ -145,6 +145,92 @@ void test_tcp_custom_syncookie(void)
>>     destroy_skel:
>>       system("tc qdisc del dev lo clsact");
>> +    test_tcp_custom_syncookie__destroy(skel);
>> +}
>> +
>> +/* Test: bpf_sk_assign_tcp_reqsk() should reject non-TCP skb.
>> + *
>> + * Send a UDP packet through TC ingress where a BPF program calls
>> + * bpf_sk_assign_tcp_reqsk() on it. The kfunc should return an error
>> + * because the skb carries UDP, not TCP.
>> + *
>> + * TCP and UDP servers share the same port. The BPF program intercepts
>> + * the UDP packet, looks up the TCP listener via the dest port, and
>> + * attempts to assign a TCP reqsk to the UDP skb.
>> + */
>> +static void run_protocol_check(struct test_tcp_custom_syncookie *skel,
>> +                   int family, const char *addr)
>> +{
>> +    int tcp_server = -1, udp_server = -1, udp_client = -1;
>> +    char buf[32] = "test";
>> +    int port, ret;
>> +
>> +    tcp_server = start_server(family, SOCK_STREAM, addr, 0, 0);
>> +    if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
>> +        return;
>> +
>> +    port = ntohs(get_socket_local_port(tcp_server));
>> +
>> +    /* UDP server on same port for synchronization and port sharing */
>> +    udp_server = start_server(family, SOCK_DGRAM, addr, port, 0);
>> +    if (!ASSERT_NEQ(udp_server, -1, "start udp_server"))
>> +        goto close_tcp;
>> +
>> +    skel->bss->udp_intercepted = false;
>> +    skel->data->assign_ret = -1;
>
> assign_ret is init to -1
>
>> +
>> +    udp_client = connect_to_fd(udp_server, 0);
>> +    if (!ASSERT_NEQ(udp_client, -1, "connect udp_client"))
>> +        goto close_udp_server;
>>   +    ret = send(udp_client, buf, sizeof(buf), 0);
>> +    if (!ASSERT_EQ(ret, sizeof(buf), "send udp"))
>> +        goto close_udp_client;
>> +
>> +    /* recv() ensures TC ingress BPF has processed the skb */
>> +    ret = recv(udp_server, buf, sizeof(buf), 0);
>> +    if (!ASSERT_EQ(ret, sizeof(buf), "recv udp"))
>> +        goto close_udp_client;
>> +
>> +    ASSERT_EQ(skel->bss->udp_intercepted, true, "udp_intercepted");
>> +
>> +    /* assign_ret == 0 means kfunc accepted UDP skb (bug).
>> +     * assign_ret < 0 means kfunc correctly rejected it (fixed).
>> +     */
>> +    ASSERT_NEQ(skel->data->assign_ret, 0, "assign_ret");
>
> and here it checks NEQ 0....
>
> Maybe init assign_ret to 0?
>
> Also, why not specifically check for -EINVAL?


You're right, checking for -EINVAL is more precise and avoids hiding a 
silent failure in the lookup path.

Will init assign_ret to 0 and check for -EINVAL instead.


