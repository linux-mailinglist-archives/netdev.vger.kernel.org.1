Return-Path: <netdev+bounces-39824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5817C499A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FC51C20B5D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1349F9EE;
	Wed, 11 Oct 2023 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KrXGlOnC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B3F4ED
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:04:34 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BCB94
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:04:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c17de836fbso82631171fa.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697004269; x=1697609069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLcMO6tCvEayfczTS0N9hdUJJuOrTWwhHyFzgaVwZn4=;
        b=KrXGlOnCEpVTWcDsXatte8CfI140KWpbiWN/2vBPZddVe1kl/8jIfgXGo1dAr8ke3U
         Cf8B0pc6Al8U4iNWe+e7QgTZvdR/Dt2u7BzcQ9PHIxK6nrKjnE0qVqsRPXk7QzVyObF+
         V/wN4Kr5jvdnh7Nsnn69b5Z/5bJ3hZAF0KCHi17Wq8neb6Wl0X9VloYo5YLz3IzaHKqT
         N99vCb/GTYLcdPW0OWQb4YUkh4ws7DiKp4nC/xIvExfw0lm+RgCElcbed01DUnp7hWkB
         H0ZBKNT/E2G46f3Rzp6P3R7bpiuO5IfUIrxC+NHXFFa/4hsYgzqrhuuNnnf+D0u0FVXf
         758g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697004269; x=1697609069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLcMO6tCvEayfczTS0N9hdUJJuOrTWwhHyFzgaVwZn4=;
        b=PtuWPqaEZhQXYVox1FfdPXfcDS+KzGIyy+8BHq2XMbE28B4d0UNEEcQJQT5jEeN8yh
         aDEaqXUWAoiJcnkYhVz8Ua/4Wt7f3863ECsMBfB4rhMa9VwE55APkmvlptuxlXlCAZii
         DPcyNFoqSvvItfCwW8R4mMDb6AJcN5hz+IcUNoH6vMA+7LbTMXDqMvUYs4JN3WsDf1Gj
         tUxOfjGDPvjgawEa1coEcZZ5l0cLApXJevOD4uWXsEkvVAyggEXgH8/oBTIpXD2euWt4
         GLPPJi6h6AMtmTmieXTCQ0/oZFbREmRdsGrmETPvY2kWKr4leK1HKWu2lgLpGVadExuU
         c8yQ==
X-Gm-Message-State: AOJu0YxqwWQibN9M2xk741Ej0x7QCpoeFaw0dzgAd+DQt0RTnYiAjirn
	TEENMUTaquBw4x1qAaLCF2fEMA==
X-Google-Smtp-Source: AGHT+IFz6pqAjvf8mSXUjVojcq7g3QjTibwN65Mxi56SdMelQyAIboAXJ7Vm/aMkiwrzM5oCl4tJmQ==
X-Received: by 2002:a05:6512:31d0:b0:4ff:a04c:8a5b with SMTP id j16-20020a05651231d000b004ffa04c8a5bmr20964704lfe.47.1697004269544;
        Tue, 10 Oct 2023 23:04:29 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c248400b004060f0a0fd5sm15756721wms.13.2023.10.10.23.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:04:28 -0700 (PDT)
Date: Wed, 11 Oct 2023 08:04:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: Re: [patch net-next 05/10] netlink: specs: devlink: fix reply
 command values
Message-ID: <ZSY666H7J9eq/Ext@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-6-jiri@resnulli.us>
 <20231010115935.58b4b2ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010115935.58b4b2ea@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 08:59:35PM CEST, kuba@kernel.org wrote:
>On Tue, 10 Oct 2023 13:08:24 +0200 Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Make sure that the command values used for replies are correct. This is
>> only affecting generated userspace helpers, no change on kernel code.
>
>Still, I think this needs net.

It affects only userspace generated code, that's why I didn't bother. If
you insist, I can send separate patch to net.


