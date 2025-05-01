Return-Path: <netdev+bounces-187343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4CAAA6799
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA9A9881D0
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2D92609EC;
	Thu,  1 May 2025 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v4XTPbg6"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57833987
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746143909; cv=none; b=U82UjutpynUNm5AYotgJT2+hnGa/K5HmF3+K+Yndb+UYhuq4KY5ZI2LFXkJOJi8UL5zPdDry00aM/HR3NjbIsQLATDH/dNCYNg9dtL8YoDZA6TYDEvflN278aN7Zv9eXNAdkjg/sCe0o06rpOTx909sMjfOWdtSo/rCFKoSPkGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746143909; c=relaxed/simple;
	bh=I5u9d8HWSZ/ZH/v+9KgdHorfTXAGHqr6+YiS97kzkxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VebgMA7MQW6S0MmrHUKtMx3lvXt63GvVpOjVyescZdFufYExIZNXNWiK3C6U0kGH0CJDFqfl3Rmohr6sN8JLJHTQhRWjbs6Vk0Q0O/2H4WriFAzlZgWvzYmElRl9lJNxu5N2hxeoKiqwlkyQ1btNeVwSVIoZmw6lWqCib7IhLX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v4XTPbg6; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <83c8f387-c4a9-4293-9996-fec285d34c94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746143895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tncfEf9FYDlLvfP3M87721xQwzJy/xmBPxmLH4uisu4=;
	b=v4XTPbg6220J33yOMAVDdpprkK87l1JXWgxAgOApGYxk0I/YoR08sx2fqAnPMDmTzM6YLc
	1PkQzC5n4zZqRe1WDqyAlVEvZ3IeEkx72YaD4BTjWdL1RDdztSd4/e6qWuhjPvhlB2zOoT
	B6dgECqCriWZJd1UEHSy9ApluSWVrQA=
Date: Thu, 1 May 2025 16:58:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v1 2/5] selftests/bpf: Test setting and
 creating bpf qdisc as default qdisc
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, xiyou.wangcong@gmail.com, kernel-team@meta.com
References: <20250501223025.569020-1-ameryhung@gmail.com>
 <20250501223025.569020-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250501223025.569020-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/1/25 3:30 PM, Amery Hung wrote:
> First, test that bpf qdisc can be set as default qdisc. Then, attach
> an mq qdisc to see if bpf qdisc can be successfully created and grafted.
> 
> The test is a sequential test as net.core.default_qdisc is global.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_qdisc.c      | 78 +++++++++++++++++++
>   1 file changed, 78 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> index c9a54177c84e..c954cc2ae64f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> @@ -159,6 +159,79 @@ static void test_qdisc_attach_to_non_root(void)
>   	bpf_qdisc_fifo__destroy(fifo_skel);
>   }
>   
> +static int get_default_qdisc(char *qdisc_name)
> +{
> +	FILE *f;
> +	int num;
> +
> +	f = fopen("/proc/sys/net/core/default_qdisc", "r");
> +	if (!f)
> +		return -errno;
> +
> +	num = fscanf(f, "%s", qdisc_name);
> +	fclose(f);
> +
> +	return num == 1 ? 0 : -EFAULT;
> +}
> +
> +static void test_default_qdisc_attach_to_mq(void)
> +{
> +	struct bpf_qdisc_fifo *fifo_skel;
> +	char default_qdisc[IFNAMSIZ];
> +	struct netns_obj *netns;
> +	char tc_qdisc_show[64];
> +	struct bpf_link *link;
> +	char *str_ret;
> +	FILE *tc;
> +	int err;
> +
> +	fifo_skel = bpf_qdisc_fifo__open_and_load();
> +	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);

	fifo_skel->links.fifo = bpf_map__attach_struct_ops(....);

Then no need to bpf_link__destroy(link). bpf_qdisc_fifo__destroy() should do.

> +	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> +		bpf_qdisc_fifo__destroy(fifo_skel);
> +		return;
> +	}
> +
> +	err = get_default_qdisc(default_qdisc);
> +	if (!ASSERT_OK(err, "read sysctl net.core.default_qdisc"))
> +		goto out;
> +
> +	err = write_sysctl("/proc/sys/net/core/default_qdisc", "bpf_fifo");
> +	if (!ASSERT_OK(err, "write sysctl net.core.default_qdisc"))
> +		goto out;
> +
> +	netns = netns_new("bpf_qdisc_ns", true);
> +	if (!ASSERT_OK_PTR(netns, "netns_new"))
> +		goto out;

This should be 'goto out_restore_dflt_qdisc'.

I would stay with minimum number of cleanup labels if possible. Initialize the 
variables that need to be cleaned up instead. There is no need to optimize each 
cleanup case for a test,

e.g. "struct netns_obj netns = NULL; char default_qdisc[IFNAMSIZ] = {};..."

> +
> +	SYS(out_restore_dflt_qdisc, "ip link add veth0 type veth peer veth1");
> +	SYS(out_delete_netns, "tc qdisc add dev veth0 root handle 1: mq");
> +
> +	tc = popen("tc qdisc show dev veth0 parent 1:1", "r");
> +	if (!ASSERT_OK_PTR(tc, "tc qdisc show dev veth0 parent 1:1"))
> +		goto out_delete_netns;
> +
> +	str_ret = fgets(tc_qdisc_show, sizeof(tc_qdisc_show), tc);
> +	if (!ASSERT_OK_PTR(str_ret, "tc qdisc show dev veth0 parent 1:1"))
> +		goto out_delete_netns;
> +
> +	str_ret = strstr(tc_qdisc_show, "qdisc bpf_fifo");
> +	if (!ASSERT_OK_PTR(str_ret, "check if bpf_fifo is created"))
> +		goto out_delete_netns;

Instead of pipe and grep, how about having the bpf_fifo_init bpf prog to set a 
global variable when called and then check the "fifo_skel->bss->init_called == 
true" here?

> +
> +	SYS(out_delete_netns, "tc qdisc delete dev veth0 root mq");
> +out_delete_netns:
> +	netns_free(netns);
> +out_restore_dflt_qdisc:
> +	write_sysctl("/proc/sys/net/core/default_qdisc", default_qdisc);
> +out:
> +	bpf_link__destroy(link);
> +	bpf_qdisc_fifo__destroy(fifo_skel);
> +}
> +
>   void test_bpf_qdisc(void)
>   {
>   	struct netns_obj *netns;
> @@ -178,3 +251,8 @@ void test_bpf_qdisc(void)
>   
>   	netns_free(netns);
>   }
> +
> +void serial_test_bpf_qdisc_default(void)
> +{
> +	test_default_qdisc_attach_to_mq();
> +}


