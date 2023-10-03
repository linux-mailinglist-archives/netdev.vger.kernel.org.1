Return-Path: <netdev+bounces-37625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726267B65FD
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7E26E281605
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C407D15E9C;
	Tue,  3 Oct 2023 10:04:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59351DDC9
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:04:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEBEA6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 03:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696327457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfgzT7dblsbnLe9E8D8npioQvHy4Ol8QEwV/2aJSdcY=;
	b=WCSCJ7TjjNpDQlgdSaf7uBcIdzouzaTUis3OY0e24kHv7Cm536B5Qxzgv3QCfJLurOQsf3
	uDXVL2/8pMfG8STm9k1nP/cTYcNWXQeLST24ilncjPmNtFaK/eltWJsmjHrsXvbFYHFsi7
	EwFSoOXFTaGfKg0u9K2u24YZ0C1pmL4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-RAe7GTOpN0mXA9FTqvrFZg-1; Tue, 03 Oct 2023 06:04:06 -0400
X-MC-Unique: RAe7GTOpN0mXA9FTqvrFZg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5361af5eb40so127860a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 03:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696327445; x=1696932245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfgzT7dblsbnLe9E8D8npioQvHy4Ol8QEwV/2aJSdcY=;
        b=mLoygi6G9t0OUzPZkpOmK1puLGFvAEdi1XF9jhVW7InJVz+aXMb9mE2PKe7Zu6cjpJ
         20GNHaPkDXvHmVwnkd/dKrSs8vL/Nut3RLJ2XApJtN9N9AOgz7Cixz/fzRUp7HUbOIJw
         mYnwJnhCnr4NlgnhBqyLVP7uju/nVqzCNLVX90nhK2p/7kKsU06Aw7CcafzzLvLzDy+b
         kk4IgbeFM930FDrQWcqOeeYFAfOSkLSFX7YepdR354LDxL3hIE5b8E4cVBSFXK26QoCX
         qjmTKcvDVMhe6JEaqMtjknDlIW6A7BzeFzRAS15WoSAvmB/+MHNNPZPygKJW4nrdU3zw
         aaQw==
X-Gm-Message-State: AOJu0YxzwvJsN35OtjAy0X1vRXPsWj4qSFvTqMweGqPv/8z5rRYVhvUV
	w1zI9JvsXOaI16cezn6J0Vm8bnQjTcy04wMSmw/X/Ty8h1sE3ZN9wf2soAIIbDlDKhuvGPZgZCS
	6rNPyK+1mRB76aIWn
X-Received: by 2002:a05:6402:42c7:b0:51e:5dd8:fc59 with SMTP id i7-20020a05640242c700b0051e5dd8fc59mr14600420edc.1.1696327445038;
        Tue, 03 Oct 2023 03:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKo/lsiY8VL6sFsslqGDy+eu1dcCABvmDtzR1hIGuq84a0yGZ62b+pvxxgewsKJG/LfHcPZw==
X-Received: by 2002:a05:6402:42c7:b0:51e:5dd8:fc59 with SMTP id i7-20020a05640242c700b0051e5dd8fc59mr14600381edc.1.1696327444638;
        Tue, 03 Oct 2023 03:04:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id m3-20020aa7d343000000b00530ccd180a3sm600522edr.97.2023.10.03.03.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:04:03 -0700 (PDT)
Message-ID: <2fd12c42d3dd60b2e9b56e9f7dd37d5f994fd9ac.camel@redhat.com>
Subject: Re: [PATCH 1/4] net: mellanox: drop mlx5_cpumask_default_spread()
From: Paolo Abeni <pabeni@redhat.com>
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Valentin Schneider
 <vschneid@redhat.com>, Maher Sanalla <msanalla@nvidia.com>, Ingo Molnar
 <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,  Daniel Bristot de
 Oliveira <bristot@redhat.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Yury Norov <ynorov@nvidia.com>
Date: Tue, 03 Oct 2023 12:04:01 +0200
In-Reply-To: <20230925020528.777578-2-yury.norov@gmail.com>
References: <20230925020528.777578-1-yury.norov@gmail.com>
	 <20230925020528.777578-2-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 2023-09-24 at 19:05 -0700, Yury Norov wrote:
> The function duplicates existing cpumask_local_spread(), and it's O(N),
> while cpumask_local_spread() implementation is based on bsearch, and
> thus is O(log n), so drop mlx5_cpumask_default_spread() and use generic
> cpumask_local_spread().
>=20
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 28 ++------------------
>  1 file changed, 2 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/e=
thernet/mellanox/mlx5/core/eq.c
> index ea0405e0a43f..bd9f857cc52d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -828,30 +828,6 @@ static void comp_irq_release_pci(struct mlx5_core_de=
v *dev, u16 vecidx)
>  	mlx5_irq_release_vector(irq);
>  }
> =20
> -static int mlx5_cpumask_default_spread(int numa_node, int index)
> -{
> -	const struct cpumask *prev =3D cpu_none_mask;
> -	const struct cpumask *mask;
> -	int found_cpu =3D 0;
> -	int i =3D 0;
> -	int cpu;
> -
> -	rcu_read_lock();
> -	for_each_numa_hop_mask(mask, numa_node) {
> -		for_each_cpu_andnot(cpu, mask, prev) {
> -			if (i++ =3D=3D index) {
> -				found_cpu =3D cpu;
> -				goto spread_done;
> -			}
> -		}
> -		prev =3D mask;
> -	}
> -
> -spread_done:
> -	rcu_read_unlock();
> -	return found_cpu;
> -}
> -
>  static struct cpu_rmap *mlx5_eq_table_get_pci_rmap(struct mlx5_core_dev =
*dev)
>  {
>  #ifdef CONFIG_RFS_ACCEL
> @@ -873,7 +849,7 @@ static int comp_irq_request_pci(struct mlx5_core_dev =
*dev, u16 vecidx)
>  	int cpu;
> =20
>  	rmap =3D mlx5_eq_table_get_pci_rmap(dev);
> -	cpu =3D mlx5_cpumask_default_spread(dev->priv.numa_node, vecidx);
> +	cpu =3D cpumask_local_spread(vecidx, dev->priv.numa_node);
>  	irq =3D mlx5_irq_request_vector(dev, cpu, vecidx, &rmap);
>  	if (IS_ERR(irq))
>  		return PTR_ERR(irq);
> @@ -1125,7 +1101,7 @@ int mlx5_comp_vector_get_cpu(struct mlx5_core_dev *=
dev, int vector)
>  	if (mask)
>  		cpu =3D cpumask_first(mask);
>  	else
> -		cpu =3D mlx5_cpumask_default_spread(dev->priv.numa_node, vector);
> +		cpu =3D cpumask_local_spread(vector, dev->priv.numa_node);
> =20
>  	return cpu;
>  }

It looks like this series is going to cause some later conflicts
regardless of the target tree. I think the whole series could go via
the net-next tree, am I missing any relevant point?

Thanks!

Paolo


