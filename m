Return-Path: <netdev+bounces-135689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA4F99EE5C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E3E1C21ABA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A061C4A1B;
	Tue, 15 Oct 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TaSIKGHC"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678F41AF0DA
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000601; cv=none; b=eB1aDFtMBI3ncpxb64GpT1ybA4B2wTHEO3Y40fSYK9ajlSGH0rKajyzFyq7yQjoo42+/YlS/t/1l419VzoPn2bf4pt7yFc5y+MYJ0suxloiQ/YmPx8R/ttXW/oTolsLTXjdjgAN9Lza8/irq6MhqPWnOjNpxZxO+V4wgjT+ViKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000601; c=relaxed/simple;
	bh=AKlkkcgk3v+0GVyZ8wK4YCyIOVviQ4h65LnXX7AywkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhC2ohBTIndkvxwdjrKzxp4xwHkVCC8H189BUjA7bGip4rRvSrjwig9BhZO0mbzOPC3moNluDsSKR65bV4catobhQUVOSzvV10MALpsfZ5MGDW3TeijDfXXbyCAkOacN+xrIU1ifHPGUe+GJ+y2AJR/JQuErzSD+GdCrnjYUNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TaSIKGHC; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <58b00c7f-b74b-4f14-a8c4-080d3fcedcb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729000594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjBoCtHGn+AojvJG0+ycFhdP11CHoL/kpWCMAwi8vcU=;
	b=TaSIKGHC7vhEpwRctaE1O8pWI2kba/i5l/L+z8Jw0LINvsPKuAT0d6Vo20oE4MDra/7xc+
	+0nDBCX5F5zA/1kGhpya9STs1eGH8GCHIwsMvCpnBogHgqRXK+Eei9kVjGWUnTC9nC5c7t
	6rFV9/gARTw20lWBtMuuZDxiBCVcC/I=
Date: Tue, 15 Oct 2024 14:56:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v11 07/14] iavf: add support
 for indirect access to PHC time
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 intel-wired-lan@lists.osuosl.org, aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Simon Horman <horms@kernel.org>
References: <20241013154415.20262-1-mateusz.polchlopek@intel.com>
 <20241013154415.20262-8-mateusz.polchlopek@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241013154415.20262-8-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/10/2024 16:44, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Implement support for reading the PHC time indirectly via the
