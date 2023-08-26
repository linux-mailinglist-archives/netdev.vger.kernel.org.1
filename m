Return-Path: <netdev+bounces-30868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE96789654
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 13:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9271F28194A
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 11:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F19D517;
	Sat, 26 Aug 2023 11:43:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A85D314
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 11:43:10 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C460619BA
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 04:43:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso78428266b.2
        for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693050187; x=1693654987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snB0XFE0xq/DdBgntDAZ5eDzi93Voobdcub3YXS6W9M=;
        b=JydLWUyFO9FzWHp/YOEbKeZfsYX/COfYOqUeX0nQQQRHFrfYyTgdolSf2v06SVo4w4
         PeVzWT1c5wZcm+Zt4hgwOZ+eWt47Yf2t64PrLuATxGm0ztp+x0G2a6aQXmTTRbIBQPXC
         8XlEIneVqPxP5lWjFs3gxL5jl5vpQ4YrCUAcDoHFWCtJXOzsQGuTvPKa35gSyHlgIa2v
         R9aVNWEmdHHsnI5VvQ6QP9MlN2c27QBuIriggsqi7wVm6A7GVQM2iBvN1Yl6N5JO8ZAq
         nHiSfG4sTWdBaNrBgeXwQWDGrAtggBVfTK4bnTA/zzsz/eKZzUGnGsw+/ezsvjB4GcC6
         ZLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693050187; x=1693654987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snB0XFE0xq/DdBgntDAZ5eDzi93Voobdcub3YXS6W9M=;
        b=CaG8IEme9B6G40x6TLF93egZgVUpDnId+2PU7MhNzucKoItLgVg74JmspnC1CGCVGg
         LrHes9d7DWlCvayoCI1BVV4fsK+t7Tscog7MkHhCH4mk47qY4QEKbKF0RNgI7dksUlrE
         KKwmSANvqvDKvwGWTxwPWDtAzWdJYFNgcCNLndlpl+VQsm8M7naoQ6WtGpyCEm7fJNME
         1+iaNoO1QVBsiY622dDhR2mFWiMlP0GawvLFD/b1e8JLqlp/vFYUPJwBNTgNHYIUqh23
         S20JCkCECyJuIv56EAhmQGK/6q6FBmdh2DE3L5OBgNonW9gYL9qy1fHIcRNKxUHINOKr
         8U7g==
X-Gm-Message-State: AOJu0YwSGjmhcfY50P+Brk71Q9ksHmua0JlMK9FuP4smuojtseZBN3Hm
	vTkITwvcAhqYqV9pAWiQJxc=
X-Google-Smtp-Source: AGHT+IGKOQ9Mo1W2GbT8UXWXyz88XQb9exPH48CZqwy+HHUVG9jisB/ugiqvm31V6qKWgrNZMgTPdg==
X-Received: by 2002:a17:907:2cf1:b0:9a1:e1cf:6c70 with SMTP id hz17-20020a1709072cf100b009a1e1cf6c70mr7569123ejc.6.1693050187142;
        Sat, 26 Aug 2023 04:43:07 -0700 (PDT)
Received: from skbuf ([188.27.184.225])
        by smtp.gmail.com with ESMTPSA id fx13-20020a170906b74d00b00982be08a9besm2123065ejb.172.2023.08.26.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 04:43:06 -0700 (PDT)
Date: Sat, 26 Aug 2023 14:43:04 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Brian Hutchinson <b.hutchman@gmail.com>, Tristram.Ha@microchip.com,
	Woojung.Huh@microchip.com
Cc: Christian Eggers <ceggers@arri.de>, netdev@vger.kernel.org,
	arun.ramadoss@microchip.com, rakesh.sankaranarayanan@microchip.com
Subject: Re: Microchip net DSA with ptp4l getting tx_timeout failed msg using
 6.3.12 kernel and KSZ9567 switch
Message-ID: <20230826114304.tb7dm3tr5gun5acs@skbuf>
References: <CAFZh4h9wHtTGFag-JDtjqFEmqnMoW4cTOr_CF3GQwKLb5jigrQ@mail.gmail.com>
 <4860127.31r3eYUQgx@n95hx1g2>
 <CAFZh4h-6yWvpvzJyv06zy8MbtMmXG==V0h2vU=uUN8iMMcb=ig@mail.gmail.com>
 <CAFZh4h-0PBrFh1pDr6Jfg95rF6wUt1o=k=-EgG+8MxN7pnyiAw@mail.gmail.com>
 <CAFZh4h_ueji_KucLdPx9PtTQP1g29PbcjNDFGzLBJYpYK8Rt3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFZh4h_ueji_KucLdPx9PtTQP1g29PbcjNDFGzLBJYpYK8Rt3w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 03:03:32PM -0400, Brian Hutchinson wrote:
> Update.  Top posting because I think this is my issue.
> 
> I dug further into my problem.  I'm using E2E and it looks like the
> mainlined Microchip KSZ DSA PTP code is only supporting P2P.
> 
> The 5.10.69 kernel that I was first able to get working with
> Christian's early pre-mainlined patches had:
> 0016-net-dsa-microchip-ksz9477-add-E2E-support.patch
> 
> ... which gets into the "sticky" bits of why these patches weren't
> accepted in the first place due to some Microchip specific
> implementation if I recall correctly.
> 
> Regards,
> 
> Brian

+Tristram Ha, Woojung Huh

