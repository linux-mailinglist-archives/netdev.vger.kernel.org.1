Return-Path: <netdev+bounces-20656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BF7760670
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 05:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507811C20D80
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BFE20F6;
	Tue, 25 Jul 2023 03:12:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB831FD1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:12:41 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3819B4
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:05:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-268160d99ccso259900a91.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690254325; x=1690859125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niSMZqBCvW/Me9jsMaxXz5gtuZ44llk1Ot3soT0LhIs=;
        b=FniJo6cfZiXO48N3LrJPbrRtsXuGwEsrxL+rPNcNzpIfBU8e0vwfaKRVcngIxQ6/Nq
         uV6IwXjWItzg/7IWT04hxNl0ft8u0yvH7EyRJ6POcXsP6dFyjR2vvuievKT7V7wXKj9i
         Hs4OFXg82m4uyRZZDGIHYrUPf7Daiin7owJFDMH9ALFzGhGiMR/jo54iE9PQ2yCszEax
         GduXKZlfrLf0f1lI69b+SeFKsM1fBAPgAwEi9/QiPJB5pr3rcwSAawR7U6Bt6cbBHX1B
         l+6jljnScvspLgnoIuyzCCNBX+9PGgFUwcZiZbmROS7agCNCVVXov8LOv0CsZfjvTopq
         9j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690254325; x=1690859125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niSMZqBCvW/Me9jsMaxXz5gtuZ44llk1Ot3soT0LhIs=;
        b=aEn9oxj8RI67hPJ23AuAY6Okdb0GfZEQnc3C1l3qojONA0JxBSAPA6oh2KzGVkjOJh
         GZZv5ZUHkdO79VYsXmi94cSf3u5VxF6TsPtRH3nA2Yx4ifF+pzpC2vhOtu9R8pnoBsM0
         nJvulbBv+eabFUVJkDNxSyhpH2wvyFIo1fQPMuTHNNaxU1JSV1d5u5AoXxOgkJkdSJ7G
         e5/B3Fyt46czIGuCkg1h/CZgFUdgKLlOFmNzbLPMzvry5D009Dsau39EbDTyKpXzMZp5
         Vjf2aayAOoDDkgAeagjv5WkCplMDnIroDRTwiVaDh0FaD+ydQVpHAh2nVouBvG02TUEk
         pdpA==
X-Gm-Message-State: ABy/qLZH/oAYixty7zTNyF0VXFw8PB06SG18vJe40yB0eZL0sqBWiyvA
	Zett0YkWdMtwmSzwWgztXFYbEw==
X-Google-Smtp-Source: APBJJlFB/cQTGj3IlIfGF+HAM8hU50IJB+Lr29ujA3cHbbDSAB3N90HdGCOpa8iydTeMw+f8qxyL2Q==
X-Received: by 2002:a17:90a:1d46:b0:268:abc:83d5 with SMTP id u6-20020a17090a1d4600b002680abc83d5mr6012554pju.4.1690254324674;
        Mon, 24 Jul 2023 20:05:24 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:1c25:884:3ed:e1db:b610? ([2408:8000:b001:1:1f:58ff:f102:103])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090aba8a00b002681d44071csm2043968pjr.46.2023.07.24.20.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 20:05:24 -0700 (PDT)
Message-ID: <6049aa99-aa47-5137-f66e-350bc4723914@bytedance.com>
Date: Tue, 25 Jul 2023 11:05:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 24/47] drm/panfrost: dynamically allocate the
 drm-panfrost shrinker
Content-Language: en-US
To: Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
 linux-mtd@lists.infradead.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
 roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
 paulmck@kernel.org, tytso@mit.edu, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-25-zhengqi.arch@bytedance.com>
 <cdd08c9e-81d3-a85f-5426-5db738aa73ec@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <cdd08c9e-81d3-a85f-5426-5db738aa73ec@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Steven,

