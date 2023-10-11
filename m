Return-Path: <netdev+bounces-40063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFE07C59BC
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 19:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701C02820CB
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907FF208CC;
	Wed, 11 Oct 2023 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2OrgEJpw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716A200C4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:00:09 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DBA8F
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:00:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso2564043a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697043603; x=1697648403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z77EMHX9KsGdyJVrgOdxmt5oAQMs6s95ci61Y1ZZk9w=;
        b=2OrgEJpwiEQZ/JlvhEYWebJsZV7AvPZgbBJPbtHCnrRkxaqY2qVahtGSoaQe33XRwb
         B3rFDzfP/htNL/rATj+nFaBxNIYAbNXhesDniMNpEQUg4aooD8er/04xshNf97Yxjecl
         ZHtg/WAPWHroUOK/nT3brKSWKKYVQ8wKLNDQI7lFwXCv5H2ksHk5ELLIjBIMowAbC0EK
         PYqYNSDoIBw+Bw6oQ+eYz7AwFAwDPcQDXrAiD4e2/tfLxqAfWtPmfg1kH3aZYrHpAJBw
         70nhlq5fWD9+0e/v9tDtpLMa4PPMqyfWyEuX5Udm2jg87R6JWCh0YuWGhL0kpmyi5kUT
         DVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043603; x=1697648403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z77EMHX9KsGdyJVrgOdxmt5oAQMs6s95ci61Y1ZZk9w=;
        b=UaswOewfycUkrF4CpuwinxAspaB14vpsibGw+mExisNIKXxl7+fKpNqyyBZg+jgInA
         OzWVtT3JK16i7NPUBLnZgoHGVNwPAzq7fVDa6QpsD5jSRd2/3rgXMu9W08P95d+SZamy
         NccqmDv7E2R3U6ltBxAIehWzD12Bbf+kO/TqZe0BjcXL2feWjhN+FZCVDgCCfjjCerke
         bUkP3nO2KiHPGaEZBoLRJQ8m6TnDlfMbj7tZqOTSsF2/UHlvX47+Em6+eTHT0A4kf2Cv
         jlneMo0Q7v3/OuhRxPtLMcKM04LP5RRer0ELJ89tQSnJySvwjb3ntyZKJO47ZunpyWA2
         iUKw==
X-Gm-Message-State: AOJu0YyPXN9CraKsgEHf8WUbCo4gpa3ZICPurW3QA7g/606R7dGbuQ7Z
	Lgx2aHq7PlQ0HChPVEZleuUKMw==
X-Google-Smtp-Source: AGHT+IFaRJuH6GpWoqX3S5BKiiLXh//3F89IJNJvNcv2syeh2fYIdY/uDaUCb+veohY9TWBA+9c02w==
X-Received: by 2002:aa7:d14d:0:b0:533:c3d9:767a with SMTP id r13-20020aa7d14d000000b00533c3d9767amr18020505edo.3.1697043603117;
        Wed, 11 Oct 2023 10:00:03 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l21-20020aa7d955000000b00537f44827a8sm9075313eds.64.2023.10.11.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:00:02 -0700 (PDT)
Date: Wed, 11 Oct 2023 19:00:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: Re: [patch net-next 05/10] netlink: specs: devlink: fix reply
 command values
Message-ID: <ZSbUkXcmI4rV2e+S@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-6-jiri@resnulli.us>
 <20231010115935.58b4b2ea@kernel.org>
 <ZSY666H7J9eq/Ext@nanopsycho>
 <20231011094404.0acb9c0a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011094404.0acb9c0a@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 11, 2023 at 06:44:04PM CEST, kuba@kernel.org wrote:
>On Wed, 11 Oct 2023 08:04:27 +0200 Jiri Pirko wrote:
>>> Still, I think this needs net.  
>> 
>> It affects only userspace generated code, that's why I didn't bother. 
>> If you insist, I can send separate patch to net.
>
>Yes, please.

Ok.

