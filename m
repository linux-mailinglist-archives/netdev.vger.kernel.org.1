Return-Path: <netdev+bounces-213259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C23B2442F
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30D61B68174
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6388A2EA47C;
	Wed, 13 Aug 2025 08:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867322690D9;
	Wed, 13 Aug 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073268; cv=none; b=NRNeXq1nZJ7nTen5q9mUU45JpJrqdGhYVTqs9T7eTLNU1rnE9mxpnXlGKMKqXAzfsRjwXJ8S0q5Pojs49cCK2a2VdwUt5faUi1gKfPg6RzUK+4MFvWC64hn5ZdRBnYTWYlfOFAg1APqS6PgEyikgX8wdyqRGsYSaX042EHWUWhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073268; c=relaxed/simple;
	bh=y/s7wwOlYPVkyXx5nbRs5KaAJ0ZEjjOZjp/AnDFDD50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quRq4epl7FRYSpLXD5F82qDlCfaMkGCluF1bEWOYG6fWsiW+Dg0QYTlXwQ49T4G6qZYKtCIsOVM2hVwbEdlJ4pO9UXw4y7E5iLW3BV7x4eNggqYSQO3OFfKZFurN63cyGHngKBAx+G7BvriFI9aTG98HqyyOho6tSjX4bdWhJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7c8.dynamic.kabel-deutschland.de [95.90.247.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A4D2C61E647BA;
	Wed, 13 Aug 2025 10:20:33 +0200 (CEST)
Message-ID: <785b380c-d4ba-423c-93ed-059d0aebc6be@molgen.mpg.de>
Date: Wed, 13 Aug 2025 10:20:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-next 2/2] igbvf: remove
 duplicated counter rx_long_byte_count from ethtool statistics
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kohei.enju@gmail.com
References: <20250813075206.70114-1-enjuk@amazon.com>
 <20250813075206.70114-3-enjuk@amazon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250813075206.70114-3-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kohei,


Thank you for your patch.

Am 13.08.25 um 09:50 schrieb Kohei Enju:
> rx_long_byte_count shows the value of the GORC (Good Octets Received
> Count) register. However, the register value is already shown as
> rx_bytes and they always show the same value.
> 
> Remove rx_long_byte_count as the Intel ethernet driver e1000e did in
> commit 0a939912cf9c ("e1000e: cleanup redundant statistics counter").
> 
> Tested on Intel Corporation I350 Gigabit Network Connection.
> 
> Tested-by: Kohei Enju <enjuk@amazon.com>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
>   drivers/net/ethernet/intel/igbvf/ethtool.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
> index c6defc495f13..9c08ebfad804 100644
> --- a/drivers/net/ethernet/intel/igbvf/ethtool.c
> +++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
> @@ -36,7 +36,6 @@ static const struct igbvf_stats igbvf_gstrings_stats[] = {
>   	{ "lbtx_bytes", IGBVF_STAT(stats.gotlbc, stats.base_gotlbc) },
>   	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
>   	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },
> -	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },
>   	{ "rx_csum_offload_good", IGBVF_STAT(hw_csum_good, zero_base) },
>   	{ "rx_csum_offload_errors", IGBVF_STAT(hw_csum_err, zero_base) },
>   	{ "rx_header_split", IGBVF_STAT(rx_hdr_split, zero_base) },

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: Should you resend, *redundant* instead of *duplicated* might better 
describe the removed counter.

