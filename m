Return-Path: <netdev+bounces-269078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAfKEl/Iumm6bwIAu9opvQ
	(envelope-from <netdev+bounces-269078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:44:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB79A2BE801
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D813061749
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922C92882A7;
	Wed, 18 Mar 2026 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB+5iIE6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EAB3A874F;
	Wed, 18 Mar 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847290; cv=none; b=JyK1iSLSNCxhDP8ehV+y/D3PGRfz43Y5z1zzo3u5+/5aoTO16pJLREDgj6DGD3cnNyr6o7GISr6Bkk25LyQEcjmGeDc/U+svTUeH4m321NrXJsSlbQxAOXGic998orWGq94jxgSpjYUde4RkXZoADG9TgQxvlN6+VbLpieynPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847290; c=relaxed/simple;
	bh=mS06dha5V1d33X6pXbkQF+3tFpcBwARDW5DaghCv+lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZRds2+0vmBcH7s95p79dgkIvCLSzZttSrIpjAJ6LA5IbfbVxgcReETYBJ063K65e80E7slMKGq/KfagXt8MBcW3P4uLKyeIKKO/um8bEiqS2rV5259U9oWDwy0K84rWEeN9MO5HTnUAU+vbGaYCOzXnCkL71h6k+JgFvT1zkvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB+5iIE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27A7C19421;
	Wed, 18 Mar 2026 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773847289;
	bh=mS06dha5V1d33X6pXbkQF+3tFpcBwARDW5DaghCv+lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fB+5iIE6GijSUvTZuJarSrtb/f6AK14Ej/z+tIWOwLR2g7RJo075hKMWo0EmbaC0j
	 IO5KEYr/aDpwEGZXr/5J3It+36dHUAUJA9DbVPZJpFjSmVXCVoNKEFFJzSXFDLiDMX
	 DWCWQ/XvwuTlwmZWuMYeffAqNkDLMbVAAagPHEliOTFmu50TCoUFap479e3lltwhCk
	 v7lQjAGRMp3z68DInzEjt1JABGYGh5sYP3y0/oN0FT1rcraMQ8Hw30tlNaIBn9/vN7
	 UXaR7USuk4uQycZ7P4DqbnpjGcoTx99RlvPEJLx7wWLNvGSD35hgKPEDc9w/W3tGb9
	 LDDYmVGdLfbzQ==
From: Simon Horman <horms@kernel.org>
To: sbhatta@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	bbhushan2@marvell.com,
	lcherian@marvell.com,
	linux-kernel@vger.kernel.org,
	gakula@marvell.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	sgoutham@marvell.com
Subject: Re: [net-next,1/4] octeontx2-af: npa: cn20k: Add NPA Halo support
Date: Wed, 18 Mar 2026 15:21:23 +0000
Message-ID: <20260318152123.1909135-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1773665859-4036-2-git-send-email-sbhatta@marvell.com>
References: <1773665859-4036-2-git-send-email-sbhatta@marvell.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-269078-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.960];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: EB79A2BE801
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npa: cn20k: Add NPA Halo support

CN20K silicon implements unified aura and pool context type called Halo
for better resource usage. This patch adds support to handle Halo context
type operations.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> index fe8f926c8b75..c963f43dc7b0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> index e2a33e46b48a..aa2b8acf6be4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c

[ ... ]

> @@ -233,6 +259,12 @@ static int npa_lf_hwctx_disable(struct rvu *rvu, struct hwctx_disable_req *req)
>  		aq_req.aura_mask.bp_ena = 1;
>  		cnt = pfvf->aura_ctx->qsize;
>  		bmap = pfvf->aura_bmap;
> +	} else if (req->ctype == NPA_AQ_CTYPE_HALO) {
> +		aq_req.aura.ena = 0;
> +		aq_req.aura_mask.ena = 1;
> +		rvu_npa_halo_hwctx_disable(&aq_req);
> +		cnt = pfvf->aura_ctx->qsize;
> +		bmap = pfvf->halo_bmap;
>  	}
>
>  	aq_req.ctype = req->ctype;
> @@ -241,8 +273,8 @@ static int npa_lf_hwctx_disable(struct rvu *rvu, struct hwctx_disable_req *req)
>  		rc = rvu_npa_aq_enq_inst(rvu, &aq_req, NULL);
>  		if (rc) {
>  			err = rc;
>  			dev_err(rvu->dev, "Failed to disable %s:%d context\n",
>  				(req->ctype == NPA_AQ_CTYPE_AURA) ?
>  				"Aura" : "Pool", id);
>  		}
>  	}

When disabling a HALO context fails, wouldn't the error message print
"Pool" instead of "Halo"? The ternary expression only checks for AURA,
so HALO failures would be logged as Pool failures, making debugging on
cn20k hardware misleading.

