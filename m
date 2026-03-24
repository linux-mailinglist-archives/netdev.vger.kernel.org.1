Return-Path: <netdev+bounces-271322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJB2DYkJw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:00:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FF731D124
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C14263063A00
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D03B2FF4;
	Tue, 24 Mar 2026 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dvc3wWfY"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38E3AE18A
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389596; cv=none; b=bPFaahRpsPm+FDll7D68jV6fStjYgLScV6h+Ysu1fcJzgRrCNK5isRvaXpd5BR+SOg9N82LUiUaaeIpyycRuI9myXxoTs/HULiamRWNhUsukzrLhxanEYZxmuVthMto46b/bd6FwTW7i4G9xe0i3EgVXenVcQocpEoy/+lm8rWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389596; c=relaxed/simple;
	bh=ShgZqAsm1ES9TM2DCVST2bOFKrWMl1Az0BkQq6rZ+Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAvxcT8SxUaHZoNseQqSKd6uPvsz0FbCH5C85SHzbN+LHDA8WUMJze9WODBXV8UbuBRGvMu11Br22U5Q7JdWqStP4ZDriiQcu0orEbcF65psmBdX/xKQ2ebmcCtny0tQLKM4803825MWLL/p1raXVsXNvIvZJMgmwDifMN9jsZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dvc3wWfY; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9adc3c2e-0d5a-4863-b3ed-194d8f9fd630@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774389581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6cbUmLdr2RxX8BjNLt/qO3H5GrfRjVsh/qY1m2DFXM=;
	b=dvc3wWfYADOarkhfj7HCpwJ7tW6Yjy29gNM6Jw1oC7c/yXnkjaG55LEHh73E0nY85ZPYp3
	8l75bFEL+HPFUdFh5PsEzVkG5/ff42c162xk16fcwJN/iU8X8zDvHDf/KGLpq7/RghyQJB
	efIzOvHgApLtbGpO5K2N/Z8CO/uNwPo=
Date: Tue, 24 Mar 2026 14:59:32 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260323105510.51990-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[shopee.com,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271322-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 67FF731D124
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 3:54 AM, Jiayuan Chen wrote:
> +void test_tcp_custom_syncookie_protocol_check(void)
> +{
> +	struct test_tcp_custom_syncookie *skel;
> +	struct sockaddr_in tcp_addr, udp_addr;
> +	socklen_t addr_len = sizeof(tcp_addr);
> +	int tcp_server = -1, udp_client = -1;
> +	char buf[32] = "test";
> +	int ret;
> +
> +	if (setup_netns())
> +		return;
> +
> +	skel = test_tcp_custom_syncookie__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
>   
> +	/* Create a TCP listener so the BPF can find a LISTEN socket */
> +	tcp_server = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
> +	if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
> +		goto destroy_skel;
> +
> +	ret = getsockname(tcp_server, (struct sockaddr *)&tcp_addr, &addr_len);
> +	if (!ASSERT_OK(ret, "getsockname"))
> +		goto close_tcp;
> +
> +	skel->bss->tcp_listener_port = ntohs(tcp_addr.sin_port);
> +	skel->bss->udp_test_port = 9999;
> +
> +	ret = bpf_program__fd(skel->progs.tcp_custom_syncookie_badproto);
> +	if (setup_tc(ret))
> +		goto close_tcp;
> +
> +	udp_client = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (!ASSERT_NEQ(udp_client, -1, "udp socket"))
> +		goto cleanup_tc;
> +
> +	memset(&udp_addr, 0, sizeof(udp_addr));
> +	udp_addr.sin_family = AF_INET;
> +	udp_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> +	udp_addr.sin_port = htons(9999);
> +
> +	ret = sendto(udp_client, buf, sizeof(buf), 0,
> +		     (struct sockaddr *)&udp_addr, sizeof(udp_addr));
> +	ASSERT_EQ(ret, sizeof(buf), "sendto udp");
> +
> +	/* Wait for TC ingress BPF to process the skb. */
> +	kern_sync_rcu();

hmm... is it guaranteed to work? Regardless, it checks the error 
returned from bpf_sk_assign_tcp_reqsk(). Maybe bpf_prog_test_run is simpler?

pw-bot: cr

> +
> +	ASSERT_EQ(skel->bss->udp_intercepted, true, "udp_intercepted");
> +
> +	/* assign_ret == 0 means kfunc accepted UDP skb (bug).
> +	 * assign_ret < 0 means kfunc correctly rejected it (fixed).
> +	 */
> +	ASSERT_NEQ(skel->data->assign_ret, 0, "assign_ret");
> +
> +cleanup_tc:
> +	system("tc qdisc del dev lo clsact");
> +	if (udp_client >= 0)
> +		close(udp_client);
> +close_tcp:
> +	close(tcp_server);
> +destroy_skel:
>   	test_tcp_custom_syncookie__destroy(skel);
>   }

