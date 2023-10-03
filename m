Return-Path: <netdev+bounces-37755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079007B6F82
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 19:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 77E261F21128
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E1E3B298;
	Tue,  3 Oct 2023 17:19:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6A03AC3F
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 17:19:01 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8461A6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:18:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so1946110a12.2
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696353537; x=1696958337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5EnlzNRFWMQ7thQWMg/qT9DCbeAiLijmJLaD1WjKhQ4=;
        b=PbsgRErK8SIzG8DK8L4BqFECdeegvxIauEJ06yxII0kvwI0N5370QnUGF5Df09DdxL
         VSVivSqr3ba7iapJP+9ZCqO6tk5fAic0GzvfYHInhwieJXbwJm++jvVWZ4EsPrxwZ+9f
         8ABWCC7HsYk4wfK0++yDBNAAM/musscuWsWmuUnOhEqK3mwYcBOKMmN27HhQHewnqmO+
         IVx1JbV+gp8en+KNfSCpzCzuMLUg4qLBEO2y9O/9JlCF+0B2weusFaSorWPrZDpXduVU
         Dq1IYnbbs5UL4o10vCS9Rz4KJsIFbrbB+nLVkswGUgg24gUwuQiGVhxIllRB0w2BVk7a
         soEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353537; x=1696958337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EnlzNRFWMQ7thQWMg/qT9DCbeAiLijmJLaD1WjKhQ4=;
        b=lZWqlAmsErQEF5V9bCQOzu4Hja+gaEKRFi/hEUmMy3ag3IyLj/jn9lfwBeWZOhaMvz
         R3gKeDMjBi77Wbgaveb1peO4x2zG7e21XHbfZoWLg2gPTaJgA0tkK4bJG0j6mekrNU5+
         62J7oqJtDim5cGAERGAABcd8mvyGtRn4Cov1c90NLcymGajbU3J1auAUk+bU9PX21WQZ
         CXCn1IiJ8+5hqzCl4mzJyf3bRXVI6dwsBc7ednyzA8lwdoqm5P5WpKmBYMQGpSzWahCN
         HfPRXw5JW+nQ4xV/rDzu7Q6rTEMHsSJlkJ23JAKO/qqyBMB6Bul0fz7dYjlR6KFF0iZI
         H4CA==
X-Gm-Message-State: AOJu0Yyn9OE3DLVwDYTjrtz/kFuvo9KKpaEKPGUGTPc1MLa0S7X+3ZU0
	zqzOmV5kUzB8C1QXQxUIK6MfIw==
X-Google-Smtp-Source: AGHT+IFZlMvMFeZ+OIrO7SCq93L8uRpsoOdhD5LXSPfy8mVx/wszOcWdFS9c324GMhaor8MVEZFISg==
X-Received: by 2002:a17:906:3cb2:b0:9ad:df85:97ae with SMTP id b18-20020a1709063cb200b009addf8597aemr13771395ejh.66.1696353537104;
        Tue, 03 Oct 2023 10:18:57 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jw21-20020a17090776b500b009786c8249d6sm1389944ejc.175.2023.10.03.10.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:18:56 -0700 (PDT)
Date: Tue, 3 Oct 2023 19:18:55 +0200
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
Message-ID: <ZRxM/+njiiu78b9p@nanopsycho>
References: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
 <20230927092435.1565336-4-arkadiusz.kubalewski@intel.com>
 <4018c0b0-b288-ff60-09be-7ded382f4a82@linux.dev>
 <DM6PR11MB4657AA79C0C44F868499A3129BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZRrb87drG7aVrxsT@nanopsycho>
 <eb019ccf-c50b-e9d7-e4e6-f6574f805b49@linux.dev>
 <DM6PR11MB4657DB3C9BC3E1EFE6A2F3389BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZRu0OlwKWSmXFOcV@nanopsycho>
 <DM6PR11MB46573DF9081298B816A215329BC4A@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46573DF9081298B816A215329BC4A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 03, 2023 at 04:29:13PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Tuesday, October 3, 2023 8:27 AM
