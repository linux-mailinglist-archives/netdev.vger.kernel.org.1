Return-Path: <netdev+bounces-254569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD3EHdjsemmE/wEAu9opvQ
	(envelope-from <netdev+bounces-254569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:15:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE118ABDE5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6E14304E0CD
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C033E2E7623;
	Thu, 29 Jan 2026 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klH5MSfe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2242D9EEC;
	Thu, 29 Jan 2026 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663589; cv=none; b=LNTrEDbOUVotPmxu5/RLD7kkN/xsaEQ2pKqcJ36HJ9z08e1h5KBDMaV3r9EcPPy69pSZoMY34bROEzxozm8Iup2OArPAyb6SGFlcQK+i+SvecDwNY2rC74kUHpp3Nsdj3Bk9/cm+TgVGEKX4OhgKAFgSWo+LKyplPN0I9B9L2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663589; c=relaxed/simple;
	bh=3Ad3DlMjIgIEv6QksfGagi8nhcC2wkZPvAuz16purjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozJpmu1KM0LHtnWgdgFksIByepTO+VST2+OkyznWm3v+s4JcLiXPSuMo1ZpEPClqJ1qCeHwQNXIGP8Re946G4DrplU/ZAa9DQ8DsFS/4iwtcNA8gJophfqQMh/Ai12MizqiKbTzh1jJsNHq3gc/fNrrMAsUQ9WSPJQk/SVxHkjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klH5MSfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B376BC19421;
	Thu, 29 Jan 2026 05:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663589;
	bh=3Ad3DlMjIgIEv6QksfGagi8nhcC2wkZPvAuz16purjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=klH5MSfew+LtWXhbcbhx9T9YxER2r3/v+2izEzSkWu2Q4K3qRsf1fzYb8Tts7pIb+
	 fTNzCQfUB2JmRARLCUNJCDg9N05h0JCq119bkBtfHejgE33ii2o1J/bi6jTArWobpb
	 /9ruZiQx2gpOdtS6veRlSx2SesEmAl4EY859qvAd68xY8CukxOY5LvWnbuOUEOuEpV
	 Mf4fVjSrRPOsSZ7An1RMXJeGQSaQBgv6iFudo4NSoEYoQTik++MFOzLBaa1hybU60u
	 RnSHu/A3UOVonilAzelnOGGFq69C5qEciAC6SrYDf0FlcrKQiB9ZSasVZb70ESooSq
	 ehTWE4SXbiWzw==
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
Subject: Re: [net-next,v6,09/13] octeontx2-af: npc: cn20k: virtual index support
Date: Wed, 28 Jan 2026 21:13:07 -0800
Message-ID: <20260129051307.376632-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128071235.3577206-10-rkannoth@marvell.com>
References: <20260128071235.3577206-10-rkannoth@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-254569-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE118ABDE5
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: virtual index support

This patch adds virtual MCAM index allocation support for CN20K,
enabling defragmentation by allowing entries to be moved while
maintaining stable virtual indexes for callers.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 62b4d657c369..642336b0d476 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> +static int npc_vidx_maps_modify(struct rvu *rvu, u16 vidx, u16 new_midx)
> +{
> +	u16 old_midx;
> +	void *map;
> +	int rc;
> +
> +	if (!npc_is_vidx(vidx)) {
> +		dev_err(rvu->dev,
> +			"%s: vidx(%u) does not map to proper mcam idx\n",
> +			__func__, vidx);
> +		return -ESRCH;
> +	}
> +
> +	map = xa_erase(&npc_priv.xa_vidx2idx_map, vidx);
> +	if (!map) {
> +		dev_err(rvu->dev,
> +			"%s: vidx(%u) could not be deleted from vidx2idx map\n",
> +			__func__, vidx);
> +		return -ESRCH;
> +	}
> +
> +	old_midx = xa_to_value(map);
> +
> +	rc = xa_insert(&npc_priv.xa_vidx2idx_map, vidx,
> +		       xa_mk_value(new_midx), GFP_KERNEL);
> +	if (rc) {
> +		dev_err(rvu->dev,
> +			"%s: vidx(%u) cannot be added to vidx2idx map\n",
> +			__func__, vidx);
> +		goto fail1;
> +	}
> +
> +	map = xa_erase(&npc_priv.xa_idx2vidx_map, old_midx);
> +	if (!map) {
> +		dev_err(rvu->dev,
> +			"%s: old_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
> +			__func__, old_midx, vidx);
> +		rc = -ESRCH;
> +		goto fail2;
> +	}
> +
> +	rc = xa_insert(&npc_priv.xa_idx2vidx_map, new_midx,
> +		       xa_mk_value(vidx), GFP_KERNEL);
> +	if (rc) {
> +		dev_err(rvu->dev,
> +			"%s: new_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
> +			__func__, new_midx, vidx);
> +		goto fail3;
> +	}
> +
> +	return 0;
> +
> +fail3:
> +	if (xa_insert(&npc_priv.xa_idx2vidx_map, old_midx,
> +		      xa_mk_value(vidx), GFP_KERNEL))
> +		dev_err(rvu->dev,
> +			"%s: Error to roll back idx2vidx old_midx=%u vidx=%u\n",
> +			__func__, old_midx, vidx);
> +fail2:
> +	if (xa_erase(&npc_priv.xa_vidx2idx_map, vidx))
> +		dev_err(rvu->dev,
> +			"%s: Failed to roll back vidx2idx vidx=%u\n",
> +			__func__, vidx);
> +
> +fail1:
> +	if (xa_insert(&npc_priv.xa_idx2vidx_map, old_midx,
> +		      xa_mk_value(vidx), GFP_KERNEL))

The rollback at fail1 appears to operate on the wrong XArray. When
xa_insert() fails above and we jump to fail1, the xa_idx2vidx_map still
contains old_midx since the erase of xa_idx2vidx_map has not executed yet.
This xa_insert() will return -EBUSY because the key already exists.

Should this instead restore vidx to xa_vidx2idx_map with the original
old_midx value, since that was the map modified before the failure?

> +		dev_err(rvu->dev,
> +			"%s: Faled to roll back idx2vidx to old_midx=%u, vidx=%u\n",
> +			__func__, old_midx, vidx);
> +
> +	return rc;
> +}

[ ... ]

