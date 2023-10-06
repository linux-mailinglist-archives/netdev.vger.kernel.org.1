Return-Path: <netdev+bounces-38643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A47BBD64
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98611281E58
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1F2AB2A;
	Fri,  6 Oct 2023 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DKlz1GAM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF2273C5
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:59:12 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B37AD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 09:59:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9936b3d0286so434638466b.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 09:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696611549; x=1697216349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyN8VYYSeUZkA8K6OYxn1GebMFQmwAIvZCPDtYmEOAo=;
        b=DKlz1GAMoyltZHrSQx/XBz4tneWhbzA7KmFhM7rju+qUK9CPqj25/7rOCcskQm8y3x
         mCc5rLEaX95LkFnVsaDsyH+PepQgyKdL7nZXbIfIAtZeT2d4IjHY+3Cj3hKP/t/8Pxjg
         cTdyZifJhcmeXytJsEtjrM9gJnao8H6db0RcbLSMlrQbAZjrRn1jRRtQDXnMUqiDRs4L
         1pP2i1y0MW9rIrxE+G6ZReZhrwBRPoUCbRuvjXBPH2b8wnozu3tPcTZrGKq4EDQhgkGA
         i7nW5P9j+ZmrEQI4cueKZzaBfik3CPH561YWuOeiX38EeWCoUoboAMtQ1+sIEA2qTLwH
         RAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696611549; x=1697216349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyN8VYYSeUZkA8K6OYxn1GebMFQmwAIvZCPDtYmEOAo=;
        b=S79jDGWLFhAU3WwoNsT16C3Xlx1mTfkZLiyRP43OFvRIk5jX5ynN1uOBSlAOHj0bKA
         QYtWhwE1YUgD9mrszvkYhwAgcjgxUOtgRSwKi6tMSLlaSB1J52sl1jCEULtxgnIWUIcQ
         Ig1UYkXs1nRiXaCIQjVpaDxS2MHmEBXQwucEXts+ozALueDP0w76pUpBMeN9ZY0xIikv
         +VkvSmJwssrX94CpmoSMW1NFbTQNEN1gYyhhM/lT88aqhD4prZW2U6ai0xpwOm8jvU/d
         60Y0lkD/8Ari0TwawCm/4+KvCAB7ox33MIgJPpJGFC0q6IXS7FvdCRwMIiIfETUzCCsF
         zouA==
X-Gm-Message-State: AOJu0YwzgiYEU/2Dd64gyIjczZVoMEqQUy2+vMoipoDDHC72rj2B4D+v
	p8U6NoGFQoRp/hNKA8ku5Ret0A==
X-Google-Smtp-Source: AGHT+IGp3hDmxmj0aF2sFJeRmRwziquKM+zmL/oatKNk5/6Z0/XsfCeyl9ywon0NTiGsHqTQaOMhvQ==
X-Received: by 2002:a17:906:76d1:b0:9b6:8155:cbef with SMTP id q17-20020a17090676d100b009b68155cbefmr8549878ejn.61.1696611548821;
        Fri, 06 Oct 2023 09:59:08 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o23-20020a17090611d700b00991e2b5a27dsm3171230eja.37.2023.10.06.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:59:06 -0700 (PDT)
Date: Fri, 6 Oct 2023 18:59:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew@lunn.ch, jesse.brandeburg@intel.com,
	sd@queasysnail.net, horms@verge.net.au
Subject: Re: [RFC] docs: netdev: encourage reviewers
Message-ID: <ZSA82AYG8GF+HYgy@nanopsycho>
References: <20231006163007.3383971-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006163007.3383971-1-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 06:30:07PM CEST, kuba@kernel.org wrote:
>Add a section to our maintainer doc encouraging reviewers
>to chime in on the mailing list.
>
>The questions about "when is it okay to share feedback"
>keep coming up (most recently at netconf) and the answer
>is "pretty much always".
>
>The contents are partially based on a doc we wrote earlier
>and shared with the vendors (for the "driver review rotation").
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Looks awesome. Thanks for doing this!

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

