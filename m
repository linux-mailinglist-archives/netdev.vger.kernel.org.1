Return-Path: <netdev+bounces-271175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE62EHy/wmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:44:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E132319489
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CB5F303CD34
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6B3F20F5;
	Tue, 24 Mar 2026 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE9Iz/vb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42AD35F190;
	Tue, 24 Mar 2026 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370187; cv=none; b=arRyCXUhu2EmzQdMKJ25G8TjQxBqtmF3dF8VXfa7KO9jgk9fM2XDPGxz/BJaS1d5z2M+nD58x9XbzoOJX6cMEVnxwijviN6etnlqmBPU7Gboou9s+r9p/Z0UMRiaJoux2GiJXuN7Ez7m0Ydx3q7/kZ0EiFV9dk+wE2fuXFXw1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370187; c=relaxed/simple;
	bh=tOwpwjaKq7s/HV5FPdqEWC3sHjUBVt7pp8ol+9JKC0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRpEFVFyhKXUGZob5puHlN4/qpE88HsRM3PnHE+pr+YFuhBt2qgeb5dNr858SIc5Q/3i4oux8RJGr56y/PBh8PLu8FgmtDBGEDOJcuUb6YYO1q3qk3lNTM+hhjrTA5dD424HapjvbJM6s+ZoKQTF1ullyXLCCJkR+l5RJDdiC6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE9Iz/vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452A6C19424;
	Tue, 24 Mar 2026 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774370187;
	bh=tOwpwjaKq7s/HV5FPdqEWC3sHjUBVt7pp8ol+9JKC0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eE9Iz/vb3dfKBjT9GlkHgEtj3j5q1H7uREy06fAIIOTiCMOi0iO2R+h+h2UK0YNVU
	 ZumKscGf0nzc77gJvbdoWLAW+WRvc9sypuoXHTdwT/puRfe3l0gbTW0Ikc0MSzbn3M
	 zFmrM3g2L1AVz5BnhTG08uzk4qXdUM0LGyNNKfKwAuCWKAzIEuO9/YxEFV3VMag5aO
	 A1MO42o4YsvwFv7jGQixExdVgnA5J4cFizkX2rNr23qj1kMBg2HzMN6nGLavT70wUf
	 kX9Mt1AuZgXDFdC8xeuwkworNXMz1c+JK22/EhPWhDQWq3FTJeuI5UANUa4jHaWHBB
	 GUx80WweQn4Dw==
Date: Tue, 24 Mar 2026 16:36:21 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
	jiri@resnulli.us, chuck.lever@oracle.com, matttbe@kernel.org,
	cjubran@nvidia.com, shshitrit@nvidia.com, dtatulea@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH v7 net-next 5/5] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <20260324163621.GC111839@horms.kernel.org>
References: <20260323035110.3908741-1-rkannoth@marvell.com>
 <20260323035110.3908741-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323035110.3908741-6-rkannoth@marvell.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271175-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E132319489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 09:21:10AM +0530, Ratheesh Kannoth wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.
> 
> When the rvu_af module is loaded with the kpu_profile parameter, the
> specified profile is read from /lib/firmware/kpu and programmed into
> the KPU registers. Add npc_kpu_profile_cam2 for the extended cam format
> used by filesystem-loaded profiles and support ptype/ptype_mask in
> npc_config_kpucam when profile->from_fs is set.
> 
> Usage:
>   1. Copy the KPU profile file to /lib/firmware/kpu.
>   2. Build OCTEONTX2_AF as a module.
>   3. Load: insmod rvu_af.ko kpu_profile=<profile_name>
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c

...

> @@ -1730,32 +1835,90 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
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

Effectively the code below is the else arm of the condition above.
I would suggest that moving the contents of both arms into helpers
would lead to a cleaner implementation.

> +
> +		entries = min(fw_kpu->entries, rvu->hw->npc_kpu_entries);
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

