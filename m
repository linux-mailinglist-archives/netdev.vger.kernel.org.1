Return-Path: <netdev+bounces-248762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 468E0D0DEEB
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C9B63060A7A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D212D7DC4;
	Sat, 10 Jan 2026 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzRTdXIk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43432D6E6F;
	Sat, 10 Jan 2026 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768085978; cv=none; b=LmGSFCYKcolPsDudXRH8OyguN4CDBnqKQV+AZaM7oNR1aa8B2FZaSyZL2ggRxmdJoblSTeFcIhLtGqkPfQ0oAQ1l8dBpBBc591JCpM0T1XfmOQfC1e1FZLyJJitZG+oM1JMAR/W1WUjXzTCO7GooIO2n4wSTHQzFuoh+jUEQOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768085978; c=relaxed/simple;
	bh=jmIoJPcuE8EOzGCHfc92UHce/Q74KWiOwO0tPS+L8nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcxcweOS83aU7iefgEV37ZQOF5w5lL73IO86VE9gUnE/X22Ho/a9ir4lgSVjp7CbjDzGketemyuBjromqyPrq3GQ9DsOxRiaDadFDBWyZ91SDr/Vqa67BT4C+FgJOPAA0ISL5IAS9U3GyJmQwzfVsPAiThxGE8dZ/6dOXTFXbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzRTdXIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132EBC19425;
	Sat, 10 Jan 2026 22:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768085978;
	bh=jmIoJPcuE8EOzGCHfc92UHce/Q74KWiOwO0tPS+L8nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzRTdXIkvY6s4kzoRFKKD5UsbeBJoptOR/MD2tpYz1st2Ii2eV7qUAkTmx5WEABrO
	 LGVTt/UFalkcoc1HnshtXYvrAxqKyWWYolHff1lrA41ZN/R7hjdVLzFJO664/ykSTq
	 /80DWmrudOFSx/1RTVmI+hG+uPBDKqCP8WexiNpYgb8jPG6rdAf5jdFikoqaMR8o8t
	 1hqWWPcwu+iGmcxfI8XAI4qRY4VNFDDjjzgIfQO4aTVizQVROJkNvf0Ex6pD5MsqvB
	 Rr7WsaAiIWUQZF1V2XrtQC1Cpor3ys/r8xEAKHyvt5OjtE9rJz/nfy9Uv4fzQ+LgaW
	 RJBcAuxMAfrbg==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v3,11/13] octeontx2-pf: cn20k: Add TC rules support
Date: Sat, 10 Jan 2026 14:59:36 -0800
Message-ID: <20260110225936.3900883-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109054828.1822307-12-rkannoth@marvell.com>
References: <20260109054828.1822307-12-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least pausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-pf: cn20k: Add TC rules support

This patch implements dynamic MCAM entry allocation for CN20K TC rules.
The PF driver requests entries from AF driver on the fly and shifts
entries based on rule priority, rejecting rules when X2/X4 mixing
prevents proper shifting.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> index a60f8cf53feb..cd2c9a95ee22 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c

[ ... ]

> +void cn20k_tc_update_mcam_table_del_req(struct otx2_nic *nic,
> +					struct otx2_flow_config *flow_cfg,
> +					struct otx2_tc_flow *node)
> +{
> +	struct otx2_tc_flow *first, *tmp, *n;
> +	int i = 0, index;
> +	u16 cntr_val = 0;
> +	u16 entry;
> +
> +	index = cn20k_tc_get_entry_index(flow_cfg, node);
> +	first = list_first_entry(&flow_cfg->flow_list_tc, struct otx2_tc_flow,
> +				 list);
> +	entry = first->entry;
> +
> +	/* If entries cannot be shifted then delete given entry
> +	 * and free it to AF too.
> +	 */
> +	if (!cn20k_tc_check_entry_shiftable(nic, flow_cfg, node,
> +					    index, false)) {
> +		list_del(&node->list);
> +		entry = node->entry;
> +		goto free_mcam_entry;
> +	}

[ ... ]

> +free_mcam_entry:
> +	if (cn20k_tc_free_mcam_entry(nic, entry))
> +		netdev_err(nic->netdev, "Freeing entry %d to AF failed\n",
> +			   first->entry);
                           ^^^^^^^^^^^^

Should this error message print 'entry' instead of 'first->entry'? When
the code takes the "not shiftable" path, it sets entry = node->entry and
jumps to free_mcam_entry. At that point, first->entry may be different
from the entry value that was actually passed to cn20k_tc_free_mcam_entry().

> +}

