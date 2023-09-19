Return-Path: <netdev+bounces-35037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D17A697E
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490001C20A20
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3C33716F;
	Tue, 19 Sep 2023 17:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC68814
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 17:19:15 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C80AD
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:19:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so63077005e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695143951; x=1695748751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaskWQQiFjlTz9MjSMaWDulsW6ZeGw3HwwgCo0AhQRU=;
        b=ngLsnrqFCYB6E1G/xtljouePG3nZ+ofBDUle9MRseXzWFpMxdro7V9W2RsHhfTXeXf
         P/iAVXr4kihjOV6taXb86CANyQafuXjUBTMRJandJl0p7hphITkdZkt81fu0DlWPN95C
         0c+VIigtMb4jdSi21YuDUAo61pbKXx/sxpTV/E3gk7zm1eBrsGtCTFFrO+JFYvg59v5M
         Oz+OvQtlUxhZBFx1rIgKTKPSA//lDg9RAqhXLGiyVjY0eeURniW2EPbc5I/Zab/zYbCd
         FZsLEB5XQ3pAWk713+dd5QT/FDqIBRPfMi57+pOv0zKyrrYVq+aJ7Pgi53JcgvGRDanF
         xjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695143951; x=1695748751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaskWQQiFjlTz9MjSMaWDulsW6ZeGw3HwwgCo0AhQRU=;
        b=bc0bYhKQ6znZLvhKaBxLI6DFuDL0soJQSmIGsm8cNJL7EZey4IS4gmWdGzYR8yaPYX
         6ONYQFDRDzWgsyb3gisc8ePml8Yu9jGWR0ZAHNnS+wImBsnK3qIqyBJ4QK/cyNhw5Dvx
         kBOmsHeaNE2HPIjmzDc6cnmj6mF266RecYP32xWgGI/lyVl3vl7TUmCoRf8Ux2WwhMuK
         LL/9JeSxS4vVZvvSZVtcy6zuyhuN0chNlYGnxjNw0DvP5SGUBHxHPEN6iI+w9zbzg5Uo
         p0EH+K3Q9Ib6YGN3XJzNLXAaIY9uKdSua3GF5BagZ3keZzIny//FuxLNDZeVLjYS4ayT
         8Czw==
X-Gm-Message-State: AOJu0YwBvuhJpRIhjaew7vdGJvIy66k/6QJOEEZHFogKOlRrlfznTiZv
	fO0ZMaZt6tgNdQc+NS+Z4eJ+Kw==
X-Google-Smtp-Source: AGHT+IGAp2IRRRmK/hnBUI6gm0Oae9nsb9ykQU9uvEo/VDUW/8IaaK2LaeObX7/iEXUnl8lBWCUi8g==
X-Received: by 2002:a7b:c453:0:b0:405:1bfb:ff14 with SMTP id l19-20020a7bc453000000b004051bfbff14mr401205wmi.9.1695143950752;
        Tue, 19 Sep 2023 10:19:10 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003fef60005b5sm15807270wmh.9.2023.09.19.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:19:10 -0700 (PDT)
Date: Tue, 19 Sep 2023 19:19:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	daniel.machon@microchip.com
Subject: Re: [patch iproute2-next v2 3/5] devlink: introduce support for
 netns id for nested handle
Message-ID: <ZQnYDVBeuIRn7uwK@nanopsycho>
References: <20230919115644.1157890-1-jiri@resnulli.us>
 <20230919115644.1157890-4-jiri@resnulli.us>
 <3652856a-1cda-c050-04da-fe2204949ff5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3652856a-1cda-c050-04da-fe2204949ff5@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Sep 19, 2023 at 04:03:27PM CEST, dsahern@gmail.com wrote:
>On 9/19/23 5:56 AM, Jiri Pirko wrote:
>> @@ -2723,6 +2725,40 @@ static bool should_arr_last_handle_end(struct dl *dl, const char *bus_name,
>>  	       !cmp_arr_last_handle(dl, bus_name, dev_name);
>>  }
>>  
>> +struct netns_name_by_id_ctx {
>> +	int32_t id;
>> +	char *name;
>> +	struct rtnl_handle *rth;
>> +};
>> +
>> +static int netns_name_by_id_func(char *nsname, void *arg)
>> +{
>> +	struct netns_name_by_id_ctx *ctx = arg;
>> +	int32_t ret;
>> +
>> +	ret = netns_netnsid_from_name(ctx->rth, nsname);
>> +	if (ret < 0 || ret != ctx->id)
>> +		return 0;
>> +	ctx->name = strdup(nsname);
>> +	return 1;
>> +}
>> +
>> +static char *netns_name_by_id(int32_t id)
>> +{
>> +	struct rtnl_handle rth;
>> +	struct netns_name_by_id_ctx ctx = {
>> +		.id = id,
>> +		.rth = &rth,
>> +	};
>> +
>> +	if (rtnl_open(&rth, 0) < 0)
>> +		return NULL;
>> +	netns_foreach(netns_name_by_id_func, &ctx);
>> +	rtnl_close(&rth);
>> +
>> +	return ctx.name;
>> +}
>> +
>
>The above is not devlink specific, so it should go in lib/namespace.c as
>well.
>
>Name wise it should be consistent with the last patch, so either
>netns_id_to_name or netns_name_from_id based on the name from the
>refactoring in patch 2.

Okay.

>
>
>>  static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>>  {
>>  	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
>> @@ -2740,6 +2776,30 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>>  	sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
>>  		mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
>>  	print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
>> +
>> +	if (tb[DEVLINK_ATTR_NETNS_ID]) {
>> +		int32_t id = mnl_attr_get_u32(tb[DEVLINK_ATTR_NETNS_ID]);
>> +
>> +		if (id >= 0) {
>> +			char *name = netns_name_by_id(id);
>> +
>> +			if (name) {
>> +				print_string(PRINT_ANY,
>> +					     "nested_devlink_netns",
>> +					     " nested_devlink_netns %s", name);
>> +				free(name);
>> +			} else {
>> +				print_int(PRINT_ANY,
>> +					  "nested_devlink_netnsid",
>> +					  " nested_devlink_netnsid %d", id);
>> +			}
>> +		} else {
>> +			print_string(PRINT_FP, NULL,
>> +				     " nested_devlink_netnsid %s", "unknown");
>> +			print_int(PRINT_JSON,
>> +				  "nested_devlink_netnsid", NULL, id);
>> +		}
>
>Also, devlink in the name here provides no addititional value (devlink
>is the command name) and why add 'nested'? The attribute is just
>NETNS_ID, so why not just 'netnsid' here.

Well, it is a netnsid of the nested devlink instance, not the object
(e.g. port) itself. Omitting that would be misleading. Any idea how to
do this differently?


>
>
>> +	}
>>  }
>>  
>>  static void __pr_out_handle_start(struct dl *dl, struct nlattr **tb,
>

