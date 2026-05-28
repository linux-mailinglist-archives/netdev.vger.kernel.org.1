Return-Path: <netdev+bounces-292874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA2NIPTHGGqZnQgAu9opvQ
	(envelope-from <netdev+bounces-292874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:55:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A095FB1F3
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EFA8300AEEA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEC736C9C5;
	Thu, 28 May 2026 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="y2KJP44t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39236B048
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780008941; cv=none; b=mdlRArD8i9eJf9clsCui32BA2GbCk8PoUfkjg39XEtbEISET03t7K9+rIatlTD4f1z620uLqAnAX4J89QOaDKLfJ7E86suPS02qZDLW6v5G0HQ+qKFrU7o7ISqStlg4BJUDZC8BakMYkbWX2X3jbajeSkbRHHLJWJARqVxrXK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780008941; c=relaxed/simple;
	bh=yF+t/MxA8C1202gDEuqnLcAowiuRvjX0RRxo5GBhxRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtIKUnEhu3pI/OP8gABnEjyAvGrZv8a0jcom3VIyxlt77uRbjEzNQW+2Oq/zjl/xpPX0L6WbEFUi2eUcfb5yF27hgTssQ2xzPChB6h4Us8UdFPMYfXIxQXsCBDxzyQqIkF+AUrNqAGTCyWX9X6JXdcOBkECiP6B6C6RKPtVWQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=y2KJP44t; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304e86ecebfso42986eec.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1780008940; x=1780613740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hYbf4kzlnIJc0DIgLjb8FNPQMjUNGbaxH90ljGYoYU=;
        b=y2KJP44t5bXoV+K2ct+ssYDNnzdqZK7cYWeHxpUhmS4VY9Di+M80zxjMoEe4TcArdy
         BG9n3DVGj+Y0oEpWbpMp5KkReFqQkAiT4XbYkX0oo6pNK1fcoTrMHNSbOzLeTTWFA/A0
         DlXkhDm/+fo0L8Ne3wXmFQxPYBvBgfD7S5HJ6MSyEqN7i2D2+DeJBCs4vCIoKKJt3ovA
         MmYu0SkbT72u/tV39hUMywlg+EPpUU96JROSNjWjaLmiy4JYQoE261+f1YoQpL+eIbPO
         QpRGAdJBQIHbVHHNMl2JxIisikxqkcLyNJdyrT6VF019vINDLR1S2axzH3DAuDEz9HmO
         jgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780008940; x=1780613740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hYbf4kzlnIJc0DIgLjb8FNPQMjUNGbaxH90ljGYoYU=;
        b=MFhauZh+7l9PTIWzRHFJ11o+DvPheCdkf6N4GdCilw/31w1m7AnDFgNJsp8ROm0lm5
         F+KzH2rhs70kpDvKFtcw/F0u9FAVDLbYd6cMVPhSEOAjXRWZBYRxc76YZRTk0AAV7Jm9
         kZcALiGXRxsE2tPTAHJF49XdE9M0ToAZCgHC+fJfszV+ryvhtjCZBVkgKK+KFNKMsnX/
         Cz2uTA59474ibpTyjb8ro0JFiBzTYSpdkd/G2IV/Ntui8Khq1/5Fni7krzyw8QxY7Qd+
         fGMAxjWindtWdPTwGAMxYYRgDQlvf0jHQVtCIpcfWKM5XJr4AmDNtToJ1rpLwEfx/9fD
         ksng==
X-Forwarded-Encrypted: i=1; AFNElJ9lcXu1ZoNzKx2KbmH6crAIQaqzUneThWggm2akAbWyMjYG/alD/Y3S9WyGNLuErN/YfXCVuHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxX2LuEPhACEGlAJZ3oLHG9jQ9y2GxNNNDvmELK+/250an7b9h
	ZsQUqfS/khBLiA8+gYxYJY0nacermcIm9r5O+Z0wtG2A/lv1b44+JTQu+bQQpsv2gVc=
X-Gm-Gg: Acq92OFJOFbrhAXoARNr+CYRfI+vUV7bUnhxRCKcLjUrZWbWzqYt+04FLtSSssM2Xy2
	3HIOqwydYV0z0ffgUQ75Vw6e335qkTOP+RL6jCuqxcDqmGFsLPgOI8lpgkq9oiY45DTXW8I3xPz
	JYr04WjKmmN7Ax2J7VH0ufABnblSybKwfeAUg2B9q3iDRZ/xNDvEAZLiU8i7U08bcuUS9sQcFYJ
	cnZtWJ+0gy+KQEol1WPmfsSyxEseF7V3V5DE3s9XO9UyvoDYbMwpnOTcphe/tuFavvusjNTxIlO
	3RjfE/14EWF0sVsC40JA2Xh+aZUiXGwVpZTBGItQI8hDeMtMXefJxwQvdbMFGrpIcVr+wkEJcHG
	f12IA39tuhu8JMb/uAiZG82jgQ1uBhQuBBzeSNcDYmohq0puxlimISHDL99lt0TGmqHlT7LfRrw
	JjzJLMYz3gIgyd4rpWXgLBkaKX
X-Received: by 2002:a05:7300:72c5:b0:304:e327:aef8 with SMTP id 5a478bee46e88-304eb0d0400mr88891eec.2.1780008939657;
        Thu, 28 May 2026 15:55:39 -0700 (PDT)
Received: from m2 ([83.171.251.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ebcc77f3sm237240eec.22.2026.05.28.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:55:39 -0700 (PDT)
Date: Thu, 28 May 2026 15:55:37 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v7 7/7] selftests/bpf: add bpf_icmp_send
 recursion test
Message-ID: <3evosyl26zvnzhficgf73g4ecdgdrdlnabvt2423ku36qbovp7@ij6dxahqxlxt>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
 <20260526153708.279717-8-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526153708.279717-8-mahe.tardy@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jrife-io.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292874-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[jrife.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[jrife-io.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,jrife-io.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: E7A095FB1F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 03:37:08PM +0000, Mahe Tardy wrote:
> This test is similar to test_icmp_send_unreach_cgroup but checks that,
> in case of recursion, meaning that the BPF program calling the kfunc was
> re-triggered by the icmp_send done by the kfunc, the kfunc will stop
> early and return -EBUSY.
> 
> The test attaches to the root cgroup to ensure the ICMP packet generated
> by the kfunc re-triggers the BPF program. Since it's attached only for
> this recursion test, it should not disrupt the whole network.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  .../bpf/prog_tests/icmp_send_kfunc.c          | 42 +++++++++++++++++-
>  tools/testing/selftests/bpf/progs/icmp_send.c | 44 +++++++++++++++++++
>  2 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index 51f809ea6896..f48e1d41e3ed 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
>  #include <network_helpers.h>
> +#include <cgroup_helpers.h>
>  #include <linux/errqueue.h>
>  #include <poll.h>
>  #include "icmp_send.skel.h"
> @@ -10,6 +11,7 @@
>  #define ICMP_DEST_UNREACH 3
>  #define ICMPV6_DEST_UNREACH 1
> 
> +#define ICMP_HOST_UNREACH 1
>  #define ICMP_FRAG_NEEDED 4
>  #define NR_ICMP_UNREACH 15
>  #define ICMPV6_REJECT_ROUTE 6
> @@ -193,7 +195,6 @@ void test_icmp_send_unreach_tc(void)
> 
>  	if (test__start_subtest("ipv4"))
>  		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);
> -
>  	if (test__start_subtest("ipv6"))
>  		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);
> 
> @@ -201,3 +202,42 @@ void test_icmp_send_unreach_tc(void)
>  	bpf_link__destroy(link);
>  	icmp_send__destroy(skel);
>  }
> +
> +void test_icmp_send_unreach_recursion(void)
> +{
> +	struct icmp_send *skel;
> +	int cgroup_fd = -1;
> +
> +	skel = icmp_send__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	if (setup_cgroup_environment()) {
> +		fprintf(stderr, "Failed to setup cgroup environment\n");
> +		goto cleanup;
> +	}
> +
> +	cgroup_fd = get_root_cgroup();
> +	if (!ASSERT_GE(cgroup_fd, 0, "get_root_cgroup"))
> +		goto cleanup;
> +
> +	skel->links.recursion =
> +		bpf_program__attach_cgroup(skel->progs.recursion, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.recursion, "prog_attach_cgroup"))
> +		goto cleanup;
> +
> +	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET,
> +					"127.0.0.1");
> +
> +	/* Because there's recursion involved, the first call will return at
> +	 * index 1 since it will return the second, and the second call will
> +	 * return at index 0 since it will return the first.
> +	 */
> +	ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY, "kfunc_rets[0]");
> +	ASSERT_EQ(skel->data->rec_kfunc_rets[1], 0, "kfunc_rets[1]");
> +
> +cleanup:
> +	cleanup_cgroup_environment();
> +	icmp_send__destroy(skel);
> +	close(cgroup_fd);

