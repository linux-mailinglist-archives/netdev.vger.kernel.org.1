Return-Path: <netdev+bounces-27586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CE177C74A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58802281340
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 06:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519E7525A;
	Tue, 15 Aug 2023 06:00:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBE3C27
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:00:58 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7C106
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:00:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so45844235e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692079254; x=1692684054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATuGiDRRt6vLATPUxSeo+7i81xqN5HyTALEXdeKA4F8=;
        b=SsENlgM7QwFBr4fyrbLmlKEqIOdsbrkBW2fnqHH5I2nXrhsqj2FyMeX3t7E9PdQGv6
         4w3Q5NO2ODfd50GcDA/PcpYdIdFq6nutLetkQeTZxjhv6FLVuDYHZZlGMqLX3SeAkg/n
         92909bebuwsmYgZ5i+5UQG5pUc6VCB1jV4+iEG7syt29d/2lbK49DGBeH45mJZgezNMI
         tug6zMwxljUWocIraQL5YPO2RD7mehMNmwGTdZdL4qDyCPcmGAMNogk1jMor8GFY6rNO
         /x7ESOnP5Re+gF9gxek0LS3Uq1kGzI2gzTBiE21SomQ/h2qnxDxC8lj49n6LWWFJOCC9
         ak8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692079254; x=1692684054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATuGiDRRt6vLATPUxSeo+7i81xqN5HyTALEXdeKA4F8=;
        b=Cy+nmsHns1PPphtpLXpYchVkrJldA/0j2HQbtFDHx4dTMFGu1Wu5gs/oEhSNZyCh13
         Zhp48kcrXxTYdoO4O0a20uYGsKnrdZNnq3nrZVh0QUZ+f/HSUNxs0xbO1IYfETPvhBgV
         yNBAHuJf/VLlDKjBi4roo+Zv9L0Ce0Lz49cK+E5rrpR4NFIjvBVewGUOMned/viFiEea
         Tk9O7WLw+P3UH+AyIZQhyJ0CD+o1iVDs6zaZVeh8WUHUw6zgHoHu2bbmN+gSnPXbfpvw
         6PJXykJF+kPxCHEUUgsLfhR7425WHJcIhxpqXQSCPP+ahJNZNdF6MN54gULjPyziuSGB
         x8Zg==
X-Gm-Message-State: AOJu0Yyd2TDu8gFqH0d9wgoMB2asKW3fq2UAUA/NcrNouRfxS4Tu1VLe
	s8wZxJRA838ab3genkSVTnp5sA==
X-Google-Smtp-Source: AGHT+IH8cmixjntyPDKCP530AEOMW0rBts8FuLSUpsAjovyOl5LT8jngycJtfLakdIg/yNABjQ9QLg==
X-Received: by 2002:a7b:ce90:0:b0:3fb:ef86:e30 with SMTP id q16-20020a7bce90000000b003fbef860e30mr8635975wmj.10.1692079254020;
        Mon, 14 Aug 2023 23:00:54 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b003fc06169ab3sm19280308wmi.20.2023.08.14.23.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 23:00:53 -0700 (PDT)
Date: Tue, 15 Aug 2023 08:00:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	intel-wired-lan@lists.osuosl.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v4 3/9] dpll: core: Add DPLL framework base
 functions 
Message-ID: <ZNsUlAk/XIcPsMY0@nanopsycho>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230811200340.577359-4-vadim.fedorenko@linux.dev>
 <20230814201709.655a24e2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814201709.655a24e2@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 15, 2023 at 05:17:09AM CEST, kuba@kernel.org wrote:
>On Fri, 11 Aug 2023 21:03:34 +0100 Vadim Fedorenko wrote:

[...]


>> +int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>> +			 const struct dpll_device_ops *ops, void *priv)
>> +{
>> +	struct dpll_device_registration *reg;
>> +	bool first_registration = false;
>> +
>> +	if (WARN_ON(!ops))
>> +		return -EINVAL;
>> +	if (WARN_ON(!ops->mode_get))
>> +		return -EINVAL;
>> +	if (WARN_ON(!ops->lock_status_get))
>> +		return -EINVAL;
>> +	if (WARN_ON(type < DPLL_TYPE_PPS || type > DPLL_TYPE_MAX))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&dpll_lock);
>> +	reg = dpll_device_registration_find(dpll, ops, priv);
>> +	if (reg) {
>> +		mutex_unlock(&dpll_lock);
>> +		return -EEXIST;
>> +	}
>> +
>> +	reg = kzalloc(sizeof(*reg), GFP_KERNEL);
>> +	if (!reg) {
>> +		mutex_unlock(&dpll_lock);
>> +		return -ENOMEM;
>> +	}
>> +	reg->ops = ops;
>> +	reg->priv = priv;
>> +	dpll->type = type;
>> +	first_registration = list_empty(&dpll->registration_list);
>> +	list_add_tail(&reg->list, &dpll->registration_list);
>> +	if (!first_registration) {
>> +		mutex_unlock(&dpll_lock);
>> +		return 0;
>> +	}
>> +
>> +	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
>> +	mutex_unlock(&dpll_lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dpll_device_register);
>
>Is the registration flow documented? It's a bit atypical so we should
>write some pseudocode somewhere.

We have examples in 3 drivers with actual code. But sure, could use some
documentation.


>
>> +/**
>> + * dpll_device_unregister - unregister dpll device
>> + * @dpll: registered dpll pointer
>> + * @ops: ops for a dpll device
>> + * @priv: pointer to private information of owner
>> + *
>> + * Unregister device, make it unavailable for userspace.
>> + * Note: It does not free the memory
>> + * Context: Acquires a lock (dpll_lock)
>> + */
>> +void dpll_device_unregister(struct dpll_device *dpll,
>> +			    const struct dpll_device_ops *ops, void *priv)
>> +{
>> +	struct dpll_device_registration *reg;
>> +
>> +	mutex_lock(&dpll_lock);
>> +	ASSERT_DPLL_REGISTERED(dpll);
>> +	reg = dpll_device_registration_find(dpll, ops, priv);
>> +	if (WARN_ON(!reg)) {
>> +		mutex_unlock(&dpll_lock);
>> +		return;
>> +	}
>> +	list_del(&reg->list);
>> +	kfree(reg);
>> +
>> +	if (!list_empty(&dpll->registration_list)) {
>> +		mutex_unlock(&dpll_lock);
>> +		return;
>> +	}
>> +	xa_clear_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
>> +	mutex_unlock(&dpll_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(dpll_device_unregister);
>
>> +/**
>> + * struct dpll_pin - structure for a dpll pin
>> + * @id:			unique id number for pin given by dpll subsystem
>> + * @pin_idx:		index of a pin given by dev driver
>> + * @clock_id:		clock_id of creator
>> + * @module:		module of creator
>> + * @dpll_refs:		hold referencees to dplls pin was registered with
>> + * @parent_refs:	hold references to parent pins pin was registered with
>> + * @prop:		pointer to pin properties given by registerer
>> + * @rclk_dev_name:	holds name of device when pin can recover clock from it
>> + * @refcount:		refcount
>> + **/
>> +struct dpll_pin {
>> +	u32 id;
>> +	u32 pin_idx;
>> +	u64 clock_id;
>> +	struct module *module;
>> +	struct xarray dpll_refs;
>> +	struct xarray parent_refs;
>> +	const struct dpll_pin_properties *prop;
>> +	char *rclk_dev_name;
>
>Where is rclk_dev_name filled in?

Leftover, should be removed.

[..]


