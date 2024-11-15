Return-Path: <netdev+bounces-145283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A179CE09E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8E01F23C19
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0777C1CEEB2;
	Fri, 15 Nov 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwp3uq+/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E931F16B
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678306; cv=none; b=plqaE90i4LXvFF3HJpjjG2pZkgEoU8Ybafr7QTe3k8EdVOuGd8chjhaeUwAESpyvdSdOlqDfqJNtC7dOaDLEYb8opI23MPUZY4B66exNumF31PxI78cLJTEP4aYyhWWVW503sVg3DbfLm0FzYF/RjwWcUrgcMNK1zx4FzZPyuOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678306; c=relaxed/simple;
	bh=3yGbxF65nKGpPf3kAm5l8y5Ojc278AMQ6ZAHbQvYFwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ3SEZMtpbhBH5izppblCayCdN5EH7DlaiNqT6dCSvA3g75ptON2ZolRDvZNEMxx8bmbSKb5Y32sYfPw1T1xCF2yeZP99or//qxBKfSb1zmT/OWsbtIqDKcHL0i9voMNUANFiLPHqs6l/oquRErCYIyWxQWYMZOVuBY6b8BsEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwp3uq+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC29EC4CECF;
	Fri, 15 Nov 2024 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731678306;
	bh=3yGbxF65nKGpPf3kAm5l8y5Ojc278AMQ6ZAHbQvYFwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwp3uq+/gfYQ5JxtFA6w8SmZBxkjETqdF+MyH9FO+H1LrsYbnTODGdSLCrHkuT/zP
	 ndTWcWBfxoePeWxHS5tDhmt1Qo92hWaVlQnhWULI5u0MNJOOD9UqShURitIWLA72rZ
	 dCVbB9q2i3YZVfy1S1ZpFTeATiWclgKgJ04My1hrdlpW/7M8mxrVVGRZTV8CuyX/3e
	 h/0TiyVx2VV19BZFSwn4UCvXcUEql7+VhAOMk7oSzdNccPq+jpumUoQjjWXhTRCMH0
	 H5KGLwIyx1aX5+eGnXR03H+90Gi4+uuz9ni5qcIwH5IpHLJ6N6qt7L14+gThy5zP80
	 vS3YN+4yY546Q==
Date: Fri, 15 Nov 2024 13:45:02 +0000
From: Simon Horman <horms@kernel.org>
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH iwl-net 07/10] idpf: add Tx timestamp capabilities
 negotiation
Message-ID: <20241115134502.GQ1062410@kernel.org>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-8-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113154616.2493297-8-milena.olech@intel.com>

On Wed, Nov 13, 2024 at 04:46:19PM +0100, Milena Olech wrote:
> Tx timestamp capabilities are negotiated for the uplink Vport.
> Driver receives information about the number of available Tx timestamp
> latches, the size of Tx timestamp value and the set of indexes used
> for Tx timestamping.
> 
> Add function to get the Tx timestamp capabilities and parse the uplink
> vport flag.
> 
> Co-developed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c

...

> +/**
> + * idpf_ptp_get_vport_tstamps_caps - Send virtchnl to get tstamps caps for vport
> + * @vport: Virtual port structure
> + *
> + * Send virtchnl get vport tstamps caps message to receive the set of tstamp
> + * capabilities per vport.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)

...

> +	for (u16 i = 0; i < tstamp_caps->num_entries; i++) {
> +		u32 offset_l, offset_h;

It looks like the type of offset_l and offset_h should be __le32
to match the values that are stored in them.

Flagged by Sparse.

> +
> +		ptp_tx_tstamp = ptp_tx_tstamps + i;
> +		tx_tstamp_latch_caps = rcv_tx_tstamp_caps->tstamp_latches[i];
> +
> +		if (tstamp_access != IDPF_PTP_DIRECT)
> +			goto skip_offsets;
> +
> +		offset_l = tx_tstamp_latch_caps.tx_latch_reg_offset_l;
> +		offset_h = tx_tstamp_latch_caps.tx_latch_reg_offset_h;
> +		ptp_tx_tstamp->tx_latch_reg_offset_l = le32_to_cpu(offset_l);
> +		ptp_tx_tstamp->tx_latch_reg_offset_h = le32_to_cpu(offset_h);
> +
> +skip_offsets:
> +		ptp_tx_tstamp->idx = tx_tstamp_latch_caps.index;
> +
> +		list_add(&ptp_tx_tstamp->list_member,
> +			 &tstamp_caps->latches_free);
> +
> +		tstamp_caps->tx_tstamp_status[i].state = IDPF_PTP_FREE;
> +	}

...

