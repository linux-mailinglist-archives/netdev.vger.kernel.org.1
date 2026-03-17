Return-Path: <netdev+bounces-268378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6XX8NPmtuGmHhgEAu9opvQ
	(envelope-from <netdev+bounces-268378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:27:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2320B2A2888
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E1193009B3F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB47C312831;
	Tue, 17 Mar 2026 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8LkH68c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2D433AD
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710838; cv=none; b=XUfOmM75evvrYJAKQ+RUsenUmn8mWllD6Cmfdo29eqNpgrNG2awTrLBLDrojOaHixpMB336UXeHhN4oUoLvnd8/j2jYCMUcRfas93c0cYuIH/ZKBXpXfViXRo/iWX4Ja0dbBMU+/dHhNiWbCVWy6cSehshRz7H6eNhVlWu+pceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710838; c=relaxed/simple;
	bh=yoiduCnUKRO0yz9jxVnQDHNSVI3+B0dPKMstdEd2/fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARxUhY7MVFBuBwUfoYFbqD6Je5oju5g3emYPtWPw5cOqFx1Oaop4BqOXyr/HH2ACZOL+JEMbmml6CzU98Q9rD9XlBKvzGFdPx1uBBos90MJ71SnxfrYdb7oy6qlEarXxBoEqb6DRvTd/8IoRkY+EKBWpSs1o8NCAWU5pwsd1SP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8LkH68c; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bea8a1c040so3167189eec.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773710837; x=1774315637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OlKamCL8WXsAiYfYsDwpaxwBpBEiFOPeO6WpPGnkXU=;
        b=X8LkH68cYa/ZzsiLMsXdzTLVQYfcqGT2gYWLLBgIsTsHLwalnr1S3k8IDmtf5glmZn
         glXwG1UFUI9SIrS3NrAPkX9QYwc7XI4WzPWzDHIRKHFN1r+DbwsjXuHOFPtH8S/C+SdK
         D5WBlU5n64oE2TILKxy4g+l3jQln3jlempl545Idngji/gDDTVMue0V3+H1iwaifVpsD
         Pag+Xi1EtxftkNu+tSbq0UGavCtyFY17pt1lhHgJ/CM8oMTAXopeZvUgyK40iXZNgeuJ
         w+AaCbTuko1scioZbrFpcUXq3445dLkUb3kxypoQCz1003Q3wIsyuh4gYrPduypqSlaG
         YY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773710837; x=1774315637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OlKamCL8WXsAiYfYsDwpaxwBpBEiFOPeO6WpPGnkXU=;
        b=DkfqCcdJNK/KN00noepW3WJbGM9+eQZqV1bsvqnNMeettV8SVCWvQPKLtnyPGcJ7o9
         h+Zt+zd4HozvtDz/opeZpaUBkSeZNPjhXmU1lF/lmzkL1DzS7QCCqvtz1ChY+V2DIMyJ
         xhLXS5P3AFV7YC85jQ8tlSJZ5WGSRA8UoONk4ysuwUvlVcLdF8wepqZo7k1L0LbaEd6/
         XQz0h2g8bnf+wC2Q1gwWZbsqZzduSkg6/0BbsfBFP1iJ3AOZVCpxx2yLP1bS/aZfK0g5
         K/zrN5NmfXukuwUq3KOrdO75nioI29sCsfz2WN4hUSjuKGRgf2usGAVw4Q6D7H/uX3L5
         nMfQ==
X-Gm-Message-State: AOJu0YwRMXu//NhfG+FYursm20VlpbTyxMb2TLaxI3HmbNEhSFHzqYID
	RhkSdbzSzfMDfMDQjZlvVon5kJaTf70E1xPF7vMJZgodvmRf3lVKnv5oilIvmQoC
X-Gm-Gg: ATEYQzwEBQqZ2Hh8SUdna/4DgOT3x1FQEUzmKQ/9fs6+EJe9UWrBmIA+AAYoeZ4H/WV
	oWy0aIJjg6Ozxb+2ACJDS5pPVBAbPleV5SOIMtVpoFkTBY3XBKqUWlWMd+dMiVURJcdAeyh8k0z
	ZcKHiaab26r/YuJtZOOHrMB1MXv5QQxjpciaIOsufs9AUz0pELiZVHZy1XRgpP4QHmS0cfWdU+6
	Afb7AnvJNBY83M8FIcszhqL70+beRxzeU/4Dt554Q4NqGYKwO8QIVGnQiMZaWLkITMncRJfkWNE
	j+HI2XgHg2jrJjBXdR3bYMqo/R66G6Tye//Nw6HgaYu9GRZE1YjhFMEogggZalV39YdrjbciLAf
	2gQfhgki7WlHYwNehJAPW6ePso0jNIsTMT9EXQXm8l2Xb0JBsM6SK4mw1smZIcxtkSpkjh/qYZ0
	6oRCTgsgcFdO+QNl3F50bG/bPHlS7BDg==
X-Received: by 2002:a05:693c:60d0:b0:2c0:c27c:338d with SMTP id 5a478bee46e88-2c0c27c36b1mr2060815eec.35.1773710836513;
        Mon, 16 Mar 2026 18:27:16 -0700 (PDT)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a12e2sm17874042eec.2.2026.03.16.18.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 18:27:16 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:27:09 +0800
From: Kevin Hao <haokexin@gmail.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Harini Katakam <harini.katakam@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: macb: Protect access to net_device::in_ptr
 with RCU lock
Message-ID: <abit7VLwoy2ttEus@pek-khao-d3>
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
 <20260315-macb-irq-v1-2-0154104cbf61@gmail.com>
 <DH4EHTJNY6GL.3EXTP61HNUNDD@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fXQ1Gh8sSRril/+g"
Content-Disposition: inline
In-Reply-To: <DH4EHTJNY6GL.3EXTP61HNUNDD@bootlin.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268378-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2320B2A2888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--fXQ1Gh8sSRril/+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 06:59:35PM +0100, Th=E9o Lebrun wrote:
> Hello Kevin,
>=20
> On Sun Mar 15, 2026 at 12:44 PM CET, Kevin Hao wrote:
> > @@ -5915,13 +5915,16 @@ static int __maybe_unused macb_suspend(struct d=
evice *dev)
> > =20
> >  	if (bp->wol & MACB_WOL_ENABLED) {
> >  		/* Check for IP address in WOL ARP mode */
> > +		rcu_read_lock();
> >  		idev =3D __in_dev_get_rcu(bp->dev);
> >  		if (idev)
> >  			ifa =3D rcu_dereference(idev->ifa_list);
> >  		if ((bp->wolopts & WAKE_ARP) && !ifa) {
> >  			netdev_err(netdev, "IP address not assigned as required by WoL walk=
 ARP\n");
> > +			rcu_read_unlock();
> >  			return -EOPNOTSUPP;
> >  		}
> > +
> >  		spin_lock_irqsave(&bp->lock, flags);
> > =20
> >  		/* Disable Tx and Rx engines before  disabling the queues,
> > @@ -5963,6 +5966,7 @@ static int __maybe_unused macb_suspend(struct dev=
ice *dev)
> >  			tmp |=3D MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
> >  		}
> >  		spin_unlock_irqrestore(&bp->lock, flags);
> > +		rcu_read_unlock();
> > =20
> >  		/* Change interrupt handler and
> >  		 * Enable WoL IRQ on queue 0
>=20
> Instead of making the RCU critical section extend so much, you could
> dereference ifa->ifa_local into a stack variable. In particular, it
> would avoid the RCU critical section covering a spinlock critical
> section.

I initially considered using a local variable before submitting this, as I =
also
believe that `ifa->ifa_local` is unlikely to be modified or freed in this
context. However, I ultimately decided to protect these sections with RCU f=
or
the following reasons:

- It is logically more consistent to protect access to `ifa->ifa_local` with
  RCU locking.

- For section already under spinlock protection, adding RCU locking introdu=
ces
  negligible overhead, especially in a scenario like this.

That said, I do not have a strong preference for either approach. If you pr=
efer
using a local variable to keep the RCU region shorter, I can prepare a v2 w=
ith
that change.

Thanks,
Kevin

--fXQ1Gh8sSRril/+g
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmm4re0ACgkQk1jtMN6u
sXEwswf/dI7nafCf1tPMTrWTo1FxqPw7W3YsFa/D/oc9aPiv9xIlslAjlwcXm5ij
YjwNC8TZsAqnLG2WjLUgRPWo3YKMT9JSUodiS52D8RGjy81sewed//NObhTywLLS
zn0BD8z9AA287jagIe1hrargXOdU5niK3kjNrpRJh4V5SyoZwofWSN8D4QFtuhXG
iUUZB1UYOYEq8pR+GYLT3mtrkUhASTaJ1PJq7P/tO5Y47fgrCtmn0Asi4+2tar3M
PG8CvfTQ4sEVXOaGObs3TBHLICS5HzuYC+LroL9ttThlM7ltu5yRxU+B6MGmbLAG
XjIIsbQiMsChwmBvqqDJWIZY3/2+kg==
=zP9L
-----END PGP SIGNATURE-----

--fXQ1Gh8sSRril/+g--

