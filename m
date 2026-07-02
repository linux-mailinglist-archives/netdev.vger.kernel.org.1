Return-Path: <netdev+bounces-304097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J+hhMq1FRmoKNgsAu9opvQ
	(envelope-from <netdev+bounces-304097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:04:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C26F6612
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:04:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=mmbMJopU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304097-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304097-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8630D30C16ED
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640823EAC90;
	Thu,  2 Jul 2026 10:25:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A9416D0C
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:25:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987931; cv=none; b=PIacwgbABzJv7qdq1GfhsPdk1ALcZpui7Uqr09QJyl9LLGFWIV5kpjmyacRhAQ1Bs//blaqAcY3O3NMm0gZekiwPGFkcTTeQ+t9GIMBYIuCPitDYoHU25QoRTxGzo2atd6NQ1Amf2nLembEK/osgCmo4t4V17YB+Yax//Beh3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987931; c=relaxed/simple;
	bh=4c9MR/wjhvT2gCHUXqup3VyOlygWwo/sdPuGMz2qwJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzPxxPjN7uXviJXTJVjpRzm0YaEl33ml3g9QJk2xmFFCMSUE1tsOkRP7llNMojIsiZCKOulya68Z0xImqVr1sb8U0n7u7/YneMrZYwDsM97BD+KhxXp8f21G0tGmHtCTXdvE+BqglE8rEygZmE3sxx0EK33Jaj1ogyxy4CTn6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmbMJopU; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782987930; x=1814523930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4c9MR/wjhvT2gCHUXqup3VyOlygWwo/sdPuGMz2qwJ4=;
  b=mmbMJopUkjFY09kSIYPBKB/ybmx/EU94jEJEtIUKI4ywMIjhjgpg4z+0
   Q71qoS9x9smgLuyI9wMo94Ao5f40gD7n5c+OHPnTqBD2EWWAHPmI5UzsL
   rHvRmjMCL6rCeuDc6grnOGx75FK/jw71B92LuSrHCPrSUlxMdqQpTW71E
   svBIVicah3ivvqOLUlCBklVJMt7EAgjnYMLPcTWmNlU2cNZCVJWdMNBuR
   8nSkd0FOqEEc9Nvp08w8waIpMmmDnjZLkzpXyOg6B0RLPSG0RlpzI1lds
   umRVL1zPDPOK0oeGxDRFEQBMabWejJMIa6KXMADnu95rdARvhEWpNuzPR
   A==;
X-CSE-ConnectionGUID: dgcdX/WYTxKzalW7Fwzxtw==
X-CSE-MsgGUID: vhREtzQgSLu4tP/mZwFiEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83517587"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83517587"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 03:25:29 -0700
X-CSE-ConnectionGUID: pY+dMFr6Qti2xVAGggsMww==
X-CSE-MsgGUID: Geg4lS0BSdaTqVCAkVNbng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="248846372"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.94.248.198]) ([10.94.248.198])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 03:25:25 -0700
Message-ID: <f2c285ba-8089-41a1-b28a-9062f2b584c8@linux.intel.com>
Date: Thu, 2 Jul 2026 12:25:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: fix stats array
 overflow via proper realloc
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
 <20260701104141.9740-2-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260701104141.9740-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304097-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,vger.kernel.org:from_smtp,atlassian.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A35C26F6612



