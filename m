Return-Path: <netdev+bounces-251273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC0D3B78E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D66830049DA
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035EA270EDF;
	Mon, 19 Jan 2026 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKpGqHP5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2221ABAA;
	Mon, 19 Jan 2026 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852010; cv=none; b=ttOaeJESkaxXeZx9M9DAUkt8UTYZsshzMcekiKM8+lXDQy8rYHd5bq/B+UI1YTl5s+KtyublKIK3unJFpZ8MBIdJSqNezJfflHtSgKR2hRrVCxR13CkfBOvDaFlFd7vHqNS1HnqHGD5gvMO74HkDz/ovVS18bxby3/KG5BtKU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852010; c=relaxed/simple;
	bh=4UQ2NAS1iZ0RAtjKM4tifvX/yPeV8vl11NrVnc6K0IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krjJyE34Q69owez4WjE4IBfnwjaGDcjMAfXXEksRIVoAz+S7wJMByZ7yAtQydqSirIbWwQ1ZmQQoTYpeogODLAxhqfcXV7OaJzTv9l6CSGgHvCrvZ9PE6Thuyel+lcPfVWz+graFAUdTl67v+H02FsVrMp/lehwNoVPflTwafI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKpGqHP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B380C116C6;
	Mon, 19 Jan 2026 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768852010;
	bh=4UQ2NAS1iZ0RAtjKM4tifvX/yPeV8vl11NrVnc6K0IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKpGqHP5TtXl9t8Cj07DPYQa3JONDWn6MkDyoYBqFVE1BEo/G0WNAAhlAGuLcS135
	 rCR455MHC5yqkoGSK+yGKTPQcPQ5XXaWtV5tNnDA1p7/531c0MuomMIhZfMwKBv0Zn
	 ynC5gl2fybsfSfynIYpHjGyB+C1bWjYAKDM/PNSubc7i3/HjzD0b8MnUXVcgtyOaAa
	 sQ2URbpzlLCm+gNE+78pqYaO/hhMpHafh0L867VMZAeUZcIbpqAUKjaD+PXJpFdwjg
	 UomJMG7iuwOm7GFAxufUaHgb4JXUf5eGxG71VybQFmteYi32wAGBAH7SGKaTwcmo1N
	 T0wbf1p19w3bw==
From: Jakub Kicinski <kuba@kernel.org>
To: hkelam@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,PatchV2,1/2] octeontx2-af: Mailbox handlers to fetch DMAC filter drop counter
Date: Mon, 19 Jan 2026 11:46:46 -0800
Message-ID: <20260119194646.1265255-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117165520.2215073-2-hkelam@marvell.com>
References: <20260117165520.2215073-2-hkelam@marvell.com>
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
octeontx2-af: Mailbox handlers to fetch DMAC filter drop counter

This patch adds mailbox handler support to read the DMAC filter drop
counter from CGX and RPM MAC blocks.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 3abd750a4bd7..aef0087174b7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c

[ ... ]

> +int rvu_mbox_handler_cgx_get_dmacflt_dropped_pktcnt(struct rvu *rvu,
> +						    struct msg_req *req,
> +						    struct cgx_dmac_filter_drop_cnt *rsp)
> +{
> +	int pf = rvu_get_pf(rvu->pdev, req->hdr.pcifunc);
> +	struct mac_ops *mac_ops;
> +	u8 cgx_id, lmac_id;
> +	void *cgxd;
> +
> +	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
> +	cgxd = rvu_cgx_pdata(cgx_id, rvu);
> +	mac_ops = get_mac_ops(cgxd);
> +
> +	if (!mac_ops->get_dmacflt_dropped_pktcnt)
              ^^^^^^^^^

Can mac_ops be NULL here? When a PF is not CGX-mapped, pf2cgxlmac_map[pf]
returns 0xFF, which extracts cgx_id=0xF. Then rvu_cgx_pdata() returns
NULL if cgx_id >= cgx_cnt_max. Subsequently, get_mac_ops(NULL) returns
NULL, and this line would dereference a NULL pointer.

Other similar handlers in this file check is_pf_cgxmapped() or
is_cgx_config_permitted() before proceeding with the CGX operations.
For example, rvu_mbox_handler_cgx_fec_stats() and
rvu_mbox_handler_cgx_features_get() both validate the PF mapping first.

Should this handler also include a validation check like:

    if (!is_pf_cgxmapped(rvu, pf))
        return 0;

> +		return 0;
> +
> +	rsp->count =  mac_ops->get_dmacflt_dropped_pktcnt(cgxd, lmac_id);
> +	return 0;
> +}
-- 
pw-bot: cr

