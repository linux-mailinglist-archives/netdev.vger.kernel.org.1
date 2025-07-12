Return-Path: <netdev+bounces-206294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179CBB0283E
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 02:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4ED0A4367E
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC1AF507;
	Sat, 12 Jul 2025 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZcxmEVjm"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B718EB0
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752279814; cv=none; b=MCDAoivBah+ShyLdOQS3O1RugHh6lNX4bQOm8VNMDbPeqoy/vJkWPL1uHxWHJ/TDT+tAAftbKKX3azNnrLCttIFN6y1ttvl6owzJByBS9TNQ2aFv14yKKVm7tV8tnpYQCYMGjkcdQl1RF3iyB1fhUc7HHnidVdD0Rt05r6G2Noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752279814; c=relaxed/simple;
	bh=uQTm1LG86uMk297LYMdWRW7WqXNvMrl/Y6KgC130zF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbl8D17CRCrGesnR4qjhU1+dVwmLncxLBnblPA7yqMkgCZPgmLwyz3FdA0VY/oV9rPnADbYsY6EHTKRc2p67o1GIJ0bBsqTy8QyqsH+/bVeh9b/Jsm8pnKprgRkPytzAgoNMQve/PpzhBUvUXylZ6eiiIYpTw2KCQXuVtbh1p4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZcxmEVjm; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c66f688-988f-4f55-a822-de5686178b1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752279799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV3Q6zQlbxZ47PhQT6BykyiRHOIN3lHCKTsD93l8X5k=;
	b=ZcxmEVjme3OODqmbIpKekmtZ4EBEZ5hzrbtqTa6yk9dv+eGJNno8GwOTPzrLa1mvewCBCv
	avnMyoyD7mD7YtD0jUmmR9c6SoBuVmaRKjV2iahXn+Hp4BIcQX1MejSwmotqbRMqphuKNm
	SfB/pndpkE9qfUuHwuI2kmzaWnvANRE=
Date: Fri, 11 Jul 2025 17:23:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 10/12] selftests/bpf: Create established
 sockets in socket iterator tests
To: Jordan Rife <jordan@jrife.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250709230333.926222-1-jordan@jrife.io>
 <20250709230333.926222-11-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250709230333.926222-11-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/9/25 4:03 PM, Jordan Rife wrote:
>   
> +static int accept_from_one(int *server_fds, int server_fds_len)
> +{
> +	int fd;
> +	int i;
> +
> +	for (i = 0; i < server_fds_len; i++) {
> +		fd = accept(server_fds[i], NULL, NULL);
> +		if (fd >= 0)
> +			return fd;
> +		if (!ASSERT_EQ(errno, EWOULDBLOCK, "EWOULDBLOCK"))
> +			return -1;
> +	}
> +
> +	return -1;

After looking at the set again before landing, I suspect there is a chance that 
this function may return -1 here if the final ack of the 3WHS has not been 
received yet.

> +}
> +
> +static int *connect_to_server(int family, int sock_type, const char *addr,
> +			      __u16 port, int nr_connects, int *server_fds,
> +			      int server_fds_len)
> +{
> +	struct network_helper_opts opts = {
> +		.timeout_ms = 0,
> +	};
> +	int *established_socks;
> +	int i;
> +
> +	/* Make sure accept() doesn't block. */
> +	for (i = 0; i < server_fds_len; i++)
> +		if (!ASSERT_OK(fcntl(server_fds[i], F_SETFL, O_NONBLOCK),
> +			       "fcntl(O_NONBLOCK)"))

server_fds is non-blocking.

> +			return NULL;
> +
> +	established_socks = malloc(sizeof(int) * nr_connects*2);
> +	if (!ASSERT_OK_PTR(established_socks, "established_socks"))
> +		return NULL;
> +
> +	i = 0;
> +
> +	while (nr_connects--) {
> +		established_socks[i] = connect_to_addr_str(family, sock_type,
> +							   addr, port, &opts);

connect returns as soon as the syn-ack is received.

> +		if (!ASSERT_OK_FD(established_socks[i], "connect_to_addr_str"))
> +			goto error;
> +		i++;
> +		established_socks[i] = accept_from_one(server_fds,
> +						       server_fds_len);

I am not sure the final ack is always received by the server at this point. If 
not, the test could be flaky. Is this case possible? and is it better to 
poll/select for a fixed number of seconds?

> +		if (!ASSERT_OK_FD(established_socks[i], "accept_from_one"))
> +			goto error;
> +		i++;
> +	}
> +
> +	return established_socks;
> +error:
> +	free_fds(established_socks, i);
> +	return NULL;
> +}


