Return-Path: <netdev+bounces-269987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK15GyZ+vWnH+QIAu9opvQ
	(envelope-from <netdev+bounces-269987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:04:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D90772DE36F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B84932C910B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5D3D3002;
	Fri, 20 Mar 2026 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjcfqnsZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790323C3443;
	Fri, 20 Mar 2026 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025682; cv=none; b=KAnvfNHRQX0SNibTLgDIWmTx2S1nuAx55D6oz+YgXzVnLU2JU971SCg2cV0qHySvqoxEce5ngpD53keTXZp2AHgUdlL7reLV1/8A7fCk5zUBuMjSSaLWLZoS6jLyf/VizbyWiQczCZp3Pgl+0+Bu2mA/xmrPFai43veXIztUZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025682; c=relaxed/simple;
	bh=F5/92/huukTzZOEXR2/8CsvfoysKjVXex3ibWwxK7RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3GQ+AB3vaJmDoOSNpZD50jrqqK7jhZIiHoVSq2jqXjl0fxXcCWi/mPi1OqA5pVlND2SzCLoIjI1FRGoqmLaIH5LrY6VmNhpgXpOrEzAzECJDzXES6RyK7H2ayrWcxgXC6QhRTeYVXjpBA3GpazhSTMz4WKcbvYeQ/BtF7BYbjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjcfqnsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2755CC4CEF7;
	Fri, 20 Mar 2026 16:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774025682;
	bh=F5/92/huukTzZOEXR2/8CsvfoysKjVXex3ibWwxK7RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SjcfqnsZRRpt/lzjXwoulSAXN7RiVAQT/AR0pO6/jp1zVl80KnsGvQGYVhv53UL5b
	 vN6Qbr2yI4PA0LO6gvfVEgmgthEcybwsBNsUNjO4woFUgq2b5Llwm91+kegDwDhjXc
	 ZsHTi3bXKbIhSHPQUwhx59ULkEAUod64AGeNOutjwEWr/iKgT27Hp+4IG6u931X5ee
	 szLlghJ5VT2gKz9j++JVuoMqG/bK5GRv/I7k01pCG7VZqaMPiM1Mk0d/mBYGyy8SBI
	 Ubqgxpk0Z2/4MPizPG45cArGcr4ffqa2rjDIt/QTDsXlhg/BkgBlmVucmuuQX8MahM
	 w3PSfpr+P2bww==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	shshitrit@nvidia.com,
	cjubran@nvidia.com,
	netdev@vger.kernel.org,
	matttbe@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	sgoutham@marvell.com,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	chuck.lever@oracle.com,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v6 net-next 5/5] octeontx2-af: npc: Support for custom KPU profile from filesystem
Date: Fri, 20 Mar 2026 16:54:32 +0000
Message-ID: <20260320165432.98832-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319055533.1720093-6-rkannoth@marvell.com>
References: <20260319055533.1720093-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,google.com,redhat.com,marvell.com,davemloft.net,gmail.com,resnulli.us,oracle.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-269987-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.966];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D90772DE36F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: Support for custom KPU profile from filesystem

Flashing updated firmware on deployed devices is cumbersome. Provide a
mechanism to load a custom KPU (Key Parse Unit) profile directly from
the filesystem at module load time.

When the rvu_af module is loaded with the kpu_profile parameter, the
specified profile is read from /lib/firmware/kpu and programmed into
the KPU registers. Add npc_kpu_profile_cam2 for the extended cam format
used by filesystem-loaded profiles and support ptype/ptype_mask in
npc_config_kpucam when profile->from_fs is set.

