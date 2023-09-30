Return-Path: <netdev+bounces-37221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5747B43FB
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 23:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4AA74B209CA
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 21:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C561946E;
	Sat, 30 Sep 2023 21:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47DBBA48
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 21:57:29 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC757CA
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:57:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2791d5f1a09so792878a91.1
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696111048; x=1696715848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VI3LavMGZ6n/laTSAV7fEld2pH9NIz3R1LBssCn8kek=;
        b=U39k2SZKFfEI1HTcYbOp5wn1IpWvbsvEkm1tqMBcCCzjBPhDwBBjF77nxX/0u5+UYO
         t63FcTJIN8nNspv0aDjzdajM1T4YE31Kl4N3bs0jJFyur83lZKKyUnyo5iJNhWoNFWOO
         9gFjV+4mgsPXTJh6Gux3wFCD81pKmxrlVlIk7fn6SwGBhRXHx4aY47DcvCe9C8XG0cvb
         geRKZRAajZRuW96Ncmp1Nn1gSP1DZxj9kPHUyOylzSV8HNMtiaV8G4hXa7QkVDRTmCP8
         a/s/4Wp/c2xeAsNOY2Y+QdntLiHuZ4qgQwgnK/Twk4bqDKr1tSpUigZkSvbWDeRRwyIr
         E5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696111048; x=1696715848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VI3LavMGZ6n/laTSAV7fEld2pH9NIz3R1LBssCn8kek=;
        b=QNO5uejEhqnae0muOpe2+FaABlHt65jqPFT6uCZsGZaQe3pp1snvfi+lTfkp9HvxJE
         rbOx289SnaBNVTYv0Pn6oTD2Yo4OBveuXA0xbsYRK6wGihGcbO8oBBel8bNnQHzjqTNK
         YDqf54DTlh4uxUwxk8L67S4RvHOr9LWYZZma8CFMSyZwQM7yyG9Jjjzv/xbF2IgUv0JT
         wqPyc+7Wdq0Ta8q5qzMaGrZfCgcFihFRpsuhGhhbdAaHU3XVVRafsbZ9GLMIDIRkNrgk
         3F+arwvzmzmREqoVd1Am0ZuE61kODc/+T4gfIEolD13gYmnYaR0bpm6COmP/RPpCzNcj
         bc/w==
X-Gm-Message-State: AOJu0Yzny+uC3iEHzJPOPGRz1+Jbhw7Qgt0i6LF9eX9nUAA2UF97o5/0
	FU2fxFwUo9r0QF68WLsxpJo=
X-Google-Smtp-Source: AGHT+IF26zkgroAYRQQwTfSG/3L6W2pAtUMoko6Dg09YzDVERGzwbU8SubBLVbEALbc9gQsQj1f49w==
X-Received: by 2002:a17:902:dac8:b0:1bf:1a9e:85f7 with SMTP id q8-20020a170902dac800b001bf1a9e85f7mr8919793plx.1.1696111048078;
        Sat, 30 Sep 2023 14:57:28 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id z5-20020a170902ee0500b001c727d3ea6bsm7437539plb.74.2023.09.30.14.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 14:57:27 -0700 (PDT)
Date: Sat, 30 Sep 2023 14:57:24 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
	alex.maftei@amd.com, davem@davemloft.net, rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v3 2/3] ptp: support multiple timestamp event
 readers
Message-ID: <ZRiZxH5TbkKS5py7@hoboy.vegasvil.org>
References: <20230928133544.3642650-1-reibax@gmail.com>
 <20230928133544.3642650-3-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928133544.3642650-3-reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 03:35:43PM +0200, Xabier Marquiegui wrote:

> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 197edf1179f1..65e7acaa40a9 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -101,14 +101,74 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
>  	return 0;
>  }
>  
> -int ptp_open(struct posix_clock *pc, fmode_t fmode)
> +int ptp_open(struct posix_clock_user *pcuser, fmode_t fmode)
>  {
> +	struct ptp_clock *ptp =
> +		container_of(pcuser->clk, struct ptp_clock, clock);
> +	struct ida *ida = ptp_get_tsevq_ida(ptp);

No need for IDA or ...

> +	struct timestamp_event_queue *queue;
> +
> +	if (!ida)
> +		return -EINVAL;
> +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> +	if (!queue)
> +		return -EINVAL;
> +	queue->close_req = false;
> +	queue->reader_pid = task_pid_nr(current);

... PIDs.  Just allocate the queue and set:

> +	pcuser->private_clkdata = queue;

> +void ptp_flush_users(struct posix_clock *pc)

I can't see any need for "flush users".

open/release are per-user anyhow.

> @@ -184,11 +216,11 @@ static void ptp_clock_release(struct device *dev)
>  
>  	ptp_cleanup_pin_groups(ptp);
>  	kfree(ptp->vclock_index);
> -	mutex_destroy(&ptp->tsevq_mux);
>  	mutex_destroy(&ptp->pincfg_mux);
>  	mutex_destroy(&ptp->n_vclocks_mux);
>  	ptp_clean_queue_list(ptp);

You don't need this ^^^

Keep it simple:

- allocate queue on open()
- free the queue on release()

Hm?

>  	ida_free(&ptp_clocks_map, ptp->index);
> +	mutex_destroy(&ptp->close_mux);
>  	kfree(ptp);
>  }
>  

Thanks,
Richard

