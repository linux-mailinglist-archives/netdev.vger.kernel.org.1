Return-Path: <netdev+bounces-28830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD27780EE7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8091C21639
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DA718C25;
	Fri, 18 Aug 2023 15:17:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF4182BC
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 15:17:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9A63A9C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692371830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymeDjtpK/Bfq1NJqz0HPCsZOdauO6COV4txWMHbTX2Q=;
	b=bL7dlJTtvcUQ+wWJlJTYwoVxPaYJRqkejvwMTg3znGrTLbP3N+hyu0tgR1ZhvAd6G5EPl4
	95c/fduYYFC16HHwqjWSehwfdsH3CQmLLC5I8laENuD3oxppOsf/AoP55g3y/RfVJ/C2i5
	dSjwpklgpy5ivHEIsl+oxSkcgq2g5G0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-VS_3sUWdMJ-yRv5fyEE4Dg-1; Fri, 18 Aug 2023 11:17:08 -0400
X-MC-Unique: VS_3sUWdMJ-yRv5fyEE4Dg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1c4c13a9d44so1894589fac.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371828; x=1692976628;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymeDjtpK/Bfq1NJqz0HPCsZOdauO6COV4txWMHbTX2Q=;
        b=MZE+iMVt5rIfH1lcoJNWJTaLHEe2voJe4XDrAbGZyRPFTa6z8/Z6BVEjcu8kYrJ5cb
         srLqeNrrOsNV5HHBI7ELIVvPbipsq/KhBVvPU9CvsJrG6I00XFyShNukIl9634zUNBLP
         5JoHSi/o3Zl6jw+cVgPDeBFz2UsT77I5xB9ak7AImkY+HtPsRWi+U1ytrRzT8RHijVUN
         dKp8yag2cw34xG9ApZx+Uz3Vw8J4n25O6cDwdhnqr0t3UIho09+y1AyUbWy0yecHpzqR
         yH0Z/XCTb9pDW4m7EsuYNGhGmcO3WbzTFfk/5xESL6PpDnMfh4sETc09mI0zYRv/S6IP
         bFRA==
X-Gm-Message-State: AOJu0YybHFElJugayJSOCUNg4B7jpRrou5pTTxiKS9fuNWRMDi2sN/xX
	antLjO2JAPNDigcomlGZp2pxzDkSPU9yJP6s3GvBb9e6rCNQ2KgxRsM1Nlx30k1w++NxVZaxV9R
	8Vz7F+EG/3YpeHTyc
X-Received: by 2002:a05:6870:e814:b0:1bd:f37b:5e96 with SMTP id o20-20020a056870e81400b001bdf37b5e96mr1668435oan.23.1692371827976;
        Fri, 18 Aug 2023 08:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHay8XbyAQAbwd7G2dOy0MUw3oqeL5Wga6U21sC/U0kglgrRNHjCZgSg57WrRpg7pGwu0Gv8Q==
X-Received: by 2002:a05:6870:e814:b0:1bd:f37b:5e96 with SMTP id o20-20020a056870e81400b001bdf37b5e96mr1668426oan.23.1692371827740;
        Fri, 18 Aug 2023 08:17:07 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id n4-20020a056870a44400b001c4b8a9ef88sm1109415oal.24.2023.08.18.08.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:17:07 -0700 (PDT)
Date: Fri, 18 Aug 2023 09:17:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: <kvm@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
 <shannon.nelson@amd.com>
Subject: Re: [PATCH vfio] pds_core: Fix function header descriptions
Message-ID: <20230818091705.7e4d7d0e.alex.williamson@redhat.com>
In-Reply-To: <20230817224212.14266-1-brett.creeley@amd.com>
References: <20230817224212.14266-1-brett.creeley@amd.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 17 Aug 2023 15:42:12 -0700
Brett Creeley <brett.creeley@amd.com> wrote:

> The pds-vfio-pci series made a small interface change to
> pds_client_register() and pds_client_unregister(), but forgot to update
> the function header descriptions. Fix that.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308180411.OSqJPtMz-lkp@intel.com/
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>

I think we also want:

Fixes: b021d05e106e ("pds_core: Require callers of register/unregister to pass PF drvdata")

I'll add that on commit.  Thanks,

Alex

> ---
>  drivers/net/ethernet/amd/pds_core/auxbus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index 63d28c0a7e08..4ebc8ad87b41 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -8,7 +8,7 @@
>  
>  /**
>   * pds_client_register - Link the client to the firmware
> - * @pf_pdev:	ptr to the PF driver struct
> + * @pf:		ptr to the PF driver's private data struct
>   * @devname:	name that includes service into, e.g. pds_core.vDPA
>   *
>   * Return: 0 on success, or
> @@ -48,7 +48,7 @@ EXPORT_SYMBOL_GPL(pds_client_register);
>  
>  /**
>   * pds_client_unregister - Unlink the client from the firmware
> - * @pf_pdev:	ptr to the PF driver struct
> + * @pf:		ptr to the PF driver's private data struct
>   * @client_id:	id returned from pds_client_register()
>   *
>   * Return: 0 on success, or


