Return-Path: <netdev+bounces-268416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GByBXbLuGkSjgEAu9opvQ
	(envelope-from <netdev+bounces-268416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:33:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 672CF2A33C3
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF011300EA92
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B092D7DCE;
	Tue, 17 Mar 2026 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7PzRmCi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F428314E;
	Tue, 17 Mar 2026 03:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773718386; cv=none; b=kokkYjLSPjShVNmXt0AFDNpLlrHvgouafpRkFL6ekXoiIWCe+HX+PwypQZk3Nj9usXqFriMrTPGJvazczWmlsKVvHngLLcORLXJeO3NFGeRtspEwmQH63MXDirReuK1R0hALcQsNUWHOddaR6JFxJKmxk4Zy3JVcRrk+eyp/dfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773718386; c=relaxed/simple;
	bh=hZzE+s8e6SgE8p7GNtVi0M9UZayNpO3qdRhdvOZsajY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IojLAlAb6hAZk59uFeXwg/qP5aO8dQi+5W9NESLfnpHHG6nz9wfWagWenTl6TxtN/TlNbNNXirG0pGLlPfDMc8q8QveEjJ2rGuTc1ixs7YyTY3HRZOIQQtCNwTLBUrwuXyIV47MlepCrMHD35M4AHFO7c7xvwRr9pnwaw9PPeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7PzRmCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122B4C19421;
	Tue, 17 Mar 2026 03:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773718386;
	bh=hZzE+s8e6SgE8p7GNtVi0M9UZayNpO3qdRhdvOZsajY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7PzRmCikPbh5OgeZD0cE95CXIm3S0aVkj7r90KYlhWiVkbZv9swm4W9Xs3KRxyWF
	 PZnDeWestMJA/xTUVRk72rHyNyhyJwEgPC6gT6rsuPP1stkGxUqg0ZfXN3nw7gY2SM
	 wZcNL9iauULZ40t/OLpaRl0zKPPTgiuNOPHBzq7T/6Qb35PZ/AyreWQi+sV02Begg4
	 T+9SkEq/zFWschecqQP2j6FQiEoB1J34Bld/XLmRA2miEQfAFgJYpNUnWGH4ZUbl4Y
	 RQ961/CaLe2exTaQKA7wbOWuJBHU0CZDXWslkhLHOc0OUJlrdGQsN0we84V/WDjWTb
	 KcKL9wPMgJmvg==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	donald.hunter@gmail.com,
	saeedm@nvidia.com,
	sgoutham@marvell.com,
	edumazet@google.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	horms@kernel.org,
	cjubran@nvidia.com,
	pabeni@redhat.com,
	shshitrit@nvidia.com
Subject: Re: [v4,net-next,5/5] octeontx2-af: npc: Support for custom KPU profile from filesystem
Date: Mon, 16 Mar 2026 20:32:15 -0700
Message-ID: <20260317033214.646969-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312022754.2029595-6-rkannoth@marvell.com>
References: <20260312022754.2029595-6-rkannoth@marvell.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,oracle.com,resnulli.us,gmail.com,nvidia.com,marvell.com,google.com,davemloft.net,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-268416-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 672CF2A33C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "review on patch 3 looks legit, so sending this along
even tho not so sure about this one".

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: Support for custom KPU profile from filesystem

This commit provides a mechanism to load custom KPU (Key Parse Unit)
profiles from the filesystem at module load time, avoiding the need to
flash updated firmware on deployed devices.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 8dad272fd069..c8c09a91b13f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> @@ -666,7 +672,8 @@ void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
>  	num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
>
>  	for (idx = 0; idx < num_pkinds; idx++)
> -		npc_config_kpmaction(rvu, blkaddr, &rvu->kpu.ikpu[idx],
> +		npc_config_kpmaction(rvu, blkaddr,
> +				     npc_get_ikpu_nth_entry(rvu, idx),
>  				     0, idx, true);

When a filesystem-loaded profile is used on cn20k (from_fs=true),
npc_get_ikpu_nth_entry() returns &profile->ikpu2[idx]. However, ikpu2
is never allocated for the cn20k path.

The allocation of ikpu2 happens inside npc_apply_custom_kpu() in the
from_fs block, but that block is never reached for cn20k because
npc_apply_custom_kpu() returns early via npc_cn20k_apply_custom_kpu()
before reaching the ikpu2 allocation:

static int npc_apply_custom_kpu(struct rvu *rvu,
				struct npc_kpu_profile_adapter *profile,
				bool from_fs, int *fw_kpus)
{
	...
	if (is_cn20k(rvu->pdev))
		return npc_cn20k_apply_custom_kpu(rvu, profile);

	if (from_fs) {
		profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
					      sizeof(ikpu_action_entries),
					      GFP_KERNEL);
		...
	}
	...
}

However, npc_load_kpu_profile() unconditionally sets profile->from_fs =
true after npc_apply_custom_kpu() returns success.

Does this code dereference a NULL-offset pointer? The resulting
&NULL[idx] is passed to npc_config_kpmaction() which dereferences it
(kpuaction->errlev), which would cause a kernel crash.

This same issue affects cam2 and action2 via npc_get_kpu_cam_nth_entry()
and npc_get_kpu_action_nth_entry().

>
>  	/* Program KPM CAM and Action profiles */

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 352dc5f1d5b9..e348cdd375eb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c

[ ... ]

> @@ -1731,32 +1837,89 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
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

This is a concern raised by Simon Horman during review that was
acknowledged but not addressed in v4.

The loop variable 'entry' is declared as u16 in npc_apply_custom_kpu():

    u16 kpu, entry;

while 'entries' is an int:

    entries = fw_kpu->entries;

In the from_fs path, 'entries' is read directly from the firmware blob
without bounds checking. If a corrupt or malicious firmware file
specifies fw_kpu->entries > 65535, the u16 variable wraps around at
65536:

    for (entry = 0; entry < entries; entry++)

When entry reaches 65535, incrementing it produces 0, which is still
less than entries, creating an infinite loop that hangs the kernel.

Should the code cap entries in the from_fs path or use an int-sized loop
variable? The author acknowledged this concern with 'ACK' in v3 review
discussion, and Simon emphasized that "the kernel should not rely on
filesystem data being well-formed."

>
>  	return 0;

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -521,13 +521,17 @@ npc_program_single_kpm_profile(struct rvu *rvu, int blkaddr,

[ ... ]

> @@ -536,16 +540,18 @@ npc_program_single_kpm_profile(struct rvu *rvu, int blkaddr,
>  	max_entries = rvu->hw->npc_kpu_entries / 2;
>  	entry = start_entry;
>  	/* Program CAM match entries for previous kpm extracted data */
> -	num_entries = min_t(int, profile->cam_entries, max_entries);
> +	num_entries = min_t(int, num_cam_entries, max_entries);
>  	for (idx = 0; entry < num_entries + start_entry; entry++, idx++)
> -		npc_config_kpmcam(rvu, blkaddr, &profile->cam[idx],
> +		npc_config_kpmcam(rvu, blkaddr,
> +				  npc_get_kpu_cam_nth_entry(rvu, profile, idx),
>  				  kpm, entry);
>
>  	entry = start_entry;
>  	/* Program this kpm's actions */
> -	num_entries = min_t(int, profile->action_entries, max_entries);
> +	num_entries = min_t(int, num_action_entries, max_entries);
>  	for (idx = 0; entry < num_entries + start_entry; entry++, idx++)
> -		npc_config_kpmaction(rvu, blkaddr, &profile->action[idx],
> +		npc_config_kpmaction(rvu, blkaddr,
> +				     npc_get_kpu_action_nth_entry(rvu, profile, idx),
>  				     kpm, entry, false);
>  }
>
> @@ -615,6 +621,12 @@ npc_program_kpm_profile(struct rvu *rvu, int blkaddr,
>  			const struct npc_kpu_profile *profile1,
>  			const struct npc_kpu_profile *profile2)
>  {

[ ... ]

> +	/* Program the first KPM profile */
> +	npc_program_single_kpm_profile(rvu, blkaddr, idx,
> +				       0, profile1);
> +
> +	/* Program the second KPM profile */
> +	start_entry = profile->cam_entries;
> +	npc_program_single_kpm_profile(rvu, blkaddr, idx,
> +				       start_entry, profile2);
> +
> +	total_cam_entries = profile->cam_entries + profile2->cam_entries;
> +	total_action_entries = profile->action_entries + profile2->action_entries;
> +	npc_enable_kpm_entry(rvu, blkaddr, idx, 0,
> +			     total_cam_entries, total_action_entries);
> +
> +	val = profile->cam_entries;
> +	rvu_write64(rvu, blkaddr, NPC_AF_KPMX_PASS2_OFFSET(idx), val);
>  }

Looking at npc_program_kpm_profile(), it uses profile->cam_entries
directly in four places instead of calling npc_get_num_kpu_cam_entries().

When profile->from_fs is true (filesystem-loaded KPU profile), the
accessor returns cam_entries2, while the raw field cam_entries retains
its default value from npc_prepare_default_kpu().

Does this cause the start_entry for the second profile to be based on
the wrong count, leading profile2 entries to overlap or be offset
incorrectly? Would total_cam_entries and total_action_entries passed to
npc_enable_kpm_entry() be wrong, enabling the wrong set of entries? And
would NPC_AF_KPMX_PASS2_OFFSET be set incorrectly?

The callee npc_program_single_kpm_profile() was correctly updated to use
accessors, but npc_program_kpm_profile() was not.

