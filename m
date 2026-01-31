Return-Path: <netdev+bounces-255337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI5ULAx4fWknSQIAu9opvQ
	(envelope-from <netdev+bounces-255337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:33:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920CC088D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F9413006B5C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8432335029F;
	Sat, 31 Jan 2026 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2KIepuD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDB34E76A;
	Sat, 31 Jan 2026 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769830405; cv=none; b=UAb6Nr16LQb8ssEBgTkkJHu1tEJW3C/0cqYUrCRBNshMrGbeuocEgBD3fL/GKCFlDyeKcH2SfbXnxsAhLsv2SJW08cKaZGxyjMbj8bW+GCySZGcfCiL0GjPl6THcao0lvz4LYh8jUZUWC+VO/vqx9s43lE0jsQQX3hr+ZCs68gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769830405; c=relaxed/simple;
	bh=pb/l1QnS42Xhg7djJDxHxh6dWiXBRyj70BDc+XB5/3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7Yxl+h+e5TiBbHI3LDefeBXAtnz/YkAJxIsAl0WUa+IvP/IYon4cF8ZBFFjRtr43Se7GUpP184i7wK/dejFTbI5ZxgRZLjztAE9W+mhr5hxRQHESVYN00EWfk0ALJJ+SgqpygfJDbv0U3RfngMiGoxNLo9qwp6i3VQj7TvmUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2KIepuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C494CC4CEF1;
	Sat, 31 Jan 2026 03:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769830405;
	bh=pb/l1QnS42Xhg7djJDxHxh6dWiXBRyj70BDc+XB5/3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2KIepuDQtjsNW/f+U3XEpmIQ3aS3351GYbP8raffAAV7oVpeYRn3Buw/Yhn75PIs
	 x6bfN2saWn1Ll7ael2/XjIQWnaiLk1mx8qiqZRPlMCos4n9dfpI41qCu48J9EikX56
	 8ZkuZCQvjxqqt7plj6VjRlvai6gXIfG4GnIdwz5rczY0ueSqydlcLcxhgwE2ULNZgv
	 tbR62Zgvtrqh+JG3hGPa5TY2/HdR/J20bLbLZa/Z8SS1ODoxvlnL9+v/Zh6wHWM63o
	 fKATPdY/ifNj3ZpeV0xTNhU0b/ijx1WfXME5P9E8YNTjE0DiJVNVFhmGqmAJ83eXTZ
	 l8OA+Zz2ZPwmg==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v7,11/13] octeontx2-pf: cn20k: Add TC rules support
Date: Fri, 30 Jan 2026 19:33:23 -0800
Message-ID: <20260131033323.1013856-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129083339.264386-12-rkannoth@marvell.com>
References: <20260129083339.264386-12-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255337-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4920CC088D
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-pf: cn20k: Add TC rules support

This patch adds dynamic MCAM entry allocation for TC rules on CN20K,
with X2/X4 key width support and entry shifting based on priorities.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c

[ ... ]

> +int cn20k_tc_update_mcam_table_add_req(struct otx2_nic *nic,
> +				       struct otx2_flow_config *flow_cfg,
> +				       struct otx2_tc_flow *node)
> +{
> +	struct otx2_tc_flow *tmp;
> +	u16 cntr_val = 0;
> +	int list_idx, i;
> +	int entry, prev;
> +
> +	list_idx = otx2_tc_add_to_flow_list(flow_cfg, node);
> +	entry = node->entry;
> +	if (!cn20k_tc_check_entry_shiftable(nic, flow_cfg, node,
> +					    list_idx, true)) {
> +		/* Due to mix of X2 and X4, entries cannot be shifted.
> +		 * In this case free the entry allocated for this rule.
> +		 */
> +		if (cn20k_tc_free_mcam_entry(nic, entry))
> +			netdev_err(nic->netdev,
> +				   "Freeing entry %d to AF failed\n", entry);
> +		return -EINVAL;
                ^^^^^^^^^^^^^^

When this returns -EINVAL, the caller otx2_tc_add_flow() will then jump
to free_leaf and call cn20k_tc_free_mcam_entry() again with the same
entry value (stored in new_node->entry). Is this a double-free of the
MCAM entry?

> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> +	if (is_cn20k(nic->pdev)) {
> +		rc = cn20k_tc_alloc_entry(nic, tc_flow_cmd, new_node, &dummy);
> +		if (rc) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "MCAM rule allocation failed");
> +			kfree_rcu(new_node, rcu);
> +			return rc;
> +		}
> +	}
> +
> +	entry = otx2_tc_update_mcam_table(nic, flow_cfg, new_node, true);
> +	if (entry < 0) {
> +		NL_SET_ERR_MSG_MOD(extack, "Adding rule failed");
> +		rc = entry;
> +		goto free_leaf;
> +	}
> +
>  	mutex_lock(&nic->mbox.lock);
>  	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
>  	if (!req) {
>  		mutex_unlock(&nic->mbox.lock);
>  		rc = -ENOMEM;
>  		goto free_leaf;
>  	}

[ ... ]

>  free_leaf:
> +	cn20k_tc_free_mcam_entry(nic, new_node->entry);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This function is called unconditionally in the error path, but on
non-CN20K devices new_node->entry was never initialized (it would be 0
from kzalloc). Would this send a mbox message to free MCAM entry 0 on
older silicon? Should this call be guarded with is_cn20k()?

Additionally, when cn20k_tc_update_mcam_table_add_req() fails due to
X2/X4 mix, it already frees the entry before returning -EINVAL. Reaching
this point would then attempt to free the same entry again.

