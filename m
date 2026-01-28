Return-Path: <netdev+bounces-254076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM0UCAx1eWkSxQEAu9opvQ
	(envelope-from <netdev+bounces-254076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:31:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF99C483
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 838E1304289A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06C52BDC25;
	Wed, 28 Jan 2026 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2oXVzWR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB61129B8DB;
	Wed, 28 Jan 2026 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567371; cv=none; b=Vv1jD2J392ZQ/U2pSIqfu0uP3GsKyIrmHQQIjEtEp8iK7jPIjXZdugFM3XSz7fAJEn7Jj7lWM3t+mO8xBx0WXgDXSpDwp7uQJFijDaG/c8QoHO9zUm+DE92160/Ff6QbZqnHdPt8DY42qGXl03OmZOafytecOFQS51d830BNU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567371; c=relaxed/simple;
	bh=AadjOGl9E8lbn2TzvWiTeYz2XeOY9Rn7hDPdGzWjF4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OM4dUng8flkYLRXRCmrGUvpFAJr1LVCgyo8+ZAcphU/9KFFwYJwzaZnGMf8BWJslZLuAZrODgxxaTbDXr67SJFXQ+uyu6GVDxTKeMJAgaj7izWHNLivjP8zM09HkCK7sn3AXsPk34+43xuQdRr0UYQ7kgtDAxnn2FBgXutx1cxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2oXVzWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304ACC116C6;
	Wed, 28 Jan 2026 02:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769567371;
	bh=AadjOGl9E8lbn2TzvWiTeYz2XeOY9Rn7hDPdGzWjF4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2oXVzWRbhryxNhNnr6ajXUX+1mnbCLMDWqELJkDOjL/RTMeiboE2nETN0/TQJW65
	 zImRMW+ZcBUjLoDo88NN4rCXPHyztye3uVpm5hCtRXo9ahRJrY5X8pH0kR1sUoEQwY
	 Szas7aq73Vo2UG/LiZkt4mhH1caRKz2Pvf0fa9+O+c176IOPh+XqKHoKR7SBnZ3I9c
	 S5TJROkVxL6dBxmt/gmVH63vnKPrT6Ur+R153AcZ0BvLuvxex3YtFwLuk0xP1yAHxC
	 L1MiPrAr4XsCpQEFnfliZN2BKYkbses9rm5hvaBJnfozy77GmuEw/O4NtV8O51BgcB
	 Obtoxi5ihdfrg==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sbhatta@marvell.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	sgoutham@marvell.com,
	sumang@marvell.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v5,10/13] octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation
Date: Tue, 27 Jan 2026 18:29:30 -0800
Message-ID: <20260128022930.4153164-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126123254.1000480-11-rkannoth@marvell.com>
References: <20260126123254.1000480-11-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254076-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 73AF99C483
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation

This patch extends the install_flow mailbox request message with additional
fields that allow the AF driver to determine the required NPC MCAM entry
type, allocate the MCAM entry, and complete the flow installation in a
single step for CN20K.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 052d989f2d9a..efd994c65b32 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c

[ ... ]

> +static int otx2_get_kw_type(struct otx2_nic *pfvf,
> +			    struct npc_install_flow_req *fl_req,
> +			    u8 *kw_type)
> +{
> +	struct npc_get_num_kws_req *req;
> +	struct npc_get_num_kws_rsp *rsp;
> +	u8 *src, *dst;
> +	int off, err;
> +	int kw_bits;
> +
> +	off = offsetof(struct npc_install_flow_req, packet);
> +
> +	mutex_lock(&pfvf->mbox.lock);
> +
> +	req = otx2_mbox_alloc_msg_npc_get_num_kws(&pfvf->mbox);
> +
> +	dst = (u8 *)&req->fl + off;
                  ^^^

Can this dereference a NULL pointer? otx2_mbox_alloc_msg_* functions can
return NULL on allocation failure, and this line accesses req->fl without
first checking if req is NULL.

Other similar functions in this file (e.g., otx2_mcam_pfl_info_get(),
otx2_get_dft_rl_idx()) properly check for NULL after the mailbox
allocation before using the returned pointer.

> +	src = (u8 *)fl_req + off;
> +
> +	memcpy(dst, src, sizeof(struct npc_install_flow_req) - off);

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index 963d12ecd328..5fe077935c97 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c

[ ... ]

> @@ -1759,8 +1857,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
>  		enable = true;
>
>  	/* Do not allow requests from uninitialized VFs */
> -	if (from_vf && !enable)
> +	if (from_vf && !enable) {
> +		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
> +						    allocated, req->entry);
>  		return NPC_FLOW_VF_NOT_INIT;
> +	}
>
>  	/* PF sets VF mac & VF NIXLF is not attached, update the mac addr */
>  	if (pf_set_vfs_mac && !enable) {
>  		ether_addr_copy(pfvf->default_mac, req->packet.dmac);
>  		ether_addr_copy(pfvf->mac_addr, req->packet.dmac);
>  		set_bit(PF_SET_VF_MAC, &pfvf->flags);
>  		return 0;
                ^^^^^^^^^^

Does this path leak the allocated MCAM entry? When rvu_npc_alloc_entry_for_
flow_install() allocates an entry (setting allocated=true), but then this
early return path is taken, rvu_npc_free_entry_for_flow_install() is not
called. All other early return paths in this function properly free the
entry, but this one does not.

>  	}
>
>  	mutex_lock(&rswitch->switch_lock);

