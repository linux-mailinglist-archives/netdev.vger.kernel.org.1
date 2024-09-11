Return-Path: <netdev+bounces-127462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E139757B1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB071C25950
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514818C344;
	Wed, 11 Sep 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pp3b2RfD"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37819CC19
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070175; cv=none; b=WX2qGTMwBvq4+8dM47RHdXc8lVLky89SAvxa8gzcnVyGin1rdnPMkQoE4iZwGvsgWkbwU6xEAf5BLq7b3K1D4YQEi/iKPoBCyglasw8cUPO9upLyTNo/kBNhZOQdRi+RDxHu+wILlSSrfJqJn3Z10mVwNEchetSnvrmcoE51yRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070175; c=relaxed/simple;
	bh=5MNG4HOkOTF6AKS6N4c5zwJ4wQrJIxGKiYo6sqenF3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpW1EWHLF5X8OUJat+QiXSfCqQ+gqbjs4c7MN7PDOEQv4mCAxpaecdO1j4Fel0lmbUm5m4mzkQd/e/ayKO/FJ681KFGhPTHn3tykcWjhweAxBS3Qf/jGzcEUUJDPkyRjTcMEQtAvK4hfleNv1B/ns+p0CH4F56EghE8kLr/z2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pp3b2RfD; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ceb00673-8151-49b0-b36b-75b5dc402041@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726070168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8NaUEcC/jxxHDpfZXwZPhCuZ+KZJ7rMZcv9TtycY/A=;
	b=pp3b2RfDorR3bidkDidzDEAsRCIsQ8XomPytKNyTz1OX51OQ38KYet0NW7ZYJk/L3oLSV4
	wwVbtho6SIUpIIx2MkEYIvaLfqHEstRyLspm/kVEOMdRiGRZIS1dvDpnK63s8i9g6BLjLv
	Wt9q/n1hhgyyLuksA9ylb2cUeR/pDR8=
Date: Wed, 11 Sep 2024 16:56:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] octeontx2-af: Knobs for NPC default rule
 counters
To: Linu Cherian <lcherian@marvell.com>, davem@davemloft.net,
 sgoutham@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20240911143303.160124-1-lcherian@marvell.com>
 <20240911143303.160124-2-lcherian@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240911143303.160124-2-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/09/2024 15:33, Linu Cherian wrote:
