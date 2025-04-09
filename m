Return-Path: <netdev+bounces-180724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE36A82463
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB58E1BA18A7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED725F780;
	Wed,  9 Apr 2025 12:09:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CD25E476
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200554; cv=none; b=lIldOwvFUvrRZpk4bBFyNGI9kbRIFhiquAKVFlS9J457NL0UVU2heUzY6Rf+kdcQ7oG4ZelAjVGJTc8Br0BVClykc4vXHmxg1C60r9zjnqdt4UVkzf83xQpT1qh3Da+ndp+TZ6pSyIcfogqSyqu/zsIY4iDCKg87W3GeYq4nUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200554; c=relaxed/simple;
	bh=ugJn329Q4SAyP1D2vejqkWdr9MT1ubLwE1DlABoJEwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJ64+Gcegi12Im6iDnihTReoibE1wdEPm4QCGhugZ5rH0y5Eh4fEAm1LDSqfEWciijo4m3MwnKqacFadF7dcLTG7RZNTrozTT7694Vvwy929xRGbY2LfhERkk9dmUirbC5AadSq0da5quqQgn8KOsP6cEJ6N1mq+PrfwEqjXBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.43] (g43.guest.molgen.mpg.de [141.14.220.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8208C61E64799;
	Wed, 09 Apr 2025 14:08:26 +0200 (CEST)
Message-ID: <55ae83fc-8333-4a04-9320-053af1fd6f46@molgen.mpg.de>
Date: Wed, 9 Apr 2025 14:08:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/2] ice: add link_down_events
 statistic
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Michal Kubiak <michal.kubiak@intel.com>
References: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250409113622.161379-4-martyna.szapar-mudlaw@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250409113622.161379-4-martyna.szapar-mudlaw@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Martyna,


Thank you for your patch.

Am 09.04.25 um 13:36 schrieb Martyna Szapar-Mudlaw:
> Introduce a new ethtool statistic to ice driver, `link_down_events`,
> to track the number of times the link transitions from up to down.
> This counter can help diagnose issues related to link stability,
> such as port flapping or unexpected link drops.
> 
> The counter increments when a link-down event occurs and is exposed
> via ethtool stats as `link_down_events.nic`.

It’d be great if you pasted an example output.

> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice.h         | 1 +
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
>   drivers/net/ethernet/intel/ice/ice_main.c    | 3 +++
>   3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 7200d6042590..6304104d1900 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -621,6 +621,7 @@ struct ice_pf {
>   	u16 globr_count;	/* Global reset count */
>   	u16 empr_count;		/* EMP reset count */
>   	u16 pfr_count;		/* PF reset count */
> +	u32 link_down_events;

Why not u16?

>   
>   	u8 wol_ena : 1;		/* software state of WoL */
>   	u32 wakeup_reason;	/* last wakeup reason */
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index b0805704834d..7bad0113aa88 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -137,6 +137,7 @@ static const struct ice_stats ice_gstrings_pf_stats[] = {
>   	ICE_PF_STAT("mac_remote_faults.nic", stats.mac_remote_faults),
>   	ICE_PF_STAT("fdir_sb_match.nic", stats.fd_sb_match),
>   	ICE_PF_STAT("fdir_sb_status.nic", stats.fd_sb_status),
> +	ICE_PF_STAT("link_down_events.nic", link_down_events),
>   	ICE_PF_STAT("tx_hwtstamp_skipped", ptp.tx_hwtstamp_skipped),
>   	ICE_PF_STAT("tx_hwtstamp_timeouts", ptp.tx_hwtstamp_timeouts),
>   	ICE_PF_STAT("tx_hwtstamp_flushed", ptp.tx_hwtstamp_flushed),
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index a03e1819e6d5..d68dd2a3f4a6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -1144,6 +1144,9 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>   	if (link_up == old_link && link_speed == old_link_speed)
>   		return 0;
>   
> +	if (!link_up && old_link)
> +		pf->link_down_events++;
> +
>   	ice_ptp_link_change(pf, link_up);
>   
>   	if (ice_is_dcb_active(pf)) {

The diff looks good.


Kind regards,

Paul


