Return-Path: <netdev+bounces-263481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO+gJUp3p2nyhgAAu9opvQ
	(envelope-from <netdev+bounces-263481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:05:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3406A1F8AC6
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95F7F303CB36
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF901189F20;
	Wed,  4 Mar 2026 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+WCScYg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723223BCE3;
	Wed,  4 Mar 2026 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582726; cv=none; b=u5WpWDjbD4noBOo88T/x+D1jvWoX7hToxtwAnWwr3gsnTzjm/lFEzwT6ubmAZvzniqM5MwmohW9t8vE0OH4M3ITi5ZiYxu4mWron9WC/mZPTBD6tihqMjbVS5aqrUHuHFC5zfQaWOCO5tepz7mdB9mRq3HlPvauFpoSzenDpqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582726; c=relaxed/simple;
	bh=dJj33vn0uyglOFKOBzUSc21jG+H7CREFob0Sopoc7Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEpkVsLfeM80SLXgXa5wUXFfWAmgCkYbUN87oWmNz4+fmrVnQ2DzODrCx4yjuTkNQUPXiv9bBI9bEKB4w7C7DjWZrOWaVhUSZC/6JLhFvMt13i6f3appL/z3PWtDfI1YLtRrd7aX6OUk8JMMCAQiRhBIP4IUeP7jf+HcH5UeoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+WCScYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77235C116C6;
	Wed,  4 Mar 2026 00:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772582726;
	bh=dJj33vn0uyglOFKOBzUSc21jG+H7CREFob0Sopoc7Ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+WCScYgs/78sSR0hSmUT0bOF01jZEHNulnhbIbVo2caJOUGOF910ZmtaqecXg2Pj
	 GdwIUzpuAg2SioSGYH/cfrC5WfwVrECf9l/h2j33tU35u/JJA/FB9CGMgcZL5nH1VF
	 vpETpr/9o2B60vloU6Tyr2dUERkJxGFesrqTIrTzYpW7BkKcXdQJmXmlOUM61836OS
	 juqpa18nAhk5RVZOjZE5VVtHUEGagcPehuzOsFMjAWqB+AM0cE5jvarxnSmhmnrX1G
	 yIW447koQNAshXJANOzDCyZ6/eRPnT5GLkhXYWoO+cGLKUUUSHGokG72Zjwt/sI4u6
	 BTVATapdTc0Ew==
Date: Tue, 3 Mar 2026 16:05:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 2/5] bnxt_en: Resize RSS contexts on channel
 count change
Message-ID: <20260303160524.3e07dbfd@kernel.org>
In-Reply-To: <20260303181535.2671734-3-bjorn@kernel.org>
References: <20260303181535.2671734-1-bjorn@kernel.org>
	<20260303181535.2671734-3-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3406A1F8AC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263481-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue,  3 Mar 2026 19:15:30 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> -	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=3D
> -	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
> -	    netif_is_rxfh_configured(dev)) {
> -		netdev_warn(dev, "RSS table size change required, RSS table entries mu=
st be default to proceed\n");
> -		return -EINVAL;
> +	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=3D bnxt_get_nr_rss_ctxs(bp=
, bp->rx_nr_rings)) {
> +		u32 new_size =3D bnxt_get_nr_rss_ctxs(bp, req_rx_rings) * BNXT_RSS_TAB=
LE_ENTRIES_P5;
> +		u32 old_size =3D bnxt_get_rxfh_indir_size(dev);
> +
> +		/* Validate context 0 can be resized before mutating anything */
> +		if (netif_is_rxfh_configured(dev) &&
> +		    ethtool_rxfh_indir_can_resize(bp->rss_indir_tbl, old_size, new_siz=
e)) {
> +			netdev_warn(dev, "RSS table size change not supported with current in=
direction table\n");
> +			return -EINVAL;
> +		}
> +
> +		rc =3D ethtool_rxfh_contexts_resize_all(dev, new_size);
> +		if (rc)
> +			return rc;
> +
> +		/* All validated; apply context 0 resize */
> +		if (netif_is_rxfh_configured(dev))
> +			ethtool_rxfh_indir_resize(bp->rss_indir_tbl, old_size, new_size);
>  	}
> =20
>  	rc =3D bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp=
);

You resize the tables even if something else fails later on.
I think either this if () should only contain the validation checks,
and the actual resizing has to happen later.
Or you need to "un-resize" (which should never fail so it's fine).

