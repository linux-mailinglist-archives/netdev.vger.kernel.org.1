Return-Path: <netdev+bounces-277309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML+YMYHE2Gk4hwgAu9opvQ
	(envelope-from <netdev+bounces-277309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:36:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440B3D4ED9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CED5D303B10D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FFF3B6C10;
	Fri, 10 Apr 2026 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxQJVGr4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="STza8ktp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF33B47D9
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813663; cv=none; b=oI+sLSK+JxR8C6QeD9HtBCKnTdFBmhxmJ6FuzpvBu4by9og4rYjnKNtKmsTzAUwFqf/DuKNo3/Gv/MBVs0FIdHsWFz/7GmH07oaXXOS3CTLERtLHBpwj4dCuDVeCdHTqHZFYugo+SbZCX6JRF4H4gDcaqKGUEZNdQJaT/EKINFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813663; c=relaxed/simple;
	bh=ZdEvcx7oxPNxVyRxXuzQtQC7kdccxvrraMSdetS1ilA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dG0/Z8srYYKzNhMNgb/OlXgK2HWW7pvU2ECvRI9N9pu+xBUlQMkM+17ECFwIhKIVpKn4PTjzwdGwcJXU+E/2wDjBonupMAAV/5tP2Xn4XYr4KRfANs/Qw0sZExDvQLFc4VOHisVUyUBJnEVUi2TUH1KrAhddB2ctFOI1KabKSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxQJVGr4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=STza8ktp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775813660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbNXgPIhRUaORuGkZXuCuXIvu+tsHUf6wi7oUQz/0l4=;
	b=VxQJVGr4kd0u7VYLXjkXGj2TfCp6t4n9dudveo/n1nOUyehQ9EV8QiLkKf4hajyAXytQ3/
	CL6immdpiB3O/oJ9ZHG+4swTF1A//gApA8tip/Y1vQFDdENM4eVGL/4kRciuc2wtAa7ylX
	YPxkPix+yRfqWoow15Fe0PEwryVYfEk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-mgru8RAPPf-8NbiIb3c6iA-1; Fri, 10 Apr 2026 05:34:19 -0400
X-MC-Unique: mgru8RAPPf-8NbiIb3c6iA-1
X-Mimecast-MFC-AGG-ID: mgru8RAPPf-8NbiIb3c6iA_1775813658
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso2071805e9.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775813657; x=1776418457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbNXgPIhRUaORuGkZXuCuXIvu+tsHUf6wi7oUQz/0l4=;
        b=STza8ktpUlAdlzmwtZTQGBuKbKsaQ9d5O/XZs3nzQHQY0FMNmD3Gr6JPornFwF9q4w
         A8nA22WBvUmfygX6fFnOyLeJojvK3fxvtH02afJCzo28hV6nbJU7YfwwXaIokXbetf+h
         TN6h1jCgCyNizwJ5GXzCTPF5SbtSswNwgEj6M2oEQhg8R5jDb1jaupf3k7eUPhTAw528
         4NKTxaXLz07xXUHP+IFl87DcoCJ6K2/TJRRkfNZK8G13ysOP7NxBcFQYQtxq4CH+BNZc
         zoiNzk6hvP7IxYu2sB+bU3NZltcp8GfPFzUqz4fHiVZwVDkVbhGUyTtGMgqKL7+hnEb1
         Sr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813657; x=1776418457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbNXgPIhRUaORuGkZXuCuXIvu+tsHUf6wi7oUQz/0l4=;
        b=i9vKsro8xR6qRZY0soYWvcXONQd9+mOCWwnUAHvOjxqQwpb693xyv4oAB6ZGSscI4x
         As0HB+UlmT7aaP9Ft29bhc4w9V2EsQ5x8t2SZNS24rs+tsS6Q/RRET7Evzgsrbm3zeUP
         Gj7a3DyIkB17TCuOyeUCeiReAjZTpdJUosS/xYAYzFt7bO4p6fNZyT+UGFnI9CyaWQaF
         QpiMsEvUtFggD9vX6inrPeNDXeGJRViPMCQrU5NFzguhUoNASFFvD9XFnowG0zMjjCqd
         MTMAPxOfe3ZF7cZN9vCgkPUy9b4kTBoAzLkNyKKuvALQ2tcGk02VSmOl/NoC/X8/2TAd
         pYxw==
X-Forwarded-Encrypted: i=1; AJvYcCXE6R/qleoTYZHHS4ukTDJ5lheLzaLcK4ftsHhZrLHm1JBlTTKK4IuGQxiN97RCDWA74eGUPq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWlg75keeBfut5kz3QcPQwzd4KM3OX0FKFZKcBG7WXZ/T1oN0
	7SxzHAYJFgDINWhPT+KBNrDD871XerqOEgMs2U3bMTyZu2fMV2GOVL5JQp1zgSwWp4JDJJNYPnj
	8XcvedQCtPpKLpPX6Q+v9GUJaJJJjRZleRYH/zLWC/x7jJkLmhTly9xdfZ7urQnvihw==
X-Gm-Gg: AeBDiev6t07ExAQRg9ffP/FRszPDTBSOCiVR1xn61Ld5Pz74jUYNEfyXeHqf3YZbV5K
	lDEv2EM6vogfUV1qWFMnhHQSctbeHyugzGmIjzlwWvgmt+jczAgDe6GiwKCD8HUCXKhXvhJq9Ay
	hhN+10aPKWV2uNTIhaTSqez5cCDmdEv02vULaqSHSILJsAuRp4mMRU81Le0w89ofg6IfqbL7yu2
	ZyopLAiZ3Tf5U2yCaQEeJOlr8jP7jAgTb1ngRmV3nFSLJpkkZ05iJxqZ+B1lEFRt53tyrdc8P4N
	WY8LY6Xvh29MLZrgjRTQgBpjpgQnUCDcRU44Bxu4kBV4GDSO0hc8aDCxqOZ/k3IkTmYT5/n0tEx
	EtABoW/++4FgMHDhw1HpV
X-Received: by 2002:a05:600c:3f0d:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-488d68769f9mr25808795e9.26.1775813656789;
        Fri, 10 Apr 2026 02:34:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0d:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-488d68769f9mr25808205e9.26.1775813656212;
        Fri, 10 Apr 2026 02:34:16 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d78cfdsm17897975e9.4.2026.04.10.02.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 02:34:15 -0700 (PDT)
Message-ID: <715ae9de-25f4-4496-abb5-9c98ccda5ede@redhat.com>
Date: Fri, 10 Apr 2026 11:34:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 3/4] ice: fix ready bitmap check
 for non-E822 devices
