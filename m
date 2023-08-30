Return-Path: <netdev+bounces-31458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB178E209
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 00:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2BF1C20400
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 22:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30898BE1;
	Wed, 30 Aug 2023 22:03:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDA8481
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 22:03:09 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522EC5
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:02:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1befe39630bso235335ad.0
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693432886; x=1694037686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl43R+lChKxojREtCX5qEwE6O83opJafYEjwfICzGUg=;
        b=UPP13ttyfl2Yd1c69cmuJxMS4xhuH28XCNAyeu95bymNQARqiKg9n0pQccs9t1OrUY
         65KdiIAn6XE9MNh9ICFx3wYkPmo96WuE45t5aUV7UkD7gX38ta1WtcyRL/eTv0NqhU91
         3bMM+XW23N+J7mX7cS7ACsC5Ubg+YUE0TEDlVRRpCMnV+EIW7OLA6L8S+L9GBwaM2TxA
         P6u18c2h56UZ9VAhhllOEU5zOkcyS6hw4KF58aOUkUeL7n+mSUYVyUKpm5Je4MfzUFiL
         Ib8MdvtO09Fj5Zon2BuxUR9l6YFIo6hjHIidBvX84MmQ1oij651NoFhDvAytFUpFWfMB
         iMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432886; x=1694037686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl43R+lChKxojREtCX5qEwE6O83opJafYEjwfICzGUg=;
        b=KXxD0kqAgHXMVHUQUYaab7coRuMUfjAyGwxEXOqRmXadU3fKuaZ/nZMj8Jcwaovz5K
         oh6iPM0YKwP4K/XUsdyce+dtQcpTrFJJUozf7llt0naE9W0Qt44csD/ATM/KGnq/0zi8
         x7GI6K92iYT3Cj2qdx70EIYHWSQNXKeA8Y+UqQpCpa64KGzEoP+XvugApUlGrmp4M/5a
         EQP+ZXEVwfi0lGtXTlSaphlDpm9FCWiXeozpz15TW4NciDoEaXiymKYtC6viL0vhIkH8
         JEoTlNqb3diwyhg8ZLnX5TIqqKCoOPZ6WoekWPI4hLuUQk/FZrYyLRJtmRtSHvQ7ZmeH
         y2Xw==
X-Gm-Message-State: AOJu0YxKCsX3PIGsK0EvgUsoCR/9TkFRyULSdP22XYErwVEz7p4vWU1c
	wMPOV6/icacNwQI0C9rkWcutfvg4ckU=
X-Google-Smtp-Source: AGHT+IFehm7h42OBDgIicD004ojdbeg7U0zqGzNo2H6Xnmv0F8sj71Oby2vSsz6p12DXl9/frVFASA==
X-Received: by 2002:a17:903:230c:b0:1bb:ac37:384b with SMTP id d12-20020a170903230c00b001bbac37384bmr3530786plh.6.1693432885591;
        Wed, 30 Aug 2023 15:01:25 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b001b8a3e2c241sm11566769plj.14.2023.08.30.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 15:01:25 -0700 (PDT)
Date: Wed, 30 Aug 2023 15:01:22 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	netdev@vger.kernel.org, ntp-lists@mattcorallo.com
Subject: Re: [PATCH] ptp: Demultiplexed timestamp channels
Message-ID: <ZO+8Mlk0yMxz7Tn+@hoboy.vegasvil.org>
References: <ZO37vZvXX9OPDLHH@hoboy.vegasvil.org>
 <20230830214101.509086-1-reibax@gmail.com>
 <20230830214101.509086-2-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830214101.509086-2-reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 11:41:01PM +0200, Xabier Marquiegui wrote:

> +ssize_t ptp_dmtsc_read(struct file *file, char __user *buf, size_t cnt,
> +		       loff_t *offset)
> +{
> +	struct ptp_dmtsc_cdev_info *cdev = file->private_data;
> +
> +	return ptp_queue_read(cdev->pclock, buf, cnt, cdev->minor);
> +}
> +
> +static const struct file_operations fops = {
> +						.owner = THIS_MODULE,
> +						.open = ptp_dmtsc_open,
> +						.read = ptp_dmtsc_read,
> +						.release = ptp_dmtsc_release
> +						};

I'll say it again... There is no need to add a new char dev!

You will need a patch series of at least three patches, step by step:

1. Delete ptp_clock.tsevq
   Replace it will a linked list of `struct timestamp_event_queue`
   Populate the list with ONE queue in ptp_clock_register()

   This will be your first patch.
   It will have the same functionality as before.

2. Allocate a new `struct timestamp_event_queue` on posix_clock_operations.open()
   Add it into the list.
   Remove it again on posix_clock_operations.release()

   This will introduce new functionality, as all events will go to all
   consumers.

3. Introduce a new ioctl that filters events based on user preference.

Hm?

Thanks,
Richard


