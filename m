Return-Path: <netdev+bounces-257232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBqiHqe5hGnG4wMAu9opvQ
	(envelope-from <netdev+bounces-257232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:39:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12191F4AE8
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 750BF300381A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE5410D3B;
	Thu,  5 Feb 2026 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvIsPqHl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA0219A71;
	Thu,  5 Feb 2026 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305955; cv=none; b=I6S0YGF2hCN3t2zKIuQ0p2cUpcJQC4TFSIFvr4L1WNLmA3QN7xvgqQ60wzdW4wOVyfvDcAgz5hZuRNg+mmGARuKGeUjaqoyT3TgDg6CevfeNl1uPoG3TUvpmBfQjLd4ZqE/TLEny7krTQaNrZ9+QP0tcz2cinOdptHDQq5+HilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305955; c=relaxed/simple;
	bh=S0C0ObLPyX+j08Utb4Ec6O2Bcs5xrgBKqKpna3VNht0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jvw/UptpQ2GzfYsvNc3W1hMz1i8wXIzvfzSzqS5EpxmhgXByZizgR3FGINn0qkmSEqrZvRFEn9L1VbqhXhKv4R6/WUgyTMVnH4tPKUzBqzrfsJ3ak68vJ7W37PzuKtA0ik0k4DDEFAG56fG3sYIcfWEdB5peA0utxGNVmbesMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvIsPqHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8ACC4CEF7;
	Thu,  5 Feb 2026 15:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770305954;
	bh=S0C0ObLPyX+j08Utb4Ec6O2Bcs5xrgBKqKpna3VNht0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fvIsPqHloGJhbA6IQAOHhQpaek54TtK7r3R8ISM0LT/tG+Cz7C6DExd3oZCh7KZ2Q
	 tjnAB6NgDcEOng/FR3+K80t3diy9sPg6A75dj/L9HzdS4ycfjUxq9IZLVRB/JptdAZ
	 tz6RQx+B/uWyDOXNm5G+UqP28G3vzQ+nNpFpvjipCXTcZfdBgpo0zYcTG3WdTukfFA
	 W5fIeBE0xwAe7LPDJHe3CPxxjZyqnWTeOhhCVYP94TPn5ItVg022JRNdzpyAtB/iJr
	 wseTgGCbLLFRoEyE86s/o1MVz8bUdKOqRbNbq+4NBtrIZMGYX4pIbXeErX3Vlwnuxy
	 3wEuPYFxHa/5A==
Date: Thu, 5 Feb 2026 07:39:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: dsa: yt921x: Use u64_stats_t for MIB
 stats
Message-ID: <20260205073913.1859434a@kernel.org>
In-Reply-To: <CAAXyoMNUSQXNCdzLWNimvu7TPV8+60GVcQASFCS2-N3d9MAmsg@mail.gmail.com>
References: <20260203171305.95085-1-mmyangfl@gmail.com>
	<20260203171305.95085-4-mmyangfl@gmail.com>
	<20260204211252.71b8fa86@kernel.org>
	<CAAXyoMNUSQXNCdzLWNimvu7TPV8+60GVcQASFCS2-N3d9MAmsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257232-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
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
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12191F4AE8
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 13:32:29 +0800 David Yang wrote:
> On Thu, Feb 5, 2026 at 1:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed,  4 Feb 2026 01:12:43 +0800 David Yang wrote: =20
> > > 64-bit variables might not be atomic on 32-bit architectures, thus
> > > cannot be unconditionally made lock-free. Use u64_stats_t so it would
> > > still be lock-free on 64-bit architectures. =20
> >
> > IDK why we need to worry about lock free reading of those 64b values...
> > =20
> > > @@ -771,22 +785,27 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch =
*ds, int port, uint64_t *data)
> > >       struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > >       struct yt921x_port *pp =3D &priv->ports[port];
> > >       struct yt921x_mib *mib =3D &pp->mib;
> > > +     unsigned int start;
> > >       size_t j;
> > >
> > >       mutex_lock(&priv->reg_lock);
> > >       yt921x_read_mib(priv, port);
> > >       mutex_unlock(&priv->reg_lock); =20
> >
> > ..when in all(?) the readers converted by this patch we take the mutex
> > to refresh the stats anyway. And presumably do expensive IO/reg reads
> > under that mutex. So just extend the mutex over the read section and
> > save us the retry logic, please, it will make no difference to perf. =20
>=20
> .get_stats64() is atomic, that's why everyone (mostly) is using
> u64_stats_t for DSA stats.

I understand, but only ndo_get_stats64() is, all the other cases like
ethtool stats can keep holding the lock and use u64 / u64_stats_read()
without a retry.

I had this argument with people before, I don't get why people try to
microoptimize device stats so much. The u64_stats* infra is really meant
for per-CPU/per-queue software stats which must have low overhead.

