Return-Path: <netdev+bounces-256904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EJAIyH2g2kwwQMAu9opvQ
	(envelope-from <netdev+bounces-256904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:45:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED44BEDC16
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8A6C3015C9C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 01:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0929B799;
	Thu,  5 Feb 2026 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaOS7f4Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BBD299A82
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255893; cv=none; b=DILdhQ/FABazVaH9yjI55/IlzlTMRS7QNbS6xORUUAsKH5sv1y3L62tvwxspa9zqfAFsbh2WzIiVabLrTY9YijiUpgZkUHQpdNCKutST2deyH2hz/TJx+2ooha8+phK4Xc0FG30wxQo6/UOYdpIaQJbKNqcUDFywglbS2YVpNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255893; c=relaxed/simple;
	bh=cWR+NIQC8+IVnYP1ihJqr42Zfi0tIf6rTJpVE9edZSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm1f7nEs87S5wv2S9GATJQu92VvSta8OAmdxNJfYb1ZceRidr9fNX2a3ZoCh6DdBUlta3PKbNChtek6t4KLpGCKCRzTpQLclW2h6izN7ZGyOJvah2OX7SRgLu1y37kORgSRkRbB3EpuxQVYytdQgHnVabL9NcAOWhQWBZrgpLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaOS7f4Y; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-794719afcd4so4304427b3.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 17:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770255892; x=1770860692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdGCHRhz9ScFkBVtx8D0sOJfkRC6ABYnYH3vsQn15cg=;
        b=BaOS7f4YUR52RNKddY0rK8v77BahslndHZvoq306oEQAlz9Gbaq2k5Cz1cupzgI2dT
         xj9D7pLDWXLIw+pi8bilyP7Nhl5dQoYgwK4sBpwiMzt5E9OfZC0oRE3BSNcOJf7OGk55
         6mcrzs0qJdG/9uSUBDZ1imzd6YtMDj9i8kxfQFwjH+6fCUKK204vol2xXAdh2lUtQq3N
         yf2oN7l7za5ajLgeYxqAJWc8Q1ZFfU35E44UfoNvPz3yUqWqDM/3d2B30ktqazCez05u
         AI6k0GInoto/wRt6WqUuWN+ndgmHsQtiqtKsgv+g6ev22HUpekga9SywUD6jeD5T9p81
         xQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770255892; x=1770860692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdGCHRhz9ScFkBVtx8D0sOJfkRC6ABYnYH3vsQn15cg=;
        b=YPfN2xry1zqnzwoTn80o3XoMLoZmchcKSZrEPux4rQw2jAgPpuUmww1lwi2yLCy9mE
         GDvWY292AJKs0FmquP0WoXp4WEGcBuIO+7BE1K9wUQiS6it3xvKlvi9fXV9htm1D4uiB
         0MDoYLvKJbV4SZWNKh2RbpUtQOmj4mik1gk6ssMLw+4YwY8ltYZPwm9mKqZOr4jseHsC
         opViun+1VdZcitU3J+hCQN9ZtvTLPIrRuR2/AXPMWD32pWhZX1j3GBluZlTA/04DhmSY
         B+vXfEw+RKqlY6Y8KSczMYSBYxBNwZ0ve+Ts7ScnD/us5mHUkKhJNN9IbDUz46Mmrv12
         XbGw==
X-Gm-Message-State: AOJu0YxWkpQcgD8o44IuzqEjPsHHaDS/meZLm1+0ppNdTIEyEidLTqhn
	Y6I1OZcgMkG4vffZF5tdunaDq1G2kHGPe1uFMX+jmyvjIZ4VaozGfk7c
X-Gm-Gg: AZuq6aJQx69c3E0ekh08BRSLeD/P1EyUBbuclAGFIWW2hq6nNG2voHS/4rUpYKExkIv
	jGVkp35tjYsCnsOI5kdqUSsYWQ7gtcgPMdRW6rNPfyfSJWfA3qB+I/PFHu8JIZgnRaEtCVLvRXz
	t/g+WzOhNz1vOjbZLjFJxZ76gIObHD6R5G9GteQrozOrsKrZkYmLMQB24qLsts8vHYkgdGXuyES
	Zm0HiR/XCM0CW5jB8ofE4DKVtpWeGrfiAIbBl3pOJW/EkD86A8dGk+UI12ZsHy5GP0uys769B5H
	VXBEKaMM5WFlNGoyDjzuFaUqPrzXoXhlINRrCdKxdaJ6eZS5zZ352iRhOzoufhwfhtPTG2zWpWt
	4Nghb0hGStcKf+UkNKeNfM62rSkXm6Pvm4TeN/mQkzuMEPv+czMAE2+rNL3fLLBZ4yi5tA9Ll4r
	UoTdnY3iJyGtToHhrRCAKuFn8sB7krztURqA==
X-Received: by 2002:a05:690c:2fc7:b0:794:c5b8:7d13 with SMTP id 00721157ae682-794fe63f559mr29250637b3.11.1770255891860;
        Wed, 04 Feb 2026 17:44:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794fefd00b5sm34815287b3.43.2026.02.04.17.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 17:44:51 -0800 (PST)
Date: Wed, 4 Feb 2026 17:44:48 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 16/16] selftests/net: Add netkit container
 tests
Message-ID: <aYP2EO8RANz+zCJi@devvm11784.nha0.facebook.com>
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-17-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129222830.439687-17-daniel@iogearbox.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256904-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nk_qlease.py:url,irq.py:url,loopback.sh:url,davidwei.uk:email,rss_api.py:url,nic_timestamp.py:url]
X-Rspamd-Queue-Id: ED44BEDC16
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:28:30PM +0100, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add two tests using NetDrvContEnv. One basic test that sets up a netkit
> pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
> program to ping from a remote host to the netkit in netns.
> 
> Second is a selftest for netkit queue leasing, using io_uring zero copy
> test binary inside of a netns with netkit. This checks that memory
> providers can be bound against virtual queues in a netkit within a
> netns that are leasing from a physical netdev in the default netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |  2 +
>  .../selftests/drivers/net/hw/nk_netns.py      | 23 +++++
>  .../selftests/drivers/net/hw/nk_qlease.py     | 90 +++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
>  create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 9c163ba6feee..39ad86d693b3 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -32,6 +32,8 @@ TEST_PROGS = \
>  	irq.py \
>  	loopback.sh \
>  	nic_timestamp.py \
> +	nk_netns.py \
> +	nk_qlease.py \
>  	pp_alloc_fail.py \
>  	rss_api.py \
>  	rss_ctx.py \

I think we might also need something like:

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index 2307aa001be1..334be5027a7c 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -5,6 +5,7 @@ CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
+CONFIG_NETKIT=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_UDMABUF=y


Best,
Bobby

