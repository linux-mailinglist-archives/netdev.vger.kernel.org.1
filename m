Return-Path: <netdev+bounces-37569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B57B60C3
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 08:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id B8A95B20996
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 06:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BE4A15;
	Tue,  3 Oct 2023 06:27:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B788186C
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 06:27:12 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68394D7
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 23:27:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-533df112914so796034a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696314428; x=1696919228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nasBPIo/xHcUBNpodGyPU6trXTolky3DJWsttEP7pMQ=;
        b=v7y4GTqN9zHXkvEPRgbVfNa1qUMxDszzY71kYW9V8KtXQ9vgfWrPAgOOH1wV3M8qNg
         3M23DZuiMLcb5Rhb8twZjfhJGPPM4Oce4ULeeGE7Ls7+I3n9xwUpEiaRvWi96MUuuYGa
         1n0JRqa7G0GIjFJBsYhDuGVcpqULeKjGHIRVLXznxqTg8CQy+Vgrn4NFVYBSS+koNurB
         AO9i1Uta2iDs03lip1TDk0YM6bHojnk9d7lIyLs7ow1sADcNCVpRn6JVbWfeUSDOrkwb
         C8oFYfWVNG+WNbzZ/6dluZgh8xdve1DpaFGPKSPbutdtvSO6V2Bjzjp+Y+X6s6nZOWo4
         4CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696314428; x=1696919228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nasBPIo/xHcUBNpodGyPU6trXTolky3DJWsttEP7pMQ=;
        b=bzXRqH1aecHTlxsdwCr3RwtI09r4mKhi2Lvtv+dNlcVtwwFJBqamux4GW11S2ZyxAR
         8XM4SQXD3meFOMgYQolIZ3XkIGIujvbb/TsxcpdCXy+Fe236r3fdO8R31dAH373YehdW
         rC3uqsj8bJ/r+dttGjgzM0iDX74JDOh2lvzg2WIndTumZ2L97smTmXs3cW71Tl0ctIGR
         Zwt5vp75kFkGrC0XLrWrskRar40vVyby9+jaqxb3DAkngL0MBn/36TSSxZYSc+INk7PQ
         48DQKaN1L0E5suLKGwG6YcpOIG+qAY5xVO2G74pl4JGAYGiWjyIbDayhy2bASz8a/065
         UOZA==
X-Gm-Message-State: AOJu0YxvjMgyZZjyDSq7yzvu3MxdrifzOGUQNkephGWvm97oBk/UBuHh
	+CbW40IMd/a6jVSrNErjmiPH5g==
X-Google-Smtp-Source: AGHT+IGktzEJPQwQ4FrIOHaSByngUhSzABrutCkp7xAGo5V5R4BfWDuJKH4B8vDl7eGG7nhBjMIC2g==
X-Received: by 2002:a50:ec89:0:b0:533:3d2b:7473 with SMTP id e9-20020a50ec89000000b005333d2b7473mr11167966edr.12.1696314427737;
        Mon, 02 Oct 2023 23:27:07 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7c914000000b0053331f9094dsm323417edt.52.2023.10.02.23.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 23:27:07 -0700 (PDT)
Date: Tue, 3 Oct 2023 08:27:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH net-next 3/4] dpll: netlink/core: add
 support for pin-dpll signal phase offset/adjust
Message-ID: <ZRu0OlwKWSmXFOcV@nanopsycho>
References: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
 <20230927092435.1565336-4-arkadiusz.kubalewski@intel.com>
 <4018c0b0-b288-ff60-09be-7ded382f4a82@linux.dev>
 <DM6PR11MB4657AA79C0C44F868499A3129BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZRrb87drG7aVrxsT@nanopsycho>
 <eb019ccf-c50b-e9d7-e4e6-f6574f805b49@linux.dev>
 <DM6PR11MB4657DB3C9BC3E1EFE6A2F3389BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657DB3C9BC3E1EFE6A2F3389BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 03, 2023 at 01:10:39AM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>>Vadim Fedorenko
