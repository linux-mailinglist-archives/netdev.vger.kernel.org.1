Return-Path: <netdev+bounces-278091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGuKOt713GlaYgkAu9opvQ
	(envelope-from <netdev+bounces-278091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:55:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C573ECCC9
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 740753047BDF
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBE13CE498;
	Mon, 13 Apr 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPMnnPu+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0593CBE7F;
	Mon, 13 Apr 2026 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776088206; cv=none; b=thje7gbfKwYPRYBMGEUj10qVCBNuDPTTrSyiitmS48bnAR/+0qUfm5fnz5S/euxoZKYNDGFZoklmbmdmwCMmkyLk7+hvwoASu5fMP2J9jyp2g3rj51F38GueyAo3z9YZyEp+FLhvCFnERcoMkqwtHNyl9ts6kS/Tc4iaBJrvR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776088206; c=relaxed/simple;
	bh=n8P3A32iXXPyddzyRWIf+p2tfoJTjQMl42WD08TiDec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fsdenVMU6BawA18gmPM1UFAs/3JERcq34mpVt+/EWUoT0ZU5NcEQsyOaLUR3DMrlg1EqoXwHiIR1pPUiTJAQ9Nsw47OsJWSlGjf0eI7fGDTV1fziHCkvAWJ9INeMvysdy8qZ1XtQPGmCm4Zz0Ot5rz3yspKs/ehsETPU95xVyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPMnnPu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3937C2BCAF;
	Mon, 13 Apr 2026 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776088205;
	bh=n8P3A32iXXPyddzyRWIf+p2tfoJTjQMl42WD08TiDec=;
	h=Date:From:To:Cc:Subject:From;
	b=SPMnnPu+KFgnbN4kGmap74UGpXGQhCWGlhjkmHYTINUlYRAOE3Y68L53ZhrLJrzU6
	 /M6hKOgi4JobvRhLc8gM98h6zlA5Kf8oRYOH+pLvmT24OSC5bb43vygGihAK8mW2J1
	 Ps5618MW5tlNZMgLmHDeCBlzsHhlmqNP3fgIYtUkeQ1NPODvFq8MXECm7Z4pUecZJk
	 qf2NXvtk4KUjmR3yA5NENWg3pmr58D55lqrH0woWdJ/oClBmQXMgxB8ja4B/Qdit8g
	 /uu8/mcL/eYXXUxym+R0uL8DYvlppvYo1MTERQEvy42TY6mz7BfaQE9RpLDRJ1h1zB
	 0fluUaJubg6LQ==
Date: Mon, 13 Apr 2026 14:50:01 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <adz0iX85FHMz0HdO@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Es3unqQZqdMSnSa"
Content-Disposition: inline
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278091-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97C573ECCC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--5Es3unqQZqdMSnSa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/net/sch_generic.h

between commit:

  a6bd339dbb351 ("net_sched: fix skb memory leak in deferred qdisc drops")

=66rom the net tree and commit:

  ff2998f29f390 ("net: sched: introduce qdisc-specific drop reason tracing")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/net/sch_generic.h
index 5fc0b1ebaf25c,5af262ec4bbd2..0000000000000
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@@ -1168,24 -1185,14 +1185,24 @@@ static inline void tcf_kfree_skb_list(s
  }
 =20
  static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *sk=
b,
- 				      enum skb_drop_reason reason)
+ 				      enum qdisc_drop_reason reason)
  {
 +	struct Qdisc *root;
 +
  	DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
  	DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);
 =20
 -	tcf_set_qdisc_drop_reason(skb, reason);
 -	skb->next =3D q->to_free;
 -	q->to_free =3D skb;
 +	rcu_read_lock();
 +	root =3D qdisc_root_sleeping(q);
 +
 +	if (root->flags & TCQ_F_DEQUEUE_DROPS) {
- 		tcf_set_drop_reason(skb, reason);
++		tcf_set_qdisc_drop_reason(skb, reason);
 +		skb->next =3D root->to_free;
 +		root->to_free =3D skb;
 +	} else {
 +		kfree_skb_reason(skb, (enum skb_drop_reason)reason);
 +	}
 +	rcu_read_unlock();
  }
 =20
  /* Instead of calling kfree_skb() while root qdisc lock is held,

--5Es3unqQZqdMSnSa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnc9IgACgkQJNaLcl1U
h9C82wf+P9SVV2/sIdIzprm0vC6tWkuVwbD1a56lnRW7HF4SfZZqL1OgtnNHgpl/
+qo+ef4oWU41OQz8NQjJRydh3KRyD65AD8VtBK6j9+rzOLTxxVnZdbAJP269IDb5
u/VOx3EQRPTlPYyCYUMa9ooGTYk4rhBId9HONknjh4nldo3kGm80wdQUDVW3WObg
N70W4EPrdhefdRaN9goz35t8Zk9nlPq01vZShHjlmbflckbbIhLZRK1bqlh4A5VX
iTCM/4xz3QAXbK+2oEks17UAFj7h3kkeQNGU0ocZyoR0nC5f6lu4vB6NChaz/KMW
yC+VBqWl+ewgxZjnSjn8chtW24KOhA==
=2NSp
-----END PGP SIGNATURE-----

--5Es3unqQZqdMSnSa--

