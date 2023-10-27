Return-Path: <netdev+bounces-44675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3CE7D916F
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17231282062
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B542514F72;
	Fri, 27 Oct 2023 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MrtduIph"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D811711
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:26:55 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7986ED6D
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:26:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso2805281a12.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698395206; x=1699000006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajVsHrYz4sAMl+egkL0LXZbrUlbwMROYKJL/eTgDgjg=;
        b=MrtduIphdBvdD0Wg+OWGS05PMrtrnkjSp1GfKIK7HItdYiSbFbJmSxk1Wc0e2dSdrB
         DtwSSDWTxWybwzI/cvbp8nYYJXObVo0Qj0V+H6S1d895BhnbtKbdbyosg3l8kCzkDXdU
         6/x5u3xhJtGxk/Y4fEZEZ4W8yilXxh/pundVDQ/YohvXlu2usv+VafrZwp+aKc9gvPNm
         OdUXOpoPWLH3yjic6n+ymF0aCo1HtuL5Fqlff0QdqnFdKyxE6SN9h61azADuzsVY5Lar
         1JXe+VZHP6mbLn6uh+Un0W2AzP83aBW+Uin+m9rd4zMwDPeQlbrBFmfDftCV8g/ABnkv
         tLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698395206; x=1699000006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajVsHrYz4sAMl+egkL0LXZbrUlbwMROYKJL/eTgDgjg=;
        b=MxxozhxROrq5IjTVbCMbe7WTsTtN3otvqF5wCWRtHV8tInfDlQ5iN2pma7xOruxTnj
         67TagSCp1xfal186U8kND4nPKzZksE9Ras1fAmrRn326uvQMPojdJ9JYvRGflhKM8gKS
         AyJ3JLVPsMenLKIsZR32qbJOIr6BcBR/qn7svXpzjkqjU3MXF8c2X3as/V0YE2e/4pKZ
         NeYFOEcbMgaY6FskcRnWP9wWW1DxNmvd3LP04gnoWhXDb6zZBjavr6KJsfnH/mi0G188
         ODnUMVyJsHpQ/7Yl20v2nmhKmCwfKG2Vk2/N6qwR1llJbZ9pStZnYzPurppIKSzGXHkm
         LO4w==
X-Gm-Message-State: AOJu0Yz8TruXNCoaHbCdOkZdl3xtpI5fIeKNsAmogMo0qqnKKxZALk6g
	FEq+U2Ek0SX2jO7jPcANG7eLY6gnkbVVnvGH+kQ=
X-Google-Smtp-Source: AGHT+IHqMAavSPTf5YnXU2JebdAot6g4TXP0/IxxufQ7dV2H8YgfUj+gvHRfveSIcNrhqg9yNnDw7w==
X-Received: by 2002:a05:6402:1a39:b0:540:e598:a35f with SMTP id be25-20020a0564021a3900b00540e598a35fmr1935299edb.5.1698395206612;
        Fri, 27 Oct 2023 01:26:46 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id a25-20020aa7cf19000000b00540f4715289sm845242edy.61.2023.10.27.01.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:26:46 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:26:45 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	daniel.machon@microchip.com
Subject: Re: [patch iproute2-next v3 3/6] devlink: extend
 pr_out_nested_handle() to print object
Message-ID: <ZTt0RRgTU1Cw4LuJ@nanopsycho>
References: <20231024100403.762862-1-jiri@resnulli.us>
 <20231024100403.762862-4-jiri@resnulli.us>
 <61a6392e-5d77-4f15-bcd2-7bd26326d805@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a6392e-5d77-4f15-bcd2-7bd26326d805@gmail.com>

Thu, Oct 26, 2023 at 07:03:30PM CEST, dsahern@gmail.com wrote:
>On 10/24/23 4:04 AM, Jiri Pirko wrote:
>> @@ -2861,6 +2842,38 @@ static void pr_out_selftests_handle_end(struct dl *dl)
>>  		__pr_out_newline();
>>  }
>>  
>> +static void __pr_out_nested_handle(struct dl *dl, struct nlattr *nla_nested_dl,
>> +				   bool is_object)
>> +{
>> +	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
>> +	int err;
>> +
>> +	err = mnl_attr_parse_nested(nla_nested_dl, attr_cb, tb);
>> +	if (err != MNL_CB_OK)
>> +		return;
>> +
>> +	if (!tb[DEVLINK_ATTR_BUS_NAME] ||
>> +	    !tb[DEVLINK_ATTR_DEV_NAME])
>> +		return;
>> +
>> +	if (!is_object) {
>> +		char buf[64];
>> +
>> +		sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
>> +			mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
>
>buf[64] - 1 for null terminator - 16 for IFNAMSIZ leaves 47. I do not

IFNAMSIZ is irrelevant here.


>see limits on bus name length, so how can you guarantee it is always <
>47 characters?
>
>Make this snprintf, check the return and make sure buf is null terminated.

I will fix it in separate patch, as this is just copied here.


>
>> +		print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
>> +		return;
>> +	}
>> +
>> +	__pr_out_handle_start(dl, tb, false, false);
>> +	pr_out_handle_end(dl);
>> +}
>> +
>> +static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
>> +{
>> +	__pr_out_nested_handle(NULL, nla_nested_dl, false);
>> +}
>> +
>>  static bool cmp_arr_last_port_handle(struct dl *dl, const char *bus_name,
>>  				     const char *dev_name, uint32_t port_index)
>>  {
>

