Return-Path: <netdev+bounces-190371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1486EAB685C
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1711B6301A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE9254AE0;
	Wed, 14 May 2025 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oa+PLgph"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764E1C3039
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217010; cv=none; b=LcTaF/VpttFcX/xKVG9/luLMC+7PPzavcRNKq1w4Vzwtw358MoBuBQJIOY2zYiJj+SdUvdgHdo1/VMGleDmiPTyn4Eh4/1wrCwhbW/ShZX9Oiv8c7UCb6VEfadpFqmDJztgLLWR1niEBR7ayRawGsJmk7P4TvPZlkDquqTXj1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217010; c=relaxed/simple;
	bh=D7GcchLdGVI3BEYhyhdSFNEBkGACTV2shXw19ofpyyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ny4Y1uUnxAR/xvXw/I+ox7lHjrIMf+yfAkaCcHw6c73Q3qsep3IWwVY5i3gvQak6q9HOWJ29fZoC4fN6wBVLX3KE0JbH2rG/0TCH2ZIwc0BieH2UudWj8T/iwGW9vwyve8stV7ZgAMbNOOa35CnXTTjdGRmlxbTwCZbaPE0UGD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oa+PLgph; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6cebadc-39fc-4cb0-be4b-d797deab12a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747217003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kP1tibvKFzK3ton7j6wkx93ql5HPqIhhrlxE6cuCpbs=;
	b=Oa+PLgpheMWK25xM4ne0KdUFKgmX5pGNUp7NfqSnNtjRO8r2cyEkp5CARM1uNz24gmhdPl
	ugHVGGYZNgC//WqSLuhA8jC3ypSqb8lAXpdqPHCFdqXdiU0iZ5AMSyJEc9mhEUR1TUAsFD
	sknb/NPXKoZKeszaORYM5BbOFHiDGds=
Date: Wed, 14 May 2025 11:03:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-next 0/5] Intel driver conversion to new hardware
 timestamping API
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Richard Cochran <richardcochran@gmail.com>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250513101132.328235-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/05/2025 11:11, Vladimir Oltean wrote:
> Since the introduction of the new ndo_hwtstamp_get() and
> ndo_hwtstamp_set() operations in v6.6, only e1000e and iavf have
> been converted.
> 
> There is a push to get rid of the old code path for configuring hardware
> timestamping, so the reset of the drivers are converted in this patch
> set.
> 
> Vladimir Oltean (5):
>    ice: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>    igc: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>    igb: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>    ixgbe: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>    i40e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
> 
>   drivers/net/ethernet/intel/i40e/i40e.h        |  9 ++--
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 24 +---------
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c    | 43 +++++++++---------
>   drivers/net/ethernet/intel/ice/ice_main.c     | 24 +---------
>   drivers/net/ethernet/intel/ice/ice_ptp.c      | 45 ++++++++++---------
>   drivers/net/ethernet/intel/ice/ice_ptp.h      | 17 ++++---
>   drivers/net/ethernet/intel/igb/igb.h          |  9 ++--
>   drivers/net/ethernet/intel/igb/igb_main.c     |  6 +--
>   drivers/net/ethernet/intel/igb/igb_ptp.c      | 37 +++++++--------
>   drivers/net/ethernet/intel/igc/igc.h          |  9 ++--
>   drivers/net/ethernet/intel/igc/igc_main.c     | 21 +--------
>   drivers/net/ethernet/intel/igc/igc_ptp.c      | 36 +++++++--------
>   drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  9 ++--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  6 +--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 42 ++++++++---------
>   15 files changed, 147 insertions(+), 190 deletions(-)
> 

The changes are pretty straight-forward.

For series:
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