>>Sent: Monday, October 2, 2023 5:09 PM
>>
>>On 02/10/2023 16:04, Jiri Pirko wrote:
>>> Mon, Oct 02, 2023 at 04:32:30PM CEST, arkadiusz.kubalewski@intel.com
>>> wrote:
>>>>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>> Sent: Wednesday, September 27, 2023 8:09 PM
>>>>>
>>>>> On 27/09/2023 10:24, Arkadiusz Kubalewski wrote:
>>>>>> Add callback op (get) for pin-dpll phase-offset measurment.
>>>>>> Add callback ops (get/set) for pin signal phase adjustment.
>>>>>> Add min and max phase adjustment values to pin proprties.
>>>>>> Invoke get callbacks when filling up the pin details to provide user
>>>>>> with phase related attribute values.
>>>>>> Invoke phase-adjust set callback when phase-adjust value is provided
>>>>>> for
>>>>>> pin-set request.
>>>>>>
>>>>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>
>>>>> [...]
>>>>>
>>>>>> +static int
>>>>>> +dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr
>>>>>> *phase_adj_attr,
>>>>>> +		       struct netlink_ext_ack *extack)
>>>>>> +{
>>>>>> +	struct dpll_pin_ref *ref;
>>>>>> +	unsigned long i;
>>>>>> +	s32 phase_adj;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	phase_adj = nla_get_s32(phase_adj_attr);
>>>>>> +	if (phase_adj > pin->prop->phase_range.max ||
>>>>>> +	    phase_adj < pin->prop->phase_range.min) {
>>>>>> +		NL_SET_ERR_MSG(extack, "phase adjust value not supported");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +	xa_for_each(&pin->dpll_refs, i, ref) {
>>>>>> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>>>>>> +		struct dpll_device *dpll = ref->dpll;
>>>>>> +
>>>>>> +		if (!ops->phase_adjust_set)
>>>>>> +			return -EOPNOTSUPP;
>>>>>
>>>>> I'm thinking about this part. We can potentially have dpll devices with
>>>>> different expectations on phase adjustments, right? And if one of them
>>>>> won't be able to adjust phase (or will fail in the next line), then
>>>>> netlink will return EOPNOTSUPP while _some_ of the devices will be
>>>>> adjusted. Doesn't look great. Can we think about different way to apply
>>>>> the change?
>>>>>
>>>>
>>>> Well makes sense to me.
>>>>
>>>> Does following makes sense as a fix?
>>>> We would call op for all devices which has been provided with the op.
>>>> If device has no op -> add extack error, continue
>>>
>>> Is it real to expect some of the device support this and others don't?
>>> Is it true for ice?
>>> If not, I would got for all-or-nothing here.
>>>
>>
>>But nothing blocks vendors to provide such configuration. Should we
>>rollback the configuration? Otherwise we can easily make it
>>inconsistent.
>
>Good point, in such case rollback might be required.
>
>>
>>I'm more thinking of checking if all the devices returned error (or
>>absence of operation callback) and then return error instead of 0 with
>>extack filled in.
>>
>
>Well, what if different devices would return different errors?
>In general we would have to keep track of the error values returned in
>such case.. Assuming one is different than the other - still need to error
>extack them out? I guess it would be easier to return common error if there

In this case, it is common to return the first error hit and bail out,
not trying the rest.


>were only failures and let the driver fill the errors on extack, smt like:
>
>	int miss_cb_num = 0, dev_num = 0, err_num;
>
>	xa_for_each(&pin->dpll_refs, i, ref) {
>		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>		struct dpll_device *dpll = ref->dpll;
>
>		dev_num++;
>		if (!ops->phase_adjust_set) {
>			miss_cb_num++;
>			continue;
>		}
>		ret = ops->phase_adjust_set(pin,
>					dpll_pin_on_dpll_priv(dpll, pin),
>					dpll, dpll_priv(dpll), phase_adj,
>					extack);
>		if (ret)
>			err_num++;
>	}
>	if (dev_num == miss_cb_num)
>		return -EOPNOTSUPP;
>	if (dev_num == err_num)
>		return -EINVAL;
>	__dpll_pin_change_ntf(pin);
>	return 0;
>
>??
>
>Thank you!
>Arkadiusz
>
>>>
>>>> If device fails to set -> add extack error, continue
>>>> Function always returns 0.
>>>>
>>>> Thank you!
>>>> Arkadiusz
>>>>
>>>>>
>>>>>> +		ret = ops->phase_adjust_set(pin,
>>>>>> +					    dpll_pin_on_dpll_priv(dpll, pin),
>>>>>> +					    dpll, dpll_priv(dpll), phase_adj,
>>>>>> +					    extack);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +	__dpll_pin_change_ntf(pin);
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>
>>_______________________________________________
>>Intel-wired-lan mailing list
>>Intel-wired-lan@osuosl.org
>>https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

