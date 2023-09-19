Return-Path: <netdev+bounces-34993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA867A661B
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AD5281F27
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688A538DD2;
	Tue, 19 Sep 2023 14:03:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235303C07
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:03:31 +0000 (UTC)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EE6F2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:03:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7926b7f8636so141625639f.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695132209; x=1695737009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtVLO2haBgS3lLOL325dUaSh5qZMcnVFUSZOYjIbPBw=;
        b=bmRdIR2p5fME2uz0fMqR4K0Wd6xYVv1x91JSS6N/YJ46cTUtyiUfdqA0fS6oxvhDQY
         b2XxWxMYdheDiccrnan3Lh0ElbHofWQ5d3M5krI44i9gY7vOV8ASdzVSuU8q+HjY2nmz
         MACHabZEcT1Du9ZPo23A5qmWElqTXsef1/vzgnkvJ+49q9AlUHGMl1c9Y7FBqZCUNG4m
         Xm3vmyhfZD59+UUI65tleTIzkSQhjjPBxWkE29CNUc7FLd1/TCesBCokVm8EbU+S8lCC
         s2XY73UiPHcN//s0o4XU9Yn00Z/Iwv99OB4TqspHWveWXaJVCCUWR5nPqPmBFHV/Ef1V
         E3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132209; x=1695737009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtVLO2haBgS3lLOL325dUaSh5qZMcnVFUSZOYjIbPBw=;
        b=mQrhv3YSdbk8YLXYPwU03DPGhaU6gXZ0l/eHlTqTogZ9xAeZo0QJagNKlRnIy4gHzw
         Q4zvoA2OFggbr5jBuy1rhrlt5y5UNq3zx3oIJF8CWMcBjJOTSaMeaUHQH82XO64zDjPV
         vwnJ1Xv+66PazDGI2VBIsTeb75xSkZsGugrpm27Qr68WBOxRnWvZcXQQmisKRPZ4L9gt
         mh4+ZbpIGAdmZ510JwaGtIck0TfkKNd1nPqCsI0IEAUoz07+6uK3qY2Cxq8bYql0Xo4y
         ioAZ4J8+Jb2aUQLo/UczDIFuSU4zfERcTjEXGlSyr4Ncmsnlgc7XsrY5cARZrtwBdAaG
         4fNA==
X-Gm-Message-State: AOJu0YyzvmKWXMIRiBzScpA4z3ssEed6XjFW05HnaLa0/cr5zQq2iy98
	OXmomj+6BvZkgTFumxiP5LE=
X-Google-Smtp-Source: AGHT+IG760PCBf4Duk4zO8WDQqT9mxNrVyXwE7tzTv8MFU43eZB/5G6JKNi3lVJFFoq/BnmmaTyJcg==
X-Received: by 2002:a5e:c104:0:b0:792:93b9:2065 with SMTP id v4-20020a5ec104000000b0079293b92065mr2193831iol.7.1695132209213;
        Tue, 19 Sep 2023 07:03:29 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:a8ed:9f3d:7434:4c90? ([2601:282:1e82:2350:a8ed:9f3d:7434:4c90])
        by smtp.googlemail.com with ESMTPSA id q20-20020a5d8354000000b00777b7fdbbffsm3464413ior.8.2023.09.19.07.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 07:03:28 -0700 (PDT)
Message-ID: <3652856a-1cda-c050-04da-fe2204949ff5@gmail.com>
Date: Tue, 19 Sep 2023 08:03:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [patch iproute2-next v2 3/5] devlink: introduce support for netns
 id for nested handle
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, daniel.machon@microchip.com
References: <20230919115644.1157890-1-jiri@resnulli.us>
 <20230919115644.1157890-4-jiri@resnulli.us>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230919115644.1157890-4-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/19/23 5:56 AM, Jiri Pirko wrote:
> @@ -2723,6 +2725,40 @@ static bool should_arr_last_handle_end(struct dl *dl, const char *bus_name,
>  	       !cmp_arr_last_handle(dl, bus_name, dev_name);
>  }
>  
> +struct netns_name_by_id_ctx {
> +	int32_t id;
> +	char *name;
> +	struct rtnl_handle *rth;
> +};
> +
> +static int netns_name_by_id_func(char *nsname, void *arg)
> +{
> +	struct netns_name_by_id_ctx *ctx = arg;
> +	int32_t ret;
> +
> +	ret = netns_netnsid_from_name(ctx->rth, nsname);
> +	if (ret < 0 || ret != ctx->id)
> +		return 0;
> +	ctx->name = strdup(nsname);
> +	return 1;
> +}
> +
> +static char *netns_name_by_id(int32_t id)
> +{
> +	struct rtnl_handle rth;
> +	struct netns_name_by_id_ctx ctx = {
> +		.id = id,
> +		.rth = &rth,
> +	};
> +
> +	if (rtnl_open(&rth, 0) < 0)
> +		return NULL;
> +	netns_foreach(netns_name_by_id_func, &ctx);
> +	rtnl_close(&rth);
> +
> +	return ctx.name;
> +}
> +

The above is not devlink specific, so it should go in lib/namespace.c as
well.

Name wise it should be consistent with the last patch, so either
netns_id_to_name or netns_name_from_id based on the name from the
refactoring in patch 2.


>  static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>  {
>  	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
> @@ -2740,6 +2776,30 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>  	sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
>  		mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
>  	print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
> +
> +	if (tb[DEVLINK_ATTR_NETNS_ID]) {
> +		int32_t id = mnl_attr_get_u32(tb[DEVLINK_ATTR_NETNS_ID]);
> +
> +		if (id >= 0) {
> +			char *name = netns_name_by_id(id);
> +
> +			if (name) {
> +				print_string(PRINT_ANY,
> +					     "nested_devlink_netns",
> +					     " nested_devlink_netns %s", name);
> +				free(name);
> +			} else {
> +				print_int(PRINT_ANY,
> +					  "nested_devlink_netnsid",
> +					  " nested_devlink_netnsid %d", id);
> +			}
> +		} else {
> +			print_string(PRINT_FP, NULL,
> +				     " nested_devlink_netnsid %s", "unknown");
> +			print_int(PRINT_JSON,
> +				  "nested_devlink_netnsid", NULL, id);
> +		}

Also, devlink in the name here provides no addititional value (devlink
is the command name) and why add 'nested'? The attribute is just
NETNS_ID, so why not just 'netnsid' here.


> +	}
>  }
>  
>  static void __pr_out_handle_start(struct dl *dl, struct nlattr **tb,


