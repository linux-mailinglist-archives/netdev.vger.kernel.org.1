Return-Path: <netdev+bounces-256963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDMENtomhGlRzwMAu9opvQ
	(envelope-from <netdev+bounces-256963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:12:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0217BEEA6F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B5A83004432
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB49330C372;
	Thu,  5 Feb 2026 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaNUORRB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892C2E7653;
	Thu,  5 Feb 2026 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770268373; cv=none; b=UVexRBhEklt88v2OazEQIAyTAPENUf7e9Y38K9SQjSx70abklQwcn8tzERkHgvX0rCtLkffynudkS41WmIHFO6NSzwzkGK9ASlNTIdcjh297E6FfXLaOn65ywUhb5qiNtOEQNjh/Hzh/iiY5Ry0VaohP0HspbKKPJWcYxYFxae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770268373; c=relaxed/simple;
	bh=Vl7TrPprWCwGj19OCOJ+kanJKZiV77f2y6pUNd+/esg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMeTISQcf2KOuO3Cx6dJKhojbLtEVql25/ecxQ89KwWdUbIw9ygLrYl+cPmHRkoLhHNH2r7bEWLvwdtphDucUaS7vlUVx5mALMH8y5ctLUmQOh+qrD0wTvwQ3WjpwIZRJ2iWPLKwCIgn7jfXXQdAMuWSVQvVllEzxApn5TKX+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaNUORRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBED9C4CEF7;
	Thu,  5 Feb 2026 05:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770268373;
	bh=Vl7TrPprWCwGj19OCOJ+kanJKZiV77f2y6pUNd+/esg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RaNUORRB2KtD8EO5vCPTbTO+/oC2eNHPc8HGlI7G5/Ti5RRB+9d/02RKf4O8Ji5hb
	 ANjXfaxLMkneFXcZNVHVG6U3KlNWQ8eL7xn27rbTiD71YbnbHZad5KGxip/FNIjULb
	 uyZmD7mjpstx9/e7Je/D/hbc5pl+I2mqZRHMMlEZiJ1qEPzz0/z4Fpq/6s1PPySakj
	 8sTgCB8BU7bmMtd8i9KRh99VU9TVr3fR7MbIDu07Aa/1RbVYQtJ6B20xJwkXny3CQx
	 S8ld7ORnP8LFn3VZvNquGD5qGPzdqsMLkcVdMaIxCuMkWnKUyvb/W6o9qOXlFVZM0z
	 Ao13CHOERlZwA==
Date: Wed, 4 Feb 2026 21:12:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: dsa: yt921x: Use u64_stats_t for MIB
 stats
Message-ID: <20260204211252.71b8fa86@kernel.org>
In-Reply-To: <20260203171305.95085-4-mmyangfl@gmail.com>
References: <20260203171305.95085-1-mmyangfl@gmail.com>
	<20260203171305.95085-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256963-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0217BEEA6F
X-Rspamd-Action: no action

On Wed,  4 Feb 2026 01:12:43 +0800 David Yang wrote:
> 64-bit variables might not be atomic on 32-bit architectures, thus
> cannot be unconditionally made lock-free. Use u64_stats_t so it would
> still be lock-free on 64-bit architectures.

IDK why we need to worry about lock free reading of those 64b values...

> @@ -771,22 +785,27 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
>  	struct yt921x_priv *priv = to_yt921x_priv(ds);
>  	struct yt921x_port *pp = &priv->ports[port];
>  	struct yt921x_mib *mib = &pp->mib;
> +	unsigned int start;
>  	size_t j;
>  
>  	mutex_lock(&priv->reg_lock);
>  	yt921x_read_mib(priv, port);
>  	mutex_unlock(&priv->reg_lock);

..when in all(?) the readers converted by this patch we take the mutex
to refresh the stats anyway. And presumably do expensive IO/reg reads
under that mutex. So just extend the mutex over the read section and
save us the retry logic, please, it will make no difference to perf.

> -	j = 0;
> -	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> -		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
> +	do {
> +		start = u64_stats_fetch_begin(&pp->syncp);
>  
> -		if (!desc->name)
> -			continue;
> +		j = 0;
> +		for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> +			const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
>  
> -		data[j] = ((u64 *)mib)[i];
> -		j++;
> -	}
> +			if (!desc->name)
> +				continue;
> +
> +			data[j] = u64_stats_read(&((u64_stats_t *)mib)[i]);
> +			j++;
> +		}
> +	} while (u64_stats_fetch_retry(&pp->syncp, start));
>  }


