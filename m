Return-Path: <netdev+bounces-37572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3937B60CF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 08:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1022128135C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 06:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DC53D9E;
	Tue,  3 Oct 2023 06:32:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5F62D
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 06:32:21 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176938E
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 23:32:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso85563266b.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 23:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696314738; x=1696919538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWmqyqJeTEvaHR8Lmkdp/KbmlUpGqPBWa9X1iRjNIUQ=;
        b=n257AncnCcsRWxsTzyOSIQCfITDJfdbfCe3scR75S+lqXQPgHAcat3QZka5MAtQ/t7
         PViOb23pz2mq5OGm01cDSygfoNaBMKOVTwm8W14Y8DpU+IBTALjzjjNw+kwlJHEPByDc
         euwGdH+sLa+YvUeD8kOXJecsHMtVRpB51fuAcmHkCG/1ROAs6XYDgmP43q18NcKeG2Si
         StW8rDcuxd6gvN0jmgtkNJdGiNwVQpfxusJPkPE9+wyphp8N9GehUD6Z1c4QYRS2jbp3
         IC6FkL8/u5gjHOoBSLk6nORrrI0yQmhsKSaZ2Ai0f+EsizYlCwLZEwrDKGFQFBpEx9wX
         4hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696314738; x=1696919538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWmqyqJeTEvaHR8Lmkdp/KbmlUpGqPBWa9X1iRjNIUQ=;
        b=RJChQ2Zz1fPy5dt3B0+coFWGlK4zLQOFmtcNVo21srSstaYkTO4tOx+paOE5oNXKdW
         eAyY4UHYVldde6b1Qj7uHIz0x/KFagqpYYEZataVs3yAf8a4IQeDC81uqclGQqL6UDdi
         9ifEQEORLObligsZPmDSAab6zaNl/ygQchnvZe3TDk9URbksSboT2ImR9fTRQNxk1jWk
         jFlj4PPh0wPD6ukeLu7+1vTtEGagK7gW3Q5QSZcrAXttP49n8nhUs86naIUTY7mYWNiV
         B6Aphm79AIpJX8eX+2j/6nISVOC7rTzLNtTwinxniTzp6Pcycxhktzp+22KMDv4UZKIv
         1J4A==
X-Gm-Message-State: AOJu0YyrAn8Ii8RGiDLDjAcQGKSgf0ogtSPZmtVqbELts6Hr8hdg2yU3
	kQ64ifr1UWL4OobOCR/fZJkwuQ==
X-Google-Smtp-Source: AGHT+IF4PzMMEUwwkb7PbO5lVgCUiTIjKrcfk9g70VH7YQKDMKsb+ZV8H5NG7n1iNYEdIOgtTG/ONQ==
X-Received: by 2002:a17:906:3150:b0:9a1:f5b1:c864 with SMTP id e16-20020a170906315000b009a1f5b1c864mr11705405eje.10.1696314738381;
        Mon, 02 Oct 2023 23:32:18 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709064a5600b0099293cdbc98sm496181ejv.145.2023.10.02.23.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 23:32:17 -0700 (PDT)
Date: Tue, 3 Oct 2023 08:32:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH net-next 3/4] dpll: netlink/core: add support for
 pin-dpll signal phase offset/adjust
Message-ID: <ZRu1cG2uglhmCdlI@nanopsycho>
References: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
 <20230927092435.1565336-4-arkadiusz.kubalewski@intel.com>
 <4018c0b0-b288-ff60-09be-7ded382f4a82@linux.dev>
 <DM6PR11MB4657AA79C0C44F868499A3129BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZRrb87drG7aVrxsT@nanopsycho>
 <DM6PR11MB4657C61104280788DF49F0E59BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657C61104280788DF49F0E59BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 03, 2023 at 01:03:00AM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Monday, October 2, 2023 5:04 PM
