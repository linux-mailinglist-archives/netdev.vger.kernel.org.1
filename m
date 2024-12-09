Return-Path: <netdev+bounces-150139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762E19E91E2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C45280C37
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE351217656;
	Mon,  9 Dec 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meXzZQGJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89839216E27
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742844; cv=none; b=quZFBRjzIjGAGsRTY4Fj3Go7bXkH+elOAigoX5t+c5E4upYIKJnfHq8dBE0q9Mr6oB6M1NqET9Rq0YAMa84eyn79HUUss40fXIzml9jSa3AjOXCXcf0mCGShej8W9awOuS6BPAyrwR61/vUtrzIpZVtRdALsdkIfSTHj5nCckV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742844; c=relaxed/simple;
	bh=cjhEXeueBX1NeVabk8lXTMVekFREvlG2q8IWFYDSF2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4rkwPLbtJNAlInqL+BDs1zfqhiivRue1xOwW5o0Pzp39O7cQ6774cBkYhTTSJQqMFUo0NGZXB37LYhtEuxMg5VN4Urt3XxRluoClJLec9og4Hl5OwYnEBxYYM0mQBR9OzWkZLnkfbq+Scvyx7lrB1Qf9RGepTC90c5Iq47+xu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meXzZQGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9759CC4CED1;
	Mon,  9 Dec 2024 11:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733742844;
	bh=cjhEXeueBX1NeVabk8lXTMVekFREvlG2q8IWFYDSF2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meXzZQGJaf3cJW7U3u8ZVQeaKovguZYSnawlGko491TvcQ49zUhnLafyczucFVZYk
	 R2bvkGhu5+azab62x8OdM/x6J943GoTJblzIlmtRFwlJccEEFlZFbqAnnl3nNZBBmY
	 iFLM3jyirUhlEU1fqfjvMwyS1nX5MzX0LFPDT9r5eHCF/RVjDq4bgx4Mo1jquBI3eU
	 4vbu3Ok0vyABNkuXVfB9HJ0GNSubmTx1eSommaoUpv4ecY0Hq+kR6zDZJsQAGIlcMc
	 NhCz1KsG4iTz8TdDgrdZWW7o5WuGyD/tNGM2NPUhCOs6BNICX40H9MlCPoPIeTANRd
	 qBZROA6XLU3DQ==
Date: Mon, 9 Dec 2024 11:13:59 +0000
From: Simon Horman <horms@kernel.org>
To: Konrad Knitter <konrad.knitter@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, netdev@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	Sharon Haroni <sharon.haroni@intel.com>,
	Nicholas Nunley <nicholas.d.nunley@intel.com>,
	Brett Creeley <brett.creeley@intel.com>
Subject: Re: [PATCH iwl-next v2] ice: fw and port health status
Message-ID: <20241209111359.GA2581@kernel.org>
References: <20241204122738.114511-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204122738.114511-1-konrad.knitter@intel.com>

On Wed, Dec 04, 2024 at 01:27:38PM +0100, Konrad Knitter wrote:
> Firmware generates events for global events or port specific events.
> 
> Driver shall subscribe for health status events from firmware on supported
> FW versions >= 1.7.6.
> Driver shall expose those under specific health reporter, two new
> reporters are introduced:
> - FW health reporter shall represent global events (problems with the
> image, recovery mode);
> - Port health reporter shall represent port-specific events (module
> failure).
> 
> Firmware only reports problems when those are detected, it does not store
> active fault list.
> Driver will hold only last global and last port-specific event.
> Driver will report all events via devlink health report,
> so in case of multiple events of the same source they can be reviewed
> using devlink autodump feature.
> 
> $ devlink health
> 
> pci/0000:b1:00.3:
>   reporter fw
>     state healthy error 0 recover 0 auto_dump true
>   reporter port
>     state error error 1 recover 0 last_dump_date 2024-03-17
> 	last_dump_time 09:29:29 auto_dump true
> 
> $ devlink health diagnose pci/0000:b1:00.3 reporter port
> 
>   Syndrome: 262
>   Description: Module is not present.
>   Possible Solution: Check that the module is inserted correctly.
>   Port Number: 0
> 
> Tested on Intel Corporation Ethernet Controller E810-C for SFP
> 
> Co-developed-by: Sharon Haroni <sharon.haroni@intel.com>
> Signed-off-by: Sharon Haroni <sharon.haroni@intel.com>
> Co-developed-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
> Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
> Co-developed-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>

