Return-Path: <netdev+bounces-271819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CqeOUeoxGmZ1wQAu9opvQ
	(envelope-from <netdev+bounces-271819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:30:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BB32ED7D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2752D300F534
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C4538F651;
	Thu, 26 Mar 2026 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="auY2R3sw"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD81A9FB7
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495510; cv=none; b=jY/d7JN/1WLf2Ud9Ch5l6u4brLz8FYPtb/7iosBkW9hH4cl25NS9pfLY1ypW9sa2fgKQyWnYkvmpMK+vigflyqyhneyHVsOBsrrxLUvMV+Oany3QW+13FbPgsXb6R/klb+4lW/KvvDpjTqeXwRZTeYCAUbIkYfvaVvs+L6cHBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495510; c=relaxed/simple;
	bh=PeO3Wn4eC2AsM7MoyTFPPR2RxQrGibPXKvXagwq9jD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwiS++LiZgJ1r2XoZZ+44SE4rtp8uEK+88aA0m2rOewxczR0XdXfLlDXNZimXIskq+AbL6cOfiLzJN5qgmI5sify+walOeduaAsEXs8VKyStcUhljDnrgY1Kt9Qiz5wvlbUAchLa1RMm4veWHGLTStLmm/oDRw1r2YqOfnHyhOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=auY2R3sw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c27a461-2714-4c27-8604-dedd506a09aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774495506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNdfjJHD6SMD9Xw8BJ+zCQWvHXfF4m3AH/8ikcFZoxY=;
	b=auY2R3swKFmiQYJ62EhZeIZ6lJgq+hhn4f8D4apQgKw3hvmi8awSu9dy5bBPhVf1PseunR
	Bf14bYgKDDOiMNz9HrgunVljUnXDZ/QWZHVfptyhd8vBoV8P/D+2pfg3Jzfk43UPDVM1Pm
	JY1JwnQOPI2JXs2PC41PuCSNh9gyV2k=
Date: Thu, 26 Mar 2026 11:24:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add protocol check test for
 bpf_sk_assign_tcp_reqsk()
To: Martin KaFai Lau <martin.lau@linux.dev>
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <9adc3c2e-0d5a-4863-b3ed-194d8f9fd630@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271819-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A9BB32ED7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/25/26 5:59 AM, Martin KaFai Lau wrote:
> On 3/23/26 3:54 AM, Jiayuan Chen wrote:
>> +void test_tcp_custom_syncookie_protocol_check(void)
>> +{
>> +    struct test_tcp_custom_syncookie *skel;
>> +    struct sockaddr_in tcp_addr, udp_addr;
>> +    socklen_t addr_len = sizeof(tcp_addr);
>> +    int tcp_server = -1, udp_client = -1;
>> +    char buf[32] = "test";
>> +    int ret;
>> +
>> +    if (setup_netns())
>> +        return;
>> +
>> +    skel = test_tcp_custom_syncookie__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +        return;
>>   +    /* Create a TCP listener so the BPF can find a LISTEN socket */
>> +    tcp_server = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
>> +    if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
>> +        goto destroy_skel;
>> +
>> +    ret = getsockname(tcp_server, (struct sockaddr *)&tcp_addr, 
>> &addr_len);
>> +    if (!ASSERT_OK(ret, "getsockname"))
>> +        goto close_tcp;
>> +
>> +    skel->bss->tcp_listener_port = ntohs(tcp_addr.sin_port);
>> +    skel->bss->udp_test_port = 9999;
>> +
>> +    ret = bpf_program__fd(skel->progs.tcp_custom_syncookie_badproto);
>> +    if (setup_tc(ret))
>> +        goto close_tcp;
>> +
>> +    udp_client = socket(AF_INET, SOCK_DGRAM, 0);
>> +    if (!ASSERT_NEQ(udp_client, -1, "udp socket"))
>> +        goto cleanup_tc;
>> +
>> +    memset(&udp_addr, 0, sizeof(udp_addr));
>> +    udp_addr.sin_family = AF_INET;
>> +    udp_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
>> +    udp_addr.sin_port = htons(9999);
>> +
>> +    ret = sendto(udp_client, buf, sizeof(buf), 0,
>> +             (struct sockaddr *)&udp_addr, sizeof(udp_addr));
>> +    ASSERT_EQ(ret, sizeof(buf), "sendto udp");
>> +
>> +    /* Wait for TC ingress BPF to process the skb. */
>> +    kern_sync_rcu();
>
> hmm... is it guaranteed to work? Regardless, it checks the error 
> returned from bpf_sk_assign_tcp_reqsk(). Maybe bpf_prog_test_run is 
> simpler?
>
> pw-bot: cr
>
>> +
>>
I looked into using bpf_prog_test_run, but it won't work here
because bpf_sk_assign_tcp_reqsk() requires the skb to come from TC ingress
— it checks skb_at_tc_ingress() internally and returns -EINVAL otherwise.

For the synchronization concern, instead of kern_sync_rcu(), I now create
a UDP server bound to the target port and recv() the packet after sendto().
Since the BPF program returns TC_ACT_OK, the packet passes through TC 
ingress
and arrives at the UDP socket. The recv() naturally blocks until the BPF 
program
has finished processing, so no timing tricks are needed.