This will close(-1) if the first two `goto cleanup` branches are taken.
Not the end of the world, but most tests I've seen try to avoid it by
doing something like this:

if (cgroup_fd != -1)
	close(cgroup_fd);

> +}
> diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
> index 5fa5467bdb70..c899fb7b28d2 100644
> --- a/tools/testing/selftests/bpf/progs/icmp_send.c
> +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> @@ -14,6 +14,9 @@ int unreach_type = 0;
>  int unreach_code = 0;
>  int kfunc_ret = -1;
> 
> +unsigned int rec_count = 0;
> +int rec_kfunc_rets[] = { -1, -1 };
> +
>  SEC("cgroup_skb/egress")
>  int egress(struct __sk_buff *skb)
>  {
> @@ -125,4 +128,45 @@ int tc_egress(struct __sk_buff *skb)
>  	return TCX_DROP;
>  }
> 
> +SEC("cgroup_skb/egress")
> +int recursion(struct __sk_buff *skb)
> +{
> +	void *data = (void *)(long)skb->data;
> +	void *data_end = (void *)(long)skb->data_end;
> +	struct tcphdr *tcph;
> +	struct iphdr *iph;
> +	int ret;
> +
> +	iph = data;
> +	if ((void *)(iph + 1) > data_end || iph->version != 4)
> +		return SK_PASS;
> +
> +	if (iph->daddr != bpf_htonl(SERVER_IP))
> +		return SK_PASS;
> +
> +	if (iph->protocol == IPPROTO_TCP) {
> +		tcph = (void *)iph + iph->ihl * 4;
> +		if ((void *)(tcph + 1) > data_end ||
> +		    tcph->dest != bpf_htons(server_port))
> +			return SK_PASS;
> +	} else if (iph->protocol != IPPROTO_ICMP) {
> +		return SK_PASS;
> +	}
> +
> +	/* This call will provoke a recursion: the ICMP packet generated by the
> +	 * kfunc will re-trigger this program since we are in the root cgroup in
> +	 * which the kernel ICMP socket belongs. However when re-entering the
> +	 * kfunc, it should return EBUSY.
> +	 */
> +	ret = bpf_icmp_send(skb, unreach_type, unreach_code);
> +	rec_kfunc_rets[rec_count & 1] = ret;
> +	__sync_fetch_and_add(&rec_count, 1);
> +
> +	/* Let the first ICMP error message pass */
> +	if (iph->protocol == IPPROTO_ICMP)
> +		return SK_PASS;
> +
> +	return SK_DROP;
> +}
> +
>  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> --
> 2.34.1
> 

