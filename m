Return-Path: <netdev+bounces-37011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E137B3123
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 13:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B9DBA28231A
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD63916436;
	Fri, 29 Sep 2023 11:18:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6066C157
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:18:31 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2BE1B1
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 04:18:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso1938085066b.2
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695986307; x=1696591107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9fclgwxgacBkIITICuy/IWzZ2BPswGWBVkjKldpyxs=;
        b=FoDFbKD9oKlx7BIBdtWjObV4W9ovFERPNgoVmut4R7xD4LPZUIzBT1jckh2ZHPVvao
         pEj7tajFKr4l/dXhDHTeAaUTV21gRxQrI/6vuHrhcD+vIsDAZw20HTHBIYF4ikuDJOUJ
         GD/+r840MUOh81KjiNacFTfy63uYnt2dVOTJ8/TpLl2k6uO9Cph5LodTuThysFgogStp
         M5oDrl0BY4pkn44WIpXBgF7aIUtbLfryJ998ZXUe9p47ijwvLn1OgJEANhZnVfCCcNnu
         gHAgOg6dD/gxxhWj7lStT8FIynGXugN5sK6resrumQM2fw1cbi5FCA+saA3dUOa4uYEA
         QQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695986307; x=1696591107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9fclgwxgacBkIITICuy/IWzZ2BPswGWBVkjKldpyxs=;
        b=mI8uMbpFAqmR/73M/6Arsy3V113GJX+QvsdyUCk4FlayBwexlPJBlAuTBMCZ5bwcJi
         yZJEAtkvFA9KljNy9eiPYE8mxztSFueK3kKYx4tt9+loACoOeLb8ec9lq4mBDIhReWo8
         25SW1oW9iiKxcQyZQiGl/mDjr2DOM2DH98UNQJ/bFYdFcERJOoLZtKxuYoji3Osy89FY
         cnU7LCXX+Q8eyOzYdnW0uFlOWxUMTLIZ8tZqIGzCyHRP5PlYBnzb+PQ5VB6uICovBHVG
         M7ZjyWvTZeVgrudkNG7diuOAbQ+5xeSK4hsWJwI8VyWpuh9uqB+/o6lB7+3qezF8oSyw
         8BKw==
X-Gm-Message-State: AOJu0YzWB0/1twQP4UtFiGIg9JPQLeqAjEsAeD93IJTAC0gj+rLyfhui
	iGzrruv9jFB9X9NZyJSYP/+uYA==
X-Google-Smtp-Source: AGHT+IE0NWeOXAUPU5FsZ8nLtPdSHFzfG2Gab0SY6mUyKINyfytJlJC211a7w21ICtiNNIhJpw9KUg==
X-Received: by 2002:a17:906:30c2:b0:9ae:7150:af95 with SMTP id b2-20020a17090630c200b009ae7150af95mr3558741ejb.54.1695986306756;
        Fri, 29 Sep 2023 04:18:26 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m5-20020a1709062b8500b009928b4e3b9fsm12199832ejg.114.2023.09.29.04.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 04:18:26 -0700 (PDT)
Date: Fri, 29 Sep 2023 13:18:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next] tools: ynl-gen: lift type requirement for
 attribute subsets
Message-ID: <ZRaygRMJTnQ1H8+1@nanopsycho>
References: <20230919142139.1167653-1-jiri@resnulli.us>
 <ffeeac4ea45e5a087aab44ac137a945111d941e7.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffeeac4ea45e5a087aab44ac137a945111d941e7.camel@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Sep 28, 2023 at 12:15:22PM CEST, pabeni@redhat.com wrote:
>On Tue, 2023-09-19 at 16:21 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> In case an attribute is used in a subset, the type has to be currently
>> specified. As the attribute is already defined in the original set, this
>> is a redundant information in yaml file, moreover, may lead to
>> inconsistencies.
>> 
>> Example:
>> attribute-sets:
>>     ...
>>     name: pin
>>     enum-name: dpll_a_pin
>>     attributes:
>>       ...
>>       -
>>         name: parent-id
>>         type: u32
>>       ...
>>   -
>>     name: pin-parent-device
>>     subset-of: pin
>>     attributes:
>>       -
>>         name: parent-id
>>         type: u32             <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>> 
>> Remove the requirement from schema files to specify the "type" and add
>> check and bail out if "type" is not set.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>What about updating accordingly the existing specs? They are used as
>references, I think it would be better if the info there would be
>consistent.

Okay, will check that out. I will try to update some.


>
>I think the tool still allows writing something alike:
>
>    attributes:
>      ...
>      -
>        name: parent-id
>        type: u32
>      ...
>  -
>    name: pin-parent-device
>    subset-of: pin
>    attributes:
>      -
>        name: parent-id
>        type: string
>
>(mismatching types). What about adding an explicit test to prevent
>specifying again the types for already defined attributes?

Good point. Will check.


>
>Cheers,
>
>Paolo
>

