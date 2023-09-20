Return-Path: <netdev+bounces-35145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197277A741D
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EEF281CBB
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46788C06;
	Wed, 20 Sep 2023 07:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6868472
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:30:14 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9370197
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:30:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-404314388ceso69464185e9.2
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695195004; x=1695799804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rtjlC7wvTtYXnGDRzxmeHUydnBvIkEdX00Z0ufSrUE=;
        b=NF/W/erIIisajc7S3in/Hze6i1FPSAf3x/qkXz2CCI1rrtPfcu69IZFYDlpTmRVoLI
         lVyrB4bsHKAVd0GaR5zz7JXqbM9HyXGiQTMG9geVx8KDA2Y6xb5eNWv0oqgM+xokX23j
         JQMZ0UloxKLiZ+Duo4b9GdycDJwa1jaNyrNUL+S4dkmO14t2zy+cXQ6Rie9OFFC1L4GW
         1GpnmqGO9YQmm5iadNjzmy2jQNDrwJHHM0Glhu3Y7MMErkRhde5E9naq46pzkZX0obTo
         o7aTnTKnvDPjnb2J6B7PES/1b57xbbX25yO4zj1jNA/JaZjxVj37ZqNBA+oyCBI4Wxo6
         V7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195004; x=1695799804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rtjlC7wvTtYXnGDRzxmeHUydnBvIkEdX00Z0ufSrUE=;
        b=M0HCnDG2P4yIOqix+tFg98C+QzExDT3bNDgrg27KOj66S12qlFVpv4BytrvNe0BLTc
         QKm2JEvFevyKRa/4j7nazlLSdysRBw7crd5d7kHJTMEpAfpxgINMGUWljgpyapFR+neN
         AhdtSsfub4Kpx0Em7i0sd+WFmBs/HMz4eFS/e/DQCHa7y+50VfmNY/UxfQOuBzPuF98X
         YW0XV797CK2RSeoAw+V1A1+IkRkjgNCD8ftr9msQa6LnfxxssEHpLI8PS3wFR0PTWRps
         YLozkBIPdIKDvIwGCP7VVqUXrbw4KkkkPzSUN3qK3yzgAS/krv4q0Ol1bSghKVeYDyKK
         vkqw==
X-Gm-Message-State: AOJu0YwU5SJGMQ8sm5tuzkVEmZZezTu5E0l4HQcxxPin62MhL3tlnj76
	9kXyhd16b7OBmfkYALRGhgDcbhyUHQP7zdRieWc=
X-Google-Smtp-Source: AGHT+IHRTLCqYdllW6BqpGo/tB4n4x0LNMSK6YUmAswnU620mWclMpc4bjj2okzz1gLT07K/dSxLuA==
X-Received: by 2002:a05:600c:22da:b0:3fe:173e:4a34 with SMTP id 26-20020a05600c22da00b003fe173e4a34mr1578310wmg.40.1695195003729;
        Wed, 20 Sep 2023 00:30:03 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b0031f82743e25sm17628489wro.67.2023.09.20.00.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:30:02 -0700 (PDT)
Date: Wed, 20 Sep 2023 09:30:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	daniel.machon@microchip.com
Subject: Re: [patch iproute2-next v2 3/5] devlink: introduce support for
 netns id for nested handle
Message-ID: <ZQqfeQiz2OoVHqdS@nanopsycho>
References: <20230919115644.1157890-1-jiri@resnulli.us>
 <20230919115644.1157890-4-jiri@resnulli.us>
 <3652856a-1cda-c050-04da-fe2204949ff5@gmail.com>
 <ZQnYDVBeuIRn7uwK@nanopsycho>
 <5476af84-7f3d-2895-3be3-83b5abc38485@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5476af84-7f3d-2895-3be3-83b5abc38485@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Sep 19, 2023 at 08:48:29PM CEST, dsahern@gmail.com wrote:
>On 9/19/23 11:19 AM, Jiri Pirko wrote:
>>>
>>>>  static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>>>>  {
>>>>  	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
>>>> @@ -2740,6 +2776,30 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>>>>  	sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
>>>>  		mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
>>>>  	print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
>>>> +
>>>> +	if (tb[DEVLINK_ATTR_NETNS_ID]) {
>>>> +		int32_t id = mnl_attr_get_u32(tb[DEVLINK_ATTR_NETNS_ID]);
>>>> +
>>>> +		if (id >= 0) {
>>>> +			char *name = netns_name_by_id(id);
>>>> +
>>>> +			if (name) {
>>>> +				print_string(PRINT_ANY,
>>>> +					     "nested_devlink_netns",
>>>> +					     " nested_devlink_netns %s", name);
>>>> +				free(name);
>>>> +			} else {
>>>> +				print_int(PRINT_ANY,
>>>> +					  "nested_devlink_netnsid",
>>>> +					  " nested_devlink_netnsid %d", id);
>>>> +			}
>>>> +		} else {
>>>> +			print_string(PRINT_FP, NULL,
>>>> +				     " nested_devlink_netnsid %s", "unknown");
>>>> +			print_int(PRINT_JSON,
>>>> +				  "nested_devlink_netnsid", NULL, id);
>>>> +		}
>>> Also, devlink in the name here provides no addititional value (devlink
>>> is the command name) and why add 'nested'? The attribute is just
>>> NETNS_ID, so why not just 'netnsid' here.
>> Well, it is a netnsid of the nested devlink instance, not the object
>> (e.g. port) itself. Omitting that would be misleading. Any idea how to
>> do this differently?
>> 
>> 
>
>The attribute is a namespace id, and the value is a namespace id. Given
>that, the name here should be netnsid (or nsid - we did a horrible job
>with consistency across iproute2 commands). I have not followed the
>kernel patches to understand what you mean by nested devlink instance.

Please do that. Again, the netnsid is related to the nested instance.
Therefore I put the "nested_devlink" in the name. Putting just "netnsid"
as you suggest is wrong. Another possibility would be do nest this into
object, but:
1) I didn't find nice way to do that
2) We would break linecards as they expose nested_devlink already

IDK :/

