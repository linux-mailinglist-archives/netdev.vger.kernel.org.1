Return-Path: <netdev+bounces-229407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5C8BDBBFE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 01:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D4C3AE5F4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 23:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8FC30EF75;
	Tue, 14 Oct 2025 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ol2SaDhq"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B630DD3B
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483583; cv=none; b=GOh9+A9UV4nRKJ9exQT0Usr0karRZRQBAE/12bcM6ZZ3D3UEjlxSH/1aCknPNkq45HpcxeLiPNl04DtBb4qCD+10cdiL3Te7PBWlrp5gE9MSb5EX0yxKGYLji3FANXm23U5c6IhBpePBHdAzFUQulnvmhvOVEeFTjtUPASFI3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483583; c=relaxed/simple;
	bh=fcwXNTeJpcjSOx+df+r3b9LV8FwrdYExzkbElvgp/UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLWgbt/r/+A4DMmgFKGUt8Pcdg7y1UQeIlycYx0hhn/JMRpWvRiBUmBDB+PwNhwRfFJdPVF+cfOwJeNDuzH89awOM2jzfC8dG9kgChGh9sgQv30oXFHRpyjoHqE5M2oLp4grM5UBa2tOhzFamzZ1WSnZkrdix3iB7HUXzrCyapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ol2SaDhq; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c05e9b2c-ae5f-4607-821e-37f71b1dd1bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760483568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bc7/sQWaWUUq7pOFN6egIMlyTpGH0JETI7XklDirkZo=;
	b=ol2SaDhqXt3M5A6t3+VjI9NZjG3gRuw/on/RPNn+f1CTvl7D8QyzXHHo8w5/VzPLvfEKsi
	cjXqzTK+SVGUbL8+oZHeIzQrbpJ1lB05iimKkdXDx2zrHg+scDwsjBSIM104w+M15WeefR
	jBVILfO8m3BvtnjKdzzB7SESFn7JvWU=
Date: Tue, 14 Oct 2025 16:12:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net 2/6] net: Allow opt-out from global protocol
 memory accounting.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251007001120.2661442-1-kuniyu@google.com>
 <20251007001120.2661442-3-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20251007001120.2661442-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/6/25 5:07 PM, Kuniyuki Iwashima wrote:
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 60bcb13f045c..5cf8de6b6bf2 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -118,6 +118,7 @@ typedef __u64 __bitwise __addrpair;
>    *	@skc_reuseport: %SO_REUSEPORT setting
>    *	@skc_ipv6only: socket is IPV6 only
>    *	@skc_net_refcnt: socket is using net ref counting
> + *	@skc_bypass_prot_mem:

While it needs a respin, maybe useful to add comment on "@skc_bypass_prot_mem"

>    *	@skc_bound_dev_if: bound device index if != 0
>    *	@skc_bind_node: bind hash linkage for various protocol lookup tables
>    *	@skc_portaddr_node: second hash linkage for UDP/UDP-Lite protocol
> @@ -174,6 +175,7 @@ struct sock_common {
>   	unsigned char		skc_reuseport:1;
>   	unsigned char		skc_ipv6only:1;
>   	unsigned char		skc_net_refcnt:1;
> +	unsigned char		skc_bypass_prot_mem:1;
>   	int			skc_bound_dev_if;
>   	union {
>   		struct hlist_node	skc_bind_node;