Perhaps it applies to the existing code as well. But I think
the new code to handle parsing images read from the file system
could benefit from bounds checking. Basically passing in the length
of the firmware image as an argument and ensuring that data beyond
that length isn't accessed.

>  	}
>  
> @@ -1852,7 +2015,10 @@ void npc_load_kpu_profile(struct rvu *rvu)
>  	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
>  	const char *kpu_profile = rvu->kpu_pfl_name;
>  	const struct firmware *fw = NULL;
> -	bool retry_fwdb = false;
> +	int len, ret, fw_kpus = 0;
> +	char *path;
> +
> +	profile->from_fs = false;
>  
>  	/* If user not specified profile customization */
>  	if (!strncmp(kpu_profile, def_pfl_name, KPU_NAME_LEN))
> @@ -1865,27 +2031,57 @@ void npc_load_kpu_profile(struct rvu *rvu)
>  	 * Firmware database method.
>  	 * Default KPU profile.
>  	 */
> -	if (!request_firmware_direct(&fw, kpu_profile, rvu->dev)) {
> -		dev_info(rvu->dev, "Loading KPU profile from firmware: %s\n",
> -			 kpu_profile);
> +
> +	/* No support for filesystem KPU loading */
> +	if (is_cn20k(rvu->pdev))
> +		goto load_image_fwdb;
> +
> +#define PDIR "kpu/"

Please make the name of this define less generic - e.g. prefix
it with the name of the driver. And please put it towards
the top of this file.

> +	len = strlen(kpu_profile) + sizeof(PDIR);
> +	path = kmalloc(len, GFP_KERNEL);
> +	if (!path)
> +		return;
> +
> +	strscpy(path, PDIR, len);
> +	strcat(path, kpu_profile);
> +	if (!request_firmware_direct(&fw, path, rvu->dev)) {
> +		dev_info(rvu->dev, "Loading KPU profile from filesystem: %s\n",
> +			 path);
>  		rvu->kpu_fwdata = kzalloc(fw->size, GFP_KERNEL);
>  		if (rvu->kpu_fwdata) {
>  			memcpy(rvu->kpu_fwdata, fw->data, fw->size);
>  			rvu->kpu_fwdata_sz = fw->size;
>  		}
>  		release_firmware(fw);
> -		retry_fwdb = true;
> -		goto program_kpu;
> +		kfree(path);
> +
> +		ret = npc_apply_custom_kpu(rvu, profile, true, &fw_kpus);
> +		kfree(rvu->kpu_fwdata);
> +		rvu->kpu_fwdata = NULL;
> +
> +		if (ret) {
> +			rvu->kpu_fwdata_sz = 0;
> +			npc_prepare_default_kpu(rvu, profile);
> +			dev_err(rvu->dev,
> +				"Loading KPU profile from filesystem failed\n");
> +			goto load_image_fwdb;
> +		}
> +
> +		/* Cn20k does not support filesystem loading */
> +		rvu->kpu.kpus = fw_kpus;
> +		profile->from_fs = true;
> +		return;
>  	}
> +	kfree(path);
>  
>  load_image_fwdb:

I know that it was here before this patch, so this is a suggestion for a
follow-up: as this isn't a fast path I think it would be good to refactor
this code so it doesn't use goto labels as part of it's control of
conditional execution for non-error paths.

>  	/* Loading the KPU profile using firmware database */
>  	if (npc_load_kpu_profile_fwdb(rvu, kpu_profile))
>  		goto revert_to_default;
>  
> -program_kpu:
>  	/* Apply profile customization if firmware was loaded. */
> -	if (!rvu->kpu_fwdata_sz || npc_apply_custom_kpu(rvu, profile)) {
> +	if (!rvu->kpu_fwdata_sz ||
> +	    npc_apply_custom_kpu(rvu, profile, false, &fw_kpus)) {
>  		/* If image from firmware filesystem fails to load or invalid
>  		 * retry with firmware database method.
>  		 */

...