On 2023/7/24 19:17, Steven Price wrote:
> On 24/07/2023 10:43, Qi Zheng wrote:
>> In preparation for implementing lockless slab shrink, use new APIs to
>> dynamically allocate the drm-panfrost shrinker, so that it can be freed
>> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
>> read-side critical section when releasing the struct panfrost_device.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> One nit below, but otherwise:
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
>>   drivers/gpu/drm/panfrost/panfrost_drv.c       |  6 +++-
>>   drivers/gpu/drm/panfrost/panfrost_gem.h       |  2 +-
>>   .../gpu/drm/panfrost/panfrost_gem_shrinker.c  | 32 ++++++++++++-------
>>   4 files changed, 27 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
>> index b0126b9fbadc..e667e5689353 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
>> @@ -118,7 +118,7 @@ struct panfrost_device {
>>   
>>   	struct mutex shrinker_lock;
>>   	struct list_head shrinker_list;
>> -	struct shrinker shrinker;
>> +	struct shrinker *shrinker;
>>   
>>   	struct panfrost_devfreq pfdevfreq;
>>   };
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
>> index bbada731bbbd..f705bbdea360 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
>> @@ -598,10 +598,14 @@ static int panfrost_probe(struct platform_device *pdev)
>>   	if (err < 0)
>>   		goto err_out1;
>>   
>> -	panfrost_gem_shrinker_init(ddev);
>> +	err = panfrost_gem_shrinker_init(ddev);
>> +	if (err)
>> +		goto err_out2;
>>   
>>   	return 0;
>>   
>> +err_out2:
>> +	drm_dev_unregister(ddev);
>>   err_out1:
>>   	pm_runtime_disable(pfdev->dev);
>>   	panfrost_device_fini(pfdev);
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
>> index ad2877eeeccd..863d2ec8d4f0 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
>> @@ -81,7 +81,7 @@ panfrost_gem_mapping_get(struct panfrost_gem_object *bo,
>>   void panfrost_gem_mapping_put(struct panfrost_gem_mapping *mapping);
>>   void panfrost_gem_teardown_mappings_locked(struct panfrost_gem_object *bo);
>>   
>> -void panfrost_gem_shrinker_init(struct drm_device *dev);
>> +int panfrost_gem_shrinker_init(struct drm_device *dev);
>>   void panfrost_gem_shrinker_cleanup(struct drm_device *dev);
>>   
>>   #endif /* __PANFROST_GEM_H__ */
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
>> index bf0170782f25..9a90dfb5301f 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
>> @@ -18,8 +18,7 @@
>>   static unsigned long
>>   panfrost_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
>>   {
>> -	struct panfrost_device *pfdev =
>> -		container_of(shrinker, struct panfrost_device, shrinker);
>> +	struct panfrost_device *pfdev = shrinker->private_data;
>>   	struct drm_gem_shmem_object *shmem;
>>   	unsigned long count = 0;
>>   
>> @@ -65,8 +64,7 @@ static bool panfrost_gem_purge(struct drm_gem_object *obj)
>>   static unsigned long
>>   panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>>   {
>> -	struct panfrost_device *pfdev =
>> -		container_of(shrinker, struct panfrost_device, shrinker);
>> +	struct panfrost_device *pfdev = shrinker->private_data;
>>   	struct drm_gem_shmem_object *shmem, *tmp;
>>   	unsigned long freed = 0;
>>   
>> @@ -97,13 +95,24 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>>    *
>>    * This function registers and sets up the panfrost shrinker.
>>    */
>> -void panfrost_gem_shrinker_init(struct drm_device *dev)
>> +int panfrost_gem_shrinker_init(struct drm_device *dev)
>>   {
>>   	struct panfrost_device *pfdev = dev->dev_private;
>> -	pfdev->shrinker.count_objects = panfrost_gem_shrinker_count;
>> -	pfdev->shrinker.scan_objects = panfrost_gem_shrinker_scan;
>> -	pfdev->shrinker.seeks = DEFAULT_SEEKS;
>> -	WARN_ON(register_shrinker(&pfdev->shrinker, "drm-panfrost"));
>> +
>> +	pfdev->shrinker = shrinker_alloc(0, "drm-panfrost");
>> +	if (!pfdev->shrinker) {
>> +		WARN_ON(1);
> 
> I don't think this WARN_ON is particularly useful - if there's a failed
> memory allocation we should see output from the kernel anyway. And we're
> changing the semantics from "continue just without a shrinker" (which
> argueably justifies the warning) to "probe fails, device doesn't work"
> which will be obvious to the user so I don't feel we need the additional
> warn.

Make sense. Will delete this WARN_ON() in the next version.

Thanks,
Qi

> 
>> +		return -ENOMEM;
>> +	}
>> +
>> +	pfdev->shrinker->count_objects = panfrost_gem_shrinker_count;
>> +	pfdev->shrinker->scan_objects = panfrost_gem_shrinker_scan;
>> +	pfdev->shrinker->seeks = DEFAULT_SEEKS;
>> +	pfdev->shrinker->private_data = pfdev;
>> +
>> +	shrinker_register(pfdev->shrinker);
>> +
>> +	return 0;
>>   }
>>   
>>   /**
>> @@ -116,7 +125,6 @@ void panfrost_gem_shrinker_cleanup(struct drm_device *dev)
>>   {
>>   	struct panfrost_device *pfdev = dev->dev_private;
>>   
>> -	if (pfdev->shrinker.nr_deferred) {
>> -		unregister_shrinker(&pfdev->shrinker);
>> -	}
>> +	if (pfdev->shrinker)
>> +		shrinker_unregister(pfdev->shrinker);
>>   }
> 

