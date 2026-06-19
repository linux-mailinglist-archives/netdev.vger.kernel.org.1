Return-Path: <netdev+bounces-300660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e83jGGEINWr3mAYAu9opvQ
	(envelope-from <netdev+bounces-300660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:14:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5FA6A4E4C
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:14:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CyD7YIMW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300660-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300660-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C0D5302D4DF
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF8636492A;
	Fri, 19 Jun 2026 09:13:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B573624D7;
	Fri, 19 Jun 2026 09:13:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860436; cv=none; b=Haorix9xG25Vj4dt5GlPQzzFA5f3GhRzzEVtRvasf5fS6YCINzU6O+Ae4p0j/Jfm3QdEecJw/1K38afFQJbUNhiigb3cxvyu4GgRMhTk+klBebxe3vvxtnHAMuwZLEINTFvlzQ91GGGovisKPnMNALv8Jz0LhnKFBUnWitnTEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860436; c=relaxed/simple;
	bh=BA5PAEInpXEwRB2RbbXBv+1qhQnw0Zx3bIYuD7dakJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bj4dOB6Gf7h/BAWx+leF9rrk7FmDy5U5ormEocaRnUO5qfEBWmaLKSOL+9gEcvuYhzNXnfCK3eox9ZsbYC3DyZog2olhlzBB3hUoGixpMQNOKNQ+VmETt2EFqxXCZfoTNHOjHEXt+ZhbiWsave5yR6SWaM8F8fEs/ZDcUZrXm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyD7YIMW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C6A1F00A3A;
	Fri, 19 Jun 2026 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860435;
	bh=XT8oO0AnrNR+esqm1RwXDKFYKcz08jTd11DtMU4y3lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CyD7YIMWaSUCItXbMCAMvFjg2DC9CEgr6SNUtNVcI1pl5KaEx0N9MYooci/WMB0gb
	 yTTcFnMOk7nQkgGYGgo8vVDwfMig+FkmvkseguSAkkdxwlAczcQ7Trir+8CErG0LvX
	 AKWYoUzUyhha+YxTAK4DE6QtqFK0qvF/2RsB5dauguiOhDXvHO2Th1YWpRLV9Awn0h
	 86LtV75QYcAWA9HIu7H21i0+3BEd1uZJraTt7idWHDmM4SU3KosKiIelkq648Aj0jm
	 GE5UpI2Rd3avCnXJl+IqZYxB7jrf6tP7YHNPz43LStBTBPNWXwf2QnYeXj8vjD7NjI
	 s1KRtVhhvrxkQ==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	sgoutham@marvell.com
Subject: Re: [PATCH net] octeontx2-af: npc: cn20k: Fix subbank free list indexing for search order
Date: Fri, 19 Jun 2026 10:13:41 +0100
Message-ID: <20260619091341.918165-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618035926.1490794-1-rkannoth@marvell.com>
References: <20260618035926.1490794-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300660-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B5FA6A4E4C

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2-af: npc: cn20k: Fix subbank free list indexing for search order

This change re-keys the xa_sb_free free list using each subbank's slot
in subbank_srch_order[] rather than using subbank_srch_order[sb->idx],
moving the population into a new helper called from npc_priv_init().
A few comments inline.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 354c4e881c6a..d38e848add93 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -3423,6 +3423,36 @@ static int npc_create_srch_order(int cnt)
>  	return 0;
>  }
>  
> +static int npc_subbanks_srch_oder_init(struct rvu *rvu)
                                ^^^^

[Low]
Is "oder" intended here? The neighbouring identifiers
npc_create_srch_order() and subbank_srch_order use "order", so this
appears to be a typo that would be easier to fix before the symbol
lands.

> +{
> +	struct npc_subbank *sb;
> +	int sb_idx;
> +	int i, j;
> +	int rc;
> +
> +	for (i = 0; i < npc_priv->num_subbanks; i++) {
> +		sb_idx = subbank_srch_order[i];
> +		sb = &npc_priv->sb[sb_idx];
> +		sb->arr_idx = i;
> +
> +		dev_dbg(rvu->dev, "%s: sb->idx=%u sb->arr_idx=%u\n",
> +			__func__, sb->idx, sb->arr_idx);
> +
> +		rc = xa_err(xa_store(&npc_priv->xa_sb_free, sb->arr_idx,
> +				     xa_mk_value(sb->idx), GFP_KERNEL));
> +		if (rc) {
> +			dev_err(rvu->dev,
> +				"%s: xa_store(xa_sb_free) failed at slot %d (sb=%d): %d\n",
> +				__func__, i, sb_idx, rc);
> +			for (j = 0; j < i; j++)
> +				xa_erase(&npc_priv->xa_sb_free, j);
> +			return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -4727,6 +4748,10 @@ static int npc_priv_init(struct rvu *rvu)
>  	for (i = 0, sb = npc_priv->sb; i < num_subbanks; i++, sb++)
>  		npc_subbank_init(rvu, sb, i);
>  
> +	ret = npc_subbanks_srch_oder_init(rvu);
> +	if (ret)
> +		goto fail2;
> +

[Medium]
Can this leak subbank_srch_order on the new failure path?

npc_create_srch_order() allocates subbank_srch_order via kcalloc().
Before this patch, the only way to reach fail2 was when
npc_create_srch_order() itself failed and left subbank_srch_order
NULL, so fail2 not freeing it was safe.

With this new goto fail2, subbank_srch_order has already been
allocated, but the fail2 label only frees npc_priv->sb and npc_priv:

fail2:
	xa_destroy(&npc_priv->xa_sb_used);
	[...]
	kfree(npc_priv->sb);
	npc_priv->sb = NULL;
fail1:
	kfree(npc_priv);
	npc_priv = NULL;
	return ret;

A subsequent re-init would unconditionally reassign
subbank_srch_order = kcalloc(...) in npc_create_srch_order(),
permanently leaking the previous buffer.

Should this path go to a new label that also kfree()s
subbank_srch_order, or should fail2 free it?

>  	/* Get number of pcifuncs in the system */
>  	npc_priv->pf_cnt = npc_pcifunc_map_create(rvu);
>  	npc_priv->xa_pf2idx_map = kcalloc(npc_priv->pf_cnt,

[High]
Can npc_priv_init() return 0 on a real failure here?

After npc_subbanks_srch_oder_init() returns successfully, ret is 0.
If the kcalloc() for npc_priv->xa_pf2idx_map fails right after, the
code does goto fail3 which falls through fail2 and fail1 to
return ret, propagating 0 to the caller:

fail3:
	kfree(subbank_srch_order);
	subbank_srch_order = NULL;

fail2:
	[...]
fail1:
	kfree(npc_priv);
	npc_priv = NULL;
	return ret;

The caller npc_cn20k_init() then sees err == 0 and continues into
npc_setup_mcam_section(), which dereferences npc_priv (now NULL).

Pre-patch the function ended in return -ENOMEM, so the fail3 path
returned -ENOMEM unconditionally. Should ret be reset to -ENOMEM
before goto fail3, or should a separate variable be used for the
new helper's return value?

> @@ -4760,7 +4785,7 @@ static int npc_priv_init(struct rvu *rvu)
>  fail1:
>  	kfree(npc_priv);
>  	npc_priv = NULL;
> -	return -ENOMEM;
> +	return ret;
>  }

