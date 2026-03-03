Return-Path: <netdev+bounces-263153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBJZAyfKpmk0TwAAu9opvQ
	(envelope-from <netdev+bounces-263153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:46:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197F1EE771
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3929E3116161
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248C426D27;
	Tue,  3 Mar 2026 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6ScN19l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A241C30F;
	Tue,  3 Mar 2026 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537502; cv=none; b=anFuUuJFOf3LfldolOoBdimByhxgowK5vFhwz5w+Y70hMwyMDpSs5aeh3NgiyqafhI0wuwnAb9Bwlp1sBreMaeO3AZJQ29uNpzDXcraG0WWGRrxKt7a5lyawNDN6Gj98/GyWGgEzYV3AESWSHMMG3PP8lX+/QmZr4Nhzq2MV254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537502; c=relaxed/simple;
	bh=OpdJhgYx238EWFJ6pWxketSgpqalkWzRK4soF5V2xMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTF753+o+K43M+vV3HwVN/mkh2ZFQnLUaXdqV0WHscn3ag6/aXQG/uaQ2iVY0OrrmTiPxewmOIzAhk079yfYWkLs+x0Ph/161sNBGJpHv6mdZyL/j0B3Xg9h/HIYUFmBeTW/eOFL0JhFO58InGlxPfVMwUn4aH88S6fVB2OK93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6ScN19l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A14C2BCB0;
	Tue,  3 Mar 2026 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772537502;
	bh=OpdJhgYx238EWFJ6pWxketSgpqalkWzRK4soF5V2xMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6ScN19l8VWXq302BVNKBmSyRUkCx8zbQUZt2PMI2v+IkN3MjQYEjQDdmG84oKaSC
	 HpWQlxrmEMZUVWghYk/ZYoQVS1iSGFN+pfvgEg3+yaiLjQTTewgPtHjkTQnxqI8Gnx
	 N8x8U/py9VfZOz3ptWQrRgBeHQtxauCQL2Cxnf+lnocGe8OcrSz/es/sE3f8/gbNEs
	 1DnXuuQTi26B6xQucEPaPJcxY+H5mzFgfJxo5/pstOFYQKx1y4HuZlCOd7DIV+6lVu
	 9yMk4u3La/L3fnSRvRVbXOTByiHnI+rhiwTgfYxlk7e5GU/aVmBTHj5TrUrmLXEHLr
	 Mz2wfLSBaRa/Q==
Date: Tue, 3 Mar 2026 11:31:37 +0000
From: Simon Horman <horms@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: dsa: yt921x: Use u64_stats_t for
 MIB stats
Message-ID: <20260303113137.GA71509@kernel.org>
References: <20260227135057.2730254-1-mmyangfl@gmail.com>
 <20260227135057.2730254-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227135057.2730254-3-mmyangfl@gmail.com>
X-Rspamd-Queue-Id: 7197F1EE771
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263153-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:50:54PM +0800, David Yang wrote:
> 64-bit variables might not be atomic on 32-bit architectures, and could
> lead to load/store tearing. Use u64_stats_t to ensure consistency.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

...

> @@ -717,14 +716,29 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)

...

> +	u64_stats_update_begin(&pp->syncp);
> +	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> +		u64_stats_set(&mib->stats[i],
> +			      u64_stats_read(&mib_new->stats[i]));
> +	}
> +	u64_stats_set(&pp->rx_frames, rx_frames);
> +	u64_stats_set(&pp->tx_frames, tx_frames);
> +	u64_stats_update_end(&pp->syncp);
>  
>  	return 0;
>  }

...

> @@ -782,9 +796,11 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
>  		if (!desc->name)
>  			continue;
>  
> -		data[j] = ((u64 *)mib)[i];
> +		data[j] = u64_stats_read(&((u64_stats_t *)mib)[i]);

Stats is available as a member of mib as an array of u64_stats_t.
So this code can avoid bypassing the type system with a cast.
And be consistent with an earlier change in this patch.

		data[j] = u64_stats_read(&mib->stats[i]);

>  		j++;
>  	}
> +
> +	mutex_unlock(&priv->reg_lock);
>  }

...

