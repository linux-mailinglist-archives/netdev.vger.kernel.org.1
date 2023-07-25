Return-Path: <netdev+bounces-20895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52064761D61
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7ED28173B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A9923BD3;
	Tue, 25 Jul 2023 15:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0C23BD1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 15:29:29 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A181BF6
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:29:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-993a37b79e2so901271866b.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690298966; x=1690903766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjlrbfT1i6tI7AFt+LbMcfKublLdL5rytJvECbAgqhw=;
        b=3Av3W/H9AvKC2xhec4wLU32kj/ocz3g21KXV7GBjN2+pb/CcPWxxNsHubEAKO2s1VV
         qL4rlCWHhLNJhcn+6v8C5QObtLUPh41uYbKHJ+MlNkWxx2dXMMYw9zw+vhujizbK8HQR
         9YsF2kUpTqzM84WO8JSSw0A3zBYX5Zgswlw1OX4uQ3vV5DPCzlNjyIf5g1qDGBfw9uD3
         L9jFvuIHE6yOUAZIeG31nSA3brM3h3Wo9/qU3XlAs+LPe1Fn0mI2mvINcyzuX2aZIQI8
         yC//Kc0nFeA9CwPhp6FaXIfwCC42X4lHvGfNEU84qUyYileAjyAh5heW1ummpI+0iH0n
         BFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690298966; x=1690903766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjlrbfT1i6tI7AFt+LbMcfKublLdL5rytJvECbAgqhw=;
        b=YOV7rHD+RqjWSS1WswCriFInxuT3MK+CTi6nEEhMBCNz3hYCNUdbmwHqeRESAwXG+h
         g40vQZm0GPT6ehtNI7L/FPDrssBGsFhzw2hPPJGYFgQV91iGU99by2/TiGlwGNen0NOe
         /sX2tvJ6ZRpQl2bdQpvzVzf+LQWs4UkTH4lVKq9wwn0B3vZnJGKwOVksB4FBNmnSokhL
         QR76eEwwo+pY2rvEQ5x5d8WYbkLAGFvY/qr87Y0DHsCBVn6zkSuLdplw1/AX5d1uvT/n
         ejJmv3oZ0sVqVae/YeJ9kfyL5R5jyh1Bt+6b1nxRQPK2o2/Jf8uCb/1MlyfL4WIr8ArX
         0UCA==
X-Gm-Message-State: ABy/qLZPQkpJZaz68EVCEGogc4dNAWt8NAnzECssGMHaCGgSafnXb5mD
	FL8G3aXWOPnenwzZ5TiIsjPksA==
X-Google-Smtp-Source: APBJJlE0hYqOUIltZnICvYfM/7nxuYFidgVxNNz28KNMxH/AG+NBkY4dQ7R3+Tzf1zDzfBAammcJIQ==
X-Received: by 2002:a17:907:2cf7:b0:993:f8b2:d6fa with SMTP id hz23-20020a1709072cf700b00993f8b2d6famr11234456ejc.21.1690298965867;
        Tue, 25 Jul 2023 08:29:25 -0700 (PDT)
Received: from localhost ([91.218.191.82])
        by smtp.gmail.com with ESMTPSA id lv19-20020a170906bc9300b00989257be620sm8216409ejb.200.2023.07.25.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:29:24 -0700 (PDT)
Date: Tue, 25 Jul 2023 17:29:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 00/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
Message-ID: <ZL/qU/cwvPlLR3ek@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
 <ZL+C3xMq3Er79qDD@nanopsycho>
 <87ca1394a3110cad376d9bfb6d576f0f90674a2d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ca1394a3110cad376d9bfb6d576f0f90674a2d.camel@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Jul 25, 2023 at 10:36:31AM CEST, pabeni@redhat.com wrote:
>On Tue, 2023-07-25 at 10:07 +0200, Jiri Pirko wrote:
>> I see that this patchset got moved to "changes requested" in patchwork.
>> Why exacly? There was no comment so far. Petr's splat is clearly not
>> caused by this patchset.
>
>Quickly skimming over the series I agree the reported splat looks
>possibly more related to core netlink and/or rhashtable but it would
>help if you could express your reasoning on the splat itself, possibly
>with a decoded back-trace.
>

Well, since I'm touching only devlink, this is underlated to this
patchset. I don't see why I would need to care about the splat.
I will repost, if that is ok.


>Thanks!
>
>Paolo
>> 
>

