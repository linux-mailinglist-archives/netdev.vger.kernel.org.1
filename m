Return-Path: <netdev+bounces-43579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE6B7D3EFF
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89B62812E1
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545621370;
	Mon, 23 Oct 2023 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NyvvKiLG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9A1BDC6
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:19:22 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3B18F
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:19:20 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-581b6b93bd1so2160615eaf.1
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698085160; x=1698689960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yhnxnJ0EZnskjvE/QTX7vSmqovRzfbb8ia1T/C3p/w=;
        b=NyvvKiLGkDipoUL+ktH5jSIOJQ7BjzCz/p4tcrLcYT25HeQx2iZzxeo+EQbcRNJWZv
         1F5fqWQ507lJTujJPuPYnj2vEX/UsbaSYldUCBKL2+hQypZG6TMGxLtaMmBSTjTRGUQB
         zRMDjZkMtVck9txkdna0lhf/Ve/EK1PFB6qZQEsZHdEMGujYXNju0BgEBw0CIW/xyZcr
         KneBTqOvNWPsUW6NuxHMS10GZopv2hyKQMvRN1pc2rblJWY4NMf0K4zyCkLV4wtxSuxb
         3eL4Iok9kMl917iJ+aMFbjerKOwrf112D5zLT2/Q5q/dxweZYq4WnKZnoTGMNREXDnFA
         8cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085160; x=1698689960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yhnxnJ0EZnskjvE/QTX7vSmqovRzfbb8ia1T/C3p/w=;
        b=XP2vCj7nSq5t2KQJ9Q6F9v4fRPHGFCB+HxC50n4EgIl6D4hQmKnZcDVWMrR/gUNvHy
         +DBb87BxlssSOfk7p8sjH3WlM5tkQKMl9Q47Vhg49gkqK49BDryxyBPVDEipNHNFxsCp
         LuW1mVpqAi4oaPoK0GeOKsqtXFwzVJCfZHzSwAoQa/taMP1LfIoN2GartGwyGpMBBW6n
         TZ4bBeeJlGPvlLVKGXMm2t/6FIIcegI5tVXOOHUjyuaDFW59XVaIFAWM9rxxYBurUoXS
         n3YnLEmLEbcP6HFqIZ0anm4sqLFAalnbpJ0QW//M84nHgxfw9CNugMDXRFt+2V2osIjK
         vGzw==
X-Gm-Message-State: AOJu0Yw6M/UAQJ//gdUVEfZYzrCvMMpGpXuNjB7fG0OIHCh8nbV9hf3e
	Ms+viuI1sD4Xz8hCHbDXX0neYA==
X-Google-Smtp-Source: AGHT+IGdDXmlG8NU9SWCpEcJVTGZGo8oiVXha6x2olGHUS9he9wLHOzuwKgBBQJwmlQ8KyiRplOMwA==
X-Received: by 2002:a4a:e782:0:b0:56e:466c:7393 with SMTP id x2-20020a4ae782000000b0056e466c7393mr9638941oov.5.1698085159795;
        Mon, 23 Oct 2023 11:19:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id y22-20020a4ade16000000b0057b38a94f38sm1591165oot.12.2023.10.23.11.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:19:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1quzWI-003jPw-9O;
	Mon, 23 Oct 2023 15:19:18 -0300
Date: Mon, 23 Oct 2023 15:19:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: sharmaajay@linuxonhyperv.com
Cc: Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v7 2/5] RDMA/mana_ib: Register Mana IB  device with
 Management SW
Message-ID: <20231023181918.GJ691768@ziepe.ca>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-3-git-send-email-sharmaajay@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697494322-26814-3-git-send-email-sharmaajay@linuxonhyperv.com>

On Mon, Oct 16, 2023 at 03:11:59PM -0700, sharmaajay@linuxonhyperv.com wrote:

> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index 083f27246ba8..ea4c8c8fc10d 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -78,22 +78,34 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  	mib_dev->ib_dev.num_comp_vectors = 1;
>  	mib_dev->ib_dev.dev.parent = mdev->gdma_context->dev;
>  
> -	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
> -				 mdev->gdma_context->dev);
> +	ret = mana_gd_register_device(&mib_dev->gc->mana_ib);
>  	if (ret) {
> -		ib_dealloc_device(&mib_dev->ib_dev);
> -		return ret;
> +		ibdev_err(&mib_dev->ib_dev, "Failed to register device, ret %d",
> +			  ret);
> +		goto free_ib_device;
>  	}
>  
> +	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
> +				 mdev->gdma_context->dev);
> +	if (ret)
> +		goto deregister_device;
> +
>  	dev_set_drvdata(&adev->dev, mib_dev);
>  
>  	return 0;
> +
> +deregister_device:
> +	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
> +free_ib_device:
> +	ib_dealloc_device(&mib_dev->ib_dev);
> +	return ret;
>  }
>  
>  static void mana_ib_remove(struct auxiliary_device *adev)
>  {
>  	struct mana_ib_dev *mib_dev = dev_get_drvdata(&adev->dev);
>  
> +	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
>  	ib_unregister_device(&mib_dev->ib_dev);
>  	ib_dealloc_device(&mib_dev->ib_dev);
>  }

That's definitely in the wrong order

Are you shure these things should just be part of
ops->enable_driver/dealloc_driver?

> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 189e774cdab6..2c4e3c496644 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -8,7 +8,7 @@
>  void mana_ib_uncfg_vport(struct mana_ib_dev *mib_dev, struct mana_ib_pd *pd,
>  			 u32 port)
>  {
> -	struct gdma_dev *gd = mib_dev->gdma_dev;
> +	struct gdma_dev *gd = &mib_dev->gc->mana;

What is this stuff doing in this patch? Make another patch if you want
to remove gdma_dev

Jason

