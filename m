Return-Path: <netdev+bounces-35052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322847A6ADD
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 20:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256322818D5
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61FD1CA8F;
	Tue, 19 Sep 2023 18:48:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067A1FBC
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 18:48:33 +0000 (UTC)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAA4DE
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:48:31 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34fcbb4a097so14125705ab.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695149311; x=1695754111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4EZ2XUvzrjpYw70m2aKXWdlLfCenVF79WqBXSa+p5yo=;
        b=M5ze5EbSWDRxv9oM2gxxszZ1HZjcYdW1VXFX8g14djLV/Kn5stVxXHtirEmjLAfQur
         zYQZMIqC0gZ/0jvkdtYDC+IcxQNGXEQm4e6kmeBalUG9EtC2MW2MoRL2j2xGu/oDVsnu
         AufG7XJQx2K1ca07tXg7wSzioTsZ5wkO5GrKC7DYzsUFAIGpwlXuwm7+8FFm9EUPuVg+
         hHcEW4HdrmZiYFHq1i02ni0wH4Hnmsa1Dhlk1+Q4w9GqfQjI/UMvlzobFTtisKqhH40F
         hnKJjBhqMIPANDjYtP9iOAguljLemE01MVaO3tVx8SgRi9lh2KuBe+OExZwYlPojVHpx
         n1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695149311; x=1695754111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EZ2XUvzrjpYw70m2aKXWdlLfCenVF79WqBXSa+p5yo=;
        b=tyM4nwEsqNinuUevrp0jJpasq2rsTNodPJ5LqCwe3QUeLSbTrBfwevXKnZeIabukN9
         za5cb5DC2mSkcZnXFJ/d0UdorGTpt3vCcnIB0h87sMDNal/fQt+lb00A3Ka4lpYMdBKp
         6pSW5Dlnv/OySzHnrlHh7l0u2s/HSkuhH/V8h20jsCkJAqpnK6OY/8YrusXh9Y9tgXK4
         mZXNJ2qDdNKZIjzicXwTck8Xr7O6OXElhEK31I4EQGRXTATXVIUp21YBI2TA1iUliCZs
         1VJiHxM3wuSefrO63LkyenudHfas84IW2Yq59fbWtQPTYAnVCgnWzWQ47aLxM9tb3Kbm
         RDhg==
X-Gm-Message-State: AOJu0Yxr7SddIstWvd/fElP2TgeBXyWs9xEcieo2RxWwb6YZ3OWwHhcN
	u6WWJo4+ALgMbO1o5XkY7ac=
X-Google-Smtp-Source: AGHT+IENFR8MIDb4LuOscppFlh8DK85vksn9sJm8mZTf/I3hQZHTzMpOJ8o9+ygAMqAZVOcl3DBTag==
X-Received: by 2002:a05:6e02:1a02:b0:34c:dbeb:a2a2 with SMTP id s2-20020a056e021a0200b0034cdbeba2a2mr843357ild.21.1695149311244;
        Tue, 19 Sep 2023 11:48:31 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:a8ed:9f3d:7434:4c90? ([2601:282:1e82:2350:a8ed:9f3d:7434:4c90])
        by smtp.googlemail.com with ESMTPSA id eq6-20020a0566384e2600b0042b48e5da4bsm3386756jab.134.2023.09.19.11.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 11:48:30 -0700 (PDT)
Message-ID: <5476af84-7f3d-2895-3be3-83b5abc38485@gmail.com>
Date: Tue, 19 Sep 2023 12:48:29 -0600
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
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
 daniel.machon@microchip.com
References: <20230919115644.1157890-1-jiri@resnulli.us>
 <20230919115644.1157890-4-jiri@resnulli.us>
 <3652856a-1cda-c050-04da-fe2204949ff5@gmail.com>
 <ZQnYDVBeuIRn7uwK@nanopsycho>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZQnYDVBeuIRn7uwK@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/19/23 11:19 AM, Jiri Pirko wrote:
>>
>>>  static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>>>  {
>>>  	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
>>> @@ -2740,6 +2776,30 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>>>  	sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
>>>  		mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
>>>  	print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
>>> +
>>> +	if (tb[DEVLINK_ATTR_NETNS_ID]) {
>>> +		int32_t id = mnl_attr_get_u32(tb[DEVLINK_ATTR_NETNS_ID]);
>>> +
>>> +		if (id >= 0) {
>>> +			char *name = netns_name_by_id(id);
>>> +
>>> +			if (name) {
>>> +				print_string(PRINT_ANY,
>>> +					     "nested_devlink_netns",
>>> +					     " nested_devlink_netns %s", name);
>>> +				free(name);
>>> +			} else {
>>> +				print_int(PRINT_ANY,
>>> +					  "nested_devlink_netnsid",
>>> +					  " nested_devlink_netnsid %d", id);
>>> +			}
>>> +		} else {
>>> +			print_string(PRINT_FP, NULL,
>>> +				     " nested_devlink_netnsid %s", "unknown");
>>> +			print_int(PRINT_JSON,
>>> +				  "nested_devlink_netnsid", NULL, id);
>>> +		}
>> Also, devlink in the name here provides no addititional value (devlink
>> is the command name) and why add 'nested'? The attribute is just
>> NETNS_ID, so why not just 'netnsid' here.
> Well, it is a netnsid of the nested devlink instance, not the object
> (e.g. port) itself. Omitting that would be misleading. Any idea how to
> do this differently?
> 
> 

The attribute is a namespace id, and the value is a namespace id. Given
that, the name here should be netnsid (or nsid - we did a horrible job
with consistency across iproute2 commands). I have not followed the
kernel patches to understand what you mean by nested devlink instance.

