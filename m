Return-Path: <netdev+bounces-158169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA128A10C3C
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13198164A01
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1AD1ACE12;
	Tue, 14 Jan 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8rGYhk5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69F15625A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872012; cv=none; b=rQc4+dJa24NcJAp95gLc9uayr8qT/D415tN3spbXOfM+b/Br9e67ZrsvYFt+YImtWUtcjeou9ihZ/4T7gQ+ajSlsCQqn8/iCFcYoJoW+mQ/Xcqi4RKGNRAjL28E0agYakoaPsXax7dYrh0O9sBLwhmuTU22/CF+0djiY5sh19gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872012; c=relaxed/simple;
	bh=M4Cn+eL+x9zWWIRpPVhnct7ZMf79YYvSQa9ze2RWOZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh/nFMCSxr2dYQowpLTckE4HdEdTcCOB8koAHg+YtJebpkBM42zBJBMggxWzO+giCtVXuKRqhDNCd1njIdBPNA1lKHAjtnoWSqb8YNr0EzpufCva6l4vomBa4TKhlyefqd5lNHjaUHYNttoab4FRbRKeYQNtsJxA6zzTMt8iMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8rGYhk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7491AC4CEDD;
	Tue, 14 Jan 2025 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736872011;
	bh=M4Cn+eL+x9zWWIRpPVhnct7ZMf79YYvSQa9ze2RWOZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8rGYhk5UcrthKy07+U6QbtWuVwTvNjdAFVAgigadI1Orhw52/3oQYSKX+qgxh5+b
	 u2hNSV2Vecd2kcx6Mn0JdZ6zqBMGe/GOnFbCm4HDiT8yfh2P54UC6457M+xl5/UWOn
	 plqfWvQPYL7MKou4FPItIF9TczetMchsAgHKZH4PgZ+lcgQ7PYXmqLiskGe+okcPdt
	 uCWWTofON2LW4i1Ihe3AuPwrDEYVVVu2cc/0u72Vrmn0M7Dq4zwJIuWoEpBh7fd29Q
	 Ezp3W9MqYO3NKbeeJzhJWvohJFYviWYAl8LngsWcmC1uGG5aium58X5SjX4IqHr+PI
	 NEQY5quLslm4g==
Date: Tue, 14 Jan 2025 16:26:48 +0000
From: Simon Horman <horms@kernel.org>
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Josh Hay <joshua.a.hay@intel.com>
Subject: Re: [PATCH v4 iwl-next 08/10] idpf: add Tx timestamp flows
Message-ID: <20250114162648.GK5497@kernel.org>
References: <20250114121103.605288-1-milena.olech@intel.com>
 <20250114121103.605288-9-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114121103.605288-9-milena.olech@intel.com>

On Tue, Jan 14, 2025 at 01:11:13PM +0100, Milena Olech wrote:
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
> Signed-off-by: Milena Olech <milena.olech@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c

...

> +/**
> + * idpf_ptp_request_ts - Request an available Tx timestamp index
> + * @tx_q: Transmit queue on which the Tx timestamp is requested
> + * @skb: The SKB to associate with this timestamp request
> + * @idx: Index of the Tx timestamp latch
> + *
> + * Request tx timestamp index negotiated during PTP init that will be set into
> + * Tx descriptor.
> + *
> + * Return: 0 and the index that can be provided to Tx descriptor on success,
> + * -errno otherwise.
> + */
> +int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
> +			u32 *idx)
> +{
> +	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
> +	struct list_head *head;
> +
> +	/* Get the index from the free latches list */
> +	spin_lock_bh(&tx_q->cached_tstamp_caps->lock_free);
> +
> +	head = &tx_q->cached_tstamp_caps->latches_free;
> +	if (list_empty(head)) {
> +		spin_unlock_bh(&tx_q->cached_tstamp_caps->lock_in_use);

Hi Milena and Josh,

Should the line above be:

		spin_unlock_bh(&tx_q->cached_tstamp_caps->lock_free);
		                                          ^^^^^^^^^

Flagged by Smatch.

> +		return -ENOBUFS;
> +	}
> +
> +	ptp_tx_tstamp = list_first_entry(head, struct idpf_ptp_tx_tstamp,
> +					 list_member);
> +	list_del(&ptp_tx_tstamp->list_member);
> +	spin_unlock_bh(&tx_q->cached_tstamp_caps->lock_free);
> +
> +	ptp_tx_tstamp->skb = skb_get(skb);
> +	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +
> +	/* Move the element to the used latches list */
> +	spin_lock_bh(&tx_q->cached_tstamp_caps->lock_in_use);
> +	list_add(&ptp_tx_tstamp->list_member,
> +		 &tx_q->cached_tstamp_caps->latches_in_use);
> +	spin_unlock_bh(&tx_q->cached_tstamp_caps->lock_in_use);
> +
> +	*idx = ptp_tx_tstamp->idx;
> +
> +	return 0;
> +}

...

