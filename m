Return-Path: <netdev+bounces-37224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6477B447E
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 00:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C8CB028205B
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 22:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7C7D2F5;
	Sat, 30 Sep 2023 22:37:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3759BA28
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 22:37:43 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D555CD3
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 15:37:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690fe1d9ba1so3400227b3a.0
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 15:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696113462; x=1696718262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+NSL7+HoPU+jL0KLjnt6z9ImzpvykULcHhDch9aXPU=;
        b=XN7UmTiWWkqfLehUaYT5QLoHWkKXd2G6ANV3y85I3p77QrtT4kQjHQtvUmaQUSih4U
         QUHS0MdnJsJ7q7p4LY/lOVpLSTRM4QGRQv06oVECYlUZBglbm49pYAgllWYydVmoBrT4
         4RzCCH6uMocj7vXDbfeXKMT8QtVe1nTfIGfqjXpRJsVX+y62AT4/qmktDwaWVAOG/lT5
         5qt6J5f2uY+9qeSbCaxs5ldiq+gtJwFhK7KVjXzF6z4NIu3LmjAxtbMEL1mVZxNqUwPZ
         2Zp/CxJoK2wMlX8nKqXd4Mj1aLUkgRvxqPg9eQ7BlZvAaE+UBTtNzHSqbrN2HkH0ZBzL
         MVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696113462; x=1696718262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+NSL7+HoPU+jL0KLjnt6z9ImzpvykULcHhDch9aXPU=;
        b=P3BIzjxchTJzX18vStIQ0iEGuPAmqw0cZiNgUjNv3YWOj7KoMYvxbWjU6kftBY7cj1
         OQmwAh+wwQBEfIrV/IUxUH9Zw4nmXNJ4YXmj1l3XGxp5WVGw3UPykThDknTYHNC2yMnp
         GxEnq+d09Imvys6aFNvr7jkPX22ND2mNikj991lGY/g6ZG/hAJnDZQVIuXEBitpC4krQ
         O4S4RQ7z+EonxdvHxXx98+t9TdtjcZqWQgiTaiUkN3v2i9KYywp9/P0mIj5ucGUAxESl
         uQLP8D7PXDYLBCdTzwxvytVDmD+ozo6DRmgu9k6PmqUIOuywnsf/gdOsLPXib1yFFTfz
         4CEg==
X-Gm-Message-State: AOJu0YzBkSdcjHByf67oZeDjc7O5oG220XpiNpVwTkJuPUaSz62VJXQz
	SLEKfs7elqESlCLt2EGa5y0=
X-Google-Smtp-Source: AGHT+IGGUuLXOuNtPo+NNAJUEJYm4ARE/gvWYZsp/9iqgdUbslcbdR9hNb5fY1nviVvaSiMzAOjG2g==
X-Received: by 2002:a05:6a00:4682:b0:68f:c8b3:3077 with SMTP id de2-20020a056a00468200b0068fc8b33077mr7556860pfb.1.1696113462231;
        Sat, 30 Sep 2023 15:37:42 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id r20-20020aa78b94000000b006933f85bc29sm5945822pfd.111.2023.09.30.15.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 15:37:41 -0700 (PDT)
Date: Sat, 30 Sep 2023 15:37:39 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
	alex.maftei@amd.com, davem@davemloft.net, rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v3 3/3] ptp: support event queue reader channel
 masks
Message-ID: <ZRijM9YfyCmrXG7m@hoboy.vegasvil.org>
References: <20230928133544.3642650-1-reibax@gmail.com>
 <20230928133544.3642650-4-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928133544.3642650-4-reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 03:35:44PM +0200, Xabier Marquiegui wrote:

> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index 05cc35fc94ac..6bbf11dc4a05 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -105,6 +105,15 @@ struct ptp_extts_request {
>  	unsigned int rsv[2]; /* Reserved for future use. */
>  };
>  
> +struct ptp_tsfilter {
> +	union {
> +		unsigned int reader_rpid; /* PID of device user */
> +		unsigned int ndevusers; /* Device user count */
> +	};
> +	int reader_oid; /* Object ID of the timestamp event queue */
> +	unsigned int mask; /* Channel mask. LSB = channel 0 */
> +};

This is WAY too complicated.

Just let the user pass a bit mask (say 32 x uint64_t = 2048 channels)
of what they want to receive.

OR:

- ioctl to clear mask
- ioctl to set one channel in mask

After opening the character device, the default is that the user will
receive events from all channels.  This is an established API, and you
cannot change it.  If the user is only interested in specific
channels, then they can set the mask after calling open().

Thanks,
Richard

