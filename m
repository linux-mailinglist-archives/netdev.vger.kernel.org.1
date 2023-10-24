Return-Path: <netdev+bounces-44040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDD87D5EAF
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA05281AD5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12983450EA;
	Tue, 24 Oct 2023 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIR/NgXp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554002D633
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 23:29:55 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8758910C9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:29:53 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7789923612dso344216485a.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698190192; x=1698794992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kbYqBY7IEauB8HgG9o9iE1VCTMLQyNdkcObaWFVtpg=;
        b=HIR/NgXp841DHfz7bqOtXIn0edSCXwaVJMiO/hv56H7bHlSaWP0qhdbn/D6aMk+Y9a
         Yl8VBp3A0CNE2ab4U2HCmoC/X0MtavVAK+AYhX7OuY7SQbDsVVHfIicIAWkmkHRqv4fl
         pNGlrD6n+9mtIGihiwaqrKrIIWvxbRok8dmIaODOwUVYTdZfIP62ER8RoXeahBeBeKvD
         G817UZUeu8tb5sGr71UTaE6jTnqQ6bhz72Mh6A6zRbEzf6ycXXCKJxI6Zu8Z5aF+MMA+
         2IoPcSeE/ZveyWJFn+bTa06O3eZvrXC3CAgCGhp9FPBqB760Z+nu8zN6K3xkLxbZ+KzI
         2uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698190192; x=1698794992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kbYqBY7IEauB8HgG9o9iE1VCTMLQyNdkcObaWFVtpg=;
        b=A65xTSfnpuMnY/1pBKur22wOWyBTG6MOr+5wvYlpxLJWFXtQkr0bvayzPQM5AAadCh
         VglhFoGIVWIjDvgZyzhGSnb0L6NWfImzPmj4AUqHnj8lVR8zin/ZzQsr1i2XZk8NYNW7
         HwqWwqThH6582IKXkXuA9mq4n9FYMM5JelkMt9qeiKqbsEZq0s7GRQ1bPSi57cJUA4GL
         dDTzTP+UoPSf6gqZsEg6W6JhHbTDJ2K7C1tou0fNxQrglGXqSFO+mgoUgoWG422zfXl6
         30tjP4Zvvfz9s2rISRv7U2+1OmuINhtBfSyntd67Yf3/3dyYwEMdEMTH1m9lr6jw2Cpo
         XNog==
X-Gm-Message-State: AOJu0Ywv3MY000DWr8kfTegJYpdBNsWcX0DBRrO5hApS7R9IYD3joAoz
	Wh2ONPrw1jgjez1MIDB01aE=
X-Google-Smtp-Source: AGHT+IFVsC2JjtRaqHPgc4K2T6GMmdFrAk1r8HndtydifjHsrS8KeMYO9z3H/A5qCtEJAexHLOag4g==
X-Received: by 2002:ad4:5763:0:b0:658:65ed:7e8 with SMTP id r3-20020ad45763000000b0065865ed07e8mr17247656qvx.57.1698190192517;
        Tue, 24 Oct 2023 16:29:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r13-20020a0cf60d000000b0064f4ac061b0sm3965166qvm.12.2023.10.24.16.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 16:29:49 -0700 (PDT)
Message-ID: <83a69666-31d2-43c3-8612-2884f4570ff7@gmail.com>
Date: Tue, 24 Oct 2023 16:29:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 08/10] net: Add NAPI IRQ support
Content-Language: en-US
To: Amritha Nambiar <amritha.nambiar@intel.com>, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
 <169811124126.59034.7955140077923696489.stgit@anambiarhost.jf.intel.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <169811124126.59034.7955140077923696489.stgit@anambiarhost.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/23 18:34, Amritha Nambiar wrote:
> Add support to associate the interrupt vector number for a
> NAPI instance.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
[snip]

>   
> +static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
> +{
> +	napi->irq = irq;
> +}
> +
>   /* Default NAPI poll() weight
>    * Device drivers are strongly advised to not use bigger value
>    */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d02c7a0ce4bc..adf20fa02b93 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6507,6 +6507,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
>   	 */
>   	if (dev->threaded && napi_kthread_create(napi))
>   		dev->threaded = 0;
> +	napi->irq = -1;

Is there a reason you are not using netif_napi_set_irq() here?
-- 
Florian


