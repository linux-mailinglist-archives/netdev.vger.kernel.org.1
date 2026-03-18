Return-Path: <netdev+bounces-269076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAMXBMvHumm6bwIAu9opvQ
	(envelope-from <netdev+bounces-269076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:42:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ED92BE753
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24CCA31826F7
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2D7307AF2;
	Wed, 18 Mar 2026 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6yahNeG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0D3019D7;
	Wed, 18 Mar 2026 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847126; cv=none; b=rVo6BG2gIVlDl2OmetAoOdw1UwkmzLBY3Q8Hu6T3ZfjZcnBjuCs8B1J7cjN6nhGGxS8v2S8q8FvwM8cE9VI3cntXtGAxdIye6RnadTwvY8K5TB4jXNqxV3afGB37Iz2Ig4vnjzSoUFPZzNDPjLPa19fMk5bqZmOdVP5ED460Oqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847126; c=relaxed/simple;
	bh=2nBxS0U9/2i2CwQhkSs7sIJph5hX1qEpMmRI0wYhxu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYQSVtGY2ZgdJY5YVPRfEERCghDtqZrP3RdwDR0pa53wWyOwc4wKmcnOV4Fe/TgWpTGhHAd5tFpCUsUTWRKBx3K/iaqhP8PLOtwGZtUHjqaux/zG0ExsUgTiBGdsmocQpjQ4+Ls0+JXmKrSFBNFOe2bXUbnkmm3r+wPDGl3Fg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6yahNeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50242C19421;
	Wed, 18 Mar 2026 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773847125;
	bh=2nBxS0U9/2i2CwQhkSs7sIJph5hX1qEpMmRI0wYhxu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6yahNeGhUWPLaUTwOxeb3tid3+SSavAO4xpqAniJ7Jg56vcb9QlQVPgKH5hScoxK
	 cib3k/HS0765AA9ppgKPO9DksfKl/d+avR4vifxcDDHgHFsELT/5qWDs0A8xgxRPqN
	 IC1OYohZevcJb99NhMr3Zah6TWH/GCaEdmGy+i3kom4EV+LGCXBdUTSGVURtNSAw+r
	 lwwEd7ArpUaI2LGABT2UKw8TmVteKwLTdeXXUyB1f9sbVyJVZ5Vwh+tcO0BDZd7xvz
	 l7vm7BuHby2nnyE2ui4pwHCe93CTsVvLYY8il+X7wTD0acOKbp8EDN7iZKqV8XIN1M
	 A7iXakKkj8G3g==
Date: Wed, 18 Mar 2026 15:18:40 +0000
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linu Cherian <lcherian@marvell.com>
Subject: Re: [net-next PATCH 3/4] octeontx2-af: npa: cn20k: Add debugfs for
 Halo
Message-ID: <20260318151840.GD1753385@horms.kernel.org>
References: <1773665859-4036-1-git-send-email-sbhatta@marvell.com>
 <1773665859-4036-4-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1773665859-4036-4-git-send-email-sbhatta@marvell.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269076-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 73ED92BE753
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 06:27:38PM +0530, Subbaraya Sundeep wrote:

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c

...

> @@ -1204,6 +1210,20 @@ static void print_npa_pool_ctx(struct seq_file *m, struct npa_aq_enq_rsp *rsp)
>  		seq_printf(m, "W8: fc_msh_dst\t\t%d\n", pool->fc_msh_dst);
>  }
>  
> +static inline char *npa_ctype_str(int ctype)

Please don't use the inline keyword in C code unless there is a
demonstrable - usually performance - reason to do so.

Also, I wonder if the return type for this function should be const.

> +{
> +	switch (ctype) {
> +	case NPA_AQ_CTYPE_AURA:
> +		return "aura";
> +	case NPA_AQ_CTYPE_HALO:
> +		return "halo";
> +	case NPA_AQ_CTYPE_POOL:
> +		return "pool";
> +	default:
> +		return NULL;
> +	}
> +}
> +

...

