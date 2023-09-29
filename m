Return-Path: <netdev+bounces-37012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1947B316B
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8EFC21C208D8
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 11:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7725171C5;
	Fri, 29 Sep 2023 11:31:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32764F9CC
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:31:07 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F2094
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 04:31:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4065f29e933so3930705e9.1
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 04:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695987061; x=1696591861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSP/8WeTsNc7gqTaoiI4XrzGvQH5WRCwOU5sJpgsrfI=;
        b=1VhyvbxCgOcg2OZ37TBD7IWb38W9Am01o53THq9Nquf8Cve9hOqjMPZ44SGHgwx6aG
         BFxQOBE6qVgRwBeJTEKBXXTHDkWIGHjJBCKkSB+7VQq/UpUZV/sLXMfN1xvNdtn0hxvi
         o2CD8nzrCCcw7zBc5xfcOoW4v81GsEIQ++MqO1D87ldYt0z6gMbX+OfQsE0kBjeH3SdS
         Mj5OreQJsH0gL8OR1fIQiySi1DmDq2wuuA1BOBLu3xtQY7/66MrbsTgv0Ail9eyGe+VC
         eO5FCY9Tvl21Q2/OZSd4RbAvbFSxALlm0Ofjv6O2KA/J9dlcm1Wl6dtYNDmuae2CgpgH
         CPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695987061; x=1696591861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSP/8WeTsNc7gqTaoiI4XrzGvQH5WRCwOU5sJpgsrfI=;
        b=utOJXtiwsA/gdN7C4MIbVP3dmlHLtophdPDRiTTmKJCD9ctnhvkQb3apWqpafZ6xzN
         sM3hVP6WEp+xfEsZFsT9MzwkwuWQWkq+cBFam31c4JuD8jnkWkXr0Hx5NXauo/gtbyE7
         TAnvHgeL+9GTxjxSX3aahMbbPDOn7E7AsFGvAZ5zEFmqT1bnHzyrCj0H63xKQq/VqWo+
         56Tf8jxyiApvoj+fb8C+hWb4pT+5NyAxsMHtZL+vYzmjIzLnIXeff/7H1ULkKC7uPaiM
         lXDNtrYTE4JzWERQQ30vMEDJkfIARGu59vIceUu4DlpoER5A1FUBZWsLH0/3oLHb+bJE
         zKcw==
X-Gm-Message-State: AOJu0Yzbtc/QveqGV8PGGlv+GPQj/H0ZMFvysWBveTe6LWMDYUDt20wn
	DH3hJFBZz2K3ApW8/Nl6EEwxuRxouJzFzXy5TaQ=
X-Google-Smtp-Source: AGHT+IHZWsKKJj/loajLfKNuVnqXN7VojbIGALZxZUMN/eaFJjCMgBBBAT/s5UolDvdrthIWtWp+dg==
X-Received: by 2002:adf:f806:0:b0:320:bb1:5a76 with SMTP id s6-20020adff806000000b003200bb15a76mr3458199wrp.56.1695987061583;
        Fri, 29 Sep 2023 04:31:01 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m4-20020a056402430400b00536031525e5sm3133487edc.91.2023.09.29.04.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 04:30:59 -0700 (PDT)
Date: Fri, 29 Sep 2023 13:30:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	daniel.machon@microchip.com
Subject: Re: [patch iproute2-next v2 3/5] devlink: introduce support for
 netns id for nested handle
Message-ID: <ZRa1cu4TlCuj51gD@nanopsycho>
References: <20230919115644.1157890-1-jiri@resnulli.us>
 <20230919115644.1157890-4-jiri@resnulli.us>
 <3652856a-1cda-c050-04da-fe2204949ff5@gmail.com>
 <ZQnYDVBeuIRn7uwK@nanopsycho>
 <5476af84-7f3d-2895-3be3-83b5abc38485@gmail.com>
 <ZQqfeQiz2OoVHqdS@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQqfeQiz2OoVHqdS@nanopsycho>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Sep 20, 2023 at 09:30:01AM CEST, jiri@resnulli.us wrote:
>Tue, Sep 19, 2023 at 08:48:29PM CEST, dsahern@gmail.com wrote:
>>On 9/19/23 11:19 AM, Jiri Pirko wrote:
>>>>
>>>>>  static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>>>>>  {
>>>>>  	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
>>>>> @@ -2740,6 +2776,30 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>>>>>  	sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
>>>>>  		mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
>>>>>  	print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
>>>>> +
>>>>> +	if (tb[DEVLINK_ATTR_NETNS_ID]) {
>>>>> +		int32_t id = mnl_attr_get_u32(tb[DEVLINK_ATTR_NETNS_ID]);
>>>>> +
>>>>> +		if (id >= 0) {
>>>>> +			char *name = netns_name_by_id(id);
>>>>> +
>>>>> +			if (name) {
>>>>> +				print_string(PRINT_ANY,
>>>>> +					     "nested_devlink_netns",
>>>>> +					     " nested_devlink_netns %s", name);
>>>>> +				free(name);
>>>>> +			} else {
>>>>> +				print_int(PRINT_ANY,
>>>>> +					  "nested_devlink_netnsid",
>>>>> +					  " nested_devlink_netnsid %d", id);
>>>>> +			}
>>>>> +		} else {
>>>>> +			print_string(PRINT_FP, NULL,
>>>>> +				     " nested_devlink_netnsid %s", "unknown");
>>>>> +			print_int(PRINT_JSON,
>>>>> +				  "nested_devlink_netnsid", NULL, id);
>>>>> +		}
>>>> Also, devlink in the name here provides no addititional value (devlink
>>>> is the command name) and why add 'nested'? The attribute is just
>>>> NETNS_ID, so why not just 'netnsid' here.
>>> Well, it is a netnsid of the nested devlink instance, not the object
>>> (e.g. port) itself. Omitting that would be misleading. Any idea how to
>>> do this differently?
>>> 
>>> 
>>
>>The attribute is a namespace id, and the value is a namespace id. Given
>>that, the name here should be netnsid (or nsid - we did a horrible job
>>with consistency across iproute2 commands). I have not followed the
>>kernel patches to understand what you mean by nested devlink instance.
>
>Please do that. Again, the netnsid is related to the nested instance.
>Therefore I put the "nested_devlink" in the name. Putting just "netnsid"
>as you suggest is wrong. Another possibility would be do nest this into
>object, but:
>1) I didn't find nice way to do that
>2) We would break linecards as they expose nested_devlink already

Did you have a chance to check this? I have v3 ready for submission with
the other changes you requested.

Thanks!


>
>IDK :/

