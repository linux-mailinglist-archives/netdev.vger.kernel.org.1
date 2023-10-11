Return-Path: <netdev+bounces-39963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DF27C5201
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B311C20C24
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26EA1E51A;
	Wed, 11 Oct 2023 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mzOzmH8D"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A1F1DA32
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 11:27:10 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3B9E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 04:27:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so1788970a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697023627; x=1697628427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tx44OmdH8AvzAnmc17r/0+R1TfYuVOlLDwB/vI8elw=;
        b=mzOzmH8DXiX+CGCC8A/ek5gS++7OpIT+IM4uaH8Dro10rHjg7gBuHeV7EcLpshhf2I
         23/zOprZhv/jg7SLiu58pLX3c+Now5SatYiaWk2N1owvFbI05cVTkbgZ4zN/kzN0D1Ey
         KyUodTMP6VYOFOK8MeohbXRS1PgFSkHeyv+U5xONyjMbpZT7rvQLfi8RJ4HuyFX/ONL7
         JWRZb0T2i5cVHmepYb51zzLwO6nrNzVBcELZ3stHZGZP3yAnBHMuY8vgc/5mzvHhfCl6
         nv9u/Fzi3HXwlfba+j0XfIhXrp8slra6t24fIpwV3qTVdQLLMN8l0+DcBHEIKgCTVcue
         5ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023627; x=1697628427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tx44OmdH8AvzAnmc17r/0+R1TfYuVOlLDwB/vI8elw=;
        b=EGmnZ1nav8rvWZski+3KRwwQXj2uUMbau4pe6zO3sPDz58rkz1CEwF7yzGLg3Tqcvo
         F5K/KXKdA5MX3alynQzLdwsHHVUQf0lkSUD6dP6gKhttST53rBpk7oTv/dWEHJs1FbsE
         NGy01KH+lgJ9jNZECIcagWGBIeSgzBF3XSZPS4GsKh6LRAiILo+379SIvMCNFHRSRffw
         +KiVhKDG3NbY5TDCEIxx9gOuO3ZezcJzZphB9NU8qpqQi5p4u361d1TjHGPLe82qzM6n
         CJSRSSI3iscTEW//9yNISnKUtvVhIKTTia+LjoFcUGCzaMLtVhHmhcJ/WsnvQ9NCVJ2u
         uN6A==
X-Gm-Message-State: AOJu0YxVEdHbBB/BH7jgA28nyx3MzpqXsycijyj1aWHeUahS2uaTXVbl
	HY7y6TJxDJ0L5vOzHMSYl9HN0g==
X-Google-Smtp-Source: AGHT+IF8jo3wwFKAZTk3KcJHRN2x+Cd7hmDJH+TJ+11D6N55qoMsAcUb4rXKfK6SOXUkl4tR3hKpOw==
X-Received: by 2002:a05:6402:2687:b0:530:8b92:b69d with SMTP id w7-20020a056402268700b005308b92b69dmr16471091edd.10.1697023627580;
        Wed, 11 Oct 2023 04:27:07 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d9-20020a05640208c900b005256771db39sm8833843edz.58.2023.10.11.04.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:27:06 -0700 (PDT)
Date: Wed, 11 Oct 2023 13:27:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: Re: [patch net-next 01/10] genetlink: don't merge dumpit split op
 for different cmds into single iter
Message-ID: <ZSaGiSKL5/ocFYOE@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-2-jiri@resnulli.us>
 <20231010114845.019c0f78@kernel.org>
 <ZSY7+b5qQhKgzXo5@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSY7+b5qQhKgzXo5@nanopsycho>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 11, 2023 at 08:08:57AM CEST, jiri@resnulli.us wrote:
>Tue, Oct 10, 2023 at 08:48:45PM CEST, kuba@kernel.org wrote:
>>On Tue, 10 Oct 2023 13:08:20 +0200 Jiri Pirko wrote:
>>> Fixes: b8fd60c36a44 ("genetlink: allow families to use split ops directly")
>>
>>Drop Fixes, add "currently no family declares ops which could trigger
>>this issue".
>
>Yeah, we need fixes semantics written down somewhere.
>I can do it, sure.

I found 2 mentions that relate to netdev regarging Fixes:

Quoting Documentation/process/submitting-patches.rst:
If your patch fixes a bug in a specific commit, e.g. you found an issue using
``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
the SHA-1 ID, and the one line summary. 

Quoting Documentation/process/maintainer-netdev.rst:
 - for fixes the ``Fixes:`` tag is required, regardless of the tree

This patch fixes a bug, sure, bug is not hit by existing code, but still
it is present.

Why it is wrong to put "Fixes" in this case?
Could you please document this?

>
>
>>
>>>  	if (i + cnt < family->n_split_ops &&
>>> -	    family->split_ops[i + cnt].flags & GENL_CMD_CAP_DUMP) {
>>> +	    family->split_ops[i + cnt].flags & GENL_CMD_CAP_DUMP &&
>>> +	    (!cnt ||
>>> +	     (cnt && family->split_ops[i + cnt].cmd == iter->doit.cmd))) {
>>
>>Why are you checking cnt? if do was not found cmd will be 0, which
>>cannot mis-match.
>
>Correct. Will remove cnt check.

