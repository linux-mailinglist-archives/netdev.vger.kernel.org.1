Return-Path: <netdev+bounces-162699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AEAA27A3F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536921884807
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE16B218AB7;
	Tue,  4 Feb 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pViV9I+1"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B338212FA5
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694572; cv=none; b=Tp6oFHDvYUiuJuAQ7SS0P+b6QYUi8djHESBEIPxnGN9QD/4n8YSzlx+OcZBBfUi92BpGv+EIN4CARVtR//qKMATTLJnMTXj3Oi1UZhkjiMlmaZwSajgu6sxTkXMaMZ9ctQHVdCbTiqiPcwhwRGmyGWJWaoOqQs54qU2eJjMv/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694572; c=relaxed/simple;
	bh=yyiTFThxN5TnisQEfGmySCPMmJhMaXS2UTYNZg9n3zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYugUkOTmKVh5dJfZq6DwLAHOF7x2RlwEr/ER9xDQNhn4uY5tDi7EBL/SidVeh3BtFN+uaYbLBz988I8Ijbd2OovG7qoXLXSsoPfFNBxkHTAuW1VAu91390Kt1ufrXNa7AI9JoY/jtwDcmjo4fbBCnvRfBw03Uhsqfc3z9FhIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pViV9I+1; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f0b9a34-db37-4cd5-ae4a-bdc2855dfb72@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738694567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulPFD5Sl2hWxEFSYpdVtQHzXB1h6+CKjPaNObdy2iH8=;
	b=pViV9I+1nagKdYEVjF9QGC9RerkReSNr8eXuTVWekPijFVFDC9th8HKL+zB0woLARgsdbs
	S1cziL8t42DYRQrMkrqNE+KRw4WYEcO77rK6OJVJzVwEJ3VQUk4N2DAvYxxqydL+vos+YE
	FobphY14/xj4Oc3QKKtpDYtyRTEC5g4=
Date: Tue, 4 Feb 2025 18:42:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-next] ixgbe: add PTP support for E610 device
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 Milena Olech <milena.olech@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250204071259.15510-1-piotr.kwapulinski@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250204071259.15510-1-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/02/2025 07:12, Piotr Kwapulinski wrote:
> Add PTP support for E610 adapter. The E610 is based on X550 and adds
> firmware managed link, enhanced security capabilities and support for
> updated server manageability. It does not introduce any new PTP features
> compared to X550.
> 
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  1 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     | 13 +++++++++++--
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index da91c58..f03925c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -3185,6 +3185,7 @@ static int ixgbe_get_ts_info(struct net_device *dev,
>   	case ixgbe_mac_X550:
>   	case ixgbe_mac_X550EM_x:
>   	case ixgbe_mac_x550em_a:
> +	case ixgbe_mac_e610:
>   		info->rx_filters |= BIT(HWTSTAMP_FILTER_ALL);
>   		break;
>   	case ixgbe_mac_X540:
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> index 9339edb..eef25e1 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> @@ -140,6 +140,7 @@
>    * proper mult and shift to convert the cycles into nanoseconds of time.
>    */
>   #define IXGBE_X550_BASE_PERIOD 0xC80000000ULL
> +#define IXGBE_E610_BASE_PERIOD 0x333333333ULL
>   #define INCVALUE_MASK	0x7FFFFFFF
>   #define ISGN		0x80000000
>   
> @@ -415,6 +416,7 @@ static void ixgbe_ptp_convert_to_hwtstamp(struct ixgbe_adapter *adapter,
>   	case ixgbe_mac_X550:
>   	case ixgbe_mac_X550EM_x:
>   	case ixgbe_mac_x550em_a:
> +	case ixgbe_mac_e610:
>   		/* Upper 32 bits represent billions of cycles, lower 32 bits
>   		 * represent cycles. However, we use timespec64_to_ns for the
>   		 * correct math even though the units haven't been corrected
> @@ -492,11 +494,13 @@ static int ixgbe_ptp_adjfine_X550(struct ptp_clock_info *ptp, long scaled_ppm)
>   	struct ixgbe_adapter *adapter =
>   			container_of(ptp, struct ixgbe_adapter, ptp_caps);
>   	struct ixgbe_hw *hw = &adapter->hw;
> +	u64 rate, base;
>   	bool neg_adj;
> -	u64 rate;
>   	u32 inca;
>   
> -	neg_adj = diff_by_scaled_ppm(IXGBE_X550_BASE_PERIOD, scaled_ppm, &rate);
> +	base = hw->mac.type == ixgbe_mac_e610 ? IXGBE_E610_BASE_PERIOD :
> +						IXGBE_X550_BASE_PERIOD;
> +	neg_adj = diff_by_scaled_ppm(base, scaled_ppm, &rate);
>   
>   	/* warn if rate is too large */
>   	if (rate >= INCVALUE_MASK)
> @@ -559,6 +563,7 @@ static int ixgbe_ptp_gettimex(struct ptp_clock_info *ptp,
>   	case ixgbe_mac_X550:
>   	case ixgbe_mac_X550EM_x:
>   	case ixgbe_mac_x550em_a:
> +	case ixgbe_mac_e610:
>   		/* Upper 32 bits represent billions of cycles, lower 32 bits
>   		 * represent cycles. However, we use timespec64_to_ns for the
>   		 * correct math even though the units haven't been corrected
> @@ -1067,6 +1072,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
>   	case ixgbe_mac_X550:
>   	case ixgbe_mac_X550EM_x:
>   	case ixgbe_mac_x550em_a:
> +	case ixgbe_mac_e610:
>   		/* enable timestamping all packets only if at least some
>   		 * packets were requested. Otherwise, play nice and disable
>   		 * timestamping
> @@ -1233,6 +1239,7 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
>   		fallthrough;
>   	case ixgbe_mac_x550em_a:
>   	case ixgbe_mac_X550:
> +	case ixgbe_mac_e610:
>   		cc.read = ixgbe_ptp_read_X550;
>   		break;
>   	case ixgbe_mac_X540:
> @@ -1280,6 +1287,7 @@ static void ixgbe_ptp_init_systime(struct ixgbe_adapter *adapter)
>   	case ixgbe_mac_X550EM_x:
>   	case ixgbe_mac_x550em_a:
>   	case ixgbe_mac_X550:
> +	case ixgbe_mac_e610:
>   		tsauxc = IXGBE_READ_REG(hw, IXGBE_TSAUXC);
>   
>   		/* Reset SYSTIME registers to 0 */
> @@ -1407,6 +1415,7 @@ static long ixgbe_ptp_create_clock(struct ixgbe_adapter *adapter)
>   	case ixgbe_mac_X550:
>   	case ixgbe_mac_X550EM_x:
>   	case ixgbe_mac_x550em_a:
> +	case ixgbe_mac_e610:
>   		snprintf(adapter->ptp_caps.name, 16, "%s", netdev->name);
>   		adapter->ptp_caps.owner = THIS_MODULE;
>   		adapter->ptp_caps.max_adj = 30000000;


LGTM,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

