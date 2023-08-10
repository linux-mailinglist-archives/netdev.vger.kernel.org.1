Return-Path: <netdev+bounces-26258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938B17775A6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B335728202B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67111ED4E;
	Thu, 10 Aug 2023 10:22:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992BA3D71
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:22:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BB0B8
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691662934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MJzsp45aQWmMo96SK2IH9tLIZKf8yR7gHhfukdWV1k=;
	b=Fknqn5nWhb6eVeGQalsXqGNlWLXiw1QjOeF6Yc4CYasjujQVPc0k+8jmP8RnJvZk0DxxWP
	n4aOieLt1zEqVaMW1p3g96kQKt8POGdpUcpzPVf0Bpg5ClrcVqxejsrdLuqoKECumJAubp
	aFlVvlSGNZyeE2zBXB1CgGUgTQaOQvw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-FVHOCbxmPi-KjoaUR9oeaQ-1; Thu, 10 Aug 2023 06:22:13 -0400
X-MC-Unique: FVHOCbxmPi-KjoaUR9oeaQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a356c74e0so58449466b.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691662932; x=1692267732;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MJzsp45aQWmMo96SK2IH9tLIZKf8yR7gHhfukdWV1k=;
        b=ap4DbFvUfqxAiXwPS6TPE2P4CxJleYqYndrBP0nxfz7AQvF2/o9ALj0lNjpObKptV5
         h57EuT3Pa83YLwGOX2CoWt/qQuHikE6YFqFImJR5OQ/o8uDRDHNcKskZqU+e9YEuiDR1
         y0ZVQPUmbLDIPvVr6kYJysWTKdg1GQwTK4UdQMTFtzBqIu4YrfDCdXOSLaqeyWgmYK2m
         LJOUxPIyPCTBt2w+KY941Vx04gWkA1MjnyWepSgeGC4DCb/NK8ryXkB+r3Axyg7aiTRU
         7hablMkrsL/JWdE3Z5iAbz9VmDirjUPMUpvraP09a2Ic23eWwb4FdO9l62LEuCbc9uA0
         hl1w==
X-Gm-Message-State: AOJu0Yx3Wp8JBykUCcinfil5cfUV0OMM5p5D+4lT98A5s0r2eodiqRi5
	EqQMVhZlTnpBKtPiaCUzPEjf7n2i0idYeDiysNmrZ8GiQKuiva8qgeaqk92s6IzpQMdvxbgc3kL
	BZDg5pIO92oxvSrVw
X-Received: by 2002:a17:907:78d8:b0:992:d013:1132 with SMTP id kv24-20020a17090778d800b00992d0131132mr1526330ejc.1.1691662932322;
        Thu, 10 Aug 2023 03:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEIutXAhBgsqwyfmSLoRe6URqD1hvdlKgHc5Ppq9ZJpLWGK8k/IYZ2WxMc2VOLEBZDMieMUg==
X-Received: by 2002:a17:907:78d8:b0:992:d013:1132 with SMTP id kv24-20020a17090778d800b00992d0131132mr1526296ejc.1.1691662931791;
        Thu, 10 Aug 2023 03:22:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906348600b0099c157cba46sm717779ejb.119.2023.08.10.03.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:22:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AE4DBD3B809; Thu, 10 Aug 2023 12:22:10 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn.topel@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa
 <jolsa@kernel.org>, houtao1@huawei.com
Subject: Re: [RFC PATCH bpf-next 2/2] bpf, cpumap: Clean up
 bpf_cpu_map_entry directly in cpu_map_free
In-Reply-To: <20230728023030.1906124-3-houtao@huaweicloud.com>
References: <20230728023030.1906124-1-houtao@huaweicloud.com>
 <20230728023030.1906124-3-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 10 Aug 2023 12:22:10 +0200
Message-ID: <87fs4rfb8t.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> After synchronize_rcu(), both the dettached XDP program and
> xdp_do_flush() are completed, and the only user of bpf_cpu_map_entry
> will be cpu_map_kthread_run(), so instead of calling
> __cpu_map_entry_replace() to empty queue and do cleanup after a RCU
> grace period, do these things directly.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

With one nit below:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

> ---
>  kernel/bpf/cpumap.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 24f39c37526f..f8e2b24320c0 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -554,16 +554,15 @@ static void cpu_map_free(struct bpf_map *map)
>  	/* At this point bpf_prog->aux->refcnt =3D=3D 0 and this map->refcnt =
=3D=3D 0,
>  	 * so the bpf programs (can be more than one that used this map) were
>  	 * disconnected from events. Wait for outstanding critical sections in
> -	 * these programs to complete. The rcu critical section only guarantees
> -	 * no further "XDP/bpf-side" reads against bpf_cpu_map->cpu_map.
> -	 * It does __not__ ensure pending flush operations (if any) are
> -	 * complete.
> +	 * these programs to complete. synchronize_rcu() below not only
> +	 * guarantees no further "XDP/bpf-side" reads against
> +	 * bpf_cpu_map->cpu_map, but also ensure pending flush operations
> +	 * (if any) are complete.
>  	 */
> -
>  	synchronize_rcu();
>=20=20
> -	/* For cpu_map the remote CPUs can still be using the entries
> -	 * (struct bpf_cpu_map_entry).
> +	/* The only possible user of bpf_cpu_map_entry is
> +	 * cpu_map_kthread_run().
>  	 */
>  	for (i =3D 0; i < cmap->map.max_entries; i++) {
>  		struct bpf_cpu_map_entry *rcpu;
> @@ -572,8 +571,8 @@ static void cpu_map_free(struct bpf_map *map)
>  		if (!rcpu)
>  			continue;
>=20=20
> -		/* bq flush and cleanup happens after RCU grace-period */
> -		__cpu_map_entry_replace(cmap, i, NULL); /* call_rcu */
> +		/* Empty queue and do cleanup directly */

The "empty queue" here is a bit ambiguous, maybe "Stop kthread and
cleanup entry"?

> +		__cpu_map_entry_free(&rcpu->free_work.work);
>  	}
>  	bpf_map_area_free(cmap->cpu_map);
>  	bpf_map_area_free(cmap);
> --=20
> 2.29.2


