Return-Path: <netdev+bounces-265105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMB9Gx/Lq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:52:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D25A22A836
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DA59304503E
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6025E371CFC;
	Sat,  7 Mar 2026 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtH8j8tC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7582EFDAF
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772866328; cv=none; b=Q7EchyrLOb1K0BcGzpZUU0WK5TgxPX5IBtAN6OLNRyPAOjF0j1Ac1tjQyf2JuvqhrtMeZtx5Ft6u8ZsUtcSegyMOWYlA/t0srK6784qLoeYRcMS5x2wW80cmKyKzO2QJMknIHeQg7/m3tG4t9VLyU9lm+4aAukvI5uD57cV838U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772866328; c=relaxed/simple;
	bh=OSlsQQWRjXkI+YDZisZnzLyIrzjF4TUkIjjQ32hcJjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcM9iK4OW1IudUxZXZ42CwVFSFbixjA9Bp6em4QxAdKSw5BJ4mMvwVxRBWxmWp0H0L+C1Wqgbfy/hlGDYdBuNoR9jA1ebh+1/gBzxO101zYVXcA5zugQc+NbNx9Nn7rMhRQEsPcMlU09xat2G6o19/NivveTeyx6AQ2hp7m6MwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtH8j8tC; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-128b9b7e3edso756249c88.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772866326; x=1773471126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSlsQQWRjXkI+YDZisZnzLyIrzjF4TUkIjjQ32hcJjc=;
        b=YtH8j8tCo1phwnu4oupZthFV9Mr03pS0ECHMow+nbiHu6BQ1N1MZ8gDRWKJA+LqRPy
         NtJ/iugaaEJKLdZwPuUrRGhOqdegeXkzWrZqvesEP8ABDBpc8siWabtx/pwP6A2nn0L3
         C1R0azsyseTlSaaEE5+VvW21BjLLRAeLH4qgj3fIf+AuLwYLcjPQX7S5LF6vFUCDuS1z
         NmErZExCeqw68QxY+62gZeyqrDQUg4TGou04qy7P67HTmWD0masB950USJFsxfgFmM2n
         iLsRinnq+3iWGFd25Szaexd8nxLSbZ4ct1IC8oxpNJAEGbZJKxmLgWzLbLQAcvoWmbEM
         9vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772866326; x=1773471126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSlsQQWRjXkI+YDZisZnzLyIrzjF4TUkIjjQ32hcJjc=;
        b=bxcrprNJEBYz51/UPWkp2dMw0iTSGrZRil01Bl/8jaQ5MY7a5osvcWH720kiECHj8N
         C8hBGwtjqz8PGArjwgsjNpfavVHRFtolZuzWzHiT61plKCTuvbcU6sWlGJu1U1fKdP02
         I4zNMYECKdDxl1ZPIiyCETfKXJv1JBNELGJu2DqWCB6wF57hJRnCFQjRJR3u9VclO1Pf
         5Fb9D6IKsapgxbKgOOKhHFlHavE3rNjfb1l+IeAJAtvNkD2JFqmNboNDgWEYX0uCoVs9
         z15FnLF+7mXa+4MsoL3RitxvOdfFqQmZc0Fsyc4lNyY8SF0kvB+sYKV3eeVIujnl2nSM
         nsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXykKYsYCBvtifGRV0EnJ6TuT4vrr9fnj+dmBhHqjmGZduUSPVlvkfbjmM1kIIKxb6A/Jq8QSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZVbOIGFkIf1lEVOQ6ADgPeVttQJPPQw796EBXDjjWT72DcrC
	kpFXFv3llhhJBLomm11JC0n/LrxNNKs1HEPf9QlV0KAo6Btl1c1+VvsP
