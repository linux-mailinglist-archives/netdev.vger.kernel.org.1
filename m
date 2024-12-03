Return-Path: <netdev+bounces-148539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660619E2052
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F60416587B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08E61F7555;
	Tue,  3 Dec 2024 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j10rnBsh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7101F7577
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237774; cv=none; b=V7CNI7WU2kHcwMfQrB4DYdALGbPtAqa6w+r0VX2hbh0L8aRM8mp0hwE+CBZhB4KXxrsHlcZpKVYkX7JHtaocou8O2C1qCmKvawmLHRK54k5WS3x2yfj7qwcPhX9NQoF/di3Ky2S7G+oVMC004CTcF0B7HuRFixWWADS3QqSc6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237774; c=relaxed/simple;
	bh=vzQli8dvz+E9BCqg5gOlBZoTLEI1uKbE/xAKVWFJlfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqrMV/0PVYnstZW2N2VWmbCcJiKRFnnVxZpWS5bwihBJODpd/GFCh/z3iana1THfDg9OsVNWh5ADhDpwdgH1V5VoYSGjvpoGcp5TxAsRGmd/zaaSlvE93uTfd0zdjoW0c/UFjtzZ3qLsHcBikV3szIy5YWWYfcTAsqK0WFL2Pbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j10rnBsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF395C4CED6;
	Tue,  3 Dec 2024 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733237774;
	bh=vzQli8dvz+E9BCqg5gOlBZoTLEI1uKbE/xAKVWFJlfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j10rnBshmdtDmXMQ56P2qlcaD0O8YWM0HiX/kgycpwW6nY8FlwmULY3P92/gd3GAE
	 PPkH2pDmoQQ50Uuf/5Eve8ghI8iV++W0trybzDAOF35p/M/BsO5v2SSwTHl9zkgnPd
	 hrRw+aWFk1WBbB2MHRlWl0qKJk8J2SoncqgdRTD/60iCuNTrfuwRM1tq6GckNWmqrK
	 UtwKc4cwR9YqO61UPaoDq+D6q4Sjitx1crWlpUlQL1dUl3ui/hQyJ32ZqmDL2gHkT0
	 nsKZFNlPo4RstZTCj84dCvw/E5I8wM+e/2RubSxHG7lgAf0W9xkHyskFuGNNsYaiRM
	 pNIzsM8NlNjAA==
Date: Tue, 3 Dec 2024 14:56:10 +0000
From: Simon Horman <horms@kernel.org>
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: Re: [PATCH v2 iwl-next 07/10] idpf: add Tx timestamp capabilities
 negotiation
Message-ID: <20241203145610.GE9361@kernel.org>
References: <20241126035849.6441-1-milena.olech@intel.com>
 <20241126035849.6441-8-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126035849.6441-8-milena.olech@intel.com>

On Tue, Nov 26, 2024 at 04:58:53AM +0100, Milena Olech wrote:
> Tx timestamp capabilities are negotiated for the uplink Vport.
> Driver receives information about the number of available Tx timestamp
> latches, the size of Tx timestamp value and the set of indexes used
> for Tx timestamping.
> 
> Add function to get the Tx timestamp capabilities and parse the uplink
> vport flag.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Co-developed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> v1 -> v2: change the idpf_for_each_vport macro

Hi Milena,

Some minor nits from my side.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
> index e7ccdcbdbd47..057d1c546417 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
> @@ -83,6 +83,70 @@ struct idpf_ptp_secondary_mbx {
>  	bool valid:1;
>  };
>  
> +/**
> + * enum idpf_ptp_tx_tstamp_state - Tx timestamp states
> + * @IDPF_PTP_FREE: Tx timestamp index free to use
> + * @IDPF_PTP_REQUEST: Tx timestamp index set to the Tx descriptor
> + * @IDPF_PTP_READ_VALUE: Tx timestamp value ready to be read
> + */
> +enum idpf_ptp_tx_tstamp_state {
> +	IDPF_PTP_FREE,
> +	IDPF_PTP_REQUEST,
> +	IDPF_PTP_READ_VALUE,
> +};
> +
> +/**
> + * struct idpf_ptp_tx_tstamp_status - Parameters to track Tx timestamp
> + * @skb: the pointer to the SKB that received the completion tag
> + * @state: the state of the Tx timestamp
> + */
> +struct idpf_ptp_tx_tstamp_status {
> +	struct sk_buff *skb;
> +	enum idpf_ptp_tx_tstamp_state state;
> +};
> +
> +/**
> + * struct idpf_ptp_tx_tstamp - Parameters for Tx timestamping
> + * @list_member: the list member strutcure

nit: structure

     Flagged by checkpatch.pl --codespell

> + * @tx_latch_reg_offset_l: Tx tstamp latch low register offset
> + * @tx_latch_reg_offset_h: Tx tstamp latch high register offset
> + * @skb: the pointer to the SKB for this timestamp request
> + * @tstamp: the Tx tstamp value
> + * @idx: the index of the Tx tstamp
> + */
> +struct idpf_ptp_tx_tstamp {
> +	struct list_head list_member;
> +	u32 tx_latch_reg_offset_l;
> +	u32 tx_latch_reg_offset_h;
> +	struct sk_buff *skb;
> +	u64 tstamp;
> +	u32 idx;
> +};

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c

...

> @@ -3154,6 +3157,14 @@ void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
>  	idpf_vport_alloc_vec_indexes(vport);
>  
>  	vport->crc_enable = adapter->crc_enable;
> +
> +	if (!(vport_msg->vport_flags &
> +	      le16_to_cpu(VIRTCHNL2_VPORT_UPLINK_PORT)))

I think this should be cpu_to_le16.

Flagged by Sparse.

> +		return;
> +
> +	err = idpf_ptp_get_vport_tstamps_caps(vport);
> +	if (err)
> +		pci_dbg(vport->adapter->pdev, "Tx timestamping not supported\n");
>  }
>  
>  /**

...

> diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> index 44a5ee84ed60..fdeebc621bdb 100644
> --- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
> +++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> @@ -569,6 +569,14 @@ struct virtchnl2_queue_reg_chunks {
>  };
>  VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_reg_chunks);
>  
> +/**
> + * enum virtchnl2_vport_flags - Vport flags that indicate vport capabilities.
> + * @VIRTCHNL2_VPORT_UPLINK_PORT: Representatives of underlying physical ports
> + */
> +enum virtchnl2_vport_flags {
> +	VIRTCHNL2_VPORT_UPLINK_PORT	= BIT(0),
> +};
> +
>  /**
>   * struct virtchnl2_create_vport - Create vport config info.
>   * @vport_type: See enum virtchnl2_vport_type.
> @@ -620,7 +628,7 @@ struct virtchnl2_create_vport {
>  	__le16 max_mtu;
>  	__le32 vport_id;
>  	u8 default_mac_addr[ETH_ALEN];
> -	__le16 pad;
> +	__le16 vport_flags;

The kernel doc for this structure, which is immediately above the
structure, should also be updated.

Flagged by ./scripts/kernel-doc -none

>  	__le64 rx_desc_ids;
>  	__le64 tx_desc_ids;
>  	u8 pad1[72];
> -- 
> 2.31.1
> 
> 

