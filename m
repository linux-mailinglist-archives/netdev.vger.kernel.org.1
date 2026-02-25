Return-Path: <netdev+bounces-260897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI1nEcbenmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:36:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C89519697C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9569302A533
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FAA3624DB;
	Wed, 25 Feb 2026 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LnilUjxh"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96083624B7
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019190; cv=none; b=tCkU59L+rPFCKlr0UuoWHrGcMXrmQJQhnQpVRAyR3fc4gguT+aKtX6mmbicuRGNpMYQrCkTOj90cZnKiVZLFXm/mMxuSrpdeYnQwTCZKjnnNIt9b8DKIrEaZddHMqLxJ3xJX5gH9iAe/vXe/sRm9HqbQa0Pu6Hx3/BKnzCNNoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019190; c=relaxed/simple;
	bh=1vwQ/nMJsLop8N5hvJ/dUKTWBgC7/d4/WbdSYyScdtQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=M0Rv8DNs/A9oHYn9rnZZBw35a9ouXlTHSxKR14ZDthj2v+aWNXrZp0r2tNrjl/Ebh5l5w33naR0gkZlnjWKip2G48G9M5rP53dCKUPpCPedZe36Nb2+uXlh7/X3j2FpTvwXUh5yb/EhC/uVL/OQYyLsx02+0Gw+J2bYoNGrcOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LnilUjxh; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772019181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+lbL37yynnkKGbwipJpDDZmvOkYT+qnsK9JcYSaGTw=;
	b=LnilUjxhTJLE9DX/53E5Ez9QxJzc6UpfeeawPl8/gnZgSp3wG3Akfir638PiCGtA459I/9
	YjyV2PRqywrG89bAY/r0GPbmMRbcDqo7EnrsCAaMxMGZWI4LlUMrvadt/8X4viLKlICZ0I
	5bqtHgWZDyPjwpWyZeVv1DFxOE5h07k=
Date: Wed, 25 Feb 2026 11:32:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <6bc6f7fe686e53fe2aaca467920ccf300546d5bf@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v1] atm: lec: fix null-ptr-deref in
 lec_arp_clear_vccs
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: netdev@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <aZ7V5b5ZplD4B9i1@stanley.mountain>
References: <20260224044648.243578-1-jiayuan.chen@linux.dev>
 <aZ7V5b5ZplD4B9i1@stanley.mountain>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260897-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,72e3ea390c305de0e259];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,appspotmail.com:email,shopee.com:email]
X-Rspamd-Queue-Id: 7C89519697C
X-Rspamd-Action: no action

February 25, 2026 at 18:58, "Dan Carpenter" <dan.carpenter@linaro.org mai=
lto:dan.carpenter@linaro.org?to=3D%22Dan%20Carpenter%22%20%3Cdan.carpente=
r%40linaro.org%3E > wrote:


>=20
>=20On Tue, Feb 24, 2026 at 12:46:38PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20=20
>=20>  syzkaller reported a null-ptr-deref in lec_arp_clear_vccs().
> >  This issue can be easily reproduced using the syzkaller reproducer.
> >=20=20
>=20>  In the ATM LANE (LAN Emulation) module, the same atm_vcc can be sh=
ared by
> >  multiple lec_arp_table entries (e.g., via entry->vcc or entry->recv_=
vcc).
> >  When the underlying VCC is closed, lec_vcc_close() iterates over all
> >  ARP entries and calls lec_arp_clear_vccs() for each matched entry.
> >=20=20
>=20>  For example, when lec_vcc_close() iterates through the hlists in
> >  priv->lec_arp_empty_ones or other ARP tables:
> >=20=20
>=20>  1. In the first iteration, for the first matched ARP entry sharing=
 the VCC,
> >  lec_arp_clear_vccs() frees the associated vpriv (which is vcc->user_=
back)
> >  and sets vcc->user_back to NULL.
> >  2. In the second iteration, for the next matched ARP entry sharing t=
he same
> >  VCC, lec_arp_clear_vccs() is called again. It obtains a NULL vpriv f=
rom
> >  vcc->user_back (via LEC_VCC_PRIV(vcc)) and then attempts to derefere=
nce it
> >  via `vcc->pop =3D vpriv->old_pop`, leading to a null-ptr-deref crash=
.
> >=20=20
>=20>  Fix this by adding a null check for vpriv before dereferencing it.=
 If
