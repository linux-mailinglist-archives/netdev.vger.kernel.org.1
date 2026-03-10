Return-Path: <netdev+bounces-266264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ++GSNTsGmBiAIAu9opvQ
	(envelope-from <netdev+bounces-266264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:21:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD32255748
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 662AF300DCE5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF983D1702;
	Tue, 10 Mar 2026 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD4SY/I+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335FC3D16F3;
	Tue, 10 Mar 2026 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163296; cv=none; b=WhL6Qf0OS3yxb0c7SjV/HkQoyGLBPyNBgECeETzKam/tl6VgIIfIdrLG5E3SkbtgaWmNEyBeJaXI0ff3ee23k+YObnqevQDu+HQcOMXikbSBjBnSnA5+gj/+QQU8tzFA67nm/+4+4O2fnC15fofNYNHMQk3DR0prI/ry4tC4ntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163296; c=relaxed/simple;
	bh=24mHAtJi53l2fD5YRsztQMaW9zAAR5od9y43t2HCgIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbB+sk8g2wfDbPiHvQsi3r9RUmjvK2D12bTZxsiSrhYfogUzaiLQ9TV5AifLoNDjCgrSettTOeb8LppZLd2velzRJ1uarDov1+BlfdUVY0JQlN9msQeTBKjAG21CNDJlIDcJ1oWy+zaZ9CtTAsl1gymjG1wppd+ximVPoPGB9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD4SY/I+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B3DC19423;
	Tue, 10 Mar 2026 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163295;
	bh=24mHAtJi53l2fD5YRsztQMaW9zAAR5od9y43t2HCgIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gD4SY/I+pbjCfmNifCbEFQVebBUEB9JhN+A/EqIiUWojpoiHPko7jdd9adpXsaIfe
	 QtrO/GZE/++CJL6Od03owxJIjfNDKtUARay86mlDKiAC2pdE/1nAugDVAYUBiRgatr
	 CLSymGhbz0550t3+vpSICFm+XiH7vrzy2pxvlRuJC7k0NV9NYsC0x0IO50sYSGxZRD
	 rUEVli+OjlFwinlnJM/lsUh6vGrucr2Y4t5Gd0gglSb5+yZ/n3NVDyzTmxNXG93GCf
	 fhdsJMHsb3wujnAnk5Mjys44MTc/Bpaqwm89F8CbDAlt36u1gzxPWhMD3lBDW+xVVZ
	 23jsbJKund8+A==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	cjubran@nvidia.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	shshitrit@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sgoutham@marvell.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	saeedm@nvidia.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com
Subject: Re: [v3,net-next,5/5] octeontx2-af: Add support for loading custom KPU profile from filesystem
Date: Tue, 10 Mar 2026 17:21:00 +0000
Message-ID: <20260310172100.890161-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309024619.898211-6-rkannoth@marvell.com>
References: <20260309024619.898211-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BDD32255748
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,oracle.com,vger.kernel.org,marvell.com,resnulli.us,davemloft.net,google.com,redhat.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-266264-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: Add support for loading custom KPU profile from filesystem

This commit adds functionality to load custom KPU (Key Parse Unit)
profiles from the filesystem at module load time, providing an
alternative to flashing updated firmware on deployed devices.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> index cefc5d70f3e4..5928c4d3cc8b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h

[ ... ]

> @@ -290,6 +303,7 @@ struct npc_kpu_profile {
>  	int action_entries;
>  	struct npc_kpu_profile_cam *cam;
>  	struct npc_kpu_profile_action *action;
> +	struct npc_kpu_profile_cam2 *cam2;
>  };

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index a466181cf908..1efc53b63b67 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h

[ ... ]

> @@ -553,8 +553,8 @@ struct npc_kpu_profile_adapter {
>  	const char			*name;
>  	u64				version;
>  	const struct npc_lt_def_cfg	*lt_def;
> -	const struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
> -	const struct npc_kpu_profile	*kpu; /* array[kpus] */
> +	struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
> +	struct npc_kpu_profile	*kpu; /* array[kpus] */

[ ... ]

> @@ -564,6 +564,7 @@ struct npc_kpu_profile_adapter {
>  	bool				custom;
>  	size_t				pkinds;
>  	size_t				kpus;
> +	bool				from_fs;
>  };

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 352dc5f1d5b9..05aabe26f030 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c

[ ... ]

> @@ -1610,6 +1622,7 @@ u64 npc_enable_mask(int count)
>  static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
>  				    const struct npc_kpu_profile *profile)
>  {
> +	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
>  	int entry, num_entries, max_entries;
>  	u64 entry_mask;
>
> @@ -1621,10 +1634,15 @@ static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
>
>  	max_entries = rvu->hw->npc_kpu_entries;
>
> +	WARN(profile->cam_entries > max_entries,
> +	     "KPU%u: err: hw max entries=%u, input entries=%u\n",
> +	     kpu,  rvu->hw->npc_kpu_entries, profile->cam_entries);
> +
>  	/* Program CAM match entries for previous KPU extracted data */
>  	num_entries = min_t(int, profile->cam_entries, max_entries);
>  	for (entry = 0; entry < num_entries; entry++)
>  		npc_config_kpucam(rvu, blkaddr,
> +				  adapter->from_fs ? (void *)&profile->cam2[entry] :
>  				  &profile->cam[entry], kpu, entry);

Can this dereference NULL when from_fs is true for KPUs not covered by
the filesystem firmware?

Looking at the filesystem loading path in npc_apply_custom_kpu:

    for (kpu = 0; kpu < fw->kpus; kpu++) {
        ...
        ret = npc_alloc_kpu_cam2_n_action(rvu, kpu, entries);
        ...
        for (entry = 0; entry < entries; entry++) {
            profile->kpu[kpu].cam2[entry] = cam2[entry];
            ...
        }
    }

The code allocates cam2 and populates entries only for the first
fw->kpus KPUs found in the firmware blob.

However, npc_program_kpu_profile is later called for all KPUs in
npc_parser_profile_init:

    for (idx = 0; idx < num_kpus; idx++)
        npc_program_kpu_profile(rvu, blkaddr, idx, &rvu->kpu.kpu[idx]);

Since adapter->from_fs is a global flag (not per-KPU), when idx >=
fw->kpus, profile->cam2 remains NULL (the default npc_kpu_profiles[]
static initializer doesn't include cam2), causing &profile->cam2[entry]
to compute an invalid pointer.

Shouldn't there be a check to verify cam2 is non-NULL before
dereferencing it, or allocate cam2 for all KPUs when from_fs is true?

>
>  	/* Program this KPU's actions */

[ ... ]

> @@ -1678,26 +1696,50 @@ static void npc_prepare_default_kpu(struct rvu *rvu,
>  	npc_cn20k_update_action_entries_n_flags(rvu, profile);
>  }
>
> +static int npc_alloc_kpu_cam2_n_action(struct rvu *rvu, int kpu_num,
> +				       int num_entries)
> +{
> +	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
> +	struct npc_kpu_profile *kpu;
> +
> +	kpu = &adapter->kpu[kpu_num];
> +
> +	kpu->cam2 = devm_kcalloc(rvu->dev, num_entries,
> +				 sizeof(*kpu->cam2), GFP_KERNEL);
> +	if (!kpu->cam2)
> +		return -ENOMEM;
> +
> +	kpu->action = devm_kcalloc(rvu->dev, num_entries,
> +				   sizeof(*kpu->action), GFP_KERNEL);
> +	if (!kpu->action)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

Can this permanently corrupt the default profile when the second
allocation fails?

The kpu pointer targets the static npc_kpu_profiles[] array (adapter->kpu
starts as &npc_kpu_profiles[0]). When the first devm_kcalloc succeeds but
the second fails:

    kpu->cam2 = devm_kcalloc(...)  // succeeds, modifies static array
    kpu->action = devm_kcalloc(...) // fails
    return -ENOMEM;                 // kpu->action is now NULL in static array

The caller in npc_apply_custom_kpu returns the error without restoring
the original action pointer.

Later, npc_parser_profile_init calls npc_program_kpu_profile for all
KPUs, which calls npc_config_kpuaction with &profile->action[entry]
where action is NULL, causing a crash when dereferencing the NULL pointer.

Should the function restore the original pointers on allocation failure,
or use a separate copy of the profile entries for filesystem loading?

> +
>  static int npc_apply_custom_kpu(struct rvu *rvu,
> -				struct npc_kpu_profile_adapter *profile)
> +				struct npc_kpu_profile_adapter *profile,
> +				bool from_fs)
>  {
>  	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
>  	struct npc_kpu_profile_action *action;
> +	struct npc_kpu_profile_fwdata *sfw;
>  	struct npc_kpu_profile_fwdata *fw;
> +	struct npc_kpu_profile_cam2 *cam2;
>  	struct npc_kpu_profile_cam *cam;
>  	struct npc_kpu_fwdata *fw_kpu;
> -	int entries;
> +	int entries, ret;
>  	u16 kpu, entry;

[ ... ]

> @@ -1731,31 +1773,80 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
>  		return -EINVAL;
>  	}
>
> +	sfw = devm_kcalloc(rvu->dev, 1, sizeof(*sfw), GFP_KERNEL);
> +	if (!sfw)
> +		return -ENOMEM;
> +
> +	memcpy(sfw, fw, sizeof(*sfw));
> +
>  	profile->custom = 1;
> -	profile->name = fw->name;
> +	profile->name = sfw->name;
>  	profile->version = le64_to_cpu(fw->version);
> -	profile->mcam_kex_prfl.mkex = &fw->mkex;
> -	profile->lt_def = &fw->lt_def;
> +	profile->mcam_kex_prfl.mkex = &sfw->mkex;
> +	profile->lt_def = &sfw->lt_def;
> +
> +	/* Binary blob contains ikpu actions entries at start of data[0] */
> +	if (from_fs) {
> +		action = (struct npc_kpu_profile_action *)(fw->data + offset);
> +
> +		if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
> +			return -ENOMEM;
> +
> +		memcpy((void *)profile->ikpu, action, sizeof(ikpu_action_entries));
> +		offset += sizeof(ikpu_action_entries);
> +	}
>
>  	for (kpu = 0; kpu < fw->kpus; kpu++) {
>  		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
> -		if (fw_kpu->entries > KPU_MAX_CST_ENT)
> -			dev_warn(rvu->dev,
> -				 "Too many custom entries on KPU%d: %d > %d\n",
> -				 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
> -		entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
> -		cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
> -		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
> +		if (!from_fs) {
> +			if (fw_kpu->entries > KPU_MAX_CST_ENT)
> +				dev_warn(rvu->dev,
> +					 "Too many custom entries on KPU%d: %d > %d\n",
> +					 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
> +			entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
> +			cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
> +			offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
> +			action = (struct npc_kpu_profile_action *)(fw->data + offset);
> +			offset += fw_kpu->entries * sizeof(*action);
> +			if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
> +				dev_warn(rvu->dev,
> +					 "Profile size mismatch on KPU%i parsing.\n",
> +					 kpu + 1);
> +				return -EINVAL;
> +			}
> +			for (entry = 0; entry < entries; entry++) {
> +				profile->kpu[kpu].cam[entry] = cam[entry];
> +				profile->kpu[kpu].action[entry] = action[entry];
> +			}
> +			continue;
> +		}
> +		entries = fw_kpu->entries;
> +		dev_info(rvu->dev,
> +			 "Loading %u entries on KPU%d\n", entries, kpu);
> +
> +		cam2 = (struct npc_kpu_profile_cam2 *)fw_kpu->data;
> +		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam2);
>  		action = (struct npc_kpu_profile_action *)(fw->data + offset);
>  		offset += fw_kpu->entries * sizeof(*action);
>  		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
>  			dev_warn(rvu->dev,
> -				 "Profile size mismatch on KPU%i parsing.\n",
> +				 "profile size mismatch on kpu%i parsing.\n",
>  				 kpu + 1);
>  			return -EINVAL;
>  		}
> +
> +		profile->kpu[kpu].cam_entries = entries;
> +		profile->kpu[kpu].action_entries = entries;
> +		ret = npc_alloc_kpu_cam2_n_action(rvu, kpu, entries);
> +		if (ret) {
> +			dev_warn(rvu->dev,
> +				 "profile entry allocation failed for kpu=%d for %d entries\n",
> +				 kpu, entries);
> +			return -EINVAL;
> +		}
> +
>  		for (entry = 0; entry < entries; entry++) {
> -			profile->kpu[kpu].cam[entry] = cam[entry];
> +			profile->kpu[kpu].cam2[entry] = cam2[entry];
>  			profile->kpu[kpu].action[entry] = action[entry];
>  		}

Could this loop overflow and hang the kernel if firmware specifies more
than 65535 entries?

The loop variable 'entry' is declared as u16:

    u16 kpu, entry;

while 'entries' is an int:

    entries = fw_kpu->entries;

In the from_fs path, 'entries' is read directly from the firmware blob
without capping it (unlike the !from_fs path which uses
min(fw_kpu->entries, KPU_MAX_CST_ENT)).

If a corrupt or malicious firmware file specifies fw_kpu->entries >
65535, the u16 variable wraps around at 65536:

    for (entry = 0; entry < entries; entry++)

When entry reaches 65535, incrementing it produces 0, which is still
less than entries, creating an infinite loop that hangs the kernel.

Should the code either cap entries in the from_fs path or use an
int-sized loop variable?

>  	}

[ ... ]

