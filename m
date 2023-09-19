Return-Path: <netdev+bounces-35038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1FE7A6982
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8791D1C209A2
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235AC374C7;
	Tue, 19 Sep 2023 17:19:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78FA3716F
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 17:19:40 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E321C6
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:19:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32008b5e2d2so30546f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695143976; x=1695748776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvDAkbLnJfb4PBzlxbBupZm+yHV2T9qL05Lxc2aV6oQ=;
        b=sWyL8ZmHupvXMx3d1s6FuCl6D5qxYdBqmuvWnq8IxcpIQRGXYOUDYThIr4jFNWo+55
         kuI1NGgditkEOsiqBrGKc0mTDF6GXB/2nFrtsFzmLF/kGhkioCp62xFeFvt57PYoKwJ2
         QTpj8bfjRVc2AqmqScsKjIj84i8jhgeWpYuTIbXtFJTFypzgXjSqqbwGWNQDSrDCntt+
         levQJw+sMm0J/9pmKgUCIWwprq+RCVZYCrT5bTIgdfjPchBcj4m87fsGtfXeaosQnfJM
         8UbZADGbf6IahSdrH37FalCyth47gXW0+tHoox1p1DPOqdQ1Lb1jjhNqsD3ER5WLyod4
         L98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695143976; x=1695748776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvDAkbLnJfb4PBzlxbBupZm+yHV2T9qL05Lxc2aV6oQ=;
        b=MgAWrRgBqf2N/ZkYvHANPxfeFyzDW63oGHIkGnx3w9hDwUumc0AgwotNfXZjPxbIGz
         0UOboGV/x7EKFeIeLjkaiSTwD2Q++NwyX2m4guLfhAdGpkwTwF7AMyqhETfkRxOKr7//
         EvjoliPIKZJ+MKk98+RiR9fFuRIrQWxVNE8N6auu5iWmzB0g+vIPHjlI/VG6HPgaQj4s
         uwBx+wQJ2NeBYQDPLEdMvbOq1on3iw7A7sWqS1yNo91D18ifPu4yurYDBmBABCZW5Cbg
         jhu1/P8Q2VcaPpklXOk3dwzdLU4Y8j3RdyQYPq8mE0knGEQ9y1YYM39UKNtN9xRPxaz1
         48QQ==
X-Gm-Message-State: AOJu0YxZ1nY/7Pe3sYKEBVgP9pYyCs9gtnXSHepUP0xhV4F4z8uJ/FH/
	GeftTS/wFLdGdqA1LmrslJChTg==
X-Google-Smtp-Source: AGHT+IHrV6bp1hvaXfWKHUuFqXaA+AyEV6R4uAqpieBsVhwmW+XMrrre5qDr8het1JerQN0DmNET6w==
X-Received: by 2002:a5d:494e:0:b0:317:558c:c15e with SMTP id r14-20020a5d494e000000b00317558cc15emr2709851wrs.27.1695143976081;
        Tue, 19 Sep 2023 10:19:36 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p6-20020a7bcc86000000b003fbdbd0a7desm18528941wma.27.2023.09.19.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:19:35 -0700 (PDT)
Date: Tue, 19 Sep 2023 19:19:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	daniel.machon@microchip.com
Subject: Re: [patch iproute2-next v2 2/5] ip/ipnetns: move internals of
 get_netnsid_from_name() into namespace.c
Message-ID: <ZQnYJnPKtDaBV0Zb@nanopsycho>
References: <20230919115644.1157890-1-jiri@resnulli.us>
 <20230919115644.1157890-3-jiri@resnulli.us>
 <a4a7f033-e072-15c5-0084-7039456cf4db@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a7f033-e072-15c5-0084-7039456cf4db@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Sep 19, 2023 at 04:03:26PM CEST, dsahern@gmail.com wrote:
>On 9/19/23 5:56 AM, Jiri Pirko wrote:
>> diff --git a/lib/namespace.c b/lib/namespace.c
>> index 1202fa85f97d..39981d835aa5 100644
>> --- a/lib/namespace.c
>> +++ b/lib/namespace.c
>> @@ -7,9 +7,11 @@
>>  #include <fcntl.h>
>>  #include <dirent.h>
>>  #include <limits.h>
>> +#include <linux/net_namespace.h>
>>  
>>  #include "utils.h"
>>  #include "namespace.h"
>> +#include "libnetlink.h"
>>  
>>  static void bind_etc(const char *name)
>>  {
>> @@ -139,3 +141,50 @@ int netns_foreach(int (*func)(char *nsname, void *arg), void *arg)
>>  	closedir(dir);
>>  	return 0;
>>  }
>> +
>> +int netns_netnsid_from_name(struct rtnl_handle *rtnl, const char *name)
>
>just netns_id_from_name or netns_name_to_id. See comment in next patch ....

Sure.

>

