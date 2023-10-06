Return-Path: <netdev+bounces-38582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6497BB7FD
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1331C20868
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820D1CF9A;
	Fri,  6 Oct 2023 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i3nyjPTW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3C1D55B
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:41:45 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F9DCF
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:41:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-533d6a8d6b6so3821823a12.2
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696596102; x=1697200902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mW5SVktj2xUWf9LqoXpgBXu7K2ICps52XbOnVUo46IM=;
        b=i3nyjPTWpnkWzEj/THfuRj8o7jQ0jJ8ceI69hsiWJFd768iOkaw8kuB7wlZU6mfcLW
         5C5mnnWwdyCDvlhh2+rQw3gclpLMQZMdOz9PCE4PhkkfKGit/74f5Tf388rn1kWm1Y12
         +m6OKTK7U+7Jg1mZCgOfMI+Z+y9JXFG3jZOuONhZ8wDjIyNJcw+dczZl/XrlUq3QSMoV
         SMo/E2zgkzLLTMqqmwaKjk+7NSYLZnVqaPSpjn0jVHB08zuoDJLZnVGaJQ0vKaXBa3np
         LklUdg5XDDdmUFCRRHkvu8yyMNRSPOdl0yzlGIwnSNdyLjbSzPeqZreCzetssCzlpzOq
         RyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696596102; x=1697200902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW5SVktj2xUWf9LqoXpgBXu7K2ICps52XbOnVUo46IM=;
        b=KpLdHaEWAxkbKkf758YOoN0SAoMLlfGDvuPqj6lbO66nVDq6giw2Unz071lh5wtrDq
         Qnvd3PyBqV2mtGLxXGx9TzpCtHl4MfNPVhROh0iFnp9xTH46vMj/c6DrDcCpW5CHYBqc
         PeZ0b0lQvr5ixtvXatAhO5lCLJTRQQXdsS6+uhY3aQ+ibIDQSfhr9xRjJ0Y4GnPRPg9u
         rNXaKMS99Ya9f21QJJmHNWxtS5mLutCy1PTDWRfb8eov/0TtY0oDRpgNr0pqPT5lys6H
         XEZMhvbaDApIYgYBr/Xv6rGaIFqkBGdElKvIbjZTyDMulXlcfIquoVSaWzLAkGt39DET
         ekqw==
X-Gm-Message-State: AOJu0Yz4CsKqcD63b7G4bXwEiaAvxa009GEjqesUsp/W8kbR71otWVM1
	za4rqyqP7PMK/9B2uRjR4d5Qi+5Xexfdj6DlmzA9OA==
X-Google-Smtp-Source: AGHT+IGDzND6oeHj41td9dY/OmMaIkCdkLJphE1fmDDVPuSEB4VwAnf7dRKhLynRWUzgKd6WFcyYhw==
X-Received: by 2002:a17:907:b10:b0:9aa:e08:9fb7 with SMTP id h16-20020a1709070b1000b009aa0e089fb7mr6240513ejl.76.1696596102024;
        Fri, 06 Oct 2023 05:41:42 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id oz10-20020a170906cd0a00b009ad8acac02asm2849794ejb.172.2023.10.06.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:41:41 -0700 (PDT)
Date: Fri, 6 Oct 2023 14:41:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Simon Horman <horms@kernel.org>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 4/5] ice: dpll: implement phase related
 callbacks
Message-ID: <ZSAAg39SzlDS55Kn@nanopsycho>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
 <20231006114101.1608796-5-arkadiusz.kubalewski@intel.com>
 <ZR/+noRCdnsy6QJo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR/+noRCdnsy6QJo@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 02:33:34PM CEST, horms@kernel.org wrote:
>On Fri, Oct 06, 2023 at 01:41:00PM +0200, Arkadiusz Kubalewski wrote:
>> Implement new callback ops related to measurment and adjustment of
>> signal phase for pin-dpll in ice driver.
>> 
>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>
>Hi Arkadiusz,
>
>some minor feedback from my side.
>
>If you do end up re-spinning the series, please consider
>running checkpatch.pl --codespell.
>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_dpll.c | 224 +++++++++++++++++++++-
>>  drivers/net/ethernet/intel/ice/ice_dpll.h |  10 +-
>>  2 files changed, 230 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
>
>...
>
>> +/**
>> + * ice_dpll_phase_offset_get - callback for get dpll phase shift value
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: registered dpll pointer
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @phase_adjust: on success holds pin phase_adjust value
>
>nit: The parameter is called phase_offset, not phase_adjust in the code below

Yeah, the non-sense static function docs and how buggy they are. Nobody
reads them anyway. Same old story for ice I guess....


>
>> + * @extack: error reporting
>> + *
>> + * Dpll subsystem callback. Handler for getting phase shift value between
>> + * dpll's input and output.
>> + *
>> + * Context: Acquires pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error
>> + */
>> +static int
>> +ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
>> +			  const struct dpll_device *dpll, void *dpll_priv,
>> +			  s64 *phase_offset, struct netlink_ext_ack *extack)
>> +{
>> +	struct ice_dpll *d = dpll_priv;
>> +	struct ice_pf *pf = d->pf;
>> +
>> +	mutex_lock(&pf->dplls.lock);
>> +	if (d->active_input == pin)
>> +		*phase_offset = d->phase_offset * ICE_DPLL_PHASE_OFFSET_FACTOR;
>> +	else
>> +		*phase_offset = 0;
>> +	mutex_unlock(&pf->dplls.lock);
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
>>   * @pin: pointer to a pin
>
>...
>
>> @@ -1656,6 +1867,15 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
>>  				return ret;
>>  			pins[i].prop.capabilities |=
>>  				DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE;
>> +			pins[i].prop.phase_range.min =
>> +				pf->dplls.input_phase_adj_max;
>> +			pins[i].prop.phase_range.max =
>> +				-pf->dplls.input_phase_adj_max;
>> +		} else {
>> +			pins[i].prop.phase_range.min =
>> +				pf->dplls.output_phase_adj_max,
>
>nit: It probably doesn't make any difference, but perhaps ',' should be ';'.
>
>As flagged by clang-16 with -Wcomma
>
>> +			pins[i].prop.phase_range.max =
>> +				-pf->dplls.output_phase_adj_max;
>>  		}
>>  		pins[i].prop.capabilities |=
>>  			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
>
>...