> VIRTCHNL_OP_1588_PTP_GET_TIME operation.
> 
> Based on some simple tests with ftrace, the latency of the indirect
> clock access appears to be about ~110 microseconds. This is due to the
> cost of preparing a message to send over the virtchnl queue.
> 
> This is expected, due to the increased jitter caused by sending messages
> over virtchnl. It is not easy to control the precise time that the
> message is sent by the VF, or the time that the message is responded to
> by the PF, or the time that the message sent from the PF is received by
> the VF.
> 
> For sending the request, note that many PTP related operations will
> require sending of VIRTCHNL messages. Instead of adding a separate AQ
> flag and storage for each operation, setup a simple queue mechanism for
> queuing up virtchnl messages.
> 
> Each message will be converted to a iavf_ptp_aq_cmd structure which ends
> with a flexible array member. A single AQ flag is added for processing
> messages from this queue. In principle this could be extended to handle
> arbitrary virtchnl messages. For now it is kept to PTP-specific as the
> need is primarily for handling PTP-related commands.
> 
> Use this to implement .gettimex64 using the indirect method via the
> virtchnl command. The response from the PF is processed and stored into
> the cached_phc_time. A wait queue is used to allow the PTP clock gettime
> request to sleep until the message is sent from the PF.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_main.c   |   9 +-
>   drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 147 ++++++++++++++++++
>   drivers/net/ethernet/intel/iavf/iavf_ptp.h    |   1 +
>   .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  93 +++++++++++
>   4 files changed, 249 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index be07e9f8e664..b897dd94a32e 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2269,7 +2269,10 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
>   		iavf_enable_vlan_insertion_v2(adapter, ETH_P_8021AD);
>   		return 0;
>   	}
> -
> +	if (adapter->aq_required & IAVF_FLAG_AQ_SEND_PTP_CMD) {
> +		iavf_virtchnl_send_ptp_cmd(adapter);
> +		return IAVF_SUCCESS;
> +	}
>   	if (adapter->aq_required & IAVF_FLAG_AQ_REQUEST_STATS) {
>   		iavf_request_stats(adapter);
>   		return 0;
> @@ -5496,6 +5499,10 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	/* Setup the wait queue for indicating virtchannel events */
>   	init_waitqueue_head(&adapter->vc_waitqueue);
>   
> +	INIT_LIST_HEAD(&adapter->ptp.aq_cmds);
> +	init_waitqueue_head(&adapter->ptp.phc_time_waitqueue);
> +	mutex_init(&adapter->ptp.aq_cmd_lock);
> +
>   	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
>   			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
>   	/* Initialization goes on in the work. Do not add more of it below. */
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> index 5a1b5f8b87e5..f4f10692020a 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> @@ -4,6 +4,9 @@
>   #include "iavf.h"
>   #include "iavf_ptp.h"
>   
> +#define iavf_clock_to_adapter(info)				\
> +	container_of_const(info, struct iavf_adapter, ptp.info)
> +
>   /**
>    * iavf_ptp_cap_supported - Check if a PTP capability is supported
>    * @adapter: private adapter structure
> @@ -21,6 +24,138 @@ bool iavf_ptp_cap_supported(const struct iavf_adapter *adapter, u32 cap)
>   	return (adapter->ptp.hw_caps.caps & cap) == cap;
>   }
>   
> +/**
> + * iavf_allocate_ptp_cmd - Allocate a PTP command message structure
> + * @v_opcode: the virtchnl opcode
> + * @msglen: length in bytes of the associated virtchnl structure
> + *
> + * Allocates a PTP command message and pre-fills it with the provided message
> + * length and opcode.
> + *
> + * Return: allocated PTP command.
> + */
> +static struct iavf_ptp_aq_cmd *iavf_allocate_ptp_cmd(enum virtchnl_ops v_opcode,
> +						     u16 msglen)
> +{
> +	struct iavf_ptp_aq_cmd *cmd;
> +
> +	cmd = kzalloc(struct_size(cmd, msg, msglen), GFP_KERNEL);
> +	if (!cmd)
> +		return NULL;
> +
> +	cmd->v_opcode = v_opcode;
> +	cmd->msglen = msglen;
> +
> +	return cmd;
> +}
> +
> +/**
> + * iavf_queue_ptp_cmd - Queue PTP command for sending over virtchnl
> + * @adapter: private adapter structure
> + * @cmd: the command structure to send
> + *
> + * Queue the given command structure into the PTP virtchnl command queue tos
> + * end to the PF.
> + */
> +static void iavf_queue_ptp_cmd(struct iavf_adapter *adapter,
> +			       struct iavf_ptp_aq_cmd *cmd)
> +{
> +	mutex_lock(&adapter->ptp.aq_cmd_lock);
> +	list_add_tail(&cmd->list, &adapter->ptp.aq_cmds);
> +	mutex_unlock(&adapter->ptp.aq_cmd_lock);
> +
> +	adapter->aq_required |= IAVF_FLAG_AQ_SEND_PTP_CMD;
> +	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
> +}
> +
> +/**
> + * iavf_send_phc_read - Send request to read PHC time
> + * @adapter: private adapter structure
> + *
> + * Send a request to obtain the PTP hardware clock time. This allocates the
> + * VIRTCHNL_OP_1588_PTP_GET_TIME message and queues it up to send to
> + * indirectly read the PHC time.
> + *
> + * This function does not wait for the reply from the PF.
> + *
> + * Return: 0 if success, error code otherwise.
> + */
> +static int iavf_send_phc_read(struct iavf_adapter *adapter)
> +{
> +	struct iavf_ptp_aq_cmd *cmd;
> +
> +	if (!adapter->ptp.clock)
> +		return -EOPNOTSUPP;
> +
> +	cmd = iavf_allocate_ptp_cmd(VIRTCHNL_OP_1588_PTP_GET_TIME,
> +				    sizeof(struct virtchnl_phc_time));
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	iavf_queue_ptp_cmd(adapter, cmd);
> +
> +	return 0;
> +}
> +
> +/**
> + * iavf_read_phc_indirect - Indirectly read the PHC time via virtchnl
> + * @adapter: private adapter structure
> + * @ts: storage for the timestamp value
> + * @sts: system timestamp values before and after the read
> + *
> + * Used when the device does not have direct register access to the PHC time.
> + * Indirectly reads the time via the VIRTCHNL_OP_1588_PTP_GET_TIME, and waits
> + * for the reply from the PF.
> + *
> + * Based on some simple measurements using ftrace and phc2sys, this clock
> + * access method has about a ~110 usec latency even when the system is not
> + * under load. In order to achieve acceptable results when using phc2sys with
> + * the indirect clock access method, it is recommended to use more
> + * conservative proportional and integration constants with the P/I servo.
> + *
> + * Return: 0 if success, error code otherwise.
> + */
> +static int iavf_read_phc_indirect(struct iavf_adapter *adapter,
> +				  struct timespec64 *ts,
> +				  struct ptp_system_timestamp *sts)
> +{
> +	long ret;
> +	int err;
> +
> +	adapter->ptp.phc_time_ready = false;
> +	ptp_read_system_prets(sts);
> +
> +	err = iavf_send_phc_read(adapter);
> +	if (err)
> +		return err;
> +
> +	ret = wait_event_interruptible_timeout(adapter->ptp.phc_time_waitqueue,
> +					       adapter->ptp.phc_time_ready,
> +					       HZ);
> +	if (ret < 0)
> +		return ret;
> +	else if (!ret)
> +		return -EBUSY;
> +
> +	*ts = ns_to_timespec64(adapter->ptp.cached_phc_time);
> +
> +	ptp_read_system_postts(sts);

Usually prets()/postts() pair covers actual transaction time. That means
the last error check and ns_to_timespec64() are usually no covered.

Not sure though how precise it can be because of several queues used in 
the process..

> +
> +	return 0;
> +}
> +

