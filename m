Return-Path: <netdev+bounces-304094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GC8BHwZDRmpkNAsAu9opvQ
	(envelope-from <netdev+bounces-304094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:52:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EF16F63B5
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:52:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=I+R7LBKV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304094-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304094-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCBE133EFD60
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF783F4118;
	Thu,  2 Jul 2026 10:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39843E1232
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:11:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987104; cv=none; b=jX5mVf6AO5+ZoLvJIH9ML7g6DzjocmucK6PwBIkkXduBW+UiAnwuVqELcjSSfy2yZmdIH+473ym/Q3js4mykv6JXmJaEynBx/AsQGsbW8P7bNcu9IhfpEL9hjVErZ1HJ1LoGJ+o043ZWJW9i/EqI32JCYgLnJNf1KrtDfiN/HM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987104; c=relaxed/simple;
	bh=2/6+NR0ckUilWDAFxIfCLRQs1vyJZOc6bGiA25HjdxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BS0glxpFsoMNsHlBySDAdyMan3zu9bnpZ0PJeJoUMnVw+MvLamnncQZkMI99CBD9JQdOvQGPI7590tq/u14SX4wYOm+MBkiKjwTB2ZcIwumxsghM16OFJg26vFFq+QRhPkwkbQlO6mAj1FtBOQnkH3oiQ6rxsvizdjNqA62/mnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+R7LBKV; arc=none smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782987102; x=1814523102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2/6+NR0ckUilWDAFxIfCLRQs1vyJZOc6bGiA25HjdxI=;
  b=I+R7LBKVXKRQjB3DOghLdPjjgSpLuJEXW5Ex1P67vFKK4nNLAQ/LwkP8
   LGsLEjmGRXZfPGJ8vCbwmyjbfQJqzpOSnyZI0pUqxshR9+DAW7qyBZVwr
   ZGe3/tj+8pQR/hgydzKG4jTif01QorlUVATJGn0SRHeFKs3vN5tm0gCd0
   HS2ZFdxWNp6HI9gXTgHNb+bVYRBb9ONemvrsDOJSP1ZIdJW4ZjDq48Hh/
   K3wpQml0W4TvAiQ4+1HiEoLeOezU6b98hTJU5g2jfyvq2XZTW0tYtfm/C
   T1C05708AISuA9YnkOXdKF6kIt3bR0/FtUHRrD8rCsAsFtlafs8MV1/a1
   w==;
X-CSE-ConnectionGUID: FfZN57Q9R1Ojc+PNV3NrvQ==
X-CSE-MsgGUID: CjbHVNZkRdedb0TTEj/tWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="71259939"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="71259939"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 03:11:42 -0700
X-CSE-ConnectionGUID: ZHtSMcqsQSGeidej7WRwqw==
X-CSE-MsgGUID: u3sBzwdjRVaTDlUlIzeQrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="282897638"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.94.248.198]) ([10.94.248.198])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 03:11:39 -0700
Message-ID: <4cb7b4e0-05fa-4653-adbd-436f81f34072@linux.intel.com>
Date: Thu, 2 Jul 2026 12:11:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: move
 ice_vsi_realloc_stat_arrays() up
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, Michal Schmidt <mschmidt@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
References: <20260701104141.9740-1-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260701104141.9740-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304094-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:mschmidt@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:aleksandr.loktionov@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jedrzej.jagielski@intel.com,m:piotr.kwapulinski@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7EF16F63B5



