Return-Path: <netdev+bounces-250769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BDDD391F7
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E830304861A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A89205E25;
	Sun, 18 Jan 2026 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYFTfLTq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE420297C;
	Sun, 18 Jan 2026 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696830; cv=none; b=EJp7FxKnGCjhydQVgLn6HJfr/69xreI5lIdNq0iuWnSJhrI5dAMMjX4Bc+PtGSKbmqGWo9BA3zsy4vZgQQGOinDOZNo4LoJRHBnkXxT1qwekF9gGuk+xoNeQN25p36P8mv1zhcO1WeS8SWOoWR51MA8tqMQ0Zbcd5A1aXX5tApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696830; c=relaxed/simple;
	bh=+V5i591neD5CrA5ZZ4WiOqU25hLl6AhbOSC3V0OdGlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gx+Ie3Myu1njtGFBj2x15Hv1WjKSVwlu9ocmpSmHGm5qiLDIjKTmIlTQuILFq4iJ3K86Fji5/QzrWBQ4/y7LaJKPPRzstRyhrT3HTVsrtQsSg3qs9HlI7LfAuL1nwxmDJUZoL4KSUxmwIhay5DlVOe8BeVXL7008lxFjDTIrSUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYFTfLTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A3DC19422;
	Sun, 18 Jan 2026 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768696829;
	bh=+V5i591neD5CrA5ZZ4WiOqU25hLl6AhbOSC3V0OdGlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYFTfLTqtfdFs5n3W+WUAO6FIWr8BMvThb7aPMO+dvqhjE8lNZAO/rGH7PddBn5BQ
	 7NK2R1VBqhg59RToUeTLrhOaQvPRCoJlKmS0/IAFXIZh5SHDBMps7kMhq7nmEInLYN
	 4vR3FRvRWfTozi8gn3BPCA5zmO7azO+vLEUCJO99Lo5tttoj4O4VMJPMVGHNGZ6lSa
	 7YOAYGFEpSbRgqRDgS8qR+uxMQSOsKKN81J/bURQyTVvubHfERRTA2hkm+/V+JCqMj
	 1D8+ERqKzX5OZ/1ke5aVjmF1HlM0lzzoYa1a2cdp8vbBlNzzM2PpatmjP2n7+TzWif
	 36xyhc/8ceJTA==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next,v4,11/13] octeontx2-pf: cn20k: Add TC rules support
Date: Sat, 17 Jan 2026 16:40:28 -0800
Message-ID: <20260118004028.1044419-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113101658.4144610-12-rkannoth@marvell.com>
References: <20260113101658.4144610-12-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-pf: cn20k: Add TC rules support

This patch adds dynamic MCAM entry allocation for TC rules on CN20K
silicon, with support for X2/X4 key widths and entry shifting based on
rule priorities.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 26a08d2cfbb1..866d9451f5d6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> @@ -1292,7 +1277,23 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  	if (old_node)
>  		otx2_tc_del_flow(nic, tc_flow_cmd);
>
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
                ^^^^^^^^^^^^^^

For CN20K, if cn20k_tc_alloc_entry() succeeds (allocating an MCAM entry
from AF) but then otx2_mbox_alloc_msg_npc_install_flow() or
otx2_sync_mbox_msg() fails, the code goes to free_leaf. Looking at the
free_leaf cleanup path below, it calls otx2_tc_del_from_flow_list() and
kfree_rcu() but does not call cn20k_tc_free_mcam_entry() to return the
AF-allocated entry.

Is this leaking the MCAM entry on CN20K when these error paths are taken?

The cn20k_tc_update_mcam_table_add_req() function does call
cn20k_tc_free_mcam_entry() when it fails internally (due to X2/X4 mix),
suggesting MCAM entry cleanup is expected.

> @@ -1304,7 +1305,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  	memcpy(&dummy.hdr, &req->hdr, sizeof(struct mbox_msghdr));
>  	memcpy(req, &dummy, sizeof(struct npc_install_flow_req));

[ ... ]

