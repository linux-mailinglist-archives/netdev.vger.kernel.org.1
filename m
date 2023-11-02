Return-Path: <netdev+bounces-45704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A45E7DF1ED
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AE51C20D5F
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C907E15490;
	Thu,  2 Nov 2023 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d/pbwT+y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966618629
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 12:03:00 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC4B19A8
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:02:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso12117971fa.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698926577; x=1699531377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTe22ucl21toPbP0OqVOvi+LxGoUbLZHCXRrDvLCa90=;
        b=d/pbwT+y9749QZqpGiwGHoh1qsND9uPfZUV3AfKIr2q9/PTTJSsGsiqgzIKT2c6mdm
         4IAO7YxCmKxp5673d7faqZd55f7a2uFgveks8QV9DOy5osk6r8N0OijB9v8zbE5hvlzu
         c2ZwcrQWqJS8IFlAXcF2VZLy0d0pmR4R8Erzafk41YMSrzH+Nem4R5AIXY+PnXrG/lIS
         BQ+3zXCEcUNAbJ01Syn7GFZ/6LVfn0KEbZgJ4D9hwfopeDW32y6OA5myOA/2PK1U/lWy
         caAQ4BU5PCoVW8dZyHhKh4+r6Uv9UG5IOZyUppoed3fmiVOJ6VXWx5tnN4kwNLfiywxt
         9WRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926577; x=1699531377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTe22ucl21toPbP0OqVOvi+LxGoUbLZHCXRrDvLCa90=;
        b=mlnwRf5LUycW2BB2cNEk5QdYnlTIxrtx3XNUULSq2d4F608zFLNtoeBM+VpECRDwr7
         TAF3VgkB20NuWxzRmgOpFWWJ5tyco9lnWgzMrPDotd9UR0CA24IvxK0w9vozgMvAgKHP
         xAQPGY1fI8Az++4asDpFEYSVKckrjbwahJHa0KBeleGYHmbLDqMFOmbf98ectFBD97WN
         eHqjMrWUviWJ1Dj7u341fKDckhIqcwRqytSIk8SfLSPuyvWQEx+t9N7UUAgeQADQX7It
         +uNfL6151YktlRbKAL1OfaFhSgHIgmpPUy2c61LbnDNJn6AyHcNxX3oQza35u7DmKvKO
         2utg==
X-Gm-Message-State: AOJu0Yw7Y/e7/2VOqfjOv+TP7HOdKq+mnCCKFpN9icl44U9Jj+CRMk1i
	MR1yvCZ/f/X3fHYj+lZc7WF/jQ==
X-Google-Smtp-Source: AGHT+IHEbFoQHnnUS64cWYcXS8jfgEaqgDAVQde3ejDo5UHqfVTXmd/51ACdjkcz/wah3QDyHGs3ZQ==
X-Received: by 2002:a2e:9bc2:0:b0:2c1:6b9c:48d6 with SMTP id w2-20020a2e9bc2000000b002c16b9c48d6mr14025857ljj.16.1698926576832;
        Thu, 02 Nov 2023 05:02:56 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6289000000b0032da022855fsm2231629wru.111.2023.11.02.05.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:02:55 -0700 (PDT)
Date: Thu, 2 Nov 2023 13:02:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net] netlink: fill in missing MODULE_DESCRIPTION()
Message-ID: <ZUOP7tOSK2ysyuUc@nanopsycho>
References: <20231102045724.2516647-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102045724.2516647-1-kuba@kernel.org>

Thu, Nov 02, 2023 at 05:57:24AM CET, kuba@kernel.org wrote:
>W=1 builds now warn if a module is built without
>a MODULE_DESCRIPTION(). Fill it in for sock_diag.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

It's a bit odd to target -net with this, isn't it?

