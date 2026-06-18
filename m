Return-Path: <netdev+bounces-300469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SaHLKJAKNGqALwYAu9opvQ
	(envelope-from <netdev+bounces-300469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:11:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD4E6A1238
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:11:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lGtmWOB2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300469-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300469-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04AC230053D4
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666763FB07F;
	Thu, 18 Jun 2026 15:07:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C242D3739;
	Thu, 18 Jun 2026 15:07:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795251; cv=none; b=M36wofEChOme4oj8A5fBk4QW1QYE0kQuojFl7lb0K6RwuG+GdFL4zFu+LK825lWWcwzWJP0uDk3hdbKsUx5qgUP7GvRqRRwMFxhapv54NwucRl0S+UFCY/xUPXMyGoXP4ztQsdyD4fLaNQ2To3y4q3TNC2qMvaws3zjoqPRVpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795251; c=relaxed/simple;
	bh=D5ImawvzLlxIMyPCUTgOUk06SN3nr2dO+r0vmLOqkps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM0mglBkYFxOMvKUUbT9bOXf/p5mOn8TxJxNZLVCXskxp4qiANRfh7kCWOysaw2g01toAIc1gYXBgtXW3q8i1VAigI7+z0cmQRP/vKC28LfcbdxOdHD0CRauQiux6ZsNjHrvqECEAjgpFky9bzWlmLzdBXTh95KVgXgAQA1st8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGtmWOB2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3041F000E9;
	Thu, 18 Jun 2026 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795248;
	bh=9EUih94dotOKdCVH4Oy9EjLwrpJlgJ8SRBdHn8fbiYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lGtmWOB2xZGvQ1OcnoEFY0GtU1IcUA8Vf7YepuSkwmtrJq85kX4APQZ/NdOoDR5e7
	 ICenfkwVeN5Phen9S31jQDkZlT7hM3hvN7u3n3iF27jId22hp69f8hGOwZcMAMzXIR
	 ia++GliJjz0oVSqXwrAcIGklkqhoo/PxMTSaIIOkZ1P+H0xuvXjEMGnY/vtSHczZjA
	 uIdkBVwwUJAW9cpT/muHm6eImrlrXpRvEyWqDYNlXfrw5CoJaI1qd1zeKC5ygng4ac
	 izbgJ/k2rXjYwbdK3gbEgPB1CH9aPmM5d9mzob3Hhug8dar4vyEWuiGFQw1svIbOr7
	 0lOcVWWgIl7sw==
Date: Thu, 18 Jun 2026 16:07:23 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, hkelam@marvell.com, lcherian@marvell.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: Re: [PATCH net] octeontx2-af: fix CGX debugfs RVU AF PCI reference
 leaks
Message-ID: <20260618150723.GR827683@horms.kernel.org>
References: <20260617104525.1321395-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617104525.1321395-1-rkannoth@marvell.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-300469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:davem@davemloft.net,m:hkelam@marvell.com,m:lcherian@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:dbgh9129@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,marvell.com,vger.kernel.org,redhat.com,lunn.ch,google.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:email,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDD4E6A1238

On Wed, Jun 17, 2026 at 04:15:25PM +0530, Ratheesh Kannoth wrote:
> CGX per-lmac debugfs seq readers obtained struct rvu via
> pci_get_drvdata(pci_get_device(..., PCI_DEVID_OCTEONTX2_RVU_AF, ...)),
> which leaks a PCI device reference on every read. Store rvu and the CGX
> handle in debugfs inode private data when creating stats, mac_filter,
> and fwdata files (one context per CGX), and use debugfs aux numbers for
> fwdata so lmac_id matches the other CGX debugfs entries.
> 
> Fixes: f967488d095e ("octeontx2-af: Add per CGX port level NIX Rx/Tx counters")
> Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
> Fixes: 49f02e6877d1 ("Octeontx2-af: Debugfs support for firmware data")
> Cc: Linu Cherian <lcherian@marvell.com>
> Reported-by: Yuho Choi <dbgh9129@gmail.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

The nit below not withstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 77 ++++++++++---------
>  1 file changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c

...

> @@ -2831,18 +2839,14 @@ static void rvu_dbg_npa_init(struct rvu *rvu)
>  
>  static int cgx_print_stats(struct seq_file *s, int lmac_id)
>  {
> +	struct rvu_cgx_lmac_dbgfs_ctx *dctx = s->private;
>  	struct cgx_link_user_info linfo;
>  	struct mac_ops *mac_ops;
> -	void *cgxd = s->private;
> +	void *cgxd = dctx->cgxd;
> +	struct rvu *rvu = dctx->rvu;

nit: It would be nice to preserve reverse xmas tree order - longest line to
     shortest - for local variable declarations. Likewise elsewhere in this
     patch.

>  	u64 ucast, mcast, bcast;
>  	int stat = 0, err = 0;
>  	u64 tx_stat, rx_stat;

...

