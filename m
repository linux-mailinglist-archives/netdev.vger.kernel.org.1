Return-Path: <netdev+bounces-44531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E79B7D873A
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 19:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E545B21067
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0374A381D8;
	Thu, 26 Oct 2023 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8MApbiF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6E381C4
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 17:08:07 +0000 (UTC)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C2194
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:08:06 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35807d3efdfso2763835ab.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698340085; x=1698944885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OurrEE1mJhGINm9bc53oEZP2bHsZa3JLAlwp8DlC7RA=;
        b=i8MApbiF93ZWWAbF/m9HFCNlKYl+DXkaAiJilJPIQiR0qbnBKa+OuY9ySpnRuUWsjv
         C67MODW2iOPHgb2MGYCBesaAluOgyqY4tt1aJmW3opsfVdoyBk0AkzY1zorAjaggVMLE
         w0CunnY50ss4gVCH4f1xh4dzXQTwy8owG+oXaeVZoyCBfExJZxrRjsivM//G/xYEIp11
         A4FdIzKPXMBbaUarKCEO6UrtYgehhHeL/bGsx9KGR555kKDcprar4V8GGDDrQJENLP1Z
         iKlc9wVvfRI2le/bsv9jp/+V1QhbPjBgX1hmHzLpEa4kokvCx44kd3YPIAlmHTmntZC8
         ES0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340085; x=1698944885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OurrEE1mJhGINm9bc53oEZP2bHsZa3JLAlwp8DlC7RA=;
        b=h3HZf5jGeq8Y1WmVqljwAP+zSaMXPRN7ugrE7yIhLuO5NuP7PhIU4690z0DmxQBhke
         ilsm2UeEtqcEl9oRYWhyVDNklQafMap6N+T7ZfzA8IxDXSbknzOV1rv3APialty3EDsH
         dBPkt0vn3JhMlWaBBOYoXZa1aNvJCzeSkeiGnAgf7QoQsOeLqQWMzF1FsNhb/YrjrSm7
         GIMQ++vDXKeLRBJ3e9sg2/7SSYkbZ1YqNxovXkyTJ3NfN6feN20F7Ej1PxdnSXAl0J0w
         sVFwkEnu4NER7onAAgPjfea+lpwmznCo6WtD31Y8rUFoga2OSUyh65Bd2dTP4QgEu5i9
         Ag6Q==
X-Gm-Message-State: AOJu0YyvIL9193sYkGIgA6LljAfDzSfnQgzHPIpg/o4CKA/SfjWsmsBo
	3B/DOHnMOixMakiRV79Bu9R0tnlujpQ=
X-Google-Smtp-Source: AGHT+IEDAdg9wMdcnMA5yUcotopNYx7Ie3hox7VSsK25Z5nXlnC93iNaQtt3IB4yyq7sIfxEBa7EZA==
X-Received: by 2002:a05:6e02:1689:b0:34f:1e9c:45e0 with SMTP id f9-20020a056e02168900b0034f1e9c45e0mr496099ila.3.1698340085614;
        Thu, 26 Oct 2023 10:08:05 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:542:b658:250a:2f23? ([2601:282:1e82:2350:542:b658:250a:2f23])
        by smtp.googlemail.com with ESMTPSA id t1-20020a92c901000000b003574d091a7esm4476966ilp.49.2023.10.26.10.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 10:08:05 -0700 (PDT)
Message-ID: <20aa5630-9a91-4753-be38-6e3481165fc0@gmail.com>
Date: Thu, 26 Oct 2023 11:08:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch iproute2-next v3 4/6] devlink: introduce support for netns
 id for nested handle
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, daniel.machon@microchip.com
References: <20231024100403.762862-1-jiri@resnulli.us>
 <20231024100403.762862-5-jiri@resnulli.us>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231024100403.762862-5-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 4:04 AM, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Nested handle may contain DEVLINK_ATTR_NETNS_ID attribute that indicates
> the network namespace where the nested devlink instance resides. Process
> this converting to netns name if possible and print to user.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v2->v3:
> - moved netns_name_by_id() into lib/namespace.c
> - s/netns_name_by_id/netns_name_from_id/
> - rebased on top of new patch "devlink: extend pr_out_nested_handle() to
>   print object"
> v1->v2:
> - use previously introduced netns_netnsid_from_name() instead of code
>   duplication for the same function.
> - s/nesns_name_by_id_func/netns_name_by_id_func/
> ---
>  devlink/devlink.c   | 23 ++++++++++++++++++++++-
>  include/namespace.h |  1 +
>  lib/namespace.c     | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/devlink/devlink.c b/devlink/devlink.c
> index f7325477f271..7ba2d0dcac72 100644
> --- a/devlink/devlink.c
> +++ b/devlink/devlink.c
> @@ -24,6 +24,7 @@
>  #include <linux/genetlink.h>
>  #include <linux/devlink.h>
>  #include <linux/netlink.h>
> +#include <linux/net_namespace.h>
>  #include <libmnl/libmnl.h>
>  #include <netinet/ether.h>
>  #include <sys/select.h>
> @@ -722,6 +723,7 @@ static const enum mnl_attr_data_type devlink_policy[DEVLINK_ATTR_MAX + 1] = {
>  	[DEVLINK_ATTR_LINECARD_SUPPORTED_TYPES] = MNL_TYPE_NESTED,
>  	[DEVLINK_ATTR_NESTED_DEVLINK] = MNL_TYPE_NESTED,
>  	[DEVLINK_ATTR_SELFTESTS] = MNL_TYPE_NESTED,
> +	[DEVLINK_ATTR_NETNS_ID] = MNL_TYPE_U32,
>  };
>  
>  static const enum mnl_attr_data_type
> @@ -2865,7 +2867,26 @@ static void __pr_out_nested_handle(struct dl *dl, struct nlattr *nla_nested_dl,
>  		return;
>  	}
>  
> -	__pr_out_handle_start(dl, tb, false, false);
> +	__pr_out_handle_start(dl, tb, tb[DEVLINK_ATTR_NETNS_ID], false);
> +	if (tb[DEVLINK_ATTR_NETNS_ID]) {
> +		int32_t id = mnl_attr_get_u32(tb[DEVLINK_ATTR_NETNS_ID]);
> +
> +		if (id >= 0) {

why does the kernel side even add DEVLINK_ATTR_NETNS_ID if
peernet2id_alloc fails?


> +			char *name = netns_name_from_id(id);
> +
> +			if (name) {
> +				print_string(PRINT_ANY, "netns",
> +					     " netns %s", name);
> +				free(name);
> +			} else {
> +				print_int(PRINT_ANY, "netnsid",
> +					  " netnsid %d", id);
> +			}
> +		} else {
> +			print_string(PRINT_FP, NULL, " netnsid %s", "unknown");
> +			print_int(PRINT_JSON, "netnsid", NULL, id);

ie., how is -1 useful to userspace?


> +		}
> +	}
>  	pr_out_handle_end(dl);
>  }
>  



