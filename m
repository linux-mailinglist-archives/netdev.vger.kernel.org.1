Return-Path: <netdev+bounces-63710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED94A82EF91
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 14:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865BD1F24D8C
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7541BC40;
	Tue, 16 Jan 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLCQ6n4k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45A1BDC2
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705410918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WI664CwiFfrGDN1gZMoEqTeGnvPzqmrpes8IX8DTN08=;
	b=SLCQ6n4kTApWRZ8S9pSjcZ2XGxpS2zwN5FK6NGKYtpVcgZU6RfoVU1u2//EgNsHHwD5GTA
	BesC4AOWCOQ6NfJFXmMOnGidrG3YUEkWO/6RVfCEH7sXSOOaggBvMZpFhuhJro8Y7efzJj
	XIsiEajR5m75aL6BdsrTEzlpB3ew/uA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-7t4cyfO1OGqHvM4zNX_AYQ-1; Tue, 16 Jan 2024 08:15:16 -0500
X-MC-Unique: 7t4cyfO1OGqHvM4zNX_AYQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-337a9795c5cso1366103f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 05:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705410915; x=1706015715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI664CwiFfrGDN1gZMoEqTeGnvPzqmrpes8IX8DTN08=;
        b=cfpZ2smFNP6kh/gr45b1+FPb8S76yxRMxQ5UWnnNYqsQml5ik409PIpfAFOT1eeFJD
         +8fVEzFMd0KHYUBNICHwKv+9jUQ8PkfufHy81T29SdbdWRWP+RbIM3GTvQRwKNrkMRRB
         Uz6eD+S2W8eJNz0gHtkbGWf8yRmB0E4uzrueQ0t8VcGStdpZnJ1em/eoDu0aHxzaF3EK
         y1eglRpWsywZ3FSYjKYzFxHjGncAQ2Lrkxknbx23ic1qcByxo3PLn+rH4gePkGAf+aFI
         kQqhDmccrDP5LCynV729Kplhh38wUiQMTDA7xlAggNWnvHir8wWMS/z2tYoGUJJbMwdj
         NUVA==
X-Gm-Message-State: AOJu0YxCJdMjbgN8qNXvjleNdx3CIeC5DvcpO/YGSE+r0Yh2qzc8wuSB
	x92Pkrm9e+uvZwKZfhqga5ZAVkxNc2iMerzyDzDnrPvJ/l6G8FKDrrTFBI4WfJUr+BQ+18ctfJN
	x5oyTUfKb6Zxz9YuNz3FJbN1s
X-Received: by 2002:a7b:cd15:0:b0:40e:46f5:e5ef with SMTP id f21-20020a7bcd15000000b0040e46f5e5efmr2815406wmj.21.1705410914987;
        Tue, 16 Jan 2024 05:15:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUFiMiTWk4bUINhKfc0247wBh/bRaZbbmaxFbHP+hCcvjwqqLmh5eYjPZIgFNnXOOJe7av2g==
X-Received: by 2002:a7b:cd15:0:b0:40e:46f5:e5ef with SMTP id f21-20020a7bcd15000000b0040e46f5e5efmr2815401wmj.21.1705410914679;
        Tue, 16 Jan 2024 05:15:14 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e45799541sm23113390wmo.15.2024.01.16.05.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 05:15:13 -0800 (PST)
Date: Tue, 16 Jan 2024 08:15:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 1/3] virtio-net: fix possible dim status
 unrecoverable
Message-ID: <20240116081442-mutt-send-email-mst@kernel.org>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
 <1705410693-118895-2-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705410693-118895-2-git-send-email-hengqi@linux.alibaba.com>

On Tue, Jan 16, 2024 at 09:11:31PM +0800, Heng Qi wrote:
> When the dim worker is scheduled, if it fails to acquire the lock,
> dim may not be able to return to the working state later.
> 
> For example, the following single queue scenario:
>   1. The dim worker of rxq0 is scheduled, and the dim status is
>      changed to DIM_APPLY_NEW_PROFILE;
>   2. The ethtool command is holding rtnl lock;
>   3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
>      to acquire the lock and exits;
> 
> Then, even if net_dim is invoked again, it cannot work because the
> state is not restored to DIM_START_MEASURE.
> 
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
> Belongs to the net branch.
> 
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1..f6ac3e7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3524,8 +3524,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>  	struct dim_cq_moder update_moder;
>  	int i, qnum, err;
>  
> -	if (!rtnl_trylock())
> +	if (!rtnl_trylock()) {
> +		schedule_work(&dim->work);
>  		return;
> +	}
>  
>  	/* Each rxq's work is queued by "net_dim()->schedule_work()"
>  	 * in response to NAPI traffic changes. Note that dim->profile_ix

OK but this means that in cleanup it is not sufficient to flush
dim work - it can requeue itself.


> -- 
> 1.8.3.1


