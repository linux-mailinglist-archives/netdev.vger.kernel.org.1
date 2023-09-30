Return-Path: <netdev+bounces-37220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0207B43F7
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 23:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id EB63DB20A27
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D5319464;
	Sat, 30 Sep 2023 21:44:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F88C1E
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 21:44:17 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DBA9
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:44:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27909dabf1cso958957a91.1
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696110255; x=1696715055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sfg/LipJSK0IQhDOjY+S9Y8eTX3CJRuu/5A9LJ3yRc4=;
        b=I2QOryCW/b/gkPGvD+PVj4RUWakIW+OtzwUbhBL5+8tXyr4pqCbJP5rRVt3JT45neT
         0ZPORa8AB81z/aXtvuhm6fvMImlOj/S03NdJ4wTi4bQ7eeZgWhnjXLk0OVSWq4+sxg2F
         fd/wfmSBegxx9uZw6/AxBS9KJ2antn40HbvoatyR3H7ltaiGXETeanEOCplFGXEt1qBz
         qN78SyEVHoEHkHoEerpg7rn5onegum2dpoHL6z0gIn/m+95FrWOua8zteO9xaBqPVN8R
         /thfN1n3umgZLACdrliB+vcPLjQ4Dpre4sPZ2edY9cdVwNj2iP0UK9NVUPPPnxIgk9hM
         hayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696110255; x=1696715055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfg/LipJSK0IQhDOjY+S9Y8eTX3CJRuu/5A9LJ3yRc4=;
        b=fe9+5ZWy6oek+b6Uje2LabzM2QG9+TZmo6ATBsKX81gaTH3Si8g4sw7pHg2gdO3dbn
         Fn5GIKcINA3BH1PorcDA2s7YH39724ikXNu/sjEjXWkzmqjb/Umc6XbHMh0iP0xScIM8
         XAw4A0HEPZ6WvPMautLuAgLqD9dXikil1t1k9fvlPZECQAC6j3yVFNkZIyNyROavGKuY
         54b1+AgOFuz5zuebRYPlUuI4IDKdS6Q6A1GwfaEreCSZh1UJ/ZboBQILBh7PMma4KpID
         UWWSE/bIkXyyUOzxPrKGESqGcYM2d6mvKCc+m0B6IVmw2PrkH5iyZYbL/UAml4C2RnnT
         xHAw==
X-Gm-Message-State: AOJu0YxdTwbX6BVU+x9BtM4zDh/JBa2UWrfXO7whFE0Hkeuqu7rSryZ6
	Qg0NcaAC5NjIzHInr2OSgvY=
X-Google-Smtp-Source: AGHT+IEe8yN2jUSebjq+uMKg/d9WHnw9I/AzlHfca588BnakOf4g+jYMKmr3nMp7k1UZnQMQxz2u3Q==
X-Received: by 2002:a17:90a:4506:b0:268:ca63:e412 with SMTP id u6-20020a17090a450600b00268ca63e412mr6935965pjg.4.1696110254888;
        Sat, 30 Sep 2023 14:44:14 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0027732eb24bbsm3589093pjb.4.2023.09.30.14.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 14:44:14 -0700 (PDT)
Date: Sat, 30 Sep 2023 14:44:11 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
	alex.maftei@amd.com, davem@davemloft.net, rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v3 1/3] ptp: Replace timestamp event queue with
 linked list
Message-ID: <ZRiWq+GVZ9OjchR3@hoboy.vegasvil.org>
References: <20230928133544.3642650-1-reibax@gmail.com>
 <20230928133544.3642650-2-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928133544.3642650-2-reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 03:35:42PM +0200, Xabier Marquiegui wrote:

> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 362bf756e6b7..197edf1179f1 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -435,10 +435,16 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  __poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
>  {
>  	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
> +	struct timestamp_event_queue *queue;
>  
>  	poll_wait(fp, &ptp->tsev_wq, wait);
>  
> -	return queue_cnt(&ptp->tsevq) ? EPOLLIN : 0;
> +	/* Extract only the first element in the queue list
> +	 * TODO: Identify the relevant queue

Don't need todos, we see what is happening.

> @@ -228,7 +242,13 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	ptp->info = info;
>  	ptp->devid = MKDEV(major, index);
>  	ptp->index = index;
> -	spin_lock_init(&ptp->tsevq.lock);
> +	INIT_LIST_HEAD(&ptp->tsevqs);
> +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> +	if (!queue)
> +		goto no_memory_queue;
> +	spin_lock_init(&queue->lock);
> +	list_add_tail(&queue->qlist, &ptp->tsevqs);
> +	/* TODO - Transform or delete this mutex */

Again, no todos please, the patch that removes this mutex will/must
clearly justify the change.

>  	mutex_init(&ptp->tsevq_mux);
>  	mutex_init(&ptp->pincfg_mux);
>  	mutex_init(&ptp->n_vclocks_mux);

Thanks,
Richard

