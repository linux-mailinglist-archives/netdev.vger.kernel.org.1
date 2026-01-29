Return-Path: <netdev+bounces-254568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHSYEbXsemmE/wEAu9opvQ
	(envelope-from <netdev+bounces-254568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:14:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A72F0ABDDE
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4A9030416D4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D32E3AF1;
	Thu, 29 Jan 2026 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rtogy5OG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07622DC76D;
	Thu, 29 Jan 2026 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663587; cv=none; b=IFsWg1Mo3C1v85+AkqldF1e7P5Mye5csCXGFMUX8b/P18mS3wbe1W+Hn1zqQUgHicKPfeytAOIxTk8xl4v98XgQiFrTp7oKb/cw9Amaxvo2exK/r7nQaSrIOwqtVzXYwekIoaOd+TAcP2Tec9B6c8kLx/PX6VwgGbSTurIAUSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663587; c=relaxed/simple;
	bh=Zg5IpgtssIg6Jfod0JBBTvo9KTH028+RFS0K2utLIEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYSo8+atSuL3YI9UcOkaycJf/5zw5BDba/TLlygXZWnqOQjLFEPUbu95RGYpf6/PFcuhyTKHW6yKpvsdoEEw7kjpopoXM0IELgRRwIY058owq30LGuXobMaujk47Sb/h4AEP1ryNZO1uSDBLSs4/sUhSPaPGTCKVerbEgj2VkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rtogy5OG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0185C19425;
	Thu, 29 Jan 2026 05:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663587;
	bh=Zg5IpgtssIg6Jfod0JBBTvo9KTH028+RFS0K2utLIEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rtogy5OGsnv9JsQUpttIwE48pff4Y02hajzg8Iet0EpuF2/h9BMvdP+kGJK4FatX6
	 CblI5R2jvVl5mZsoi9huYZDfZvDBi0BCINdAoIC4yo4xWFIHRA4wjgV3ckMefzIniE
	 yrv8IujiCNhO7eL5Tw9wGWTKfItRi01u/nzVUUE30dG86pghBXyTj/cjvmhCts6Z2K
	 xDveRMCbCMmKqiZbGD57MV9nmrWUGB+so3f+lN17AzISi4l0+ZxXiX2bcxcy0dRj75
	 u4grev2hDMZzkQMcLnlPy/gGaywUdtuCCvGOhTZssLvPQlAEougCVfxqYnAEgBe2ZA
	 Oa1UoEQyeJFcg==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	sumang@marvell.com,
	linux-kernel@vger.kernel.org,
	sbhatta@marvell.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	sgoutham@marvell.com
Subject: Re: [net-next,v6,08/13] octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon
Date: Wed, 28 Jan 2026 21:13:05 -0800
Message-ID: <20260129051306.376568-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128071235.3577206-9-rkannoth@marvell.com>
References: <20260128071235.3577206-9-rkannoth@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-254568-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A72F0ABDDE
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon

This patch adds new mailboxes for CN20K silicon due to changes in
struct mcam_entry where the keyword arrays were increased from size 7
to 8, breaking backward compatibility.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index d73e447bedca..000280a4181b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c

[ ... ]

> @@ -1782,23 +1850,25 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
>  				 struct rvu_npc_mcam_rule *rule,
>  				 struct rvu_pfvf *pfvf)
>  {
> +	struct npc_cn20k_mcam_write_entry_req cn20k_wreq = { 0 };
>  	struct npc_mcam_write_entry_req write_req = { 0 };
> -	struct npc_mcam *mcam = &rvu->hw->mcam;
>  	struct mcam_entry_mdata mdata = { };
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	struct cn20k_mcam_entry *cn20k_entry;
>  	struct mcam_entry *entry;
>  	u8 intf, enable, hw_prio;
>  	struct msg_rsp rsp;
>  	int err;
>
> +	cn20k_entry = &cn20k_wreq.entry_data;
>  	entry = &write_req.entry_data;
> -
> -	npc_populate_mcam_mdata(rvu, &mdata, entry);
> +	npc_populate_mcam_mdata(rvu, &mdata, cn20k_entry, entry);
>
>  	ether_addr_copy(rule->packet.dmac, pfvf->mac_addr);
>
>  	if (is_cn20k(rvu->pdev))
>  		npc_cn20k_read_mcam_entry(rvu, npcblkaddr, rule->entry,
> -					  entry, &intf,
> +					  cn20k_entry, &intf,
>  					  &enable, &hw_prio);
>  	else
>  		npc_read_mcam_entry(rvu, mcam, npcblkaddr, rule->entry,
> @@ -1813,7 +1883,13 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
>  	write_req.intf = pfvf->nix_rx_intf;
>
>  	mutex_unlock(&mcam->lock);
> -	err = rvu_mbox_handler_npc_mcam_write_entry(rvu, &write_req, &rsp);
> +	if (is_cn20k(rvu->pdev))
> +		err = rvu_mbox_handler_npc_cn20k_mcam_write_entry(rvu,
> +								  &cn20k_wreq,
> +								  &rsp);

In the CN20K path, cn20k_wreq is passed to the handler but only
write_req fields were initialized above:

    write_req.hdr.pcifunc = rule->owner;
    write_req.entry = rule->entry;
    write_req.intf = pfvf->nix_rx_intf;

The cn20k_wreq.entry, cn20k_wreq.hdr.pcifunc, and cn20k_wreq.intf fields
remain zero-initialized. This causes the handler to write to MCAM entry 0
instead of rule->entry, potentially corrupting an unrelated MCAM entry
and leaving the intended rule unchanged.

Should cn20k_wreq.entry, cn20k_wreq.hdr.pcifunc, and cn20k_wreq.intf be
initialized similar to how write_req is set up in the non-CN20K path?

> +	else
> +		err = rvu_mbox_handler_npc_mcam_write_entry(rvu, &write_req,
> +							    &rsp);
>  	mutex_lock(&mcam->lock);
>
>  	return err;