To: Jacob Keller <jacob.e.keller@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Timothy Miskell <timothy.miskell@intel.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
 <20260408-jk-even-more-e825c-fixes-v1-3-b959da91a81f@intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-3-b959da91a81f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-277309-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9440B3D4ED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/8/26 20:46, Jacob Keller wrote:
> The E800 hardware (apart from E810) has a ready bitmap for the PHY
> indicating which timestamp slots currently have an outstanding timestamp
> waiting to be read by software.
>
> This bitmap is checked in multiple places using the
> ice_get_phy_tx_tstamp_ready():
>
>   * ice_ptp_process_tx_tstamp() calls it to determine which timestamps to
>     attempt reading from the PHY
>   * ice_ptp_tx_tstamps_pending() calls it in a loop at the end of the
>     miscellaneous IRQ to check if new timestamps came in while the interrupt
>     handler was executing.
>   * ice_ptp_maybe_trigger_tx_interrupt() calls it in the auxiliary work task
>     to trigger a software interrupt in the event that the hardware logic
>     gets stuck.
>
> For E82X devices, multiple PHYs share the same block, and the parameter
> passed to the ready bitmap is a block number associated with the given
> port. For E825-C devices, the PHYs have their own independent blocks and do
> not share, so the parameter passed needs to be the port number. For E810
> devices, the ice_get_phy_tx_tstamp_ready() always returns all 1s regardless
> of what port, since this hardware does not have a ready bitmap. Finally,
> for E830 devices, each PF has its own ready bitmap accessible via register,
> and the block parameter is unused.
>
> The first call correctly uses the Tx timestamp tracker block parameter to
> check the appropriate timestamp block. This works because the tracker is
> setup correctly for each timestamp device type.
>
> The second two callers behave incorrectly for all device types other than
> the older E822 devices. They both iterate in a loop using
> ICE_GET_QUAD_NUM() which is a macro only used by E822 devices. This logic
> is incorrect for devices other than the E822 devices.
>
> For E810 the calls would always return true, causing E810 devices to always
> attempt to trigger a software interrupt even when they have no reason to.
> For E830, this results in duplicate work as the ready bitmap is checked
> once per number of quads. Finally, for E825-C, this results in the pending
> checks failing to detect timestamps on ports other than the first two.
>
> Fix this by introducing a new hardware API function to ice_ptp_hw.c,
> ice_check_phy_tx_tstamp_ready(). This function will check if any timestamps
> are available and returns a positive value if any timestamps are pending.
> For E810, the function always returns false, so that the re-trigger checks
> never happen. For E830, check the ready bitmap just once. For E82x
> hardware, check each quad. Finally, for E825-C, check every port.
>
> The interface function returns an integer to enable reporting of error code
> if the driver is unable read the ready bitmap. This enables callers to
> handle this case properly. The previous implementation assumed that
> timestamps are available if they failed to read the bitmap. This is
> problematic as it could lead to continuous software IRQ triggering if the
> PHY timestamp registers somehow become inaccessible.
>
> This change is especially important for E825-C devices, as the missing
> checks could leave a window open where a new timestamp could arrive while
> the existing timestamps aren't completed. As a result, the hardware
> threshold logic would not trigger a new interrupt. Without the check, the
> timestamp is left unhandled, and new timestamps will not cause an interrupt
> again until the timestamp is handled. Since both the interrupt check and
> the backup check in the auxiliary task do not function properly, the device
> may have Tx timestamps permanently stuck failing on a given port.
>
> The faulty checks originate from commit d938a8cca88a ("ice: Auxbus devices
> & driver for E822 TS") and commit 712e876371f8 ("ice: periodically kick Tx
> timestamp interrupt"), however at the time of the original coding, both
> functions only operated on E822 hardware. This is no longer the case, and
> hasn't been since the introduction of the ETH56G PHY model in commit
> 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
>
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   1 +
>   drivers/net/ethernet/intel/ice/ice_ptp.c    |  40 ++++------
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 117 ++++++++++++++++++++++++++++
>   3 files changed, 132 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 9d7acc7eb2ce..1b58b054f4a5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -300,6 +300,7 @@ void ice_ptp_reset_ts_memory(struct ice_hw *hw);
>   int ice_ptp_init_phc(struct ice_hw *hw);
>   void ice_ptp_init_hw(struct ice_hw *hw);
>   int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready);
> +int ice_check_phy_tx_tstamp_ready(struct ice_hw *hw);
>   int ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
>   			 enum ice_ptp_tmr_cmd configured_cmd);
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index ada42bcc4d0b..34906f972d17 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2718,7 +2718,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
>   bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
>   {
>   	struct ice_hw *hw = &pf->hw;
> -	unsigned int i;
> +	int ret;
>   
>   	/* Check software indicator */
>   	switch (pf->ptp.tx_interrupt_mode) {
> @@ -2739,16 +2739,15 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
>   	}
>   
>   	/* Check hardware indicator */
> -	for (i = 0; i < ICE_GET_QUAD_NUM(hw->ptp.num_lports); i++) {
> -		u64 tstamp_ready = 0;
> -		int err;
> -
> -		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
> -		if (err || tstamp_ready)
> -			return true;
> +	ret = ice_check_phy_tx_tstamp_ready(hw);
> +	if (ret < 0) {
> +		dev_dbg(ice_pf_to_dev(pf), "Unable to read PHY Tx timestamp ready bitmap, err %d\n",
> +			ret);
> +		/* Stop triggering IRQs if we're unable to read PHY */
> +		return false;
>   	}
>   
> -	return false;
> +	return ret;
>   }
>   
>   /**
> @@ -2832,8 +2831,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>   {
>   	struct device *dev = ice_pf_to_dev(pf);
>   	struct ice_hw *hw = &pf->hw;
> -	bool trigger_oicr = false;
> -	unsigned int i;
> +	int ret;
>   
>   	if (!pf->ptp.port.tx.has_ready_bitmap)
>   		return;
> @@ -2841,21 +2839,11 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>   	if (!ice_pf_src_tmr_owned(pf))
>   		return;
>   
> -	for (i = 0; i < ICE_GET_QUAD_NUM(hw->ptp.num_lports); i++) {
> -		u64 tstamp_ready;
> -		int err;
> -
> -		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
> -		if (!err && tstamp_ready) {
> -			trigger_oicr = true;
> -			break;
> -		}
> -	}
> -
> -	if (trigger_oicr) {
> -		/* Trigger a software interrupt, to ensure this data
> -		 * gets processed.
> -		 */
> +	ret = ice_check_phy_tx_tstamp_ready(hw);
> +	if (ret < 0) {
> +		dev_dbg(dev, "PTP periodic task unable to read PHY timestamp ready bitmap, err %d\n",
> +			ret);
> +	} else if (ret) {
>   		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
>   
>   		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 441b5f10e4bb..64ad5ed5c688 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -2168,6 +2168,35 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>   	return 0;
>   }
>   
> +/**
> + * ice_check_phy_tx_tstamp_ready_eth56g - Check Tx memory status for all ports
> + * @hw: pointer to the HW struct
> + *
> + * Check the PHY_REG_TX_MEMORY_STATUS for all ports. A set bit indicates
> + * a waiting timestamp.
> + *
> + * Return: 1 if any port has at least one timestamp ready bit set,
> + * 0 otherwise, and a negative error code if unable to read the bitmap.
> + */
> +static int ice_check_phy_tx_tstamp_ready_eth56g(struct ice_hw *hw)
> +{
> +	int port;
> +
> +	for (port = 0; port < hw->ptp.num_lports; port++) {
> +		u64 tstamp_ready;
> +		int err;
> +
> +		err = ice_get_phy_tx_tstamp_ready(hw, port, &tstamp_ready);
> +		if (err)
> +			return err;
> +
> +		if (tstamp_ready)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * ice_ptp_read_tx_hwtstamp_status_eth56g - Get TX timestamp status
>    * @hw: pointer to the HW struct
> @@ -4318,6 +4347,35 @@ ice_get_phy_tx_tstamp_ready_e82x(struct ice_hw *hw, u8 quad, u64 *tstamp_ready)
>   	return 0;
>   }
>   
> +/**
> + * ice_check_phy_tx_tstamp_ready_e82x - Check Tx memory status for all quads
> + * @hw: pointer to the HW struct
> + *
> + * Check the Q_REG_TX_MEMORY_STATUS for all quads. A set bit indicates
> + * a waiting timestamp.
> + *
> + * Return: 1 if any quad has at least one timestamp ready bit set,
> + * 0 otherwise, and a negative error value if unable to read the bitmap.
> + */
> +static int ice_check_phy_tx_tstamp_ready_e82x(struct ice_hw *hw)
> +{
> +	int quad;
> +
> +	for (quad = 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lports); quad++) {
> +		u64 tstamp_ready;
> +		int err;
> +
> +		err = ice_get_phy_tx_tstamp_ready(hw, quad, &tstamp_ready);
> +		if (err)
> +			return err;
> +
> +		if (tstamp_ready)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * ice_phy_cfg_intr_e82x - Configure TX timestamp interrupt
>    * @hw: pointer to the HW struct
> @@ -4870,6 +4928,23 @@ ice_get_phy_tx_tstamp_ready_e810(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
>   	return 0;
>   }
>   
> +/**
> + * ice_check_phy_tx_tstamp_ready_e810 - Check Tx memory status register
> + * @hw: pointer to the HW struct
> + *
> + * The E810 devices do not have a Tx memory status register. Note this is
> + * intentionally different behavior from ice_get_phy_tx_tstamp_ready_e810
> + * which always says that all bits are ready. This function is called in cases
> + * where code will trigger interrupts if timestamps are waiting, and should
> + * not be called for E810 hardware.
> + *
> + * Return: 0.
> + */
> +static int ice_check_phy_tx_tstamp_ready_e810(struct ice_hw *hw)
> +{
> +	return 0;
> +}
> +
>   /* E810 SMA functions
>    *
>    * The following functions operate specifically on E810 hardware and are used
> @@ -5124,6 +5199,21 @@ static void ice_get_phy_tx_tstamp_ready_e830(const struct ice_hw *hw, u8 port,
>   	*tstamp_ready |= rd32(hw, E830_PRTMAC_TS_TX_MEM_VALID_L);
>   }
>   
> +/**
> + * ice_check_phy_tx_tstamp_ready_e830 - Check Tx memory status register
> + * @hw: pointer to the HW struct
> + *
> + * Return: 1 if the device has waiting timestamps, 0 otherwise.
> + */
> +static int ice_check_phy_tx_tstamp_ready_e830(struct ice_hw *hw)
> +{
> +	u64 tstamp_ready;
> +
> +	ice_get_phy_tx_tstamp_ready_e830(hw, 0, &tstamp_ready);
> +
> +	return !!tstamp_ready;
> +}
> +
>   /**
>    * ice_ptp_init_phy_e830 - initialize PHY parameters
>    * @ptp: pointer to the PTP HW struct
> @@ -5716,6 +5806,33 @@ int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready)
>   	}
>   }
>   
> +/**
> + * ice_check_phy_tx_tstamp_ready - Check PHY Tx timestamp memory status
> + * @hw: pointer to the HW struct
> + *
> + * Check the PHY for Tx timestamp memory status on all ports. If you need to
> + * see individual timestamp status for each index, use
> + * ice_get_phy_tx_tstamp_ready() instead.
> + *
> + * Return: 1 if any port has timestamps available, 0 if there are no timestamps
> + * available, and a negative error code on failure.
> + */
> +int ice_check_phy_tx_tstamp_ready(struct ice_hw *hw)
> +{
> +	switch (hw->mac_type) {
> +	case ICE_MAC_E810:
> +		return ice_check_phy_tx_tstamp_ready_e810(hw);
> +	case ICE_MAC_E830:
> +		return ice_check_phy_tx_tstamp_ready_e830(hw);
> +	case ICE_MAC_GENERIC:
> +		return ice_check_phy_tx_tstamp_ready_e82x(hw);
> +	case ICE_MAC_GENERIC_3K_E825:
> +		return ice_check_phy_tx_tstamp_ready_eth56g(hw);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>   /**
>    * ice_cgu_get_pin_desc_e823 - get pin description array
>    * @hw: pointer to the hw struct
>
Reviewed-by: Petr Oros <poros@redhat.com>