On 01.07.2026 12:41, Przemek Kitszel wrote:
> Move ice_vsi_realloc_stat_arrays() up, to allow calling it from
> ice_vsi_cfg_def() by the next commit.
> 
> Fix kdoc for touched code. One line break removed, "int i" scope
> minimized to the loop, no changes otherwise.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 119 +++++++++++------------
>  1 file changed, 59 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 8cdc4fda89e9..e48ee5940f17 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2303,6 +2303,65 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
>  	return 0;
>  }
>  
> +/**
> + * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
> + * @vsi: VSI pointer
> + * Return: 0 on success or -ENOMEM on allocation failure.
> + */
> +static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
> +{
> +	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
> +	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
> +	struct ice_ring_stats **tx_ring_stats;
> +	struct ice_ring_stats **rx_ring_stats;
> +	struct ice_vsi_stats *vsi_stat;
> +	struct ice_pf *pf = vsi->back;
> +	u16 prev_txq = vsi->alloc_txq;
> +	u16 prev_rxq = vsi->alloc_rxq;
> +
> +	vsi_stat = pf->vsi_stats[vsi->idx];
> +
> +	if (req_txq < prev_txq) {
> +		for (int i = req_txq; i < prev_txq; i++) {
> +			if (vsi_stat->tx_ring_stats[i]) {
> +				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> +				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
> +			}
> +		}
> +	}
> +
> +	tx_ring_stats = vsi_stat->tx_ring_stats;
> +	vsi_stat->tx_ring_stats =
> +		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
> +			       sizeof(*vsi_stat->tx_ring_stats),
> +			       GFP_KERNEL | __GFP_ZERO);
> +	if (!vsi_stat->tx_ring_stats) {
> +		vsi_stat->tx_ring_stats = tx_ring_stats;
> +		return -ENOMEM;
> +	}
> +
> +	if (req_rxq < prev_rxq) {
> +		for (int i = req_rxq; i < prev_rxq; i++) {
> +			if (vsi_stat->rx_ring_stats[i]) {
> +				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
> +				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
> +			}
> +		}
> +	}
> +
> +	rx_ring_stats = vsi_stat->rx_ring_stats;
> +	vsi_stat->rx_ring_stats =
> +		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
> +			       sizeof(*vsi_stat->rx_ring_stats),
> +			       GFP_KERNEL | __GFP_ZERO);
> +	if (!vsi_stat->rx_ring_stats) {
> +		vsi_stat->rx_ring_stats = rx_ring_stats;
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * ice_vsi_cfg_def - configure default VSI based on the type
>   * @vsi: pointer to VSI
> @@ -3011,66 +3070,6 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
>  	}
>  }
>  
> -/**
> - * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
> - * @vsi: VSI pointer
> - */
> -static int
> -ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
> -{
> -	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
> -	u16 req_rxq = vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
> -	struct ice_ring_stats **tx_ring_stats;
> -	struct ice_ring_stats **rx_ring_stats;
> -	struct ice_vsi_stats *vsi_stat;
> -	struct ice_pf *pf = vsi->back;
> -	u16 prev_txq = vsi->alloc_txq;
> -	u16 prev_rxq = vsi->alloc_rxq;
> -	int i;
> -
> -	vsi_stat = pf->vsi_stats[vsi->idx];
> -
> -	if (req_txq < prev_txq) {
> -		for (i = req_txq; i < prev_txq; i++) {
> -			if (vsi_stat->tx_ring_stats[i]) {
> -				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> -				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
> -			}
> -		}
> -	}
> -
> -	tx_ring_stats = vsi_stat->tx_ring_stats;
> -	vsi_stat->tx_ring_stats =
> -		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
> -			       sizeof(*vsi_stat->tx_ring_stats),
> -			       GFP_KERNEL | __GFP_ZERO);
> -	if (!vsi_stat->tx_ring_stats) {
> -		vsi_stat->tx_ring_stats = tx_ring_stats;
> -		return -ENOMEM;
> -	}
> -
> -	if (req_rxq < prev_rxq) {
> -		for (i = req_rxq; i < prev_rxq; i++) {
> -			if (vsi_stat->rx_ring_stats[i]) {
> -				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
> -				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
> -			}
> -		}
> -	}
> -
> -	rx_ring_stats = vsi_stat->rx_ring_stats;
> -	vsi_stat->rx_ring_stats =
> -		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
> -			       sizeof(*vsi_stat->rx_ring_stats),
> -			       GFP_KERNEL | __GFP_ZERO);
> -	if (!vsi_stat->rx_ring_stats) {
> -		vsi_stat->rx_ring_stats = rx_ring_stats;
> -		return -ENOMEM;
> -	}
> -
> -	return 0;
> -}
> -
>  /**
>   * ice_vsi_rebuild - Rebuild VSI after reset
>   * @vsi: VSI to be rebuild