> >  vpriv is already NULL, it means the VCC has been cleared by a previo=
us
> >  call, so we can safely skip the cleanup and just clear the entry's
> >  vcc/recv_vcc pointers. Note that the added check is intentional and
> >  necessary to avoid calling vcc_release_async() multiple times on the
> >  same vcc/recv_vcc, not just protecting the kfree().
> >=20=20
>=20>  Reported-by: syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com
> >  Closes: https://lore.kernel.org/all/68c95a83.050a0220.3c6139.0e5c.GA=
E@google.com/T/
> >  Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >  ---
> >  net/atm/lec.c | 27 +++++++++++++++------------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
> >=20=20
>=20>  diff --git a/net/atm/lec.c b/net/atm/lec.c
> >  index afb8d3eb2185..a5b80d6df603 100644
> >  --- a/net/atm/lec.c
> >  +++ b/net/atm/lec.c
> >  @@ -1260,24 +1260,27 @@ static void lec_arp_clear_vccs(struct lec_ar=
p_table *entry)
> >  struct lec_vcc_priv *vpriv =3D LEC_VCC_PRIV(vcc);
> >  struct net_device *dev =3D (struct net_device *)vcc->proto_data;
> >=20=20
>=20>  - vcc->pop =3D vpriv->old_pop;
> >  - if (vpriv->xoff)
> >  - netif_wake_queue(dev);
> >  - kfree(vpriv);
> >  - vcc->user_back =3D NULL;
> >  - vcc->push =3D entry->old_push;
> >  - vcc_release_async(vcc, -EPIPE);
> >  + if (vpriv) {
> >  + vcc->pop =3D vpriv->old_pop;
> >  + if (vpriv->xoff)
> >  + netif_wake_queue(dev);
> >  + kfree(vpriv);
> >  + vcc->user_back =3D NULL;
> >  + vcc->push =3D entry->old_push;
> >  + vcc_release_async(vcc, -EPIPE);
> >  + }
> >  entry->vcc =3D NULL;
> >  }
> >  if (entry->recv_vcc) {
> >  struct atm_vcc *vcc =3D entry->recv_vcc;
> >  struct lec_vcc_priv *vpriv =3D LEC_VCC_PRIV(vcc);
> >=20=20
>=20>  - kfree(vpriv);
> >  - vcc->user_back =3D NULL;
> >  -
> >  - entry->recv_vcc->push =3D entry->old_recv_push;
> >  - vcc_release_async(entry->recv_vcc, -EPIPE);
> >  + if (vpriv) {
> >  + kfree(vpriv);
> >  + vcc->user_back =3D NULL;
> >  + vcc->push =3D entry->old_recv_push;
> >  + vcc_release_async(vcc, -EPIPE);
> >=20
>=20I wasn't going say anything, but since it seems like maybe you're goi=
ng
> to redo this patch anyway. Changing "entry->recv_vcc->push" to
> "vcc->push" is obviously nice but could you do that in a separate
> patch?
>=20
>=20I use a tool to strip out the indenting changes:
> https://github.com/error27/rename_rev
>=20
>=20So when I review a patch like this, I want to pipe it to my script an=
d
> just see:
>=20
>=20+ if (vpriv) {
>  vcc->pop =3D vpriv->old_pop;
>  if (vpriv->xoff)
>  netif_wake_queue(dev);
>  kfree(vpriv);
>  vcc->user_back =3D NULL;
>  vcc->push =3D entry->old_push;
>  vcc_release_async(vcc, -EPIPE);
> + }
>  entry->vcc =3D NULL;
>  }
>  if (entry->recv_vcc) {
>  struct atm_vcc *vcc =3D entry->recv_vcc;
>  struct lec_vcc_priv *vpriv =3D LEC_VCC_PRIV(vcc);
>=20
>=20+ if (vpriv) {
>  kfree(vpriv);
>  vcc->user_back =3D NULL;
>=20
>=20 entry->recv_vcc->push =3D entry->old_recv_push;
>  vcc_release_async(entry->recv_vcc, -EPIPE);
> + }
>=20
>=20The renames are nice but now I have to check things by hand.



Hi Dan,

Thanks for the review. You're right, the entry->recv_vcc->push to vcc->pu=
sh rename should not be mixed into the bug fix patch.

I think I should only adds the if (vpriv) guards without any other change=
s.

I'll drop the cleanup rename entirely since this is legacy code and not w=
orth a separate patch.

Best,
Jiayuan

> regards,
> dan carpenter
>

