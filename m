Return-Path: <netdev+bounces-267259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N6cIslns2n4VwAAu9opvQ
	(envelope-from <netdev+bounces-267259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:26:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7828927C403
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33A883020987
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9FA30FC0F;
	Fri, 13 Mar 2026 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF/ux1kR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB4515665C;
	Fri, 13 Mar 2026 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773365186; cv=none; b=Os9nVoEShxD/OloaSkaX4zTiM6aKsasLtqgbbxmWvi6HITQcnYL6xh4d4Xyh4LQZUrKLvm6wGkVIhDiYWXWfYluYQvJ7GtuaHfB17L+Y9j31repeVsCLbCeCQutUqXyMRWmbXeTnQiQeGp2IP0UdGbXG4XAerVTiwkFcrhLT6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773365186; c=relaxed/simple;
	bh=A0p2jxel/JETw3n9wkczrAKboIOxLVVeNZqXqszB5W0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhSfobmSfqZNtlb518TgVXDgtpYxt/lbDp0b+APJYiJtXzuktanvU/Mac8FtFvdP//udb+VRUsp6raCHCWSGaLTiYoHn4KWkmq0GEyHWm/aefNIdVhl78CsIHwB6RqOMYG2FCIZrD/iabK3cS0Amx3psXwYFsfu8/MozxLY4sc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF/ux1kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6927EC4CEF7;
	Fri, 13 Mar 2026 01:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773365186;
	bh=A0p2jxel/JETw3n9wkczrAKboIOxLVVeNZqXqszB5W0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dF/ux1kRQUDskY3gzUG8P6Jalaovu+zTEQBNaPYRc9WemYa/yIbroD6rQKQYIDkYP
	 3DqVsGk2lMcskBmHaOtFexGrMp5hEAOEzoBq4VWWSJVWxfZ6+tVrDjOCrv90AoqHx0
	 Zeh3rJ7HeIgHQwWMaxEAgviuWJcqTjlYZRmG3h3Qb/JsuwHH6HvdO4/EWYFKzUF8JS
	 t88EXAHo1A2SApQm372agFvWQjWmHwFecJQlYXHgu6aZuWpw47mY3hNTg6TRqJjnjA
	 mKcn8myTBBMkXJtpxi5AcA0Piax7hYhkzfy2llLQLjrfvPxXs/W3MJfR4lb9Ned180
	 fOIxI17VsKeRg==
Date: Thu, 12 Mar 2026 18:26:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Paolo Valerio
 <pvalerio@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Message-ID: <20260312182624.35ab61c8@kernel.org>
In-Reply-To: <20260311-macb-set-channels-v2-1-982693a1f5fc@bootlin.com>
References: <20260311-macb-set-channels-v2-0-982693a1f5fc@bootlin.com>
	<20260311-macb-set-channels-v2-1-982693a1f5fc@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267259-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7828927C403
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 17:41:53 +0100 Th=C3=A9o Lebrun wrote:
> +	struct macb *bp =3D netdev_priv(netdev);
> +	unsigned int old_count =3D bp->num_queues;
> +	unsigned int count =3D ch->combined_count;
> +	int ret =3D 0;

unnecessary init

> +	/*
> +	 * MACB_CAPS_QUEUE_DISABLE means that the field QUEUE_DISABLE/BIT0 in
> +	 * the per-queue RBQP register disables queue Rx. If we don't have that
> +	 * capability we can have multiple queues but we must always run with
> +	 * all enabled.
> +	 */
> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * An ideal .set_channels() implementation uses upfront allocated
> +	 * resources and swaps them in, bringing reliability under memory
> +	 * pressure. However, here we implement it for memory savings in
> +	 * setups with less than max number of queues active.
> +	 *
> +	 * Signal it by refusing .set_channels() once interface is opened.
> +	 */
> +	if (netif_running(bp->dev))
> +		return -EBUSY;
> +
> +	if (count =3D=3D old_count)
> +		return 0;

should we reorder this with the running() check?

