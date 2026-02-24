Return-Path: <netdev+bounces-260442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cICiK893nWmAQAQAu9opvQ
	(envelope-from <netdev+bounces-260442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:05:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE0C185189
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5699301B176
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D64F372B32;
	Tue, 24 Feb 2026 10:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A612CDBE
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927498; cv=none; b=jn8XvP7UKNYETfYj+Isk3VTsrz+NHgtjRX+IUDu5p3WdI+ArDE5WF2WP1WwFjEt/DF4jo3dv1nrnLCMXshBTEYfLNhW6ps33GLcc8FjtoX1N1aAmpqVKkxr91oNr4uwrIW1ZHjl0VXqPBTsrYzjdVwOELSjyi/JSIY5YJUSJ/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927498; c=relaxed/simple;
	bh=iJpKuJc9xTGXzyB41ccXHT7ZgGyJqs0jmabkEG7WvSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVZHfwrM6hIIGcRx9nqU/kDZNPmqwtBXfSOYsamFbRoUKoTV89x8M2e4mlp4CQwIkrRrUyGkW0NpljtNMusGS5b9pEAt5BJ720N/OwuZwkWA70Db5aFEErK1mbYQquCk/PbZREBlTSAqU2xCX/r2Bh/ACSpELAetTOk+gl/lAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A685C4C28871A7;
	Tue, 24 Feb 2026 11:03:47 +0100 (CET)
Message-ID: <15d16cb1-4b7e-48ff-97d2-7d1064ebfa42@molgen.mpg.de>
Date: Tue, 24 Feb 2026 11:03:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: set max queues in
 alloc_etherdev_mqs()
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20260223125157.819135-1-michal.swiatkowski@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260223125157.819135-1-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260442-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,molgen.mpg.de:mid,mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CE0C185189
X-Rspamd-Action: no action

Dear Michal,


Thank you for the patch.

Am 23.02.26 um 13:51 schrieb Michal Swiatkowski:
> When allocating netdevice using alloc_etherdev_mqs() the maximum
> supported queues number should be passed. The vsi->alloc_txq/rxq is
> storing current number of queues, not the maximum ones.
> 
> Use the same function for getting max Tx and Rx queues which is used
> during ethtool -l call to set maximum number of queues during netdev
> allocation.
> 
> Reproduction steps:
> $ethtool -l $pf # says current 16, max 64
> $ethtool -S $pf # fine
> $ethtool -L $pf combined 40 # crash
> 
> [491187.472594] Call Trace:
> [491187.472829]  <TASK>
> [491187.473067]  netif_set_xps_queue+0x26/0x40
> [491187.473305]  ice_vsi_cfg_txq+0x265/0x3d0 [ice]
> [491187.473619]  ice_vsi_cfg_lan_txqs+0x68/0xa0 [ice]
> [491187.473918]  ice_vsi_cfg_lan+0x2b/0xa0 [ice]
> [491187.474202]  ice_vsi_open+0x71/0x170 [ice]
> [491187.474484]  ice_vsi_recfg_qs+0x17f/0x230 [ice]
> [491187.474759]  ? dev_get_min_mp_channel_count+0xab/0xd0
> [491187.474987]  ice_set_channels+0x185/0x3d0 [ice]
> [491187.475278]  ethnl_set_channels+0x26f/0x340
> 
> Fixes: ee13aa1a2c5a ("ice: use netif_get_num_default_rss_queues()")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice.h         | 22 ++++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 18 ----------------
>   drivers/net/ethernet/intel/ice/ice_main.c    |  4 ++--
>   3 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index f6a56a864459..725b130dd3a2 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -839,6 +839,28 @@ static inline void ice_tx_xsk_pool(struct ice_vsi *vsi, u16 qid)
>   	WRITE_ONCE(ring->xsk_pool, ice_get_xp_from_qid(vsi, qid));
>   }
>   
> +/**
> + * ice_get_max_txq - return the maximum number of Tx queues for in a PF
> + * @pf: PF structure
> + *
> + * Return: maximum number of Tx queues
> + */
> +static inline int ice_get_max_txq(struct ice_pf *pf)
> +{
> +	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_txq);
> +}
> +
> +/**
> + * ice_get_max_rxq - return the maximum number of Rx queues for in a PF
> + * @pf: PF structure
> + *
> + * Return: maximum number of Rx queues
> + */
> +static inline int ice_get_max_rxq(struct ice_pf *pf)
> +{
> +	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_rxq);
> +}
> +
>   /**
>    * ice_get_main_vsi - Get the PF VSI
>    * @pf: PF instance
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index a897a6b22495..a0b0416f5aea 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3780,24 +3780,6 @@ ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
>   	return 0;
>   }
>   
> -/**
> - * ice_get_max_txq - return the maximum number of Tx queues for in a PF
> - * @pf: PF structure
> - */
> -static int ice_get_max_txq(struct ice_pf *pf)
> -{
> -	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_txq);
> -}
> -
> -/**
> - * ice_get_max_rxq - return the maximum number of Rx queues for in a PF
> - * @pf: PF structure
> - */
> -static int ice_get_max_rxq(struct ice_pf *pf)
> -{
> -	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_rxq);
> -}
> -
>   /**
>    * ice_get_combined_cnt - return the current number of combined channels
>    * @vsi: PF VSI pointer
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index fa4095037be5..863ac81eebce 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4699,8 +4699,8 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
>   	struct net_device *netdev;
>   	u8 mac_addr[ETH_ALEN];
>   
> -	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
> -				    vsi->alloc_rxq);
> +	netdev = alloc_etherdev_mqs(sizeof(*np), ice_get_max_txq(vsi->back),
> +				    ice_get_max_rxq(vsi->back));
>   	if (!netdev)
>   		return -ENOMEM;
>   

Should also some checks be added to `ethnl_set_channels()` to avoid crashes?

The commit looks good:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

I am missing the mentioning of the crash in commit message 
title/summary, but I do not have a better suggestion right now.


Kind regards,

Paul

