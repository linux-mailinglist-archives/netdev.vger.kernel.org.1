Return-Path: <netdev+bounces-40064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D418B7C59BE
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 19:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5C2280F55
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A5208CC;
	Wed, 11 Oct 2023 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Lt9vqojr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356921B292
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:00:56 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215B09D
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:00:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-503065c4b25so129719e87.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697043649; x=1697648449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptSN1gkerKqWFVsddFI9jJ9NU3511ue9jSghRGtvT7w=;
        b=Lt9vqojrnV4XzlEX0BfVoxnMRrUMTru3Wa13qRP4Ts4wpW1TqviuzCBpjTiUdnjZkI
         PLsHpWijaXy2BHyh4v1PmWjvu5pOZhoqPCpoM0+9oRTpNEdMzlN2nrTrQHYeKfkLYJx3
         4ldq9fIZ1EJPn6BJIa16KtPRP+pLMs8EQcmcEUqW1mCvn5oMA9hkvJsLhcCvJkwCMPMj
         eWAjwWzAikEz+jhGHbp27SU+xrv80rG0lzjqbYzPdXAy0+dLJVCreU8OYWai/G4wErNF
         hs9BperCC2PVh7/UeJKOR+5XQ9CZNj1/i8apDuvfKQpUGHiQKFROhZDuxASF1XkSmgmm
         WddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043649; x=1697648449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptSN1gkerKqWFVsddFI9jJ9NU3511ue9jSghRGtvT7w=;
        b=a/jsFy7VodEeIrx/5CuLo/Cohd+gWn1T1+imhxZSn3+5XwuaU9rR5nXW6be2EX9ZtS
         TI3Db2+GhOBgUM5ylIltf+WLZBDLm2se8qBa3xyk1SatE13WkeuJkqcGAPFvE3w7/SQc
         lOf0UQaA5a0ogoVzbpsCfRnkt2YCdwF1Dw5eQwcFuqyw+7RFYlnaUJ3k4WpRVvA+xZRY
         D2Yrulwz/ewnP8Cy61SX2mmn85Tfvfctwt1UiWyYzG2WMRGRkL4cl49R4DtL7sWu9brM
         s3pOekE+mIwEsFi5fHDMIpmmVIvV/XRT0XRFzNvNg0ThISJj9Fnkxtu2/GhN6SOlY9rJ
         Udmg==
X-Gm-Message-State: AOJu0YwJGMe5BFDcSv2RVknQU2WXNPvadD2BPDhkikw7GVr7YBVos9ni
	t34HvmR8jQ2fBrVi0ozrAntmxw==
X-Google-Smtp-Source: AGHT+IGPReBpfdCYrT6wZlV2Hb6gMr2DOxXCRcpOUjaBE1INbOfijY7hpCxlLzimXDowR2HwThlaWw==
X-Received: by 2002:a05:6512:3b25:b0:503:3805:e902 with SMTP id f37-20020a0565123b2500b005033805e902mr24662432lfv.30.1697043649166;
        Wed, 11 Oct 2023 10:00:49 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id gx13-20020a170906f1cd00b009ad8d444be4sm9956715ejb.43.2023.10.11.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:00:48 -0700 (PDT)
Date: Wed, 11 Oct 2023 19:00:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: Re: [patch net-next 01/10] genetlink: don't merge dumpit split op
 for different cmds into single iter
Message-ID: <ZSbUv3Q+K26amgJN@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-2-jiri@resnulli.us>
 <20231010114845.019c0f78@kernel.org>
 <ZSY7+b5qQhKgzXo5@nanopsycho>
 <ZSaGiSKL5/ocFYOE@nanopsycho>
 <20231011094702.06ace023@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011094702.06ace023@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 11, 2023 at 06:47:02PM CEST, kuba@kernel.org wrote:
>On Wed, 11 Oct 2023 13:27:05 +0200 Jiri Pirko wrote:
>> >Yeah, we need fixes semantics written down somewhere.
>> >I can do it, sure.  
>> 
>> I found 2 mentions that relate to netdev regarging Fixes:
>> 
>> Quoting Documentation/process/submitting-patches.rst:
>> If your patch fixes a bug in a specific commit, e.g. you found an issue using
>> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
>> the SHA-1 ID, and the one line summary. 
>> 
>> Quoting Documentation/process/maintainer-netdev.rst:
>>  - for fixes the ``Fixes:`` tag is required, regardless of the tree
>> 
>> This patch fixes a bug, sure, bug is not hit by existing code, but still
>> it is present.
>> 
>> Why it is wrong to put "Fixes" in this case?
>> Could you please document this?
>
>I think you're asking me to document what a bug is because the existing
>doc clearly says Fixes is for bugs. If the code does not misbehave,
>there is no bug.

Interesting. Will try to remember :)

