Return-Path: <netdev+bounces-256519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOKqEoqugmliYAMAu9opvQ
	(envelope-from <netdev+bounces-256519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:27:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D900AE0D5D
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D8A030268E9
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F128853A;
	Wed,  4 Feb 2026 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GfbnYhey"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AA272E6A
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172038; cv=none; b=Z1JAoMis2Bo258W3S78XC4/kJoyvVwyFClDc2LffHhEnp7nswyW4CLrYaK54uliU12RLbPy3+yD4DyiNEV6xaImZvyWUCD3VlT93kf4zI2/VFOR/KrnLb4nbde+HtfyMV0DCNrhdSoTDsjGflM/SMp+ZtQwY+QL2gWsFZmOZARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172038; c=relaxed/simple;
	bh=eMjdcO6WEUJaANcvfNBEjOv+3qT7BlPDF3beudvM02A=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DaxlUUhoMlI3463nB+sEjQ1QvaijrxuAGviQvrKIvtQNEDK5snSn38Zl9LlSe02kubtGzIDWdBlwXZWdwBmJY5wd+K5WWB+6dt4x9xujsU1oLnY/Uefk0gKoP4vsqK8kyvLH88/AWj8jJcfoerJLxVArExipFoyaSVAe+OKwSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GfbnYhey; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770172035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voRhHdv8SbG/gEkcRiC7sWssgtqh8oKxge1QYhttiFI=;
	b=GfbnYhey3f3hzO+LvLUCNngmoCp3hAffSx91HZ199qbHUag2/X8zt6Z2qXL6UApbWGuv8C
	0B9wJuhuD5md64M+07wErc24J+JmAI/cXQbWV1bbyMzB3I4KqZ/zbZ85uJYeMJVIY3eHIh
	2LvI6eMnYOQpcJMYXp0wUSflmJ8cGqA=
Date: Wed, 04 Feb 2026 02:27:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <985568ea543b05f52c453427a6125200bcff0aaf@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v1] icmp: fix ip_rt_bug race in
 icmp_route_lookup reverse path
To: "David Ahern" <dsahern@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
In-Reply-To: <1cbd0d2e-2002-4685-99eb-97dd8947cf16@kernel.org>
References: <20260128090523.356953-1-jiayuan.chen@linux.dev>
 <892557d1-9408-40e3-8e79-587713116b93@redhat.com>
 <1cbd0d2e-2002-4685-99eb-97dd8947cf16@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256519-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e738404dcd14b620923c];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D900AE0D5D
X-Rspamd-Action: no action

February 4, 2026 at 24:24, "David Ahern" <dsahern@kernel.org mailto:dsahe=
rn@kernel.org?to=3D%22David%20Ahern%22%20%3Cdsahern%40kernel.org%3E > wro=
te:


>=20
>=20On 2/3/26 3:41 AM, Paolo Abeni wrote:
>=20
>=20>=20
>=20> On 1/28/26 10:05 AM, Jiayuan Chen wrote:
> >=20
>=20> >=20
>=20> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > >  index 19c9c838967f..dc9dcc799824 100644
> > >  --- a/net/ipv4/icmp.c
> > >  +++ b/net/ipv4/icmp.c
> > >  @@ -559,6 +559,23 @@ static struct rtable *icmp_route_lookup(struc=
t net *net, struct flowi4 *fl4,
> > >  /* steal dst entry from skb_in, don't drop refcnt */
> > >  skb_dstref_steal(skb_in);
> > >  skb_dstref_restore(skb_in, orefdst);
> > >  +
> > >  + /*
> > >  + * At this point, fl4_dec.daddr should NOT be local (we
> > >  + * checked fl4_dec.saddr above). However, a race condition
> > >  + * may occur if the address is added to the interface
> > >  + * concurrently. In that case, ip_route_input() returns a
> > >  + * LOCAL route with dst.output=3Dip_rt_bug, which must not
> > >  + * be used for output.
> > >  + */
> > >  + if (!err && rt2 && rt2->rt_type =3D=3D RTN_LOCAL) {
> > >  + net_warn_ratelimited("%s: detected local route for %pI4 "
> > >  + "during ICMP error handling (src %pI4), "
> > >  + "possible address race\n",
> > >  + __func__, &fl4_dec.daddr, &fl4_dec.saddr);
> > >=20
>=20>=20=20
>=20>  The fix looks correct to me, but this patch should target the 'net=
' tree
> >  and the above warning message is a bit off: the text string should n=
ot
> >  be broken to fit the 80 chars limit - it need to be greepable - it's
> >  probably better to not include the function name.
> >=20=20
>=20>  /P
> >=20
>=20Does the message even provide value? There is nothing a user can do
> about it.
>

Hi Paolo, David,

Thanks for the review.

Paolo, I'll fix it in newer version.

Regarding David's question about whether the message provides value:
I think it could still be useful for debugging. If a user's configuration
change causes ICMP packets to be silently dropped, there's currently no c=
ounter
or indication of what happened. Adding a dedicated counter for this rare =
race
condition seems overkill, so a rate-limited warning at least gives some v=
isibility
into the failure.

That said, I'm open to dropping the message entirely if you both think si=
lent handling
is preferred. Let me know and I'll send a new version either way.

Thanks,
Jiayuan

