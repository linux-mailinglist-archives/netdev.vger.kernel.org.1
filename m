Return-Path: <netdev+bounces-295384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FgbPC8DCIWqYNAEAu9opvQ
	(envelope-from <netdev+bounces-295384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:24:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB647642914
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:23:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hO0SlOKj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295384-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295384-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FF4E300B9D6
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B7B37DEA2;
	Thu,  4 Jun 2026 18:23:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C137756A;
	Thu,  4 Jun 2026 18:23:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597435; cv=none; b=XleUVEBnHEz1ZUMCaZShljh8eJalMBlU+eRfUE+TpKOHstvlJN8AFaX+v3d6SUnWRDAOYTSYaFFy2C+tPc16v9sRBEhcw4lKiIM82d4q1stj129I+l4OdRD+xL9H+W9hH7hLRDy7i4HU0UnmopuXibHNHxGLAnzunfAWl2+XtGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597435; c=relaxed/simple;
	bh=pGtTQ1nRJrXsADjKTyySvsM8esEGkc62Z/YtTz6xNMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZGx41Blg5LYdXkqeKOLHJ662LlV2mbtXXesOEji9WrTuwDXsDog4DZfs/dzzn3grAz9FBL9RV1SIHvk20AV+8+Ker7d8H73UL2hHBQYqfRZNtyaDWIwX+cvDnNz3NgEO3qoje5HiZYdagisBEGruepg28yW+tf8pxt+Hs3LqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO0SlOKj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D0D1F00893;
	Thu,  4 Jun 2026 18:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780597434;
	bh=80uocEmUJUWe0hTmvDEEnqw3lpr0z/qKcDt/C1xeVCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hO0SlOKjJgwZcSRvhKoiznzeSfU3Vt29JSFbKkvdVhgEXjD+fxjY6JGuLXeCVrjg/
	 Wh7hkb9+O6TRd8NKJpvPrfK+nrtZLdge+VjFIfJW/IwFLTtKjZPmvGqxC7PnBYKnzi
	 j8w5Ac4sA6ZDXmru4+pHlKR2GsjEfm3rPCLMhH2dClr+JusMSf2748j/UJJ+xIgd6F
	 u1QbD0Cu1sQuPRkYo4bNdhdSffCueRYvHbXAvBYaDPQlr1j/QSfSK31IGnKuAF5rW7
	 GfUbDz03JkCyFTnCglWd5IKdJHhYdr3HLZxjyUtfibhVka6I1nx8E/uinPFM4UmSg6
	 QcmOf6e8gGIbA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5ABB57BB315; Thu, 04 Jun 2026 20:23:51 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Ralf Lici <ralf@mandelbit.com>, netdev@vger.kernel.org
Cc: Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>, Ralf Lici
 <ralf@mandelbit.com>,
 Antonio Quartulli <antonio@mandelbit.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and
 dispatch core
In-Reply-To: <20260319151230.655687-9-ralf@mandelbit.com>
References: <20260319151230.655687-1-ralf@mandelbit.com>
 <20260319151230.655687-9-ralf@mandelbit.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 04 Jun 2026 20:23:51 +0200
Message-ID: <87a4tab1vs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.43 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295384-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[toke@kernel.org,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[toke@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ralf@mandelbit.com,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,toke.dk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB647642914

Ralf Lici <ralf@mandelbit.com> writes:

> This commit introduces the core start_xmit processing flow: validate,
> select action, translate, and forward. It centralizes action resolution
> in the dispatch layer and keeps per-direction translation logic separate
> from device glue. The result is a single data-path entry point with
> explicit control over drop/forward/emit behavior.
>
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>

This is very cool! Going quickly through the series, this seems like
thorough work that will be cool to have available in the kernel, so
thanks for doing this! I'll be quite happy to retire my barebones
BPF-based implementation once this lands :)

One comment on the device model below (which is also why I chose this
patch to reply to):

> +static void ipxlat_forward_pkt(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
> +{
> +	const unsigned int len = skb->len;
> +	int err;
> +
> +	/* reinject as a fresh packet with scrubbed metadata */
> +	skb_set_queue_mapping(skb, 0);
> +	skb_scrub_packet(skb, false);
> +
> +	err = gro_cells_receive(&ipxlat->gro_cells, skb);

So given that you're not resetting skb->dev here, IIUC, this means that
the translated packet will magically re-appear as if it arrived on the
interface it first came in on, right?

That seems... a bit too magical? Sending a packet to one device making
it suddenly reappear on a different, unrelated, device seems like it
will just create confusion. It's like the ipxlat device can't really
device if it's a device or a tunnel? :)

I think a better model is to treat the device as basically a loopback
device that translates packets before looping them back (so when they
come back they appear to be coming from that device).

Any reason why that wouldn't work?

-Toke