Hi Konrad,

Some minor feedback from my side.

> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c

...

> +/**
> + * ice_process_health_status_event - Process the health status event from FW
> + * @pf: pointer to the PF structure
> + * @event: event structure containing the Health Status Event opcode
> + *
> + * Decode the Health Status Events and print the associated messages
> + */
> +void ice_process_health_status_event(struct ice_pf *pf, struct ice_rq_event_info *event)
> +{
> +	const struct ice_aqc_health_status_elem *health_info;
> +	u16 count;
> +
> +	health_info = (struct ice_aqc_health_status_elem *)event->msg_buf;
> +	count = le16_to_cpu(event->desc.params.get_health_status.health_status_count);
> +
> +	if (count > (event->buf_len / sizeof(*health_info))) {
> +		dev_err(ice_pf_to_dev(pf), "Received a health status event with invalid element count\n");
> +		return;
> +	}
> +
> +	for (int i = 0; i < count; i++) {
> +		const struct ice_health_status *health_code;
> +		u16 status_code;
> +
> +		status_code = le16_to_cpu(health_info->health_status_code);
> +		health_code = ice_get_health_status(status_code);
> +
> +		if (health_code) {
> +			switch (health_info->event_source) {
> +			case ICE_AQC_HEALTH_STATUS_GLOBAL:
> +				pf->health_reporters.fw_status = *health_info;
> +				devlink_health_report(pf->health_reporters.fw,
> +						      "FW syndrome reported", NULL);
> +				break;
> +			case ICE_AQC_HEALTH_STATUS_PF:
> +			case ICE_AQC_HEALTH_STATUS_PORT:
> +				pf->health_reporters.port_status = *health_info;
> +				devlink_health_report(pf->health_reporters.port,
> +						      "Port syndrome reported", NULL);
> +				break;
> +			default:
> +				dev_err(ice_pf_to_dev(pf), "Health code with unknown source\n");
> +			}

The type of health_info->event_source is __le16.
But here it is being compared against host byte order values.
That doesn't seem correct.

Flagged by Sparse.

> +		} else {
> +			u32 data1, data2;
> +			u16 source;
> +
> +			source = le16_to_cpu(health_info->event_source);
> +			data1 = le32_to_cpu(health_info->internal_data1);
> +			data2 = le32_to_cpu(health_info->internal_data2);
> +			dev_dbg(ice_pf_to_dev(pf),
> +				"Received internal health status code 0x%08x, source: 0x%08x, data1: 0x%08x, data2: 0x%08x",
> +				status_code, source, data1, data2);
> +		}
> +		health_info++;
> +	}
> +}
> +
>  /**
>   * ice_devlink_health_report - boilerplate to call given @reporter
>   *

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index faba09b9d880..9c61318d3027 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -6047,6 +6047,44 @@ bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps)
>  	return false;
>  }
>  
> +/**
> + * ice_is_fw_health_report_supported

Please consider including a short description here.

Flagged by ./scripts/kernel-doc -Wall -none

> + * @hw: pointer to the hardware structure
> + *
> + * Return: true if firmware supports health status reports,
> + * false otherwise
> + */
> +bool ice_is_fw_health_report_supported(struct ice_hw *hw)
> +{
> +	return ice_is_fw_api_min_ver(hw, ICE_FW_API_HEALTH_REPORT_MAJ,
> +				     ICE_FW_API_HEALTH_REPORT_MIN,
> +				     ICE_FW_API_HEALTH_REPORT_PATCH);
> +}

...

