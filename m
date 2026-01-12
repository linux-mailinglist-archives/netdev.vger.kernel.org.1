Return-Path: <netdev+bounces-248990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF06D12564
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEDBA300E40C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E33559E5;
	Mon, 12 Jan 2026 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lq7aDmaG"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E222D8DDF
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217891; cv=none; b=e82mhUcbittGRhmbIphiEpwYuuRvcIsx1lbP0Hypa3MXuRe2sOSsmDfbX9NwNYVu43fbdTx27zr64Zekzd+JLVrL5dsvtFDJdaLl/JvUMHlnbUzjyvCov+on/qkWoDAOgeCC9GW45mSinUjH89HB0OYDUiMeEkXKwGJwLGNUs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217891; c=relaxed/simple;
	bh=NEOn60HUeDZocL6BvdbzUCkkOXmcf0fqo9qVaOJL9XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPgCuFWTlQwo5LhOrnrfJXHagYUBTe5yiLuqMzEU9ajjtKp1sgJuMl4LVhUDJmgpxD/hcas2u0Az3b24rY3KNmssmEqOVLq7rhkrDPmBNAGK57BNLeX3pD9rwXJ3En+9YM/d6p9BwP17JAuPS0VLqCh0nnALUWR5EaE9QYcBfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lq7aDmaG; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <825dbb02-5e76-45d1-acf6-78bcc2e999c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768217887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcXhocpu+w8GdlsVIvnOM5XAoY8JHsgRG7eNfAcTcyE=;
	b=lq7aDmaGWc1Y2CKE2bhQV929XXJZQYw9HdDeH+k7abiCQ6OJGvjm7HjCO7CGpVP34C6sjn
	cb5r21AwBgcZukyBCsR83ey7lowCi19OHZgNwNBcjEpeKbblEXatkSM3JqT7zPgzmjxvPR
	j9sYkMcVWhh/Wpfb7JUH47D8IYZrhQA=
Date: Mon, 12 Jan 2026 11:37:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: Implement device mode setting
 support
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>
References: <20260112101409.804206-1-ivecera@redhat.com>
 <20260112101409.804206-4-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260112101409.804206-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/01/2026 10:14, Ivan Vecera wrote:
> Add support for .supported_modes_get() and .mode_set() callbacks
> to enable switching between manual and automatic modes via netlink.
> 
> Implement .supported_modes_get() to report available modes based
> on the current hardware configuration:
> 
> * manual mode is always supported
> * automatic mode is supported unless the dpll channel is configured
>    in NCO (Numerically Controlled Oscillator) mode
> 
> Implement .mode_set() to handle the specific logic required when
> transitioning between modes:
> 
> 1) Transition to manual:
> * If a valid reference is currently active, switch the hardware
>    to ref-lock mode (force lock to that reference).
> * If no reference is valid and the DPLL is unlocked, switch to freerun.
> * Otherwise, switch to Holdover.
> 
> 2) Transition to automatic:
> * If the currently selected reference pin was previously marked
>    as non-selectable (likely during a previous manual forcing
>    operation), restore its priority and selectability in the hardware.
> * Switch the hardware to Automatic selection mode.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 106 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 106 insertions(+)
> 
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 9879d85d29af0..d0a9c361dc1d8 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -100,6 +100,20 @@ zl3073x_dpll_pin_direction_get(const struct dpll_pin *dpll_pin, void *pin_priv,
>   	return 0;
>   }
>   
> +static struct zl3073x_dpll_pin *
> +zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
> +{
> +	struct zl3073x_dpll_pin *pin;
> +
> +	list_for_each_entry(pin, &zldpll->pins, list) {
> +		if (zl3073x_dpll_is_input_pin(pin) &&
> +		    zl3073x_input_pin_ref_get(pin->id) == ref_id)
> +			return pin;
> +	}
> +
> +	return NULL;
> +}
> +
>   static int
>   zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
>   				 void *pin_priv,
> @@ -1137,6 +1151,26 @@ zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
>   	return 0;
>   }
>   
> +static int
> +zl3073x_dpll_supported_modes_get(const struct dpll_device *dpll,
> +				 void *dpll_priv, unsigned long *modes,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +
> +	/* We support switching between automatic and manual mode, except in
> +	 * a case where the DPLL channel is configured to run in NCO mode.
> +	 * In this case, report only the manual mode to which the NCO is mapped
> +	 * as the only supported one.
> +	 */
> +	if (zldpll->refsel_mode != ZL_DPLL_MODE_REFSEL_MODE_NCO)
> +		__set_bit(DPLL_MODE_AUTOMATIC, modes);
> +
> +	__set_bit(DPLL_MODE_MANUAL, modes);
> +
> +	return 0;
> +}
> +
>   static int
>   zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
>   		      enum dpll_mode *mode, struct netlink_ext_ack *extack)
> @@ -1217,6 +1251,76 @@ zl3073x_dpll_phase_offset_avg_factor_set(const struct dpll_device *dpll,
>   	return 0;
>   }
>   
> +static int
> +zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
> +		      enum dpll_mode mode, struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +	u8 hw_mode, mode_refsel, ref;
> +	int rc;
> +
> +	rc = zl3073x_dpll_selected_ref_get(zldpll, &ref);
> +	if (rc) {
> +		NL_SET_ERR_MSG_MOD(extack, "failed to get selected reference");
> +		return rc;
> +	}
> +
> +	if (mode == DPLL_MODE_MANUAL) {
> +		/* We are switching from automatic to manual mode:
> +		 * - if we have a valid reference selected during auto mode then
> +		 *   we will switch to forced reference lock mode and use this
> +		 *   reference for selection
> +		 * - if NO valid reference is selected, we will switch to forced
> +		 *   holdover mode or freerun mode, depending on the current
> +		 *   lock status
> +		 */
> +		if (ZL3073X_DPLL_REF_IS_VALID(ref))
> +			hw_mode = ZL_DPLL_MODE_REFSEL_MODE_REFLOCK;
> +		else if (zldpll->lock_status == DPLL_LOCK_STATUS_UNLOCKED)
> +			hw_mode = ZL_DPLL_MODE_REFSEL_MODE_FREERUN;
> +		else
> +			hw_mode = ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER;
> +	} else {
> +		/* We are switching from manual to automatic mode:
> +		 * - if there is a valid reference selected then ensure that
> +		 *   it is selectable after switch to automatic mode
> +		 * - switch to automatic mode
> +		 */
> +		struct zl3073x_dpll_pin *pin;
> +
> +		pin = zl3073x_dpll_pin_get_by_ref(zldpll, ref);
> +		if (pin && !pin->selectable) {
> +			/* Restore pin priority in HW */
> +			rc = zl3073x_dpll_ref_prio_set(pin, pin->prio);
> +			if (rc)
> +				return rc;

I think it's better to fill-up extack here to give at least some info of
what's happened?

> +
> +			pin->selectable = true;
> +		}
> +
> +		hw_mode = ZL_DPLL_MODE_REFSEL_MODE_AUTO;
> +	}
> +
> +	/* Build mode_refsel value */
> +	mode_refsel = FIELD_PREP(ZL_DPLL_MODE_REFSEL_MODE, hw_mode);
> +
> +	if (ZL3073X_DPLL_REF_IS_VALID(ref))
> +		mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
> +
> +	/* Update dpll_mode_refsel register */
> +	rc = zl3073x_write_u8(zldpll->dev, ZL_REG_DPLL_MODE_REFSEL(zldpll->id),
> +			      mode_refsel);
> +	if (rc)
> +		return rc;

And here as well..

> +
> +	zldpll->refsel_mode = hw_mode;
> +
> +	if (ZL3073X_DPLL_REF_IS_VALID(ref))
> +		zldpll->forced_ref = ref;
> +
> +	return 0;
> +}
> +
>   static int
>   zl3073x_dpll_phase_offset_monitor_get(const struct dpll_device *dpll,
>   				      void *dpll_priv,
> @@ -1276,10 +1380,12 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
>   static const struct dpll_device_ops zl3073x_dpll_device_ops = {
>   	.lock_status_get = zl3073x_dpll_lock_status_get,
>   	.mode_get = zl3073x_dpll_mode_get,
> +	.mode_set = zl3073x_dpll_mode_set,
>   	.phase_offset_avg_factor_get = zl3073x_dpll_phase_offset_avg_factor_get,
>   	.phase_offset_avg_factor_set = zl3073x_dpll_phase_offset_avg_factor_set,
>   	.phase_offset_monitor_get = zl3073x_dpll_phase_offset_monitor_get,
>   	.phase_offset_monitor_set = zl3073x_dpll_phase_offset_monitor_set,
> +	.supported_modes_get = zl3073x_dpll_supported_modes_get,
>   };
>   
>   /**