> Add devlink knobs to enable/disable counters on NPC
> default rule entries.
> 
> Introduce lowlevel variant of rvu_mcam_remove/add_counter_from/to_rule
> for better code reuse, which assumes necessary locks are taken at
> higher level.
> 
> Sample command to enable default rule counters:
> devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime
> 
> Sample command to read the counter:
> cat /sys/kernel/debug/cn10k/npc/mcam_rules
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
>   .../net/ethernet/marvell/octeontx2/af/rvu.h   |   8 +-
>   .../marvell/octeontx2/af/rvu_devlink.c        |  32 +++++
>   .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 132 ++++++++++++++++--
>   .../marvell/octeontx2/af/rvu_npc_fs.c         |  36 ++---
>   4 files changed, 171 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 43b1d83686d1..fb4b88e94649 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -526,6 +526,7 @@ struct rvu {
>   	struct mutex		alias_lock; /* Serialize bar2 alias access */
>   	int			vfs; /* Number of VFs attached to RVU */
>   	u16			vf_devid; /* VF devices id */
> +	bool			def_rule_cntr_en;
>   	int			nix_blkaddr[MAX_NIX_BLKS];
>   
>   	/* Mbox */
> @@ -961,7 +962,11 @@ void rvu_npc_disable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf);
>   void rvu_npc_enable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf);
>   void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
>   				    int group, int alg_idx, int mcam_index);
> -
> +void __rvu_mcam_remove_counter_from_rule(struct rvu *rvu, u16 pcifunc,
> +					 struct rvu_npc_mcam_rule *rule);
> +void __rvu_mcam_add_counter_to_rule(struct rvu *rvu, u16 pcifunc,
> +				    struct rvu_npc_mcam_rule *rule,
> +				    struct npc_install_flow_rsp *rsp);
>   void rvu_npc_get_mcam_entry_alloc_info(struct rvu *rvu, u16 pcifunc,
>   				       int blkaddr, int *alloc_cnt,
>   				       int *enable_cnt);
> @@ -986,6 +991,7 @@ void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
>   void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
>   			 int blkaddr, u16 src, struct mcam_entry *entry,
>   			 u8 *intf, u8 *ena);
> +int npc_config_cntr_default_entries(struct rvu *rvu, bool enable);
>   bool is_cgx_config_permitted(struct rvu *rvu, u16 pcifunc);
>   bool is_mac_feature_supported(struct rvu *rvu, int pf, int feature);
>   u32  rvu_cgx_get_fifolen(struct rvu *rvu);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> index 7498ab429963..9c26e19a860b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> @@ -1238,6 +1238,7 @@ enum rvu_af_dl_param_id {
>   	RVU_AF_DEVLINK_PARAM_ID_DWRR_MTU,
>   	RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
>   	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
> +	RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
>   	RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
>   };
>   
> @@ -1358,6 +1359,32 @@ static int rvu_af_dl_npc_mcam_high_zone_percent_validate(struct devlink *devlink
>   	return 0;
>   }
>   
> +static int rvu_af_dl_npc_def_rule_cntr_get(struct devlink *devlink, u32 id,
> +					   struct devlink_param_gset_ctx *ctx)
> +{
> +	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
> +	struct rvu *rvu = rvu_dl->rvu;
> +
> +	ctx->val.vbool = rvu->def_rule_cntr_en;
> +
> +	return 0;
> +}
> +
> +static int rvu_af_dl_npc_def_rule_cntr_set(struct devlink *devlink, u32 id,
> +					   struct devlink_param_gset_ctx *ctx,
> +					   struct netlink_ext_ack *extack)
> +{
> +	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
> +	struct rvu *rvu = rvu_dl->rvu;
> +	int err;
> +
> +	err = npc_config_cntr_default_entries(rvu, ctx->val.vbool);
> +	if (!err)
> +		rvu->def_rule_cntr_en = ctx->val.vbool;
> +
> +	return err;
> +}
> +
>   static int rvu_af_dl_nix_maxlf_get(struct devlink *devlink, u32 id,
>   				   struct devlink_param_gset_ctx *ctx)
>   {
> @@ -1444,6 +1471,11 @@ static const struct devlink_param rvu_af_dl_params[] = {
>   			     rvu_af_dl_npc_mcam_high_zone_percent_get,
>   			     rvu_af_dl_npc_mcam_high_zone_percent_set,
>   			     rvu_af_dl_npc_mcam_high_zone_percent_validate),
> +	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
> +			     "npc_def_rule_cntr", DEVLINK_PARAM_TYPE_BOOL,
> +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> +			     rvu_af_dl_npc_def_rule_cntr_get,
> +			     rvu_af_dl_npc_def_rule_cntr_set, NULL),
>   	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
>   			     "nix_maxlf", DEVLINK_PARAM_TYPE_U16,
>   			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 97722ce8c4cb..a766870520b3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -2691,6 +2691,51 @@ void npc_mcam_rsrcs_reserve(struct rvu *rvu, int blkaddr, int entry_idx)
>   	npc_mcam_set_bit(mcam, entry_idx);
>   }
>   
> +int npc_config_cntr_default_entries(struct rvu *rvu, bool enable)
> +{
> +	struct npc_install_flow_rsp rsp = { 0 };
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	struct rvu_npc_mcam_rule *rule;
> +	int blkaddr;
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +	if (blkaddr < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&mcam->lock);
> +	list_for_each_entry(rule, &mcam->mcam_rules, list) {
> +		if (!is_mcam_entry_enabled(rvu, mcam, blkaddr, rule->entry))
> +			continue;
> +		if (!rule->default_rule)
> +			continue;
> +		if (enable && !rule->has_cntr) { /* Alloc and map new counter */
> +			__rvu_mcam_add_counter_to_rule(rvu, rule->owner,
> +						       rule, &rsp);
> +			if (rsp.counter < 0) {
> +				dev_err(rvu->dev, "%s: Err to allocate cntr for default rule (err=%d)\n",
> +					__func__, rsp.counter);
> +				break;
> +			}
> +			npc_map_mcam_entry_and_cntr(rvu, mcam, blkaddr,
> +						    rule->entry, rsp.counter);
> +		}
> +
> +		if (enable && rule->has_cntr) /* Reset counter before use */ {
> +			rvu_write64(rvu, blkaddr,
> +				    NPC_AF_MATCH_STATX(rule->cntr), 0x0);
> +			continue;
> +		}
> +
> +		if (!enable && rule->has_cntr) /* Free and unmap counter */ {
> +			__rvu_mcam_remove_counter_from_rule(rvu, rule->owner,
> +							    rule);
> +		}
> +	}
> +	mutex_unlock(&mcam->lock);
> +
> +	return 0;
> +}
> +
>   int rvu_mbox_handler_npc_mcam_alloc_entry(struct rvu *rvu,
>   					  struct npc_mcam_alloc_entry_req *req,
>   					  struct npc_mcam_alloc_entry_rsp *rsp)
> @@ -2975,9 +3020,9 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
>   	return rc;
>   }
>   
> -int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
> -			struct npc_mcam_alloc_counter_req *req,
> -			struct npc_mcam_alloc_counter_rsp *rsp)
> +static int __npc_mcam_alloc_counter(struct rvu *rvu,
> +				    struct npc_mcam_alloc_counter_req *req,
> +				    struct npc_mcam_alloc_counter_rsp *rsp)
>   {
>   	struct npc_mcam *mcam = &rvu->hw->mcam;
>   	u16 pcifunc = req->hdr.pcifunc;
> @@ -2998,7 +3043,6 @@ int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
>   	if (!req->contig && req->count > NPC_MAX_NONCONTIG_COUNTERS)
>   		return NPC_MCAM_INVALID_REQ;
>   
> -	mutex_lock(&mcam->lock);
>   
>   	/* Check if unused counters are available or not */
>   	if (!rvu_rsrc_free_count(&mcam->counters)) {
> @@ -3035,12 +3079,27 @@ int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
>   		}
>   	}
>   
> -	mutex_unlock(&mcam->lock);

