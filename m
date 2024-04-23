Return-Path: <netdev+bounces-90422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1873B8AE144
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F22286134
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AF859161;
	Tue, 23 Apr 2024 09:46:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585A56B9D
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865574; cv=none; b=EpWIPxBJlvcGwC2NKV4Gc6/pZrNLmGwSXvy3t3tsFAs1TBtPf3sU6o1ISZ9lVT2ClqKP8FqoXeZp7KVqfeWnD08N7GBBxLsPBSHl+/220CuMIqyh3i1JczPzd/w6qG2+v1s/jaqnukaDf526WFHm6mpcnQz3EqqX77mFoLjb2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865574; c=relaxed/simple;
	bh=EK8RgrkSOuNRH+VkwUBDDAnxumIravlAz8SWG7Yw9Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWGCSLBm5asCsavUNZ+fUeAlQw9pqb/vxMmOcoEqNVnZNOqH2Lnoh3SS0P4lhBc4TBcyLQCO3pQWJ+EboRM30EliMZLEJ6ZR2D2AmRjRXDwL4zr06nNYBGpb+QAA6hEsZE60fczYng1rkG1YiS2a+YFE6R5JDmCNCQ4B2TyT7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a55bf737cecso180782966b.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 02:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713865571; x=1714470371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YeCj3/tQUe0Xc+ezUs59X1KgInMnJK3zSVxyGZF1Yk=;
        b=EsAr7vR7L4G/4uUXGBmfN1HbhIbSw+E2/8sH7VUhuKTBQ48LipPJh0QohEYgyNQeg3
         h2/dIv65vgfmsULsvEOKkVzLD7RnyKfM9SSYDNAgOnp+CmvGi234cr0WhNDeL9ruCVTf
         RCVDPZxq3A+D1+1RrLM2ue9MBK00L4j46Wy7VpSzImh/5M5FaSAyS55+Mqgp6pP/9vjb
         fzX8TKBUy7hPS065F9Ok3RN4j8oepXTyS1m2FZ8Ii+PDm9TQ7xCKnbi0Fmit1un5ZlbQ
         S5dBptB7xRvvDRZGran0fpSAe6enu5mpFe++mwoJ6TDGQguE/kbZr/9RW+S/5XqyySAv
         M81w==
X-Gm-Message-State: AOJu0YyeORkV+JHI20nu3I69t52iPEM2LdYfr8wn84AS4oNolvtUBnre
	T6XTmQSmnSYiZ9qiG6HyiB7FNotl9doIl7qMt8zfvfnqAsrgMVd3
X-Google-Smtp-Source: AGHT+IEmv7eJOQjqfY2okIiUWBZg8DRTCC2CqN8l25kseBihjKHO8EMXlpQT4ALdq4HTq1BZHcHjaA==
X-Received: by 2002:a17:906:905:b0:a52:4d96:85e with SMTP id i5-20020a170906090500b00a524d96085emr7775786ejd.53.1713865571216;
        Tue, 23 Apr 2024 02:46:11 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id x21-20020a170906299500b00a5875dd74c2sm959741eje.131.2024.04.23.02.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:46:10 -0700 (PDT)
Date: Tue, 23 Apr 2024 02:46:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] ip6_vti: fix memleak on netns dismantle
Message-ID: <ZieDYD5ibpGjlIRw@gmail.com>
References: <20240415122346.26503-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415122346.26503-1-fw@strlen.de>

Hello Florian,

On Mon, Apr 15, 2024 at 02:23:44PM +0200, Florian Westphal wrote:
> kmemleak reports net_device resources are no longer released, restore
> needs_free_netdev toggle.  Sample backtrace:
> 
> unreferenced object 0xffff88810874f000 (size 4096): [..]
>     [<00000000a2b8af8b>] __kmalloc_node+0x209/0x290
>     [<0000000040b0a1a9>] alloc_netdev_mqs+0x58/0x470
>     [<00000000b4be1e78>] vti6_init_net+0x94/0x230
>     [<000000008830c1ea>] ops_init+0x32/0xc0
>     [<000000006a26fa8f>] setup_net+0x134/0x2e0
> [..]
> 
> Cc: Breno Leitao <leitao@debian.org>
> Fixes: a9b2d55a8f1e ("ip6_vti: Do not use custom stat allocator")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/ipv6/ip6_vti.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> index 4d68a0777b0c..78344cf3867e 100644
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -901,6 +901,7 @@ static void vti6_dev_setup(struct net_device *dev)
>  {
>  	dev->netdev_ops = &vti6_netdev_ops;
>  	dev->header_ops = &ip_tunnel_header_ops;
> +	dev->needs_free_netdev = true;

Thanks for the fix!

Could you help me to understand how needs_free_netdev will trigger the
free()here?

I _though_ that any device that is being unregistered would have the stats
freed.

This is the flow I am reading:

1) When the device is unregistered, then it is marked as todo:

	unregister_netdevice_many_notify() {
		list_for_each_entry(dev, head, unreg_list) {
			net_set_todo(dev);
		}
	}

2) Then, "run_todo" will run later, and it does:
	netdev_run_todo() {
		list_for_each_entry_safe(dev, tmp, &list, todo_list) {
		if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
			netdev_WARN(dev, "run_todo but not unregistering\n");
			list_del(&dev->todo_list);
			continue;
		}

		while (!list_empty(&list)) {
			netdev_do_free_pcpu_stats(dev);
		}

	}

Thank you!

