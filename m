Return-Path: <netdev+bounces-217721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAB1B39A0C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2CB1890CEC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6694301030;
	Thu, 28 Aug 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe0HND/Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88886187346;
	Thu, 28 Aug 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377186; cv=none; b=aImH5sHBoQGn+RDYvxUkmaqapURQJifmJ41u5LrtNZXf06hIVn9FJA1atGWmyxwgJcm3+yfSwYmY6SNK86IxdvJ0gI0PWcg19dVzWENSvMDiK9LUabxwN7pybIAR4bfTLC4vi49vLf2zJwwY0IQvpFTTzQU8KcUTy0N9UgdvZbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377186; c=relaxed/simple;
	bh=ApaRwpJeqb99ibXDe3dtLn8mCDS3zrygAvunHsREGr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ynf6dIIho+/5tf4Mxrxv+O5c8FwAHBMmk1EmfEPVOvCtb8GoKV78MlTzcbHjW8OtpVPqWd+EOXQJQm9rLNksbWNy+35WU0fJ+lnJsxYbhGjgttW0uMg0Ln2UIiyRGXKaL82/j1aVgqveZi91VEA/gv5B5MVUJUnDFbAMR08/48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe0HND/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD44C4CEEB;
	Thu, 28 Aug 2025 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756377186;
	bh=ApaRwpJeqb99ibXDe3dtLn8mCDS3zrygAvunHsREGr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xe0HND/Qwks2jszGWekVHOQjyj8NWBMyOky2BTPU21LUfvhuQf48DAs4FhKGtQRkt
	 StQhX62q5huazo0L39Z43I2isj3Pi+k8l9lf2mKFVBvSC922kotnryEubQ9KnZOMxN
	 SJBuiSYG+iCYrtfzChQcq/5FPzzjf4/P57S6ogPCoWYeOJo9bP+08kevOZdWaex212
	 oO59BInnittt8Uv6j9Ct5xUy9oCgappCgd43OdKMuZW/WgPu3r6IpU4yLSWfTcY+Z+
	 5VJGKslNTyQBWSUfUayq+5mEwqtWm+2e+cxcBRTFAqVUvajQY+E6xWaOGH+yAp894k
	 frPFamw6H8Awg==
Date: Thu, 28 Aug 2025 11:33:02 +0100
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v1] ice: add support for unmanaged dpll on E830
 NIC
Message-ID: <20250828103302.GZ10519@horms.kernel.org>
References: <20250826153118.2129807-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826153118.2129807-1-arkadiusz.kubalewski@intel.com>

On Tue, Aug 26, 2025 at 05:31:18PM +0200, Arkadiusz Kubalewski wrote:

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c

...

> +/**
> + * ice_dpll_init_info_unmanaged - init dpll information for unmanaged dpll
> + * @pf: board private structure
> + *
> + * Acquire (from HW) and set basic dpll information (on pf->dplls struct).
> + * For unmanaged dpll mode.
> + *
> + * Return:
> + * * 0 - success
> + * * negative - init failure reason
> + */
> +static int ice_dpll_init_info_unmanaged(struct ice_pf *pf)
> +{
> +	struct ice_dplls *d = &pf->dplls;
> +	struct ice_dpll *de = &d->eec;
> +	int ret = 0;
> +
> +	d->clock_id = ice_generate_clock_id(pf);
> +	d->num_inputs = ice_cgu_get_pin_num(&pf->hw, true);
> +	d->num_outputs = ice_cgu_get_pin_num(&pf->hw, false);
> +	ice_dpll_lock_state_init_unmanaged(pf);
> +
> +	d->inputs = kcalloc(d->num_inputs, sizeof(*d->inputs), GFP_KERNEL);
> +	if (!d->inputs)
> +		return -ENOMEM;
> +
> +	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
> +	if (ret)
> +		goto deinit_info;
> +
> +	d->outputs = kcalloc(d->num_outputs, sizeof(*d->outputs), GFP_KERNEL);
> +	if (!d->outputs)

Hi Arkadiusz,

I think the following is needed here:

		err = -ENOMEM;

Flagged by Smatch.

> +		goto deinit_info;
> +
> +	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_OUTPUT);
> +	if (ret)
> +		goto deinit_info;
> +
> +	de->mode = DPLL_MODE_AUTOMATIC;
> +	dev_dbg(ice_pf_to_dev(pf), "%s - success, inputs:%u, outputs:%u\n",
> +		__func__, d->num_inputs, d->num_outputs);
> +	return 0;
> +deinit_info:
> +	dev_err(ice_pf_to_dev(pf), "%s - fail: d->inputs:%p, d->outputs:%p\n",
> +		__func__, d->inputs, d->outputs);
> +	ice_dpll_deinit_info(pf);
> +	return ret;
> +}

...