There is mutex_unlock() left in this function in error path of
rvu_rsrc_free_count(&mcam->counters)

>   	return 0;
>   }
>   
> -int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
> -		struct npc_mcam_oper_counter_req *req, struct msg_rsp *rsp)
> +int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
> +			struct npc_mcam_alloc_counter_req *req,
> +			struct npc_mcam_alloc_counter_rsp *rsp)
> +{
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	int err;
> +
> +	mutex_lock(&mcam->lock);
> +
> +	err = __npc_mcam_alloc_counter(rvu, req, rsp);
> +
> +	mutex_unlock(&mcam->lock);
> +	return err;
> +}
> +
> +static int __npc_mcam_free_counter(struct rvu *rvu,
> +				   struct npc_mcam_oper_counter_req *req,
> +				   struct msg_rsp *rsp)
>   {
>   	struct npc_mcam *mcam = &rvu->hw->mcam;
>   	u16 index, entry = 0;
> @@ -3050,7 +3109,6 @@ int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
>   	if (blkaddr < 0)
>   		return NPC_MCAM_INVALID_REQ;
>   
> -	mutex_lock(&mcam->lock);
>   	err = npc_mcam_verify_counter(mcam, req->hdr.pcifunc, req->cntr);
>   	if (err) {
>   		mutex_unlock(&mcam->lock);

And here it's even visible in the chunk..

> @@ -3077,10 +3135,66 @@ int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
>   					      index, req->cntr);
>   	}
>   
> -	mutex_unlock(&mcam->lock);
>   	return 0;
>   }
>   


