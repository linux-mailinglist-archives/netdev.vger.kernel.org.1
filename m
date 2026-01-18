Return-Path: <netdev+bounces-250768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAEDD391F6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A109E303EF93
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94EE1EF0B0;
	Sun, 18 Jan 2026 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM7Rr1oz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35011EA7DB;
	Sun, 18 Jan 2026 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696828; cv=none; b=QGuLyEOA9f9o+3besNMG7QKceNfwmQJAecAXrLInibN4WGuT+kWEyCTG3fpCKb57NWxibDhvGbv1K1lA15OlqwL5C5IUfNKy7GYIgyJ6xgQjlU3AwvS1rngAOveNu84Dr46jdlDNrjFI01ZmB7RJa8atGGWLL0xd54CHGw7vcKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696828; c=relaxed/simple;
	bh=BqkbOKAFvQITWeYypuRRG+5cTtpNPLSgO4oqLT0JsPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3O1Mu2IZmWenbR73JAIxhlV68xGybdWEwbH2c4IOLTmefzBxgsTHuHaZ7XJHsz3KU3p+BofwZ5yZbZ6T9tEiWS94OFirneNxcw1zzZ9aU+y1u+BzqSCX9ooxZN9hhzz4oZTYBBAvdrmNoSPnDTBx6ht9N1vNC49vbjrpDXzb9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM7Rr1oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3BBC19422;
	Sun, 18 Jan 2026 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768696828;
	bh=BqkbOKAFvQITWeYypuRRG+5cTtpNPLSgO4oqLT0JsPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YM7Rr1ozHZC4yjk/x7YDoZIygM/YzYCS4hzNMVuGyRVvKj+yqJfAXkpFbEvQja1tu
	 pf7p4fg6qUFnBsPXRZc408Z7giWW7o6Ui9UxbxkCsqzm23wuAFu7SclaUUZdeep5ux
	 7OmkH1WsNfN+OZkTYXWjuHPLLUdBdLcCaODgxuavI29ffwVZU+GsqB54ThcGU0MUpB
	 /BEDRgyDWDitLPGuFcppHfuyQMcLhGKhX3In7xwtSemYUgRIYOBF1+qcNgraCKnXcV
	 Egw6P1PRpOKcoRzVZoiXzUr0YU8qLAhHSFMppyIl9dXRgbXYAoIGEmmgU6FUpKRqN8
	 CauDtePB4Kycw==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next,v4,09/13] octeontx2-af: npc: cn20k: virtual index support
Date: Sat, 17 Jan 2026 16:40:27 -0800
Message-ID: <20260118004027.1044394-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113101658.4144610-10-rkannoth@marvell.com>
References: <20260113101658.4144610-10-rkannoth@marvell.com>
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
octeontx2-af: npc: cn20k: virtual index support

This patch adds virtual MCAM index allocation and improves CN20K MCAM
defragmentation. Virtual indexes allow the hardware to move mapped
MCAM entries internally while presenting stable indexes to callers.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index d549e75b2cb0..334b80ebec69 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +static int npc_vidx_maps_add_entry(struct rvu *rvu, u16 mcam_idx, int pcifunc,
> +				   u16 *vidx)
> +{
> +	int rc, max, min;
> +	u32 id;
> +
> +	/* Virtual index start from maximum mcam index + 1 */
> +	max = npc_priv.bank_depth * 2 * 2 - 1;
> +	min = npc_priv.bank_depth * 2;
> +
> +	rc = xa_alloc(&npc_priv.xa_vidx2idx_map, &id,
> +		      xa_mk_value(mcam_idx),
> +		      XA_LIMIT(min, max), GFP_KERNEL);
> +	if (rc) {
> +		dev_err(rvu->dev,
> +			"%s: Failed to add to vidx2idx map (%u)\n",
> +			__func__, mcam_idx);
> +		return rc;
> +	}
> +
> +	rc = xa_insert(&npc_priv.xa_idx2vidx_map, mcam_idx,
> +		       xa_mk_value(id), GFP_KERNEL);
> +	if (rc) {
> +		dev_err(rvu->dev,
> +			"%s: Failed to add to idx2vidx map (%u)\n",
> +			__func__, mcam_idx);
> +		return rc;
                ^^^^^^^^^^

If xa_insert() fails here, the entry allocated by xa_alloc() in
xa_vidx2idx_map is not cleaned up. Should there be an xa_erase() call
to remove the allocated entry before returning the error?

> +	}
> +
> +	if (vidx)
> +		*vidx = id;
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> index 0f9953eaf1b0..cc83d4fc5724 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c

[ ... ]

> +static const struct devlink_param rvu_af_dl_param_defrag[] = {
> +	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEFRAG,
> +			     "npc_defrag", DEVLINK_PARAM_TYPE_STRING,
> +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> +			     rvu_af_npc_defrag_feature_get,
> +			     rvu_af_npc_defrag,
> +			     rvu_af_npc_defrag_feature_validate),
> +};
> +
>  int rvu_register_dl(struct rvu *rvu)
>  {

[ ... ]

> +	if (is_cn20k(rvu->pdev)) {
> +		err = devlink_params_register(dl, rvu_af_dl_param_defrag,
> +					      ARRAY_SIZE(rvu_af_dl_param_defrag));
> +		if (err) {
> +			dev_err(rvu->dev,
> +				"devlink defrag params register failed with error %d",
> +				err);
> +			goto err_dl_exact_match;
> +		}
> +	}

The rvu_af_dl_param_defrag parameters are registered here for CN20K
devices, but rvu_unregister_dl() does not have a corresponding
devlink_params_unregister() call for these parameters. Should there be
a matching unregister call similar to the exact_match handling?