Link: https://lore.kernel.org/netdev/20260310172100.890161-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/20260317033214.646969-2-kuba@kernel.org/

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 69439ff76e10..a3015b12a20b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> @@ -665,9 +675,15 @@ void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
>  	num_pkinds = rvu->kpu.pkinds;
>  	num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
>
> -	for (idx = 0; idx < num_pkinds; idx++)
> -		npc_config_kpmaction(rvu, blkaddr, &rvu->kpu.ikpu[idx],
> +	/* Cn20k does not support Custom profile from filesystem */
> +	for (idx = 0; idx < num_pkinds; idx++) {
> +		act = npc_get_ikpu_nth_entry(rvu, idx);
> +		if (!act)
> +			continue;
> +
> +		npc_config_kpmaction(rvu, blkaddr, act,
>  				     0, idx, true);
> +	}

When a filesystem-loaded profile is used on cn20k (from_fs=true),
npc_get_ikpu_nth_entry() returns &profile->ikpu2[idx]:

drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:npc_get_ikpu_nth_entry() {
    struct npc_kpu_profile_adapter *profile = &rvu->kpu;

    if (profile->from_fs)
        return &profile->ikpu2[idx];

    return &profile->ikpu[n];
}

However, ikpu2 is never allocated for the cn20k path. The allocation
happens inside npc_apply_custom_kpu() in the from_fs block:

drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:npc_apply_custom_kpu() {
    if (is_cn20k(rvu->pdev))
        return npc_cn20k_apply_custom_kpu(rvu, profile);
    ...
    if (from_fs) {
        profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
                                      sizeof(ikpu_action_entries),
                                      GFP_KERNEL);
        ...
    }
}

But this from_fs block is never reached for cn20k because the function
returns early via npc_cn20k_apply_custom_kpu().

Does this code dereference a NULL-offset pointer causing a kernel crash?

The same issue appears to affect cam2 and action2 pointers which are
allocated in npc_alloc_kpu_cam2_n_action2() but never called for cn20k.

This was raised by Jakub Kicinski during v4 review on 2026-03-16.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 8d260bcfbf38..8d8feb7742e8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c

[ ... ]

> @@ -1730,32 +1835,89 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
>  		return -EINVAL;
>  	}
>
> +	*fw_kpus = fw->kpus;
> +
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
> +		profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
> +					      sizeof(ikpu_action_entries),
> +					      GFP_KERNEL);
> +		if (!profile->ikpu2)
> +			return -ENOMEM;
> +
> +		action = (struct npc_kpu_profile_action *)(fw->data + offset);
> +
> +		if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
> +			return -ENOMEM;
> +
> +		memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
> +		offset += sizeof(ikpu_action_entries);
> +	}
> +
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
> +		profile->kpu[kpu].cam_entries2 = entries;
> +		profile->kpu[kpu].action_entries2 = entries;
> +		ret = npc_alloc_kpu_cam2_n_action2(rvu, kpu, entries);
> +		if (ret) {
> +			dev_warn(rvu->dev,
> +				 "profile entry allocation failed for kpu=%d for %d entries\n",
> +				 kpu, entries);
> +			return -EINVAL;
> +		}
> +
>  		for (entry = 0; entry < entries; entry++) {
> -			profile->kpu[kpu].cam[entry] = cam[entry];
> -			profile->kpu[kpu].action[entry] = action[entry];
> +			profile->kpu[kpu].cam2[entry] = cam2[entry];
> +			profile->kpu[kpu].action2[entry] = action[entry];
>  		}
>  	}

Could this loop overflow and hang the kernel if firmware specifies more
than 65535 entries?

The loop variable 'entry' is declared as int at the top of the function,
but in the from_fs path, 'entries' is read directly from the firmware
blob:

    entries = fw_kpu->entries;

In the non-from_fs path, entries is capped:

    entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);

But in the from_fs path there is no cap on entries. If a corrupt or
malicious firmware file specifies fw_kpu->entries with a very large
value, the loop could run for an extremely long time or cause other
issues.

The kernel should not rely on filesystem data being well-formed.
Validation is needed for the from_fs case.

This was raised by Simon Horman during v3 review on 2026-03-10. The
author acknowledged this in v3 saying they would fix it in v5, but the
issue persists in the current version.

