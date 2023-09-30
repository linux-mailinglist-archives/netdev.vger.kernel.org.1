Return-Path: <netdev+bounces-37218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13CC7B43ED
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 23:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 86311282594
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E451945C;
	Sat, 30 Sep 2023 21:25:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5519455
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 21:25:28 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FDDEB;
	Sat, 30 Sep 2023 14:25:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690f8e63777so2971579b3a.0;
        Sat, 30 Sep 2023 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696109126; x=1696713926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEX8Oe7zQOV+GMrc1FkaNZ59PpZeMx7ZWUuReQFUVO8=;
        b=B4ICoQBk8l4yyemv6WY0dM+mtqWXMl1iHhQdFtM08ohdr2scnaIdfuUGtxUaf4ldIP
         gCghD75JtEKRFIg3AZ5yc3xJNBZXEebUVyiUKQhdIOTEcJLd0xHG/7/hw32C/h7MMVBp
         Lr0Yx6kifTJdw2ZIwrj7GVaUjAP1GAVW4JltFgbhL+VmbQQFyvCP8JmdTvmx3Z6HafOI
         JfPv1xWDxAH6g2pPC70cBLlYeHsuvUfmly/hyq5GW5vRHauEhEC+WTyjSgpz0S16YdVV
         lHAQEIYqUV0X6Ubtmpf1AcIYsc7P8tDSFsBiESM9iTnO7o1WLoLR6KuRNg8Ce+LAF2Pg
         R9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696109126; x=1696713926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEX8Oe7zQOV+GMrc1FkaNZ59PpZeMx7ZWUuReQFUVO8=;
        b=h+VkAL+7zA+yZcDeHjczLpi25MDYs5oQBijLLay5wFfWuoZXVGfsB0zru45+xbYZHX
         KuXrxoL+Q3T8J+L93Zl+e00lIiQHLn1gDblqgdEwEZ6HTYF8u5FMJxwMlDNIDuV5+eZt
         gCYDU/CUSdUIa61gSMjjaY43elRaBcjVc4Djl3//qBzqsarTBkNZHoFbWAXyIvDzjSKv
         KvhVdvZv897PLkVOphh29BGZO41HKuVWIc0XXhpmsvo7wDu1R/S/Vxla3eEOXsrk7PYj
         9uNvtEKSJiJBPyz/B6AkyfOGhcLQjd4fijO29GbzjqRbNbKmVUEcZnsEHnv+Udrt7l5M
         6vPQ==
X-Gm-Message-State: AOJu0YwSwmSE+dWE7OrQqsE3IcnO1QTaCMoeIaicKrx83f501qroN2fc
	o/6PN5Df8ER7VS0MwMdfFy8=
X-Google-Smtp-Source: AGHT+IEtb5NW3OpFAs2PD8HMQoO9+HLqELXFCnGANATAYT9GJIgyIs771otc45eNjyjDSR1A58yzkA==
X-Received: by 2002:a05:6a00:808:b0:692:ad93:e852 with SMTP id m8-20020a056a00080800b00692ad93e852mr8581621pfk.2.1696109126472;
        Sat, 30 Sep 2023 14:25:26 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id x26-20020aa784da000000b0068c0fcb40d3sm17028095pfn.211.2023.09.30.14.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 14:25:25 -0700 (PDT)
Date: Sat, 30 Sep 2023 14:25:23 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>,
	Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH 3/4] ptp: add ioctl interface for ptp_gettimex64any()
Message-ID: <ZRiSQ/fCa3pYZnXJ@hoboy.vegasvil.org>
References: <20230929023743.1611460-1-maheshb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929023743.1611460-1-maheshb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 07:37:43PM -0700, Mahesh Bandewar wrote:
> add an ioctl op PTP_SYS_OFFSET_ANY2 to support ptp_gettimex64any() method

This is a useful idea.

But how about a new system call instead?

    clock_compare(clockid_t a, clockid_t b);

It would accept any two clock IDs.

I've been wanting this for a long time, but never found time to
implement it.

Thanks,
Richard

