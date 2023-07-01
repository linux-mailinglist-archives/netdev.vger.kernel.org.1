Return-Path: <netdev+bounces-14891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C773C7445B4
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 02:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB82F1C20C34
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 00:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788B810E6;
	Sat,  1 Jul 2023 00:51:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E6EDC
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 00:51:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A799D1BD4;
	Fri, 30 Jun 2023 17:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q5d9fk0Kq4PVVfrVMmslbF5d31U7oc6/SS2DxBc28Hc=; b=vs8MTtvSbbgjYrbJogrzb1pxKW
	JK+3fztnoVP53vLCXM0f7H6wjh4BpPRl3jsGz6wJhz7u2qPekaJMCnkf1U7Sfv33U2UCDK/9LE3wh
	HdIAvAfxZ2goU2mx+r47OvElcUZKdaYBNRqpXI070OqEfM85L31oqAhbxqcWH7y0fOUQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qFOpe-000LRM-Vz; Sat, 01 Jul 2023 02:51:22 +0200
Date: Sat, 1 Jul 2023 02:51:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Evan Quan <evan.quan@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, Alexander.Deucher@amd.com,
	Christian.Koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
	daniel@ffwll.ch, johannes@sipsolutions.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Mario.Limonciello@amd.com, mdaenzer@redhat.com,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	hdegoede@redhat.com, jingyuwang_vip@163.com, Lijo.Lazar@amd.com,
	jim.cromie@gmail.com, bellosilicio@gmail.com,
	andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V5 2/9] driver core: add ACPI based WBRF mechanism
 introduced by AMD
Message-ID: <4b2d5e30-1962-40f4-8c36-bfc35eba503c@lunn.ch>
References: <20230630103240.1557100-1-evan.quan@amd.com>
 <20230630103240.1557100-3-evan.quan@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630103240.1557100-3-evan.quan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +	argv4 = kzalloc(sizeof(*argv4) * (2 * num_of_ranges + 2 + 1), GFP_KERNEL);
> +	if (!argv4)
> +		return -ENOMEM;
> +
> +	argv4[arg_idx].package.type = ACPI_TYPE_PACKAGE;
> +	argv4[arg_idx].package.count = 2 + 2 * num_of_ranges;
> +	argv4[arg_idx++].package.elements = &argv4[1];
> +	argv4[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +	argv4[arg_idx++].integer.value = num_of_ranges;
> +	argv4[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +	argv4[arg_idx++].integer.value = action;

There is a lot of magic numbers in that kzalloc. It is being used as
an array, kcalloc() would be a good start to make it more readable.
Can some #define's be used to explain what the other numbers mean?

> +	/*
> +	 * Bit 0 indicates whether there's support for any functions other than
> +	 * function 0.
> +	 */

Please make use of the BIT macro to give the different bits
informative names.

> +	if ((mask & 0x1) && (mask & funcs) == funcs)
> +		return true;
> +
> +	return false;
> +}
> +

> +int acpi_amd_wbrf_retrieve_exclusions(struct device *dev,
> +				      struct wbrf_ranges_out *out)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	union acpi_object *obj;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	obj = acpi_evaluate_wbrf(adev->handle,
> +				 WBRF_REVISION,
> +				 WBRF_RETRIEVE);
> +	if (!obj)
> +		return -EINVAL;
> +
> +	WARN(obj->buffer.length != sizeof(*out),
> +		"Unexpected buffer length");
> +	memcpy(out, obj->buffer.pointer, obj->buffer.length);

You WARN, and then overwrite whatever i passed the end of out?  Please
at least use min(obj->buffer.length, sizeof(*out)), but better still:

   if (obj->buffer.length != sizeof(*out)) {
         dev_err(dev, "BIOS FUBAR, ignoring wrong sized WBRT information");
	 return -EINVAL;
   }

> +#if defined(CONFIG_WBRF_GENERIC)
>  static struct exclusion_range_pool wbrf_pool;
>  
>  static int _wbrf_add_exclusion_ranges(struct wbrf_ranges_in *in)
> @@ -89,6 +92,7 @@ static int _wbrf_retrieve_exclusion_ranges(struct wbrf_ranges_out *out)
>  
>  	return 0;
>  }
> +#endif

I was expecting you would keep these tables, and then call into the
BIOS as well. Having this table in debugfs seems like a useful thing
to have for debugging the BIOS.

> +#ifdef CONFIG_WBRF_AMD_ACPI
> +#else
> +static inline bool
> +acpi_amd_wbrf_supported_consumer(struct device *dev) { return false; }
> +static inline bool
> +acpi_amd_wbrf_supported_producer(struct device *dev) {return false; }
> +static inline int
> +acpi_amd_wbrf_remove_exclusion(struct device *dev,
> +			       struct wbrf_ranges_in *in) { return -ENODEV; }
> +static inline int
> +acpi_amd_wbrf_add_exclusion(struct device *dev,
> +			    struct wbrf_ranges_in *in) { return -ENODEV; }
> +static inline int
> +acpi_amd_wbrf_retrieve_exclusions(struct device *dev,
> +				  struct wbrf_ranges_out *out) { return -ENODEV; }

Do you actually need these stub versions?

	Andrew

