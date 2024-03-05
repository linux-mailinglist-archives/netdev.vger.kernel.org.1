Return-Path: <netdev+bounces-77495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8900871F33
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D391C2526E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED3B5A4FE;
	Tue,  5 Mar 2024 12:28:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913BE59B44
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641698; cv=none; b=A02uhKsko2Qef7rwwj8hxsEpu3Wu5FHUpC/Z6GRmxA+4FvkCh/KQMf81vvSfmnW6CP2VXfvekoigJ6reySFb/RIjqR7EOVV42XpWYAQidAjtZx9XjUwjebK9oHWRFEBiNReXqxrf0wSymKOKZq5cTNe3gFQbpHyODEkqcyk7tSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641698; c=relaxed/simple;
	bh=1srBo94YIEZmKCCd/SGTD1UYqodd+1mmAdbI5BFMW8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEAy5NHvEtAmwN5vHorah2dFRe9ZETKK0JCpkntYIvPxnY764scnD83Np/roN/sxbUuNDJrYOPxoTc42R/778OjiaBo4DsPEAYQUp8SQkS18ZJpRC6HhCwPYgFSou9JMMGu/oguvoKoWigFRW6VmaY05zlDMtUx7XiA+6xeInEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A250C61E5FE38;
	Tue,  5 Mar 2024 13:27:25 +0100 (CET)
Message-ID: <9394bbe0-66bf-433a-8aa0-4051907389b3@molgen.mpg.de>
Date: Tue, 5 Mar 2024 13:27:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix typo in assignment
Content-Language: en-US
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
 Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20240305003707.55507-1-jesse.brandeburg@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240305003707.55507-1-jesse.brandeburg@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jesse,


Thank you for your patch.

Am 05.03.24 um 01:37 schrieb Jesse Brandeburg:
> Fix an obviously incorrect assignment, created with a typo or cut-n-paste
> error.

It’s probably just me, but with these one letter typos I still have to 
search the diff two or three times to spot the typo. Maybe even use 
(next time) as commit message summary:

ice: Assign tx ring stats value to tx stats and not rx ones

> Fixes: 5995ef88e3a8 ("ice: realloc VSI stats arrays")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 097bf8fd6bf0..fc23dbe302b4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3192,7 +3192,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>   		}
>   	}
>   
> -	tx_ring_stats = vsi_stat->rx_ring_stats;
> +	tx_ring_stats = vsi_stat->tx_ring_stats;
>   	vsi_stat->tx_ring_stats =
>   		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
>   			       sizeof(*vsi_stat->tx_ring_stats),
> 
> base-commit: 948abb59ebd3892c425165efd8fb2f5954db8de7

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

