Return-Path: <netdev+bounces-44676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA8D7D9187
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844AA282171
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE75154A8;
	Fri, 27 Oct 2023 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="u09lpulH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7114F76
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:29:34 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D81BF
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:29:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98377c5d53eso277140766b.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698395369; x=1699000169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJFgb9ZP3i4MfWvgXY3fGE/+WWsgQLRJSNZ7IVF5jzQ=;
        b=u09lpulHVMEZYazucVBxbso5fHM+GIjiO4FzwCkcrhcNKC4ZHvR8QNL2tXXgh15mM/
         T3syXA5MFJpvBLS07pFdnuFifDs59+yeR8XrZoafJmNFK/QPYWbmdxmG4gGE68w5XRhz
         xhCbHHSv0goGStv9lyUIndKDLylrQaRgO/diGw2pm3FCvPlL0K0hMK1iHpbUsmj6C/gq
         uYuNO1EnBjFSaySGmanthjOdn920RPeG/9BWfMBQvJW1MzGDhhIYD3yKA3yqgEjIRH9Y
         84iQKYJQDked2tCF5awhQcYO1EbmjG/ozGZVDGO3C4iggdC/SqpC0YWiTjMwNraIP7Vk
         uIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698395369; x=1699000169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJFgb9ZP3i4MfWvgXY3fGE/+WWsgQLRJSNZ7IVF5jzQ=;
        b=v0pQgwETzzLSYH+5SKpxYV7Vey0hsEhRSTAE8CSoy6Z2fzj0JHvc4cYpWtIPEI+wtF
         YfnJBbMsLPAdg7zEY9qFHrQnkNEkh5jJjEr+pCJ8BmlDvpRQA8vYqCFal1j14gObGY5+
         KTZUzfqSapODtLoU56UM1LwlX/1gL+oYazn9S3cJHhskh7doL+a3a2PWp2gnSoQ705yE
         DUNc5I2YTRkYJEMvuSHuL7HMOa9vLW9L+6LnwcAVnkFpEqOiQsxf03Vd+LtMdy4bMIk8
         Oe+FYJoAHkeNZEe9z6lMHf4yKaG3SBG+s6cuQQOnbr3MXHJ0S0l5dwViCOPZW87w5/3p
         8R/Q==
X-Gm-Message-State: AOJu0YzKLmB9cvc/yKj/uS4cL5IX7E9atapKqZM/rPv8E/NGMMoG/bNF
	kcsfRHnylH2p4z08XJbuj9E1Vg==
X-Google-Smtp-Source: AGHT+IHU8Y2eekR5wyWuxXWwcVXXW7eOhMLEKXWspmu0iUhdOhdkYx6x8mQoCHUZD1Yr73puxqMqtA==
X-Received: by 2002:a17:907:d2a:b0:9c0:99c4:79e8 with SMTP id gn42-20020a1709070d2a00b009c099c479e8mr1660795ejc.6.1698395368637;
        Fri, 27 Oct 2023 01:29:28 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id la22-20020a170906ad9600b009cd52d08563sm819602ejb.223.2023.10.27.01.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:29:28 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:29:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	daniel.machon@microchip.com
Subject: Re: [patch iproute2-next v3 4/6] devlink: introduce support for
 netns id for nested handle
Message-ID: <ZTt05z87/89QXmcC@nanopsycho>
References: <20231024100403.762862-1-jiri@resnulli.us>
 <20231024100403.762862-5-jiri@resnulli.us>
 <20aa5630-9a91-4753-be38-6e3481165fc0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20aa5630-9a91-4753-be38-6e3481165fc0@gmail.com>

Thu, Oct 26, 2023 at 07:08:04PM CEST, dsahern@gmail.com wrote:
>On 10/24/23 4:04 AM, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Nested handle may contain DEVLINK_ATTR_NETNS_ID attribute that indicates
>> the network namespace where the nested devlink instance resides. Process
>> this converting to netns name if possible and print to user.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v2->v3:
>> - moved netns_name_by_id() into lib/namespace.c
>> - s/netns_name_by_id/netns_name_from_id/
>> - rebased on top of new patch "devlink: extend pr_out_nested_handle() to
>>   print object"
>> v1->v2:
>> - use previously introduced netns_netnsid_from_name() instead of code
>>   duplication for the same function.
>> - s/nesns_name_by_id_func/netns_name_by_id_func/
>> ---
>>  devlink/devlink.c   | 23 ++++++++++++++++++++++-
>>  include/namespace.h |  1 +
>>  lib/namespace.c     | 34 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 57 insertions(+), 1 deletion(-)
>> 
>> diff --git a/devlink/devlink.c b/devlink/devlink.c
>> index f7325477f271..7ba2d0dcac72 100644
>> --- a/devlink/devlink.c
>> +++ b/devlink/devlink.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/genetlink.h>
>>  #include <linux/devlink.h>
>>  #include <linux/netlink.h>
>> +#include <linux/net_namespace.h>
>>  #include <libmnl/libmnl.h>
>>  #include <netinet/ether.h>
>>  #include <sys/select.h>
>> @@ -722,6 +723,7 @@ static const enum mnl_attr_data_type devlink_policy[DEVLINK_ATTR_MAX + 1] = {
>>  	[DEVLINK_ATTR_LINECARD_SUPPORTED_TYPES] = MNL_TYPE_NESTED,
>>  	[DEVLINK_ATTR_NESTED_DEVLINK] = MNL_TYPE_NESTED,
>>  	[DEVLINK_ATTR_SELFTESTS] = MNL_TYPE_NESTED,
>> +	[DEVLINK_ATTR_NETNS_ID] = MNL_TYPE_U32,
>>  };
>>  
>>  static const enum mnl_attr_data_type
>> @@ -2865,7 +2867,26 @@ static void __pr_out_nested_handle(struct dl *dl, struct nlattr *nla_nested_dl,
>>  		return;
>>  	}
>>  
>> -	__pr_out_handle_start(dl, tb, false, false);
>> +	__pr_out_handle_start(dl, tb, tb[DEVLINK_ATTR_NETNS_ID], false);
>> +	if (tb[DEVLINK_ATTR_NETNS_ID]) {
>> +		int32_t id = mnl_attr_get_u32(tb[DEVLINK_ATTR_NETNS_ID]);
>> +
>> +		if (id >= 0) {
>
>why does the kernel side even add DEVLINK_ATTR_NETNS_ID if
>peernet2id_alloc fails?

Yep. So the user knows that this is in a different namespace. This
logic is copied from iplink


>
>
>> +			char *name = netns_name_from_id(id);
>> +
>> +			if (name) {
>> +				print_string(PRINT_ANY, "netns",
>> +					     " netns %s", name);
>> +				free(name);
>> +			} else {
>> +				print_int(PRINT_ANY, "netnsid",
>> +					  " netnsid %d", id);
>> +			}
>> +		} else {
>> +			print_string(PRINT_FP, NULL, " netnsid %s", "unknown");
>> +			print_int(PRINT_JSON, "netnsid", NULL, id);
>
>ie., how is -1 useful to userspace?

The userspace knows that this device is in a different netnamespace, but
it is unknown as peernet2id_alloc failed. Should be really a rare
corner case when system is under memory pressure.


>
>
>> +		}
>> +	}
>>  	pr_out_handle_end(dl);
>>  }
>>  
>
>