>>
>>Mon, Oct 02, 2023 at 04:32:30PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>Sent: Wednesday, September 27, 2023 8:09 PM
>>>>
>>>>On 27/09/2023 10:24, Arkadiusz Kubalewski wrote:
>>>>> Add callback op (get) for pin-dpll phase-offset measurment.
>>>>> Add callback ops (get/set) for pin signal phase adjustment.
>>>>> Add min and max phase adjustment values to pin proprties.
>>>>> Invoke get callbacks when filling up the pin details to provide user
>>>>> with phase related attribute values.
>>>>> Invoke phase-adjust set callback when phase-adjust value is provided
>>>>> for
>>>>> pin-set request.
>>>>>
>>>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>
>>>>[...]
>>>>
>>>>> +static int
>>>>> +dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr
>>>>> *phase_adj_attr,
>>>>> +		       struct netlink_ext_ack *extack)
>>>>> +{
>>>>> +	struct dpll_pin_ref *ref;
>>>>> +	unsigned long i;
>>>>> +	s32 phase_adj;
>>>>> +	int ret;
>>>>> +
>>>>> +	phase_adj = nla_get_s32(phase_adj_attr);
>>>>> +	if (phase_adj > pin->prop->phase_range.max ||
>>>>> +	    phase_adj < pin->prop->phase_range.min) {
>>>>> +		NL_SET_ERR_MSG(extack, "phase adjust value not supported");
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +	xa_for_each(&pin->dpll_refs, i, ref) {
>>>>> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>>>>> +		struct dpll_device *dpll = ref->dpll;
>>>>> +
>>>>> +		if (!ops->phase_adjust_set)
>>>>> +			return -EOPNOTSUPP;
>>>>
>>>>I'm thinking about this part. We can potentially have dpll devices with
>>>>different expectations on phase adjustments, right? And if one of them
>>>>won't be able to adjust phase (or will fail in the next line), then
>>>>netlink will return EOPNOTSUPP while _some_ of the devices will be
>>>>adjusted. Doesn't look great. Can we think about different way to apply
>>>>the change?
>>>>
>>>
>>>Well makes sense to me.
>>>
>>>Does following makes sense as a fix?
>>>We would call op for all devices which has been provided with the op.
>>>If device has no op -> add extack error, continue
>>
>>Is it real to expect some of the device support this and others don't?
>>Is it true for ice?
>>If not, I would got for all-or-nothing here.
>>
>
>Let's step back a bit.
>The op itself is introduced as per pin-dpll tuple.. did this intentionally,
>to inform each dpll that the offset has been changed - in case dplls are
>controlled by separated driver/firmware instances but still sharing the pin.
>Same way a pin frequency is being set, from user perspective on a pin, but
>callback is called for each dpll the pin was registered with.
>Whatever we do here, it shall be probably done for frequency_set() callback as
>well.
>
>The answers:
>So far I don't know the device that might do it this way, it rather supports
>phase_adjust or not. In theory we allow such behavior to be implemented, i.e.
>pin is registered with 2 dplls, one has the callback, second not.

If there is only theoretical device like that now, implement
all-or-nothing. If such theoretical device appears in real, this could
be changed. The UAPI would not change, no problem.


>Current hardware of ice sets phase offset for a pin no matter on which dpll
>device callback was invoked.
>"all-or-nothing" - do you mean to check all callback returns and then decide
>if it was successful?

Check if all dplls have ops and only perform the action in such case. In
case one of the dplls does not have the op filled, return -EOPNOTSUPP.


Regarding the successful/failed op, I think you can just return. In
these cases, when user performs multiaction cmd, he should be prepared
to deal with consequences if part of this cmd fails. We don't have
rollback for any other multiaction cmd in dpll, I don't see why this
should be treated differently.


>
>Thank you!
>Arkadiusz
>
>>
>>>If device fails to set -> add extack error, continue
>>>Function always returns 0.
>>>
>>>Thank you!
>>>Arkadiusz
>>>
>>>>
>>>>> +		ret = ops->phase_adjust_set(pin,
>>>>> +					    dpll_pin_on_dpll_priv(dpll, pin),
>>>>> +					    dpll, dpll_priv(dpll), phase_adj,
>>>>> +					    extack);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>>>> +	__dpll_pin_change_ntf(pin);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>