>>To: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
>>
>>Tue, Oct 03, 2023 at 01:10:39AM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>>>>Vadim Fedorenko
>>>>Sent: Monday, October 2, 2023 5:09 PM
>>>>
>>>>On 02/10/2023 16:04, Jiri Pirko wrote:
>>>>> Mon, Oct 02, 2023 at 04:32:30PM CEST, arkadiusz.kubalewski@intel.com
>>>>> wrote:
>>>>>>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>>>> Sent: Wednesday, September 27, 2023 8:09 PM
>>>>>>>
>>>>>>> On 27/09/2023 10:24, Arkadiusz Kubalewski wrote:
>>>>>>>> Add callback op (get) for pin-dpll phase-offset measurment.
>>>>>>>> Add callback ops (get/set) for pin signal phase adjustment.
>>>>>>>> Add min and max phase adjustment values to pin proprties.
>>>>>>>> Invoke get callbacks when filling up the pin details to provide user
>>>>>>>> with phase related attribute values.
>>>>>>>> Invoke phase-adjust set callback when phase-adjust value is provided
>>>>>>>> for
>>>>>>>> pin-set request.
>>>>>>>>
>>>>>>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>> +static int
>>>>>>>> +dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr
>>>>>>>> *phase_adj_attr,
>>>>>>>> +		       struct netlink_ext_ack *extack)
>>>>>>>> +{
>>>>>>>> +	struct dpll_pin_ref *ref;
>>>>>>>> +	unsigned long i;
>>>>>>>> +	s32 phase_adj;
>>>>>>>> +	int ret;
>>>>>>>> +
>>>>>>>> +	phase_adj = nla_get_s32(phase_adj_attr);
>>>>>>>> +	if (phase_adj > pin->prop->phase_range.max ||
>>>>>>>> +	    phase_adj < pin->prop->phase_range.min) {
>>>>>>>> +		NL_SET_ERR_MSG(extack, "phase adjust value not
>>>>>>>> supported");
>>>>>>>> +		return -EINVAL;
>>>>>>>> +	}
>>>>>>>> +	xa_for_each(&pin->dpll_refs, i, ref) {
>>>>>>>> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>>>>>>>> +		struct dpll_device *dpll = ref->dpll;
>>>>>>>> +
>>>>>>>> +		if (!ops->phase_adjust_set)
>>>>>>>> +			return -EOPNOTSUPP;
>>>>>>>
>>>>>>> I'm thinking about this part. We can potentially have dpll devices
>>>>>>> with
>>>>>>> different expectations on phase adjustments, right? And if one of
>>>>>>> them
>>>>>>> won't be able to adjust phase (or will fail in the next line), then
>>>>>>> netlink will return EOPNOTSUPP while _some_ of the devices will be
>>>>>>> adjusted. Doesn't look great. Can we think about different way to
>>>>>>> apply
>>>>>>> the change?
>>>>>>>
>>>>>>
>>>>>> Well makes sense to me.
>>>>>>
>>>>>> Does following makes sense as a fix?
>>>>>> We would call op for all devices which has been provided with the op.
>>>>>> If device has no op -> add extack error, continue
>>>>>
>>>>> Is it real to expect some of the device support this and others don't?
>>>>> Is it true for ice?
>>>>> If not, I would got for all-or-nothing here.
>>>>>
>>>>
>>>>But nothing blocks vendors to provide such configuration. Should we
>>>>rollback the configuration? Otherwise we can easily make it
>>>>inconsistent.
>>>
>>>Good point, in such case rollback might be required.
>>>
>>>>
>>>>I'm more thinking of checking if all the devices returned error (or
>>>>absence of operation callback) and then return error instead of 0 with
>>>>extack filled in.
>>>>
>>>
>>>Well, what if different devices would return different errors?
>>>In general we would have to keep track of the error values returned in
>>>such case.. Assuming one is different than the other - still need to error
>>>extack them out? I guess it would be easier to return common error if
>>there
>>
>>In this case, it is common to return the first error hit and bail out,
>>not trying the rest.
>>
>
>OK, so now I see it like this:
>-> check if all device implement callback, if not return EOPNOTSUPP;
>-> get old phase_adjust
>-> if new == old, return EINVAL

0 would be better, no? User has what he desired.


>-> for each device: call phase_adjust_set, if fails, rollback all previous
>   successful attempts and return the failure code

That would work.


>?
>
>Thank you!
>Arkadiusz
>
>>
>>>were only failures and let the driver fill the errors on extack, smt like:
>>>
>>>	int miss_cb_num = 0, dev_num = 0, err_num;
>>>
>>>	xa_for_each(&pin->dpll_refs, i, ref) {
>>>		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>>>		struct dpll_device *dpll = ref->dpll;
>>>
>>>		dev_num++;
>>>		if (!ops->phase_adjust_set) {
>>>			miss_cb_num++;
>>>			continue;
>>>		}
>>>		ret = ops->phase_adjust_set(pin,
>>>					dpll_pin_on_dpll_priv(dpll, pin),
>>>					dpll, dpll_priv(dpll), phase_adj,
>>>					extack);
>>>		if (ret)
>>>			err_num++;
>>>	}
>>>	if (dev_num == miss_cb_num)
>>>		return -EOPNOTSUPP;
>>>	if (dev_num == err_num)
>>>		return -EINVAL;
>>>	__dpll_pin_change_ntf(pin);
>>>	return 0;
>>>
>>>??
>>>
>>>Thank you!
>>>Arkadiusz
>>>
>>>>>
>>>>>> If device fails to set -> add extack error, continue
>>>>>> Function always returns 0.
>>>>>>
>>>>>> Thank you!
>>>>>> Arkadiusz
>>>>>>
>>>>>>>
>>>>>>>> +		ret = ops->phase_adjust_set(pin,
>>>>>>>> +					    dpll_pin_on_dpll_priv(dpll, pin),
>>>>>>>> +					    dpll, dpll_priv(dpll), phase_adj,
>>>>>>>> +					    extack);
>>>>>>>> +		if (ret)
>>>>>>>> +			return ret;
>>>>>>>> +	}
>>>>>>>> +	__dpll_pin_change_ntf(pin);
>>>>>>>> +
>>>>>>>> +	return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>
>>>>_______________________________________________
>>>>Intel-wired-lan mailing list
>>>>Intel-wired-lan@osuosl.org
>>>>https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>

