Return-Path: <netdev+bounces-144900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215EF9C8B3F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19851F2167A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2633F1FEFDB;
	Thu, 14 Nov 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="apCBXg2A"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DCA1FB3CF
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588746; cv=none; b=CiUcSD42hlmOFERfUSBZNyMH0DlNc1ViygPxbbZHp2c6F7W+VvW7Bre+CFEfdBVZvgo08FrIUQzW43K/BGmtolqG1iPYoqZZyRSD1i7wFaRU7TzJnEu9ScPolcGrUD3FHQCFCRy5Yx4BMKt7IUvK1FERvwNgI51mM0BvGb2X67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588746; c=relaxed/simple;
	bh=4u2bc+gVadm+0x6gPofcenUWMGOSpmYYxEC5YQNWPRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7+Qt6AeG4KGB5P+b4L/0dyD4C9Wr75FvYH6LLT883qJNqJz0FWoPyAYKXAyFQM1M7JRNIshxRQmYrvKnQ7sACmLY8j51Z/4hRHTjr7as92WhfZczuW0mc6bOsohelAgR7bRqr0cE5IuGtSX0fQdUeSwlf7e+FESmV9rzqP+IEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=apCBXg2A; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2dc0096d-93be-42f9-b646-e74c3b36126c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731588740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FU7jZhdMJfK2f8b0/vGuJmbkIVylWUoX/z9l2OAzrwE=;
	b=apCBXg2ALM49EFUZcQeV6PRKkABkqa9/borFrBssOXWor7UynpmAJdjd0SVXAcEeblYb89
	EBvxE//DKav7HVg/Uf12OwfIjTgziZ/hds6AdGs/SuSNMBgMN6is9+03Dg0IQ7MHcZKiFv
	xp2GVs+nHopAkHgqa/AqJlyEirVsZGY=