On 01.07.2026 12:41, Przemek Kitszel wrote:
> Integrate ice_vsi_alloc_stat_arrays() with realloc variant.
> 
> Instead of keeping two functions for stat arrays allocation, change the
> ice_vsi_realloc_stat_arrays() to handle initial condition (no vsi_stat
> entry) and replace ice_vsi_alloc_stat_arrays() by the more generic
> ice_vsi_realloc_stat_arrays().
> 
> Note that VSIs of ICE_VSI_CHNL type are ignored in realloc variant as they
> were in the replaced ice_vsi_alloc_stat_arrays().
> 
> This is a fix for stats array overflow that occurs when VF is given more
> queues (an operation that will be more frequent, and by bigger increase,
> when we will merge my "XLVF" series).
> 
> Splat for increasing number of queues thanks to Michal Schmidt:
> KASAN detects the bug:
>  ==================================================================
>  BUG: KASAN: slab-out-of-bounds in ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
>  Read of size 8 at addr ffff88810affea60 by task kworker/u131:7/221
> 
>  CPU: 24 UID: 0 PID: 221 Comm: kworker/u131:7 Not tainted 7.1.0-rc1+ #1 PREEMPT(lazy)
>  ...
>  Workqueue: ice ice_service_task [ice]
>  Call Trace:
>   <TASK>
>   ...
>   kasan_report+0xd7/0x120
>   ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
>   ice_vsi_cfg_def+0x12e2/0x2060 [ice]
>   ice_vsi_cfg+0xb5/0x3c0 [ice]
>   ice_reset_vf+0x858/0xf80 [ice]
>   ice_vc_request_qs_msg+0x1da/0x290 [ice]
>   ice_vc_process_vf_msg+0xb15/0x1430 [ice]
>   __ice_clean_ctrlq+0x70d/0x9d0 [ice]
>   ice_service_task+0x840/0xf20 [ice]
>   process_one_work+0x690/0xff0
>   worker_thread+0x4d9/0xd20
>   kthread+0x322/0x410
>   ret_from_fork+0x332/0x660
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
>  Allocated by task 2439:
>   kasan_save_stack+0x1c/0x40
>   kasan_save_track+0x10/0x30
>   __kasan_kmalloc+0x96/0xb0
>   __kmalloc_noprof+0x1d8/0x580
>   ice_vsi_cfg_def+0x115c/0x2060 [ice]
>   ice_vsi_cfg+0xb5/0x3c0 [ice]
>   ice_vsi_setup+0x180/0x320 [ice]
>   ice_start_vfs+0x1f3/0x590 [ice]
>   ice_ena_vfs+0x66d/0x798 [ice]
>   ice_sriov_configure.cold+0xe4/0x121 [ice]
>   sriov_numvfs_store+0x279/0x480
>   kernfs_fop_write_iter+0x331/0x4f0
>   vfs_write+0x4c4/0xe40
>   ksys_write+0x10c/0x240
>   do_syscall_64+0xd9/0x650
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  The buggy address belongs to the object at ffff88810affea40
>                 which belongs to the cache kmalloc-32 of size 32
>  The buggy address is located 0 bytes to the right of
>                 allocated 32-byte region [ffff88810affea40, ffff88810affea60)
> 
> Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
> Closes: https://redhat.atlassian.net/browse/RHEL-164321

Is there a simpler reproducer than the script attached in the ticket?

> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
> This is an alternative to the fix [1] by Michal Schmidt, which were
> blocked due to AI feedback. My fix was already developed before Michal's,
> just not public back then. We have agreed to go on with my version.
> 
> [1] https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguyen@intel.com
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 57 +++++-------------------
>  1 file changed, 11 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index e48ee5940f17..ae167b42c558 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -513,51 +513,6 @@ static irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -/**
> - * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
> - * @vsi: VSI pointer
> - */
> -static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
> -{
> -	struct ice_vsi_stats *vsi_stat;
> -	struct ice_pf *pf = vsi->back;
> -
> -	if (vsi->type == ICE_VSI_CHNL)
> -		return 0;
> -	if (!pf->vsi_stats)
> -		return -ENOENT;
> -
> -	if (pf->vsi_stats[vsi->idx])
> -	/* realloc will happen in rebuild path */
> -		return 0;
> -
> -	vsi_stat = kzalloc_obj(*vsi_stat);
> -	if (!vsi_stat)
> -		return -ENOMEM;
> -
> -	vsi_stat->tx_ring_stats =
> -		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
> -	if (!vsi_stat->tx_ring_stats)
> -		goto err_alloc_tx;
> -
> -	vsi_stat->rx_ring_stats =
> -		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
> -	if (!vsi_stat->rx_ring_stats)
> -		goto err_alloc_rx;
> -
> -	pf->vsi_stats[vsi->idx] = vsi_stat;
> -
> -	return 0;
> -
> -err_alloc_rx:
> -	kfree(vsi_stat->rx_ring_stats);
> -err_alloc_tx:
> -	kfree(vsi_stat->tx_ring_stats);
> -	kfree(vsi_stat);
> -	pf->vsi_stats[vsi->idx] = NULL;
> -	return -ENOMEM;
> -}
> -
>  /**
>   * ice_vsi_alloc_def - set default values for already allocated VSI
>   * @vsi: ptr to VSI
> @@ -2319,7 +2274,17 @@ static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  	u16 prev_txq = vsi->alloc_txq;
>  	u16 prev_rxq = vsi->alloc_rxq;
>  
> +	if (vsi->type == ICE_VSI_CHNL)
> +		return 0;
> +
>  	vsi_stat = pf->vsi_stats[vsi->idx];
> +	if (!vsi_stat) {
> +		vsi_stat = kzalloc_obj(*vsi_stat);
> +		if (!vsi_stat)
> +			return -ENOMEM;
> +
> +		pf->vsi_stats[vsi->idx] = vsi_stat;
> +	}
>  
>  	if (req_txq < prev_txq) {
>  		for (int i = req_txq; i < prev_txq; i++) {
> @@ -2379,7 +2344,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
>  		return ret;
>  
>  	/* allocate memory for Tx/Rx ring stat pointers */
> -	ret = ice_vsi_alloc_stat_arrays(vsi);
> +	ret = ice_vsi_realloc_stat_arrays(vsi);
>  	if (ret)
>  		goto unroll_vsi_alloc;
>  


