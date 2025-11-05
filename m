Return-Path: <netdev+bounces-235644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218E6C33727
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 01:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76763AECDF
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 00:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B2F21D3D2;
	Wed,  5 Nov 2025 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h93S5tQA"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21221C9EA
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301642; cv=none; b=LccO73pDDP8irAzBOOOPRrkQriOViKP1Kwm9LpPiYqlRevsPmg3HezPVUW5w4Wd+hm6G+q0vaPb7p8LGGrW0vl9DqhOVGFIuG1NYSEmSeKuFh/VzUkZHJmwP/2hNReV7eoXsoflylzrY7nHF11VSPUTBOlfJNBOOq7OBQyYZF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301642; c=relaxed/simple;
	bh=5gcvClTVLqtwaqKnjQWMHpkh9LqtH2ScfoLLO7StRyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxBn0wCnJ4OnjHWrff+5AqqfEQXdBJbFuSZj7ceb5euoXy6fwnvg+A7pfNBmD1oTEBhn8FUsOTX6qdN6xw/7kAu0ne1mTQlJzZLGP5AMmjG+/D/BbvZ0iklhgcq4Lh7g1RtuJbHZZRJrVjiVZduAUhhea8GmjVyQWQpJSqfra7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h93S5tQA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <14bc0878-796e-415a-a319-baa609474a20@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762301627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cSI11JpcgybVjYBiMGbA7pVPJ1JONi5A3K/4HBp314=;
	b=h93S5tQA/NL4ZliGikL3WkGfnqHorX1C/fxtslb8GWs7bV78F+7p4zNuDzEKylQKkFkAN2
	IBpxl9ZDquX/3U8fwy16/+9GbaqEaFeTSDmlzAiuS9Zhlgg7nrUhjQfD9Gh8+z+HeiKKGP
	Vf6jocqvF9UFPTUKXtkhGYTObgw/zwc=
Date: Tue, 4 Nov 2025 16:13:39 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/3] bpf/selftests: add selftest for
 bpf_smc_hs_ctrl
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com,
 yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com,
 wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 sidraya@linux.ibm.com, jaka@linux.ibm.com
References: <20251103073124.43077-1-alibuda@linux.alibaba.com>
 <20251103073124.43077-4-alibuda@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251103073124.43077-4-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/2/25 11:31 PM, D. Wythe wrote:
> +static bool setup_netns(void)
> +{
> +	test_netns = netns_new(TEST_NS, true);
> +	if (!ASSERT_OK_PTR(test_netns, "open net namespace"))
> +		goto fail_netns;
> +
> +	if (!ASSERT_OK(system("ip addr add 127.0.1.0/8 dev lo"),

SYS(fail_ip, "ip addr add ...")
> +		       "add server node"))
> +		goto fail_ip;
> +
> +	if (!ASSERT_OK(system("ip addr add 127.0.2.0/8 dev lo"),

same here.

> +		       "server via risk path"))
> +		goto fail_ip;
> +
> +	return true;
> +fail_ip:
> +	netns_free(test_netns);
> +fail_netns:
> +	return false;
> +}
> +
> +static void cleanup_netns(void)
> +{
> +	netns_free(test_netns);
> +	remove_netns(TEST_NS);

remove_netns should not be needed. netns_free() should have removed it.

[ ... ]

> +static void test_topo(void)
> +{
> +	struct bpf_smc *skel;
> +	int rc, map_fd;
> +
> +	skel = bpf_smc__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "bpf_smc__open_and_load"))
> +		return;
> +
> +	rc = bpf_smc__attach(skel);
> +	if (!ASSERT_OK(rc, "bpf_smc__attach"))
> +		goto fail;
> +
> +	map_fd = bpf_map__fd(skel->maps.smc_policy_ip);
> +	if (!ASSERT_OK_FD(map_fd, "bpf_map__fd"))
> +		goto fail;
> +
> +	/* Mock the process of transparent replacement, since we will modify
> +	 * protocol to ipproto_smc accropding to it via
> +	 * fmod_ret/update_socket_protocol.
> +	 */
> +	system("sysctl -w net.smc.hs_ctrl=linkcheck");

The "sysctl -w" will echo useless output to test_progs. just use 
write_sysctl().



