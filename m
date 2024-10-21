Return-Path: <netdev+bounces-137550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BA49A6E48
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E441F231A6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741451C3F0E;
	Mon, 21 Oct 2024 15:34:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919F1C3F12;
	Mon, 21 Oct 2024 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524898; cv=none; b=QYQ+GbfWmY95hGZB+A3DUfKXdnUkP2k37hap9RhnAM1rJh5BdSA8g4tp1fy6YyJvJooh49Op/ohqDBsM86NdETknDiif306q+va6dVIkb4aGqf4+LeFUATNdqQqNknop4cpcEHTt4EyynMH2oY7ANQvyqiWWkBm2tTVm6V/6u34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524898; c=relaxed/simple;
	bh=Iujc4jVi0X8OhToUuIrWzld03JXUBjAQrBk43JukXbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZW7MSgLZVcMhFTEn5oUw0/rZRL4i/pNsCUEudJuC1irhmmiuOWcQb6wrT+/bPvKlmrzZ+WwCfmJAeZMsuvO9JslFUks/NqvDSZz6SzNj6kIkb/OwUzYL1XFvb/4NYTEx5+o+UqupINkw6tgxgCD3vbof6M+nabiQNfrx+JQ7VBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 68A4161E5FE05;
	Mon, 21 Oct 2024 17:34:21 +0200 (CEST)
Message-ID: <421389ef-f5f4-4e92-b963-c6de1cc12506@molgen.mpg.de>
Date: Mon, 21 Oct 2024 17:34:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 2/2] ice: ptp: add control over
 HW timestamp latch point
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20241021141955.1466979-1-arkadiusz.kubalewski@intel.com>
 <20241021141955.1466979-3-arkadiusz.kubalewski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241021141955.1466979-3-arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Arkadiusz,


Thank you for the patch.

Am 21.10.24 um 16:19 schrieb Arkadiusz Kubalewski:
> Allow user to control the latch point of ptp HW timestamps in E825
> devices.

Please give an example how to configure it.

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c    | 46 +++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 57 +++++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
>   3 files changed, 105 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index a999fface272..47444412ed9a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2509,6 +2509,50 @@ static int ice_ptp_parse_sdp_entries(struct ice_pf *pf, __le16 *entries,
>   	return 0;
>   }
>   
> +/**
> + * ice_get_ts_point - get the tx timestamp latch point
> + * @info: the driver's PTP info structure
> + * @point: return the configured tx timestamp latch point
> + *
> + * Return: 0 on success, negative on failure.
> + */
> +static int
> +ice_get_ts_point(struct ptp_clock_info *info, enum ptp_ts_point *point)
> +{
> +	struct ice_pf *pf = ptp_info_to_pf(info);
> +	struct ice_hw *hw = &pf->hw;
> +	bool sfd_ena;
> +	int ret;
> +
> +	ice_ptp_lock(hw);
> +	ret = ice_ptp_hw_ts_point_get(hw, &sfd_ena);
> +	ice_ptp_unlock(hw);
> +	if (!ret)
> +		*point = sfd_ena ? PTP_TS_POINT_SFD : PTP_TS_POINT_POST_SFD;
> +
> +	return ret;
> +}
> +
> +/**
> + * ice_set_ts_point - set the tx timestamp latch point
> + * @info: the driver's PTP info structure
> + * @point: requested tx timestamp latch point
> + */
> +static int
> +ice_set_ts_point(struct ptp_clock_info *info, enum ptp_ts_point point)
> +{
> +	bool sfd_ena = point == PTP_TS_POINT_SFD ? true : false;
> +	struct ice_pf *pf = ptp_info_to_pf(info);
> +	struct ice_hw *hw = &pf->hw;
> +	int ret;
> +
> +	ice_ptp_lock(hw);
> +	ret = ice_ptp_hw_ts_point_set(hw, sfd_ena);
> +	ice_ptp_unlock(hw);
> +
> +	return ret;
> +}
> +
>   /**
>    * ice_ptp_set_funcs_e82x - Set specialized functions for E82X support
>    * @pf: Board private structure
> @@ -2529,6 +2573,8 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
>   	if (ice_is_e825c(&pf->hw)) {
>   		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
>   		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
> +		pf->ptp.info.set_ts_point = ice_set_ts_point;
> +		pf->ptp.info.get_ts_point = ice_get_ts_point;
>   	} else {
>   		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
>   		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index da88c6ccfaeb..d81525bc8a16 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -6303,3 +6303,60 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
>   
>   	return 0;
>   }
> +
> +/**
> + * ice_ptp_hw_ts_point_get - check if tx timestamping is latched on/post SFD
> + * @hw: pointer to the HW struct
> + * @sfd_ena: on success true if tx timestamping latched at beginning of SFD,
> + *	false if post sfd
> + *
> + * Verify if HW timestamping point is configured to measure at the beginning or
> + * post of SFD (Start of Frame Delimiter)
> + *
> + * Return: 0 on success, negative on error
> + */
> +int ice_ptp_hw_ts_point_get(struct ice_hw *hw, bool *sfd_ena)
> +{
> +	u8 port = hw->port_info->lport;
> +	u32 val;
> +	int err;
> +
> +	err = ice_read_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, &val);
> +	if (err)
> +		return err;
> +	if (val | PHY_MAC_XIF_TS_SFD_ENA_M)
> +		*sfd_ena = true;
> +	else
> +		*sfd_ena = false;

Use ternary operator?

> +
> +	return err;

As the function returns `int`, use integers (macros) instead of boolean?

> +}
> +
> +/**
> + * ice_ptp_hw_ts_point_set - configure timestamping on/post SFD
> + * @hw: pointer to the HW struct
> + * @sfd_ena: true to enable timestamping at beginning of SFD, false post sfd
> + *
> + * Configure timestamping to measure at the beginning/post SFD (Start of Frame
> + * Delimiter)
> + *
> + * Return: 0 on success, negative on error
> + */
> +int ice_ptp_hw_ts_point_set(struct ice_hw *hw, bool sfd_ena)
> +{
> +	u8 port = hw->port_info->lport;
> +	int err, val;
> +
> +	err = ice_read_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, &val);
> +	if (err)
> +		return err;
> +	if ((val | PHY_MAC_XIF_TS_SFD_ENA_M && sfd_ena) ||
> +	    (!(val | PHY_MAC_XIF_TS_SFD_ENA_M) && !sfd_ena))
> +		return -EINVAL;
> +	if (sfd_ena)
> +		val |= PHY_MAC_XIF_TS_SFD_ENA_M;
> +	else
> +		val &= ~PHY_MAC_XIF_TS_SFD_ENA_M;
> +
> +	return ice_write_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, val);
> +}
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 656daff3447e..cefedd01479a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -348,6 +348,8 @@ void ice_ptp_init_hw(struct ice_hw *hw);
>   int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready);
>   int ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
>   			 enum ice_ptp_tmr_cmd configured_cmd);
> +int ice_ptp_hw_ts_point_get(struct ice_hw *hw, bool *sfd_ena);
> +int ice_ptp_hw_ts_point_set(struct ice_hw *hw, bool sfd_ena);
>   
>   /* E822 family functions */
>   int ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val);


Kind regards,

Paul

