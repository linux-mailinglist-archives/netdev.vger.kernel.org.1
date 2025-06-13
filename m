Return-Path: <netdev+bounces-197613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF6AD9504
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94B817DA85
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996EE238D49;
	Fri, 13 Jun 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v2xDjngk"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE0E555
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842035; cv=none; b=JZbuZYktedH5YONoK9Vlb5O/zXd78HZTnA+SBbyGhtXZPZtMJAEGsCDoKGBQAnLMs6G5zbUjnfEFyoDEk99J9Lpx/Ge6o04kA7Rd8SlGDgKNp0TI7W42sOydCOcSyq56KlF6pGMEPgh9ye3dHE/XEotYXZKIUgFPGd66OuKCxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842035; c=relaxed/simple;
	bh=kA4jhqp4xBUNaxg/pjNO8NYIx+j2PDUAkyr5hujtTvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tb6plOxXqdK0A0tMlg7+A7s2BA8xCpQFWr30BbPg2/1y06lIVrCHJPhQ4H0mw61BgIgLtDAcejkzIQk6nD8jihi0oEgC8XAa1WiPR0KZp87aLMx+pHXDV4eMw5Wfzwp7cd0FNdrtd1o4Id8MgMKZQ1gPefPEuzMrhfWp5r/QOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v2xDjngk; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c3400787-7279-4a50-a61a-92a100b3b4b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749842030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMLY4DUZwczzWxX+mHe4l4o0st/9I1jgbNlgxZD7LaY=;
	b=v2xDjngkqnMOazJSUlqgaQsgSXXpA93WGGhUq8DjjLk1zCK+nhxQkqb5YR6ZToXdoSQfyC
	+YaL9O+WQKi+9bQcKwRunZ1e3zFsfqjWZQe8F+93kheOLwjPxVUWs/HEtc3YMcm9QFJoy/
	9QhIY4dMRPpt6B0hx4/bmrYTPA7tGCI=
Date: Fri, 13 Jun 2025 20:13:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v9 06/14] dpll: zl3073x: Fetch invariants during
 probe
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250612200145.774195-1-ivecera@redhat.com>
 <20250612200145.774195-7-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250612200145.774195-7-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/06/2025 21:01, Ivan Vecera wrote:
> Several configuration parameters will remain constant at runtime,
> so we can load them during probe to avoid excessive reads from
> the hardware.
> 
> Read the following parameters from the device during probe and store
> them for later use:
> 
> * enablement status and frequencies of the synthesizers and their
>    associated DPLL channels
> * enablement status and type (single-ended or differential) of input pins
> * associated synthesizers, signal format, and enablement status of
>    outputs
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/core.c | 248 +++++++++++++++++++++++++++++++
>   drivers/dpll/zl3073x/core.h | 286 ++++++++++++++++++++++++++++++++++++
>   drivers/dpll/zl3073x/regs.h |  65 ++++++++
>   3 files changed, 599 insertions(+)
> 
> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 60344761545d8..3a57c85f902c4 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -6,6 +6,7 @@
>   #include <linux/dev_printk.h>
>   #include <linux/device.h>
>   #include <linux/export.h>
> +#include <linux/math64.h>
>   #include <linux/module.h>
>   #include <linux/netlink.h>
>   #include <linux/regmap.h>
> @@ -376,6 +377,25 @@ int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
>   					ZL_POLL_SLEEP_US, ZL_POLL_TIMEOUT_US);
>   }
>   
> +int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
> +		  unsigned int mask_reg, u16 mask_val)
> +{
> +	int rc;
> +
> +	/* Set mask for the operation */
> +	rc = zl3073x_write_u16(zldev, mask_reg, mask_val);
> +	if (rc)
> +		return rc;
> +
> +	/* Trigger the operation */
> +	rc = zl3073x_write_u8(zldev, op_reg, op_val);
> +	if (rc)
> +		return rc;
> +
> +	/* Wait for the operation to actually finish */
> +	return zl3073x_poll_zero_u8(zldev, op_reg, op_val);
> +}
> +
>   /**
>    * zl3073x_devlink_info_get - Devlink device info callback
>    * @devlink: devlink structure pointer
> @@ -484,6 +504,229 @@ struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev)
>   }
>   EXPORT_SYMBOL_NS_GPL(zl3073x_devm_alloc, "ZL3073X");
>   
> +/**
> + * zl3073x_ref_state_fetch - get input reference state
> + * @zldev: pointer to zl3073x_dev structure
> + * @index: input reference index to fetch state for
> + *
> + * Function fetches information for the given input reference that are
> + * invariant and stores them for later use.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int
> +zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
> +{
> +	struct zl3073x_ref *input = &zldev->ref[index];
> +	u8 ref_config;
> +	int rc;
> +
> +	/* If the input is differential then the configuration for N-pin
> +	 * reference is ignored and P-pin config is used for both.
> +	 */
> +	if (zl3073x_is_n_pin(index) &&
> +	    zl3073x_ref_is_diff(zldev, index - 1)) {
> +		input->enabled = zl3073x_ref_is_enabled(zldev, index - 1);
> +		input->diff = true;
> +
> +		return 0;
> +	}
> +
> +	guard(mutex)(&zldev->multiop_lock);
> +
> +	/* Read reference configuration */
> +	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
> +			   ZL_REG_REF_MB_MASK, BIT(index));
> +	if (rc)
> +		return rc;
> +
> +	/* Read ref_config register */
> +	rc = zl3073x_read_u8(zldev, ZL_REG_REF_CONFIG, &ref_config);
> +	if (rc)
> +		return rc;
> +
> +	input->enabled = FIELD_GET(ZL_REF_CONFIG_ENABLE, ref_config);
> +	input->diff = FIELD_GET(ZL_REF_CONFIG_DIFF_EN, ref_config);
> +
> +	dev_dbg(zldev->dev, "REF%u is %s and configured as %s\n", index,
> +		input->enabled ? "enabled" : "disabled",
> +		input->diff ? "differential" : "single-ended");
> +
> +	return rc;
> +}
> +
> +/**
> + * zl3073x_out_state_fetch - get output state
> + * @zldev: pointer to zl3073x_dev structure
> + * @index: output index to fetch state for
> + *
> + * Function fetches information for the given output (not output pin)
> + * that are invariant and stores them for later use.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int
> +zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index)
> +{
> +	struct zl3073x_out *out = &zldev->out[index];
> +	u8 output_ctrl, output_mode;
> +	int rc;
> +
> +	/* Read output configuration */
> +	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_CTRL(index), &output_ctrl);
> +	if (rc)
> +		return rc;
> +
> +	/* Store info about output enablement and synthesizer the output
> +	 * is connected to.
> +	 */
> +	out->enabled = FIELD_GET(ZL_OUTPUT_CTRL_EN, output_ctrl);
> +	out->synth = FIELD_GET(ZL_OUTPUT_CTRL_SYNTH_SEL, output_ctrl);
> +
> +	dev_dbg(zldev->dev, "OUT%u is %s and connected to SYNTH%u\n", index,
> +		out->enabled ? "enabled" : "disabled", out->synth);
> +
> +	guard(mutex)(&zldev->multiop_lock);
> +
> +	/* Read output configuration */
> +	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
> +			   ZL_REG_OUTPUT_MB_MASK, BIT(index));
> +	if (rc)
> +		return rc;
> +
> +	/* Read output_mode */
> +	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &output_mode);
> +	if (rc)
> +		return rc;
> +
> +	/* Extract and store output signal format */
> +	out->signal_format = FIELD_GET(ZL_OUTPUT_MODE_SIGNAL_FORMAT,
> +				       output_mode);
> +
> +	dev_dbg(zldev->dev, "OUT%u has signal format 0x%02x\n", index,
> +		out->signal_format);
> +
> +	return rc;
> +}
> +
> +/**
> + * zl3073x_synth_state_fetch - get synth state
> + * @zldev: pointer to zl3073x_dev structure
> + * @index: synth index to fetch state for
> + *
> + * Function fetches information for the given synthesizer that are
> + * invariant and stores them for later use.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int
> +zl3073x_synth_state_fetch(struct zl3073x_dev *zldev, u8 index)
> +{
> +	struct zl3073x_synth *synth = &zldev->synth[index];
> +	u16 base, m, n;
> +	u8 synth_ctrl;
> +	u32 mult;
> +	int rc;
> +
> +	/* Read synth control register */
> +	rc = zl3073x_read_u8(zldev, ZL_REG_SYNTH_CTRL(index), &synth_ctrl);
> +	if (rc)
> +		return rc;
> +
> +	/* Store info about synth enablement and DPLL channel the synth is
> +	 * driven by.
> +	 */
> +	synth->enabled = FIELD_GET(ZL_SYNTH_CTRL_EN, synth_ctrl);
> +	synth->dpll = FIELD_GET(ZL_SYNTH_CTRL_DPLL_SEL, synth_ctrl);
> +
> +	dev_dbg(zldev->dev, "SYNTH%u is %s and driven by DPLL%u\n", index,
> +		synth->enabled ? "enabled" : "disabled", synth->dpll);
> +
> +	guard(mutex)(&zldev->multiop_lock);

Not a strong suggestion, but it would be good to follow netdev style
(same for some previous functions):

https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

"Use of guard() is discouraged within any function longer than 20 lines,
scoped_guard() is considered more readable. Using normal lock/unlock is 
still (weakly) preferred."

> +
> +	/* Read synth configuration */
> +	rc = zl3073x_mb_op(zldev, ZL_REG_SYNTH_MB_SEM, ZL_SYNTH_MB_SEM_RD,
> +			   ZL_REG_SYNTH_MB_MASK, BIT(index));
> +	if (rc)
> +		return rc;
> +
> +	/* The output frequency is determined by the following formula:
> +	 * base * multiplier * numerator / denominator
> +	 *
> +	 * Read registers with these values
> +	 */
> +	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_BASE, &base);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_read_u32(zldev, ZL_REG_SYNTH_FREQ_MULT, &mult);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_M, &m);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_N, &n);
> +	if (rc)
> +		return rc;
> +
> +	/* Check denominator for zero to avoid div by 0 */
> +	if (!n) {
> +		dev_err(zldev->dev,
> +			"Zero divisor for SYNTH%u retrieved from device\n",
> +			index);
> +		return -EINVAL;
> +	}
> +
> +	/* Compute and store synth frequency */
> +	zldev->synth[index].freq = div_u64(mul_u32_u32(base * m, mult), n);
> +
> +	dev_dbg(zldev->dev, "SYNTH%u frequency: %u Hz\n", index,
> +		zldev->synth[index].freq);
> +
> +	return rc;
> +}
> +
[...]