X-Gm-Gg: ATEYQzw2+cNVsNIocX4RGigwcBfWkpdKihoSMgYPBTEH0UTUTiqRJtijSTcMeI9RbQt
	5l4RKq90EKGrOpzhhgF7UhKNMkHtvbVDg4L1b6AgbzN2/p0Oy3cgaJqsFWOr+VbyQ0poxVJXA0e
	LaNX9Z5oBa8Kzep6mhLtDCSpVAS1XUXluwbeBEZ0WJSzjKQXBbLEJZqEkjy9T2NZ61669hWaCl1
	jTFtqXtsJDt2tWECmjPxgFSiszNmxGZyDVUYK/nVSDmy6DZCTo3+crry4WmusX6k/YTaUUHejut
	oq8JY1dQF1bYm9efEYZLIG0DJs6IP0L5tFGGLc2AxOO4TJYa3+j1yNw7quE5Yew3BijJfWfgX9V
	B/De2cgBQgY+EEpAs8ewGgwlO/4WVlmchhuFnX56z9vYayqC1CM/K+10ddOJgAoKMSq0orqLY5Y
	KVN6Nue/ulPINKUpHSkxT8Qr2jgC6qBg==
X-Received: by 2002:a05:7022:eacd:b0:11a:641f:ba11 with SMTP id a92af1059eb24-128c2e99683mr2189023c88.29.1772866325632;
        Fri, 06 Mar 2026 22:52:05 -0800 (PST)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f58d24sm3227281c88.12.2026.03.06.22.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:52:04 -0800 (PST)
Date: Sat, 7 Mar 2026 14:51:57 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, claudiu.beznea@tuxon.dev, davem@davemloft.net,
	stable@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
	nicolas.ferre@microchip.com, quanyang.wang@windriver.com
Subject: Re: [net] net: macb: Shuffle the tx ring before enabling tx
Message-ID: <aavLDcBS5F6qCydY@pek-khao-d3>
References: <20260305-zynqmp-v1-1-5de72254d56b@gmail.com>
 <20260307025638.1345906-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VsGoh7P8rs3RZGT3"
Content-Disposition: inline
In-Reply-To: <20260307025638.1345906-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 3D25A22A836
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265105-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.943];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--VsGoh7P8rs3RZGT3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 06:56:38PM -0800, Jakub Kicinski wrote:
> Does this memcpy corrupt the descriptor fields on systems with 64-bit DMA?
> The macb_tx_desc() macro uses macb_adj_dma_desc_idx() to properly space t=
he
> descriptor pointers in the ring according to the descriptor size reported=
 by
> macb_dma_desc_get_size(bp), which can be 8 bytes (base), 16 bytes (with
> DMA64), or 24 bytes (with DMA64 + PTP). However, all three memcpy calls in
> this function use sizeof(struct macb_dma_desc), which is only 8 bytes and
> covers only the addr and ctrl fields.
>=20
> On systems where macb_dma64(bp) =3D=3D true, such as the AMD ZynqMp platf=
orm
> this patch targets, each descriptor has an additional macb_dma_desc_64
> struct containing the upper 32 bits of the DMA address (addrh field).
>=20
> When the shuffle copies descriptors using only 8 bytes, it moves the lower
> 32-bit address (desc->addr) and control word (desc->ctrl) to new positions
> but leaves the upper 32-bit address (addrh) unmoved in the old location.
> After the shuffle, hardware reads a composite 64-bit DMA address from
> mismatched descriptor slots: the old slot's addrh combined with the new
> slot's addr.

This is indeed an issue. Coincidentally, all the upper 32-bit addresses in =
the
tx ring were identical, which is why it went undetected during testing.
My apologies for this oversight; I will address it in the v2 version.

Thanks,
Kevin

--VsGoh7P8rs3RZGT3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmryw0ACgkQk1jtMN6u
sXFV0wgAsfpO8R4Jx2xyazjRDjOh9ZH+gKN6Pc5SffFo6Oeg++2QZrs/D83ISecM
6z9OqYyrqiImNKWdQs2HUUwbYQCpZvVcl2EsXOxQW7tLjDgJQ63N2/yjTzwzKp+k
zTdfgLAi4daT8qclVg6HeRf9/JGUDDS6MczCPbelIg4o62diwfIdqDejInFadIfy
rewx4WDupImCf7iFwW3dUw+suwTAXTeE91WfOp+WVOj0BFiSdi4MRpQNaJX7jRks
dxQXV+fVm/hQlPh7tbT20+ZVoNyAy7bckL5QPVgOJAKxO1e80Vo9iuZCnQaQVa2k
6ovaRtd7BJ9s+0b6lM/ZntqB9p8UYA==
=7dPx
-----END PGP SIGNATURE-----

--VsGoh7P8rs3RZGT3--

