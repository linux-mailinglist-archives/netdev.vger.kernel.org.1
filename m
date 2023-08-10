Return-Path: <netdev+bounces-26470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95CF777E82
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1FC1C21542
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B83A20C89;
	Thu, 10 Aug 2023 16:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE741E1DC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:43:08 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AA110C3
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:43:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe82a78740so2038145e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691685785; x=1692290585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=udBfsd+JWqh7rbWup+wXDmsDGsw79SejVVVKFi+JhkQ=;
        b=sG44Q5Fzt1E9PDQj4peXwe3uOZcVQtR7nNZGPM8k8i9Get0aMyZFqSMhclHJqZweGi
         Spy8QasoyBUvmPSJA9aiAjYrS6IvdB4ljyT0l+mFAmtTLqjaNIWuWYsDMKa8Y34ks0wo
         y8SlKnoLQLkbWgVZThMNG+bGwVUyn6cZqfsFVd2vvVYg6edT8Xi3LY79FHJ/sPea0g1u
         xImICt9/7GK2eVDdleuQDA3SAYmEGsgthSzYjN7dL52oZRN0FPS8qaPSB5eWkpJyu92E
         dHiSkkwHjwOzW/Me2/dSi7e6dLA4qMfJaMvkz4dkwM7fdcKjrJAd0sBWSvdw4pz8lpbW
         Hw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685785; x=1692290585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udBfsd+JWqh7rbWup+wXDmsDGsw79SejVVVKFi+JhkQ=;
        b=LpgDa7pkP7dOfuxXQdExFtRwSLqp7Ky2MgI0tWhqwQQqooVqa6GakR0+adFfDK2ZDI
         l+b59b5JegIDnvXhFDK2FRGSXehmUpTmNTEYR+bWKePUzJu+VMwLqeeuz3Ov3ZTWxPzv
         owiq+TMn9e+l7dMwdPtwCizv15+xkEoiWRCadjOiy9XtLsBshewmqcml2PAlWrNSiYOa
         WEkEez6g0w+VAlG01/F2sty2YoaeUmBJbZyOgPzHjwZ4/OhPj1R5gi6nBVfPvM8uIE8p
         IzRKW8RL8aB+H7bikS/0kdMIdSzxzwHFBgsVv7nGuoA/CbsQei0UkSq9bU9SUimXYRU/
         dw2g==
X-Gm-Message-State: AOJu0Ywl5ShXiacjrCmvlnxo7RTrom5B6JYKJfHVCRnAD9Rm7KBd+Lqe
	r+D+jIsYUFmgmjv/6pB8NS8WIyWS7eTYIaO4O028sA==
X-Google-Smtp-Source: AGHT+IFP4+y6HIJBkCyLwq14bmQrS/aspgtqjFGKSrRpyKEcdIg9P8tpC2S/dK/NBpaOfH7O/5IYCw==
X-Received: by 2002:a5d:594a:0:b0:314:4915:689 with SMTP id e10-20020a5d594a000000b0031449150689mr2343526wri.34.1691685785065;
        Thu, 10 Aug 2023 09:43:05 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d4690000000b00313de682eb3sm2650990wrq.65.2023.08.10.09.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:43:04 -0700 (PDT)
Date: Thu, 10 Aug 2023 18:43:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net
Subject: Re: [PATCH net-next 00/10] genetlink: provide struct genl_info to
 dumps
Message-ID: <ZNUTl+aCKI0iqg+w@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <ZNSgOt91RerMMhXV@nanopsycho>
 <20230810091459.09d825ac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810091459.09d825ac@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 10, 2023 at 06:14:59PM CEST, kuba@kernel.org wrote:
>On Thu, 10 Aug 2023 10:30:50 +0200 Jiri Pirko wrote:
>> >In the future we may add a new version of dump which takes
>> >struct genl_info *info as the second argument, instead of  
>> 
>> That would be very nice. I'm dreaming about that for quite some time :)
>
>We can probably do it fairly easily for the auto-generated families.
>I didn't want to do it now tho, because it'll conflict with your
>devlink work and DPLL (assuming that one is actually close to ready).

Yep, makes sense. Thanks!

