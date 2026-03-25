Return-Path: <netdev+bounces-271507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC3CIvPXw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:41:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC5C3250CC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E94E30265A8
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0A93D0901;
	Wed, 25 Mar 2026 12:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016433CFF67
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440137; cv=none; b=dXhA+9PzdKbutemVVM9bjzQ2u4VU1kbxepZSUdZzpK68RjEz/qlJtHf5Ty3Vq7SJze/YUk8Bl0q5sDb8wNRMTOocDihvmiwHNIkPOcehQqM2d4tbuknCIJXj8gQhMBUng7SmUAX5AXlUk9FpxSujO/vnqFYprbB1T7abNTT7idA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440137; c=relaxed/simple;
	bh=LAzwV+uatUh0X9rTiAYyoir7e3/mrBctRhn/dY1F0WY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ucVg67PYOMshe4XD9xzvaXLO+17aLT7ZLKyr/nFJ2W6nc3Qgp/GCr8W6Hq0Inh5lXJTDnupIFpaBr5LaE2ox3kJRLGtyY4K7uXdra/pM7gz7B9ww+1N928SyEUuKUHDldA9EBQZJ7bZSGq2vMTat2KG7PZvuIOkSn6QSyDP++Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1w5Mw4-001mXr-03;
	Wed, 25 Mar 2026 12:02:06 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1w5Mw1-00000004ZzQ-0ACk;
	Wed, 25 Mar 2026 13:02:05 +0100
Message-ID: <cfbb231e80caceb4138e37d036de7dca39ec7e7b.camel@decadent.org.uk>
Subject: Re: [PATCH net v2] net: consume xmit errors of GSO frames
From: Ben Hutchings <ben@decadent.org.uk>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, hawk@kernel.org, 
	alexander.h.duyck@intel.com
Date: Wed, 25 Mar 2026 13:01:59 +0100
In-Reply-To: <20260223235100.108939-1-kuba@kernel.org>
References: <20260223235100.108939-1-kuba@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6feKlbHddn688k8u0jsx"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DMARC_NA(0.00)[decadent.org.uk];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271507-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,decadent.org.uk:mid]
X-Rspamd-Queue-Id: 1DC5C3250CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-6feKlbHddn688k8u0jsx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-02-23 at 15:51 -0800, Jakub Kicinski wrote:
[...]
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4822,6 +4822,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct ne=
t_device *sb_dev)
>  		 * to -1 or to their cpu id, but not to our id.
>  		 */
>  		if (READ_ONCE(txq->xmit_lock_owner) !=3D cpu) {
> +			bool is_list =3D false;
> +
>  			if (dev_xmit_recursion())
>  				goto recursion_alert;
> =20
> @@ -4832,17 +4834,28 @@ int __dev_queue_xmit(struct sk_buff *skb, struct =
net_device *sb_dev)
>  			HARD_TX_LOCK(dev, txq, cpu);
> =20
>  			if (!netif_xmit_stopped(txq)) {
> +				is_list =3D !!skb->next;
> +
>  				dev_xmit_recursion_inc();
>  				skb =3D dev_hard_start_xmit(skb, dev, txq, &rc);
>  				dev_xmit_recursion_dec();
> -				if (dev_xmit_complete(rc)) {
> -					HARD_TX_UNLOCK(dev, txq);
> -					goto out;
> -				}
> +
> +				/* GSO segments a single SKB into
> +				 * a list of frames. TCP expects error
> +				 * to mean none of the data was sent.
> +				 */
> +				if (is_list)
> +					rc =3D NETDEV_TX_OK;
>  			}
>  			HARD_TX_UNLOCK(dev, txq);
> +			if (!skb) /* xmit completed */
> +				goto out;
> +
>  			net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
>  					     dev->name);
> +			/* NETDEV_TX_BUSY or queue was stopped */
> +			if (!is_list)
> +				rc =3D -ENETDOWN;
>  		} else {
>  			/* Recursion is detected! It is possible,
>  			 * unfortunately
> @@ -4850,10 +4863,10 @@ int __dev_queue_xmit(struct sk_buff *skb, struct =
net_device *sb_dev)
>  recursion_alert:
>  			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently=
!\n",
>  					     dev->name);
> +			rc =3D -ENETDOWN;
>  		}
>  	}
> =20
> -	rc =3D -ENETDOWN;

After removing this assignment, rc is not set properly in case the
device is down or TX is stopped.

Perhaps this assignment should be restored before the check for
(dev->flags & IFF_UP)?

Ben.

>  	rcu_read_unlock_bh();
> =20
>  	dev_core_stats_tx_dropped_inc(dev);

--=20
Ben Hutchings
Theory and practice are closer in theory than in practice - John Levine

--=-6feKlbHddn688k8u0jsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmnDzrcACgkQ57/I7JWG
EQlYbxAAp/zF9DTX4fpFnG5r4e5weVtKEUd56TUp7G2oNDIa9b9d6oCyIurB6jCu
BIcsWtA3KLGM5qtUPys2rNK2aMR0KwNlRRHiMkrEFBIXsOS6aUSj4G1XXCLVwPoc
vjAjvCYDAnMfRSU3AxPjvuGGnSAEPeO4e0d0bSriajPOhdKqNIgOyWHNVSEeDZAy
SEitG5AH9hGVkB/jDlhFEhFCCCpMWHD5gR8DEGnv+TE0hbKOPSBbHHIn9SRRDiP3
uk4mPpTgQlF1FQ7eIljgWNMI93Xeo5ZatuBcz9ljODgw/u9CJ7uO6pzvjc+bt0h9
y4ROBl33fz/aEueZXpo0JXryYz1rGKQyQKivu3fLDPTIYTItD42INrRxBbjkK0Y5
m5nfNU8BTTpB1K7cI1h0jN8+PKwIkq00QQpjU/YElZ34MZ/7YgByvg/Wzi+GYLfx
ylKSdKL+pX3QNgZX7weIO6JAngr67z8oVocWdEOYulD0W/f+anIqqvqlkkmknYMs
VN9FmE/qAgSOxC+hLL6lk1L4bX1EYJdB4NzXLCeCWL1happdz5xWmIKL2XG7CP6M
YE8izME5lIknv2GCtsG9RAl650Y1qjoQaQ+2ez+vC8j9rI4Hon5r0LytS/9rtE9J
eRY9/2AGSUeZIXgW+sxAAoRdjaWx/rKhCw7K66QZfLr8abbHMXk=
=pH0p
-----END PGP SIGNATURE-----

--=-6feKlbHddn688k8u0jsx--

