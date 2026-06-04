Return-Path: <netdev+bounces-295421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vg0tO+3sIWp5QgEAu9opvQ
	(envelope-from <netdev+bounces-295421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:23:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6518C643962
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:23:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UJNpkEQt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295421-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295421-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E920D301E7FE
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB11F78E6;
	Thu,  4 Jun 2026 21:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F93FADF6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 21:23:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608202; cv=none; b=s6gesV348RSjg5un0ipjgA5x+Z87HF0tHbOQQjeqCy/EsyfEFlJc+c0+XN0ro5J8Z7r4FMyg+N/f0Yk1zXix1uvosBZisyczJ8YaMBlYLlgSb9EHZZDFnk4S1j6akxRuIO4mlCQ25g5eb/Zw07thfwEgVVR/aiXis7XrxGJ3GjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608202; c=relaxed/simple;
	bh=0xer4wn2tCTzWbs5uLYTskx4FaXA/2EiMQZeA7em6p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opKjT36qVEUVopHPScXCtJezztjed+PVRqz64RTcwT9mZbtSTkZl/AN/ETtuQ8OJano7hT4iuFL6bK/gZxF6MWS9kZrL1RGMgb4AVveBeZ3+ElZhNkG39zqX98rud5Qd3BSM6k4tu5kdVStc1jm/0pN0cHSsJIachxuRQQtjw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJNpkEQt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1AE1F00893;
	Thu,  4 Jun 2026 21:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780608200;
	bh=sTEc98M4XZy4WMkROG0qptNsTU3Fmgz7V9VTlpGoaVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UJNpkEQt0CjkCEugmUYRNBhibW8aOtscYwd1wNIXNfvnqPgDBnxZiY1nhmlqv7+ny
	 9mbOZCovyunje6G1Z6EhgfiE+hADo5LdmjDPBYtBqZNZR7IYQ7SG5JeBDyIrOksuln
	 KS8Inh2I2jYGs+sE1IKgZqGLLnBca+6vlZnRACzPDmofakkIHTRD6hWN6cio3Jy8Mq
	 qZxdLtODHaz/gheWt60QtP04MNza/uKK4d9+wqPt3TpMcIrZPheJj1MqZ7azgqTTsm
	 2w6ortBrQUgasNRO1mQtECATG3HqNSdo9d0FDnAY38MpMKIIQzamgNGoHFDx8P4jrY
	 7k5oLWJK437Hw==
Date: Thu, 4 Jun 2026 23:23:16 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Westphal <fw@strlen.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: airoha: Fix use-after-free in metadata dst
 teardown
Message-ID: <aiHsxFrleJfpLeuA@lore-rh-laptop>
References: <20260602-airoha-mtk-metadata-uaf-fix-v1-0-3aaa99d83351@kernel.org>
 <20260602-airoha-mtk-metadata-uaf-fix-v1-1-3aaa99d83351@kernel.org>
 <21810a20-abe6-4490-969c-cfd62c4c082a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aWp9RvEMdmSaWjBX"
Content-Disposition: inline
In-Reply-To: <21810a20-abe6-4490-969c-cfd62c4c082a@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295421-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:nbd@nbd.name,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:fw@strlen.de,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nbd.name,gmail.com,collabora.com,strlen.de,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6518C643962


--aWp9RvEMdmSaWjBX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 6/2/2026 2:21 AM, Lorenzo Bianconi wrote:
> > airoha_metadata_dst_free() runs metadata_dst_free() which frees the
> > metadata_dst with kfree() immediately, bypassing the RCU grace period.
> > In the RX path, skb_dst_set_noref() sets a non-refcounted pointer from
> > the skb to the metadata_dst. This function requires RCU read-side
> > protection and the dst must remain valid until all RCU readers complete.
> > Since metadata_dst_free() calls kfree() directly, an use-after-free can
> > occur if any skb still holds a noref pointer to the dst when the driver
> > tears it down.
> > Replace metadata_dst_free() with dst_release() which properly goes
> > through the refcount path: when the refcount drops to zero, it schedules
> > the actual free via call_rcu_hurry(), ensuring all RCU readers have
> > completed before the memory is freed.
> >=20
> > Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index cecd66251dba..eab6a98d62b9 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -2936,7 +2936,7 @@ static void airoha_metadata_dst_free(struct airoh=
a_gdm_port *port)
> >  		if (!port->dsa_meta[i])
> >  			continue;
> > =20
> > -		metadata_dst_free(port->dsa_meta[i]);
> > +		dst_release(&port->dsa_meta[i]->dst);
> >  	}
> >  }
> > =20
> >=20
>=20
> the port->dsa_meta is allocated using metadata_dst_alloc().. how is it
> safe to use dst_release here? Seems like we should be calling dst_alloc
> instead of metadata_dst_alloc in order to use dst_release??

We need to allocate the metadata_dst using metadata_dst_alloc() since
md_dst->u.port_info.port_id is consumed in dsa_switch_rcv() to get the
switch conduit port.
I guess it is fine to free metadata_dst running dst_release() since dst_ini=
t()
sets DST_METADATA flag and so dst_destroy() runs metadata_dst_free() after =
the
RCU grace period.

>=20
> metadata_dst_alloc does call __metadata_dst_init which calls dst_init..
>=20
> I guess the start of the metadata_dst structure is also the same address
> as the internal dst_entry struct...
>=20
> But dst_destroy does a whole lot more than metadata_dst_release so I
> don't feel confident in this actually being a drop-in replacement... It
> calls netdev_put, it calls the dst->ops->destroy, it releases child
> refs.. Or for metadata dst entries is that all basically a no-op??

__metadata_dst_init() calls dst_init() with dev =3D NULL so netdev_put() is=
 a
no-op. Same for dst->ops is dst_blackhole_ops and and dst_blackhole_ops has=
 no
destroy callback.

>=20
> I feel like I'm missing something here.. The driver also calls
> metadata_dst_free in the remove path and that wasn't changed by this
> patch either.

can you please explain what you mean here? we do not run metadata_dst_free()
anymore.

Regards,
Lorenzo

>=20
> Generally it seems like we should be using the same API to allocate as
> to release the object... This is confusing. What am I missing?

--aWp9RvEMdmSaWjBX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiHswQAKCRA6cBh0uS2t
rHipAP4llkXraaMXUK3wGAgySlJJUwlEcRj8tHK/o/3m+eELXwEA2l1QByKUIy8/
sBrHvIWNbv90x/tGgmBZkNoYSKAXpAo=
=ev4h
-----END PGP SIGNATURE-----

--aWp9RvEMdmSaWjBX--

