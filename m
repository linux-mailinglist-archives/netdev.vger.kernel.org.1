Return-Path: <netdev+bounces-156296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925A4A05F68
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B62165FAF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B51F1AC42B;
	Wed,  8 Jan 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iR3Xs8bn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDAC139CF2
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348208; cv=none; b=nbQnUIghXuVIvOUk6mDphwVMasQIPZe7YCXAMoHMpzByC6nmvFrzGpt9p9QXNhJsKWa5y2o53PvKTkT1PZYseQ1HaeAbbm0D5G2tiAkomChQ5b+3f5xto1gAGzOiHVR00s2L2A+pQgwRMU90asMGri/gg1cAZVWv3PFzWVPPxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348208; c=relaxed/simple;
	bh=POHmf49ZLPRVTCcOwkNorVbp2wrjqz/AO7RcCsiq0fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mo+tZs/JJaEU8a23B8RMdYH9+LnGvecCVRNOE+btNEehLIUOzG2SrPj2cvFDH1JDGo2TE985gOOP5Zrv0GeY9SUQprLJW4JnhcOUVWRUyvNwhnI3FYgETZ7+OeC2FW4rs7ZQjaxM3VDBGSDqDGTwJ68dUdPNNgy1jUKcluD+kTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iR3Xs8bn; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736348203; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=huEaHL7JRodIT+bRdSxmYs/QDVp2Nwi1vkKP3m9Y4aM=;
	b=iR3Xs8bnKP0xUIY3VJbIIKTDHdR3fvmQMsYfSEQR+H0VfxAs7HE5pmROtN6ebdAv9+KlUwg+BvrMajLED9Fvh9nM6tvcSHtT80ESUxBvVqe6ExilOrUg4RwVIXc5UdkaoHPK1XGLjGHN59Nka99Pg4/sT+Fs40agVoB+pmcAo88=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WNEQabq_1736348201 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jan 2025 22:56:42 +0800
Date: Wed, 8 Jan 2025 22:56:41 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v5 07/12] net: homa: create homa_sock.h and
 homa_sock.c
Message-ID: <20250108145641.GA21926@j66a10360.sqa.eu95>
References: <20250106181219.1075-1-ouster@cs.stanford.edu>
 <20250106181219.1075-8-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106181219.1075-8-ouster@cs.stanford.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jan 06, 2025 at 10:12:13AM -0800, John Ousterhout wrote:
> These files provide functions for managing the state that Homa keeps
> for each open Homa socket.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>  net/homa/homa_sock.c | 382 ++++++++++++++++++++++++++++++++++++++++
>  net/homa/homa_sock.h | 406 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 788 insertions(+)
>  create mode 100644 net/homa/homa_sock.c
>  create mode 100644 net/homa/homa_sock.h
> 
> diff --git a/net/homa/homa_sock.c b/net/homa/homa_sock.c
> new file mode 100644
> index 000000000000..723752c6d055
> --- /dev/null
> +++ b/net/homa/homa_sock.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +/* This file manages homa_sock and homa_socktab objects. */
> +
> +#include "homa_impl.h"
> +#include "homa_peer.h"
> +#include "homa_pool.h"
> +
> +/**
> + * homa_socktab_init() - Constructor for homa_socktabs.
> + * @socktab:  The object to initialize; previous contents are discarded.
> + */
> +int homa_sock_init(struct homa_sock *hsk, struct homa *homa)
> +{
> +	struct homa_socktab *socktab = homa->port_map;
> +	int result = 0;
> +	int i;
> +
> +	spin_lock_bh(&socktab->write_lock);
> +	atomic_set(&hsk->protect_count, 0);
> +	spin_lock_init(&hsk->lock);
> +	hsk->last_locker = "none";
> +	atomic_set(&hsk->protect_count, 0);
> +	hsk->homa = homa;
> +	hsk->ip_header_length = (hsk->inet.sk.sk_family == AF_INET)
> +			? HOMA_IPV4_HEADER_LENGTH : HOMA_IPV6_HEADER_LENGTH;
> +	hsk->shutdown = false;
> +	while (1) {
> +		if (homa->next_client_port < HOMA_MIN_DEFAULT_PORT)
> +			homa->next_client_port = HOMA_MIN_DEFAULT_PORT;
> +		if (!homa_sock_find(socktab, homa->next_client_port))
> +			break;
> +		homa->next_client_port++;

It seems there might be a possibility of an infinite loop if all the
ports are in use.

> +	}
> +	hsk->port = homa->next_client_port;
> +	hsk->inet.inet_num = hsk->port;
> +	hsk->inet.inet_sport = htons(hsk->port);
> +	homa->next_client_port++;
> +	hsk->socktab_links.sock = hsk;
> +	hlist_add_head_rcu(&hsk->socktab_links.hash_links,
> +			   &socktab->buckets[homa_port_hash(hsk->port)]);
> +	INIT_LIST_HEAD(&hsk->active_rpcs);
> +	INIT_LIST_HEAD(&hsk->dead_rpcs);
> +	hsk->dead_skbs = 0;
> +	INIT_LIST_HEAD(&hsk->waiting_for_bufs);
> +	INIT_LIST_HEAD(&hsk->ready_requests);
> +	INIT_LIST_HEAD(&hsk->ready_responses);
> +	INIT_LIST_HEAD(&hsk->request_interests);
> +	INIT_LIST_HEAD(&hsk->response_interests);
> +	for (i = 0; i < HOMA_CLIENT_RPC_BUCKETS; i++) {
> +		struct homa_rpc_bucket *bucket = &hsk->client_rpc_buckets[i];
> +
> +		spin_lock_init(&bucket->lock);
> +		INIT_HLIST_HEAD(&bucket->rpcs);
> +		bucket->id = i;
> +	}
> +	for (i = 0; i < HOMA_SERVER_RPC_BUCKETS; i++) {
> +		struct homa_rpc_bucket *bucket = &hsk->server_rpc_buckets[i];
> +
> +		spin_lock_init(&bucket->lock);
> +		INIT_HLIST_HEAD(&bucket->rpcs);
> +		bucket->id = i + 1000000;
> +	}
> +	hsk->buffer_pool = kzalloc(sizeof(*hsk->buffer_pool), GFP_KERNEL);

using GFP_ATOMIC. I noticed that Homa frequently uses GFP_KERNEL with BH disabled.
Please fix it all.

> +	if (!hsk->buffer_pool)
> +		result = -ENOMEM;
> +	spin_unlock_bh(&socktab->write_lock);
> +	return result;
> +}
> +
> +/*
> -- 
> 2.34.1
> 

