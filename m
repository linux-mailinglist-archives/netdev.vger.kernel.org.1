Return-Path: <netdev+bounces-277791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMOqBF2X22n1DgkAu9opvQ
	(envelope-from <netdev+bounces-277791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E3E3E3E75
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33DB13008281
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E67837BE7F;
	Sun, 12 Apr 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfJHSvF1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B91D54FA;
	Sun, 12 Apr 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998809; cv=none; b=dBrVil/+qyW1TwpQ14VnZKtKUjeNJsPqLdC4iF0OjvOyEGSXyZbKgpess9e7jW7sBvRPuELklQweYsj1EzUW3NTN9FH2FPItdTsui92N7v2GW9rYzexu7LsBYMOEJa8jzuSeOLoWAxlnvdO6T8FvxoHPPbUfwm3wK92u2iYXCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998809; c=relaxed/simple;
	bh=YOyEuLo74ep5TwCKRiq05kVPo3T4viLmFmQcJpmuUK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAcB93tm8goZR5Oea4GAUGMTg77o8O7hHjNnZDuBCdr0hlGkupkzOFfQv7MG8riF7+UTM/8ZlK4MDphwgQaYgP07CFXsWdmJYrYBzkBJfLI4eJFxpVdHMMmO4ZsckpdUXnbZpd5R4m2HsByutGize2PaF9jlbISz9KidjmOgPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfJHSvF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9432C19424;
	Sun, 12 Apr 2026 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775998808;
	bh=YOyEuLo74ep5TwCKRiq05kVPo3T4viLmFmQcJpmuUK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfJHSvF1BLFVJuG7TSuqKNOhmBGm96sP/XDWYHmHbij3LiLkyK+GZ4o8CCa7fxlLK
	 RhMws3nS0VVqFpL/4jYTova2gp1dVR378JvGrpywLFp/BtaSwpZubnE4IlHTjys1/X
	 b+HHkXZAP1A3j73QtvPd4P1uNDJnGraRD49tuvGCRVetKqatkgzwyY6A+S9CgKi6Fa
	 GNS/2hTTDXN7nX6FLRq3+/MBOVL+kAf4X9Y8Txe4sfZ/VUrAdZ/l8KWocLQc0uwK/H
	 UuyiXPAdjvl9+gzDerHDKNrIELbjf9CKKpHEu/17ko+sd1WfYRA213WkXkm5iJGfpt
	 FtDwAS/6Ag5/g==
From: Simon Horman <horms@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Simon Horman <horms@kernel.org>,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	lorenzo@kernel.org,
	linux-kernel@vger.kernel.org (open list),
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	enelsonmoore@gmail.com,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	lukas.bulwahn@redhat.com,
	kuba@kernel.org,
	hkallweit1@gmail.com,
	dimon.zhao@nebula-matrix.com,
	corbet@lwn.net,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH v11 net-next 09/11] net/nebula-matrix: add Dispatch layer implementation
Date: Sun, 12 Apr 2026 13:59:45 +0100
Message-ID: <20260412125945.663258-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408093739.56001-10-illusion.wang@nebula-matrix.com>
References: <20260408093739.56001-10-illusion.wang@nebula-matrix.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,linuxfoundation.org,google.com,gmail.com,lunn.ch,redhat.com,lwn.net,linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-277791-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 81E3E3E3E75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add Dispatch layer implementation

This patch introduces a control-level routing mechanism for the Dispatch
layer with two routing paths: a direct path (Dispatch -> Resource -> HW)
and a channel path (Dispatch -> Channel). The implementation uses
interface-declared control levels and upper-layer configured control
levels to determine the routing.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index 8b031f6e963f..eee41d10ad63 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> @@ -6,6 +6,396 @@
>  #include <linux/pci.h>
>  #include "nbl_dispatch.h"
>
> +static u16 nbl_disp_chan_get_vsi_id_req(struct nbl_dispatch_mgt *disp_mgt,
> +					u16 func_id, u16 type)
> +{
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_common_info *common = disp_mgt->common;
> +	struct nbl_chan_param_get_vsi_id result = { 0 };
> +	struct nbl_chan_param_get_vsi_id param = { 0 };
> +	struct nbl_chan_send_info chan_send;
> +
> +	param.type = type;
> +
> +	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_VSI_ID,
> +		      &param, sizeof(param), &result, sizeof(result), 1);
> +	chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
> +
> +	return result.vsi_id;
> +}

Does nbl_disp_chan_get_vsi_id_req() ignore the func_id parameter?

The function accepts func_id but only sends param.type in the channel
message. The nbl_chan_param_get_vsi_id struct appears to have only
{vsi_id, type} fields, with no func_id field.

On the responder side:

> +static void nbl_disp_chan_get_vsi_id_resp(void *priv, u16 src_id, u16 msg_id,
> +					  void *data, u32 data_len)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
> +	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
> +	struct device *dev = disp_mgt->common->dev;
> +	struct nbl_chan_param_get_vsi_id *param;
> +	struct nbl_chan_param_get_vsi_id result = { 0 };
> +	struct nbl_chan_ack_info chan_ack;
> +	int err = NBL_CHAN_RESP_OK;
> +	int ret;
> +
> +	param = (struct nbl_chan_param_get_vsi_id *)data;
> +
> +	result.vsi_id =
> +		NBL_OPS_CALL_RET(res_ops->get_vsi_id, (p, src_id, param->type));

nbl_disp_chan_get_vsi_id_resp() uses src_id (the channel source) instead
of func_id. This creates a behavioral inconsistency with the direct path:

> +static u16 nbl_disp_get_vsi_id(struct nbl_dispatch_mgt *disp_mgt, u16 func_id,
> +			       u16 type)
> +{
> +	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
> +	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
> +
> +	return NBL_OPS_CALL_RET(res_ops->get_vsi_id, (p, func_id, type));
> +}

The direct path correctly passes func_id to res_ops->get_vsi_id(p, func_id,
type).

When the channel path is active, callers cannot query VSI IDs for
functions other than the sender. Is the func_id parameter intended to be
used in nbl_disp_chan_get_vsi_id_req()?

[ ... ]