Date: Thu, 14 Nov 2024 12:52:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net 08/10] idpf: add Tx timestamp flows
To: Milena Olech <milena.olech@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, Josh Hay <joshua.a.hay@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-9-milena.olech@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113154616.2493297-9-milena.olech@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 15:46, Milena Olech wrote:
> Add functions to request Tx timestamp for the PTP packets, read the Tx
> timestamp when the completion tag for that packet is being received,
> extend the Tx timestamp value and set the supported timestamping modes.
> 
> Tx timestamp is requested for the PTP packets by setting a TSYN bit and
> index value in the Tx context descriptor. The driver assumption is that
> the Tx timestamp value is ready to be read when the completion tag is
> received. Then the driver schedules delayed work and the Tx timestamp
> value read is requested through virtchnl message. At the end, the Tx
> timestamp value is extended to 64-bit and provided back to the skb.
> 
> Co-developed-by: Josh Hay <joshua.a.hay@intel.com>
> Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf.h        |   4 +
>   .../net/ethernet/intel/idpf/idpf_ethtool.c    |  63 +++++
>   .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  13 +-
>   drivers/net/ethernet/intel/idpf/idpf_lib.c    |  40 +++
>   drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 265 +++++++++++++++++-
>   drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  57 ++++
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 136 ++++++++-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  10 +-
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   6 +-
>   .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 232 +++++++++++++++
>   10 files changed, 813 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 1135be31b97c..76ae7f3980e6 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -293,6 +293,8 @@ struct idpf_port_stats {
>    * @link_up: True if link is up
>    * @sw_marker_wq: workqueue for marker packets
>    * @tx_tstamp_caps: The capabilities negotiated for Tx timestamping
> + * @tstamp_config: The Tx tstamp config
> + * @tstamp_task: Tx timestamping task
>    */
>   struct idpf_vport {
>   	u16 num_txq;
> @@ -339,6 +341,8 @@ struct idpf_vport {
>   	wait_queue_head_t sw_marker_wq;
>   
>   	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
> +	struct hwtstamp_config tstamp_config;
> +	struct work_struct tstamp_task;
>   };
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index 59b1a1a09996..9b6ca4c1b3a1 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> @@ -2,6 +2,7 @@
>   /* Copyright (C) 2023 Intel Corporation */
>   
>   #include "idpf.h"
> +#include "idpf_ptp.h"
>   
>   /**
>    * idpf_get_rxnfc - command to get RX flow classification rules
> @@ -1312,6 +1313,67 @@ static int idpf_get_link_ksettings(struct net_device *netdev,
>   	return 0;
>   }
>   
> +/**
> + * idpf_set_timestamp_filters - Set the supported timestamping mode
> + * @vport: Virtual port structure
> + * @info: ethtool timestamping info structure
> + *
> + * Set the Tx/Rx timestamp filters.
> + */
> +static void idpf_set_timestamp_filters(const struct idpf_vport *vport,
> +				       struct kernel_ethtool_ts_info *info)
> +{
> +	if (!vport->tx_tstamp_caps ||
> +	    vport->adapter->ptp->tx_tstamp_access == IDPF_PTP_NONE)
> +		return;
> +
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_RX_SOFTWARE |
> +				SOF_TIMESTAMPING_SOFTWARE |
> +				SOF_TIMESTAMPING_TX_HARDWARE |
> +				SOF_TIMESTAMPING_RX_HARDWARE |
> +				SOF_TIMESTAMPING_RAW_HARDWARE;
> +
> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> +}
> +
> +/**
> + * idpf_get_ts_info - Get device PHC association
> + * @netdev: network interface device structure
> + * @info: ethtool timestamping info structure
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int idpf_get_ts_info(struct net_device *netdev,
> +			    struct kernel_ethtool_ts_info *info)
> +{
> +	struct idpf_vport *vport;
> +	int err = 0;
> +
> +	idpf_vport_ctrl_lock(netdev);
> +	vport = idpf_netdev_to_vport(netdev);
> +
> +	if (!vport->adapter->ptp) {
> +		err = -EOPNOTSUPP;
> +		goto unlock;
> +	}
> +
> +	idpf_set_timestamp_filters(vport, info);
> +
> +	if (idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_PTP) &&
> +	    vport->adapter->ptp->clock) {
> +		info->phc_index = ptp_clock_index(vport->adapter->ptp->clock);
> +	} else {
> +		pci_dbg(vport->adapter->pdev, "PTP clock not detected\n");
> +		err = ethtool_op_get_ts_info(netdev, info);
> +	}
> +
> +unlock:
> +	idpf_vport_ctrl_unlock(netdev);
> +
> +	return err;
> +}
> +
>   static const struct ethtool_ops idpf_ethtool_ops = {
>   	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>   				     ETHTOOL_COALESCE_USE_ADAPTIVE,
> @@ -1336,6 +1398,7 @@ static const struct ethtool_ops idpf_ethtool_ops = {
>   	.get_ringparam		= idpf_get_ringparam,
>   	.set_ringparam		= idpf_set_ringparam,
>   	.get_link_ksettings	= idpf_get_link_ksettings,
> +	.get_ts_info		= idpf_get_ts_info,
>   };
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
> index 8c7f8ef8f1a1..7492d1713243 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
> @@ -282,7 +282,18 @@ struct idpf_flex_tx_tso_ctx_qw {
>   	u8 flex;
>   };
>   
> -struct idpf_flex_tx_ctx_desc {
> +union idpf_flex_tx_ctx_desc {
> +	/* DTYPE = IDPF_TX_DESC_DTYPE_CTX (0x01) */
> +	struct {
> +		__le64 qw0;
> +#define IDPF_TX_CTX_L2TAG2_M	GENMASK_ULL(47, 32)
> +		__le64 qw1;
> +#define IDPF_TX_CTX_DTYPE_M	GENMASK_ULL(3, 0)
> +#define IDPF_TX_CTX_CMD_M	GENMASK_ULL(15, 4)
> +#define IDPF_TX_CTX_TSYN_REG_M	GENMASK_ULL(47, 30)
> +#define IDPF_TX_CTX_MSS_M	GENMASK_ULL(50, 63)
> +	} tsyn;
> +
>   	/* DTYPE = IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX (0x05) */
>   	struct {
>   		struct idpf_flex_tx_tso_ctx_qw qw0;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index b4fbb99bfad2..467f380c8fd4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -3,6 +3,7 @@
>   
>   #include "idpf.h"
>   #include "idpf_virtchnl.h"
> +#include "idpf_ptp.h"
>   
>   static const struct net_device_ops idpf_netdev_ops;
>   
> @@ -2305,6 +2306,44 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
>   	return err;
>   }
>   
> +/**
> + * idpf_eth_ioctl - Access the hwtstamp interface
> + * @netdev: network interface device structure
> + * @ifr: interface request data
> + * @cmd: ioctl command
> + *
> + * Return: 0 on success, negative otherwise.
> + */
> +static int idpf_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> +{
> +	struct idpf_vport *vport;
> +	int err;
> +
> +	idpf_vport_ctrl_lock(netdev);
> +	vport = idpf_netdev_to_vport(netdev);
> +
> +	if (!idpf_ptp_get_vport_tstamp_capability(vport)) {
> +		idpf_vport_ctrl_unlock(netdev);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	switch (cmd) {
> +	case SIOCGHWTSTAMP:
> +		err = idpf_ptp_get_ts_config(vport, ifr);
> +		break;
> +	case SIOCSHWTSTAMP:
> +		err = idpf_ptp_set_ts_config(vport, ifr);
> +		break;
> +	default:
> +		err = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	idpf_vport_ctrl_unlock(netdev);
> +
> +	return err;
> +}
> +
>   /**
>    * idpf_alloc_dma_mem - Allocate dma memory
>    * @hw: pointer to hw struct
> @@ -2351,4 +2390,5 @@ static const struct net_device_ops idpf_netdev_ops = {
>   	.ndo_get_stats64 = idpf_get_stats64,
>   	.ndo_set_features = idpf_set_features,
>   	.ndo_tx_timeout = idpf_tx_timeout,
> +	.ndo_eth_ioctl = idpf_eth_ioctl,

ioctl interface is deprecated, should not add any new drivers with it.
It's better to use .ndo_hwtamp_get/.ndo_hwstamp_set

>   };
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> index 997528176b0f..f34642d10768 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> @@ -317,6 +317,37 @@ static int idpf_ptp_gettimex64(struct ptp_clock_info *info,
>   	return 0;
>   }
>   
> +/**
> + * idpf_ptp_update_cached_phctime - Update the cached PHC time values
> + * @adapter: Driver specific private structure
> + *
> + * This function updates the system time values which are cached in the adapter
> + * structure.
> + *
> + * This function must be called periodically to ensure that the cached value
> + * is never more than 2 seconds old.
> + *
> + * Return 0 on success, negative otherwise.
> + */
> +static int idpf_ptp_update_cached_phctime(struct idpf_adapter *adapter)
> +{
> +	u64 systime;
> +	int err;
> +
> +	err = idpf_ptp_read_src_clk_reg(adapter, &systime, NULL);
> +	if (err)
> +		return -EACCES;
> +
> +	/* Update the cached PHC time stored in the adapter structure.
> +	 * These values are used to extend Tx timestamp values to 64 bit
> +	 * expected by the stack.
> +	 */
> +	WRITE_ONCE(adapter->ptp->cached_phc_time, systime);
> +	WRITE_ONCE(adapter->ptp->cached_phc_jiffies, jiffies);
> +
> +	return 0;
> +}
> +
>   /**
>    * idpf_ptp_settime64 - Set the time of the clock
>    * @info: the driver's PTP info structure
> @@ -347,6 +378,11 @@ static int idpf_ptp_settime64(struct ptp_clock_info *info,
>   		return err;
>   	}
>   
> +	err = idpf_ptp_update_cached_phctime(adapter);
> +	if (err)
> +		pci_warn(adapter->pdev,
> +			 "Unable to immediately update cached PHC time\n");
> +
>   	return 0;
>   }
>   
> @@ -402,6 +438,11 @@ static int idpf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
>   		return err;
>   	}
>   
> +	err = idpf_ptp_update_cached_phctime(adapter);
> +	if (err)
> +		pci_warn(adapter->pdev,
> +			 "Unable to immediately update cached PHC time\n");
> +
>   	return 0;
>   }
>   
> @@ -465,6 +506,196 @@ static int idpf_ptp_gpio_enable(struct ptp_clock_info *info,
>   	return -EOPNOTSUPP;
>   }
>   
> +/**
> + * idpf_ptp_tstamp_extend_32b_to_64b - Convert a 32b nanoseconds Tx timestamp
> + *				       to 64b.
> + * @cached_phc_time: recently cached copy of PHC time
> + * @in_timestamp: Ingress/egress 32b nanoseconds timestamp value
> + *
> + * Hardware captures timestamps which contain only 32 bits of nominal
> + * nanoseconds, as opposed to the 64bit timestamps that the stack expects.
> + *
> + * Return: Tx timestamp value extended to 64 bits based on cached PHC time.
> + */
> +u64 idpf_ptp_tstamp_extend_32b_to_64b(u64 cached_phc_time, u32 in_timestamp)
> +{
> +	u32 delta, phc_lo;
> +	u64 ns;
> +
> +	phc_lo = lower_32_bits(cached_phc_time);
> +	delta = in_timestamp - phc_lo;
> +
> +	if (delta > S32_MAX) {
> +		delta = phc_lo - in_timestamp;
> +		ns = cached_phc_time - delta;
> +	} else {
> +		ns = cached_phc_time + delta;
> +	}
> +
> +	return ns;
> +}
> +
> +/**
> + * idpf_ptp_extend_ts - Convert a 40b timestamp to 64b nanoseconds
> + * @adapter: Driver specific private structure
> + * @in_tstamp: Ingress/egress timestamp value
> + *
> + * It is assumed that the caller verifies the timestamp is valid prior to
> + * calling this function.
> + *
> + * Extract the 32bit nominal nanoseconds and extend them. Use the cached PHC
> + * time stored in the device private PTP structure as the basis for timestamp
> + * extension.
> + *
> + * Return: Tx timestamp value extended to 64 bits.
> + */
> +u64 idpf_ptp_extend_ts(const struct idpf_adapter *adapter, u64 in_tstamp)
> +{
> +	unsigned long discard_time;
> +
> +	discard_time = adapter->ptp->cached_phc_jiffies + 2 * HZ;
> +
> +	if (time_is_before_jiffies(discard_time))
> +		return 0;

It might be a good idea to count such events, just to provide at least
some information to the client regarding zero timestamp?

> +
> +	return idpf_ptp_tstamp_extend_32b_to_64b(adapter->ptp->cached_phc_time,
> +						 lower_32_bits(in_tstamp));
> +}


[... skip ...]

