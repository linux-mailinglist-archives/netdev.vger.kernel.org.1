Return-Path: <netdev+bounces-118636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1518A952562
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93441B236C6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDDA14883C;
	Wed, 14 Aug 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hecGQlfs"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0335894
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673795; cv=none; b=tV5JX8RnKWttQDiFRr+W4HQ1pOFvQHnxZrxLVt2Kujb/umjid0dAI1JSAKjnEvp6JPzFc8u9ckMqPEGZoESgzM5dVw9aCHXxIZD0XC9RB1BGAJNKgBp02fnRwQ9ECp5YKMd9qW7hI2IJyMnjmBXxJmVknNmdgmIPbVGOWcTbYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673795; c=relaxed/simple;
	bh=YT1vx0NFumaazq1tKE4CpNpSU1b3mH4Kt4GKiySUDpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBkh9vw+M8KjXRrJ2rUbgrFK5xcC6RFGFiJx0yAflIbEbBEmbrKyAM6uNwKoH3NsXFni34Qlm+OKMvnOiUjCr6izCFzgSN6L2285D1csb0xD+oOYOWyzzuHjO2ORGM7R3psuz/GidS5gk5MyN/x5g1mhV3czw3qxPaa/JuxMmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hecGQlfs; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <382309fc-4c7e-4a2c-98dd-2b4d7f50b7da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723673792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ca3wTCtEZnJAGFEADWiUPk7LQMn0grIN5a2ZEEPTP7A=;
	b=hecGQlfscHzdavOp5+i8Tx+hDwnsYbkNyKOONknNUNP+IAGVjqLRqicReYv/51GSan3Gs/
	bUnJRv+I5Jti/hP4AcAtGsHsrmLMbztgZ7wItLxRtT3yR0wU8+Hnm0Q5FBHmGiV2EGWXbY
	qgfnPByguoLXNnC5eZ9LMqjuoIGULm4=
Date: Wed, 14 Aug 2024 15:16:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
 <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/5/24 2:52 AM, Matthieu Baerts (NGI0) wrote:
> +static void run_subflow(char *new)
> +{
> +	int server_fd, client_fd, err;
> +	char cc[TCP_CA_NAME_MAX];
> +	socklen_t len = sizeof(cc);
> +
> +	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> +	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
> +		return;
> +
> +	client_fd = connect_to_fd(server_fd, 0);
> +	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
> +		goto fail;
> +
> +	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> +	if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
> +		goto fail;
client_fd is leaked.

> +
> +	send_byte(client_fd);
> +
> +	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
> +	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
> +	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
> +	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
> +
> +	close(client_fd);
> +fail:
> +	close(server_fd);
> +}

