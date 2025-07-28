Return-Path: <netdev+bounces-210616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86896B140BE
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEEC188C3F8
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9984E22ACEF;
	Mon, 28 Jul 2025 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLZVchRs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE062273D92
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721468; cv=none; b=I2Byl7AUzwnSDYoxQNr4LCgStCG00r0s8Qv+pmzkAt/F7ctw36RXbz7FCzlnN/SDe9BwMB+eyZqL0n0s+2yc+ZsuuGE5F/QxGCjAL9H0+sDf7w+W7TO12jbzHAgPH7AA8bFEbrF7KRPqbc2Qkxcsh6zdMFQ5ImErvWqe/8qZNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721468; c=relaxed/simple;
	bh=/nGUWz/QI4oI9JaeM4nznpA3cGA5rFBBCsAtiIFIIQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKSGsKb8UJiuztxCV5SW1ta3+vU1+K3gRn9f83FbzfAfxDANN16m0ZEjUoGu2tcM7egqgCpN7/vCh51biScZP+dkkabjQCt4BwATpsYDU6cP9HR5abB+5g16X0DTfGTtMIHW+c9kyetBf5xd9KCv+w47nTaToMaHTwmtCRNzPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLZVchRs; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753721464; x=1785257464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/nGUWz/QI4oI9JaeM4nznpA3cGA5rFBBCsAtiIFIIQs=;
  b=gLZVchRsZrAqlgEV1eWj6qHKjbqo6RQ/Ix1Z75WyCgCEsP+cE8zom19V
   DWZYJPkgz5NTFcVONdYdLNHpoCHlkvIfOh9d6VFCUCE/IvR9H9AK6Uhap
   YsVO/L2MLocdrJ82seqtuULz3/RGbbx3+p8mnrEXkdzKYtl6MFHCsMlRd
   E4RTd2tR1KQJqdvsXjkJeir5dmaRpnfhTFErC5YN5/6LhTcdNvKbWuezR
   XRU/rjV01+BkuHP1ti+pqiPxbI6w+pL2jW4mnNtBB5ToMzbT5ydMfNpG2
   DkhXeemK6q19nL+bQ7Bl5DH3f6YKDRjCpagrE1bqnnHvqqYYRvSOrZDm5
   Q==;
X-CSE-ConnectionGUID: Qate3rdBRu2clux/wNLyYw==
X-CSE-MsgGUID: SV8XlBU9RtaBLZGU+pDLdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55677204"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55677204"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 09:51:04 -0700
X-CSE-ConnectionGUID: ry8R4pN3S9ul7V1FyWdaJg==
X-CSE-MsgGUID: agjBKv3LTLaQRocnjggyEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="193308480"
Received: from hlagrand-mobl1.ger.corp.intel.com (HELO [10.245.102.40]) ([10.245.102.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 09:51:01 -0700
Message-ID: <08e39788-8d1b-494d-87e3-e5b427875674@linux.intel.com>
Date: Mon, 28 Jul 2025 18:50:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: airoha: Fix PPE table access in
 airoha_ppe_debugfs_foe_show()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20250728-airoha_ppe_foe_get_entry_locked-v1-1-8630ec73f3d1@kernel.org>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250728-airoha_ppe_foe_get_entry_locked-v1-1-8630ec73f3d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-28 1:58 PM, Lorenzo Bianconi wrote:
> In order to avoid any possible race we need to hold the ppe_lock
> spinlock accessing the hw PPE table. airoha_ppe_foe_get_entry routine is
> always executed holding ppe_lock except in airoha_ppe_debugfs_foe_show
> routine. Fix the problem introducing airoha_ppe_foe_get_entry_locked
> routine.
> 
> Fixes: 3fe15c640f380 ("net: airoha: Introduce PPE debugfs support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid

> ---
>   drivers/net/ethernet/airoha/airoha_eth.h         |  4 ++--
>   drivers/net/ethernet/airoha/airoha_ppe.c         | 18 ++++++++++++++++--
>   drivers/net/ethernet/airoha/airoha_ppe_debugfs.c |  2 +-
>   3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index a970b789cf232c316e5ea27b0146493bf91c3767..cf33d731ad0db43bca8463fde76673b39a4f6796 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -615,8 +615,8 @@ int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data);
>   int airoha_ppe_init(struct airoha_eth *eth);
>   void airoha_ppe_deinit(struct airoha_eth *eth);
>   void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port);
> -struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
> -						  u32 hash);
> +struct airoha_foe_entry *
> +airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash);
>   void airoha_ppe_foe_entry_get_stats(struct airoha_ppe *ppe, u32 hash,
>   				    struct airoha_foe_stats64 *stats);
>   
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> index 0e217acfc5ef748453b020e5713ace1910abc4a8..4dbf2bf187d02e3e8b9d2b966036c3aa58c867b1 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -498,9 +498,11 @@ static void airoha_ppe_foe_flow_stats_update(struct airoha_ppe *ppe,
>   		FIELD_PREP(AIROHA_FOE_IB2_NBQ, nbq);
>   }
>   
> -struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
> -						  u32 hash)
> +static struct airoha_foe_entry *
> +airoha_ppe_foe_get_entry(struct airoha_ppe *ppe, u32 hash)
>   {
> +	lockdep_assert_held(&ppe_lock);
> +
>   	if (hash < PPE_SRAM_NUM_ENTRIES) {
>   		u32 *hwe = ppe->foe + hash * sizeof(struct airoha_foe_entry);
>   		struct airoha_eth *eth = ppe->eth;
> @@ -527,6 +529,18 @@ struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
>   	return ppe->foe + hash * sizeof(struct airoha_foe_entry);
>   }
>   
> +struct airoha_foe_entry *
> +airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash)
> +{
> +	struct airoha_foe_entry *hwe;
> +
> +	spin_lock_bh(&ppe_lock);
> +	hwe = airoha_ppe_foe_get_entry(ppe, hash);
> +	spin_unlock_bh(&ppe_lock);
> +
> +	return hwe;
> +}
> +
>   static bool airoha_ppe_foe_compare_entry(struct airoha_flow_table_entry *e,
>   					 struct airoha_foe_entry *hwe)
>   {
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
> index 05a756233f6a44fa51d1c57dd39d89c8ea488054..992bf2e9598414ee3f1f126be3f451e486b26640 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
> @@ -67,7 +67,7 @@ static int airoha_ppe_debugfs_foe_show(struct seq_file *m, void *private,
>   		u32 type, state, ib2, data;
>   		bool ipv6 = false;
>   
> -		hwe = airoha_ppe_foe_get_entry(ppe, i);
> +		hwe = airoha_ppe_foe_get_entry_locked(ppe, i);
>   		if (!hwe)
>   			continue;
>   
> 
> ---
> base-commit: afd8c2c9e2e29c6c7705635bea2960593976dacc
> change-id: 20250728-airoha_ppe_foe_get_entry_locked-70e4ebbee984
> 
> Best regards,


