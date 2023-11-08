Return-Path: <netdev+bounces-46610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA7D7E5629
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 13:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5CF1C20A7C
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E641772E;
	Wed,  8 Nov 2023 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq0JnlNl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16E17727
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 12:23:01 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057581BE9;
	Wed,  8 Nov 2023 04:23:01 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b566ee5f1dso4190481b6e.0;
        Wed, 08 Nov 2023 04:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699446180; x=1700050980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0P5dMyIUVIEsg9Fi9CRwc+lV/d/EXlNDl76uaA2Gkjo=;
        b=Yq0JnlNl3Js+/9Gk94Qs7k2evnhh4OiRvvUIDN/DxnpA93L37PUuTSVpXTTGAlTvYW
         6ipVAcIc6D4bZMOf9zmNYR/fQrLovQ40nNtCdIWzC0SQjmV2EjJEPrB00bx4TZxZosNd
         N/vZDeYhqrJJFJ4gIH6p6ueQ7M+kYdTWUDbYRH8pLVSPAtOzM2M3LVCtBs9wY4BAE9ph
         Lez3UJAKz+QTWj01Udx0mlr0JQPZmeeuSEOlvbyDPH4cQuoj4FEU0ASiLhjRTfcmxj/Y
         7zkQt8PMGxQ6BwAezqmoiG04zU05E3ORn3x6/tRrbNKWiuvUuMPPgQfcvm8StoI5/W7H
         rlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699446180; x=1700050980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P5dMyIUVIEsg9Fi9CRwc+lV/d/EXlNDl76uaA2Gkjo=;
        b=ABAg7uP0sqeti1GHDLQkfjW4Y6O1yxQvKEiO9Tt79ATnnEN6f8jaaU3jhpmnoPpM9e
         yF6glD5QRS6kNsHE+404nZ9QRi5jOtsOdsIBVF5RU/muu3GtJhhzwX0LUWqdAk2EMahJ
         vgXtUg4jxOXgEIFgkDLqlJeXov3/YUsmBo0fBFAFWyNtw0CR0/W2bcDaNOxjQSy26yaE
         5J2EQVOKLttxfuTo8a+IRY3OFnGk2O3zsMkCtO78mn95fpZFFe6uckXhNQci8f+qjrcl
         5dy+98/MX9dvCddwVc+dJ6JKIYvWzv9upsATAaI05UP1e7aBI8P9uSLNaw+3aymNJ7DR
         zGiQ==
X-Gm-Message-State: AOJu0Yw7j8KN1LYvSCM+0cDM11kjj2O3pjLvjEt0Qumgy1dg+1SboyVz
	ghcaWd4g3Mok4yrBneoFqBI=
X-Google-Smtp-Source: AGHT+IE+gNGcR1tsHinjSQrIOIErqFWASIj4YE4CEob6Mb/H6PRVDvDkMcOH9zqXBLgw6BZAKPgOWQ==
X-Received: by 2002:a05:6808:15a8:b0:3af:d9ea:74b6 with SMTP id t40-20020a05680815a800b003afd9ea74b6mr2156864oiw.43.1699446180243;
        Wed, 08 Nov 2023 04:23:00 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y36-20020a056a00182400b0068790c41ca2sm8861588pfa.27.2023.11.08.04.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 04:22:59 -0800 (PST)
Date: Wed, 8 Nov 2023 20:22:55 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [ANN] netdev development stats for 6.7
Message-ID: <ZUt9n0gwZR0kaKdF@Laptop-X1>
References: <20231101162906.59631ffa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101162906.59631ffa@kernel.org>

Hi Jakub,
On Wed, Nov 01, 2023 at 04:29:06PM -0700, Jakub Kicinski wrote:
> Top reviewers (thr):                 Top reviewers (msg):                
>    1 ( +2) [42] RedHat                  1 ( +2) [71] RedHat              
>    2 (   ) [27] Meta                    2 ( -1) [52] Meta                
>    3 ( +2) [23] Intel                   3 ( +2) [46] Intel               
>    4 ( +2) [15] Google                  4 ( +2) [33] Andrew Lunn         
>    5 ( -1) [12] nVidia                  5 ( +2) [29] Google              
>    6 ( +1) [12] Andrew Lunn             6 ( -2) [23] nVidia              
>    7 ( +3) [ 7] Enfabrica               7 ( +4) [14] Broadcom            

I just noticed this stats report from Simon. Thanks for your work and
sharing. I want to know if there is a way to bind my personal email
with my company so my review could increase my company's score :)
I think there are some other company developers who use their own email
also curious.

Thanks and Best Regards
Hangbin

