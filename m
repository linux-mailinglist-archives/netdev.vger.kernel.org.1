Return-Path: <netdev+bounces-301122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gDVBFP81OWpfogcAu9opvQ
	(envelope-from <netdev+bounces-301122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:17:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A776AFBC3
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:17:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W5h21FMa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301122-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301122-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E05D03006160
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709DD3B14AF;
	Mon, 22 Jun 2026 13:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42E2DC78C
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:11:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133909; cv=none; b=XyCvFo+IlIMD8khutkAkktf7klNk1ag+Pm8FeZ+skoByawoiqUM608lgG6VxZ1ll6BXie34c5xsE7Ny/5uY5iBBjyBNQva2ArF5Ev/HkonGraHCYIYf56ntbJURyEL6GT1kjKuTA5KhBGctalMa5BsGxZHOVpSJkJ0x3ARa9VKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133909; c=relaxed/simple;
	bh=kuMUN8h2+W6wUgkQ9k408YFxn0wgCD4IbDjP9jAwSMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRUGf/C1AcQ2R5xONvjwPdj/V/oqkYZ4lfC4KI2op4rNVkTtX5qKmSsRRlg7Zhe1vtmMBJrSuoG0FcuAmsxx9eonSuSZ9KKcw6ypkj97fvIjU0jBMPHPgkp4nc3mgNoAzXWBghRhfcY55uhslYzzn4Sm2RdzL3j7GW+pKgrDEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5h21FMa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61741F000E9;
	Mon, 22 Jun 2026 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782133908;
	bh=kuMUN8h2+W6wUgkQ9k408YFxn0wgCD4IbDjP9jAwSMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W5h21FMaCiwhYRbfnJW3M/AUMrvlllxpB6VO8W4gonhHLkMWnj8xNphYEhnsiSRZO
	 zAFVLgywvIJjmpJwbdGkTzMVgH1BbaiUWnX+4VGs+Urj6R0yEMtyYTKn4mHQ673CKF
	 sEd0/TI9Os6VgCmM7fAXSZ2oQq81D7AEM2fp5d933Mx5vwbP4rZmkdOFZYVJ/r9LNi
	 RPF1Jssz+YKLaDoreUKdvUibwgI1FQxxIveUogaYSKw2S9UGnBk9kdAHyl/or11Lqd
	 FUn0AX6kcOGzO0Dx+CyFxIOr7Jsu+6d5IMtuL2fiX+sl4I3gVHQndXKoBXRAiQPbl7
	 H96mjxwMN23LA==
Date: Mon, 22 Jun 2026 15:11:45 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: airoha: fix netif_set_real_num_tx_queues
 for sparse QoS channels
Message-ID: <ajk0kS76nahtop8g@lore-desk>
References: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
 <20260619-airoha-qos-fixes-v2-2-5c43485038f9@kernel.org>
 <20260622123136.GC827683@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="96HHC6WywQkcy9r+"
Content-Disposition: inline
In-Reply-To: <20260622123136.GC827683@horms.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301122-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4A776AFBC3


--96HHC6WywQkcy9r+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jun 19, 2026 at 01:37:14PM +0200, Lorenzo Bianconi wrote:
> > airoha_tc_htb_alloc_leaf_queue() assigns queue IDs based on the channel
> > index (opt->qid =3D AIROHA_NUM_TX_RING + channel), but updates
> > real_num_tx_queues with a simple increment (num_tx_queues + 1). When QoS
> > channels are allocated sparsely (e.g., channels 0 and 3 without 1 and
> > 2), the returned qid can exceed real_num_tx_queues, causing out-of-boun=
ds
> > accesses in the networking stack.
> > For example, allocating channel 0 then channel 3 results in
> > real_num_tx_queues =3D 34 but qid =3D 35, which is out of range [0, 34).
> > Fix this by computing real_num_tx_queues based on the highest active
> > channel index rather than using a simple counter, in both the allocation
> > and deletion paths.
> >=20
> > Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Thanks for the update since v1.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Simon,

thx for the review.

>=20
> FTR, there is an AI-generated review of this patch on sashiko.dev.
> I do not think that should impede the progress of this patch but
> you may want to consider it in the context of follow-up.

Even if it is not introduced by this patch, I do not think what is reported
by Sashiko is a real issue since airoha_eth driver implements
ndo_select_queue() callback and the selected queue is always in the range
[0, AIROHA_NUM_TX_RING[. HTB queues (in the range
[AIROHA_NUM_TX_RING, AIROHA_NUM_TX_RING + AIROHA_NUM_QOS_CHANNELS[) are jus=
t=20
'offloaded' and never used in the TC sw path. Agree?

Regards,
Lorenzo

--96HHC6WywQkcy9r+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajk0kQAKCRA6cBh0uS2t
rPifAP96JjXaiWba2fGEotElX4xAGC8NNJ35hRhS+KLQrqpXuQD/R5dEALeVbE9p
v+B8S48F2yLp/iWm796glhdXABPoyAw=
=/a4e
-----END PGP SIGNATURE-----

--96HHC6WywQkcy9r+--

