Return-Path: <netdev+bounces-270207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UnkID+iRvmmBTQMAu9opvQ
	(envelope-from <netdev+bounces-270207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:41:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 859682E54F7
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB34E300F5C9
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CD2175A8A;
	Sat, 21 Mar 2026 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjUxIz20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF8199D8
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774096869; cv=none; b=p/BemWuxaTWQPGbHNOqL+ZsmBEzkMPjPdrYY1zV+OEPyPZsMV+kdb/D0xTU7HW08qTRgcQzO/w00e5TEc/7Kt2fpKwa12RCG72FbZL1+W2hxKRHAStAVS4dvgRw3psIm0GRZnxVHb6h5MaHHPayaHIZ8I0pRcXjBZnuVu/Qes6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774096869; c=relaxed/simple;
	bh=fxVoXze93TK9b7JkjLP3hYYoZwJ+sQWedrY/aS+Uubs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFKkmSTYs9mt55BbakrqpEsTK1ylOAJOYkRsNN9L+cpvzLOGMkhW7/9iskjFS8xrDEIpbY9OG4G34iyhVq0ThJaH5XgPiV/IgcY4+WPFAaqlgmHr9bJadx6vZ9Z7lKbU1T40uNe0DjaZEPBv4R9Cc3M1V6CMK8Yrwt5LTs4dC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjUxIz20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437D2C19421;
	Sat, 21 Mar 2026 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774096868;
	bh=fxVoXze93TK9b7JkjLP3hYYoZwJ+sQWedrY/aS+Uubs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjUxIz20bGymV7Rs5Wvfoj/C3PHimtOj2oswMcvSb4/xuT2XsaNg2m8Au0INjBZ0e
	 5NM8fJbWPfZsIZzcfUwGrKHNO4D9xBdzsH5kuHJwzsUfPhN2T4Ait6dR0XKwSm/Jvl
	 urLpexwJz9ruvDCpqst42b6CcRcbz/39Xk3KYwNbDw3TywC7YsgMqpZEXXsjGYHalR
	 FJznFWd8EFZ2wcIzrW7+Y0a7YFd1k6y7zbIvuglzgHWH/0trij0rO5Zvdvkos+R9QO
	 VPp8eKim71vTs8gkcR0883dGJesTBzPct5hoGDaYrEMWMMVkdN679j0AE+938q7CQN
	 9DS9D5pstZoTQ==
Date: Sat, 21 Mar 2026 13:41:06 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Reset PPE cpu port configuration
 in airoha_ppe_hw_init()
Message-ID: <ab6R4krBRy5dycb-@lore-desk>
References: <20260317-airoha-fix-ppe-def-cpu-v1-1-338533d8e234@kernel.org>
 <20260320183127.22b360be@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3sTRF6na1p3lBxUs"
Content-Disposition: inline
In-Reply-To: <20260320183127.22b360be@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270207-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 859682E54F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--3sTRF6na1p3lBxUs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 17 Mar 2026 17:40:47 +0100 Lorenzo Bianconi wrote:
> > @@ -155,6 +171,11 @@ static void airoha_ppe_hw_init(struct airoha_ppe *=
ppe)
> >  						 AIROHA_MAX_MTU) |
> >  				      FIELD_PREP(FP1_EGRESS_MTU_MASK,
> >  						 AIROHA_MAX_MTU));
> > +			if (!port)
> > +				continue;
> > +
> > +			airoha_ppe_set_cpu_port(port, i);
>=20
> AI says:
>=20
> Can this lead to a NULL pointer dereference if a port is not fully
> initialized?
>=20
> In airoha_probe(), all GDM ports defined in the device tree are allocated
> and the eth->ports[] array is populated with pointers, but port->qdma is
> left as NULL.
>=20
> During airoha_register_gdm_devices(), the ports are registered sequential=
ly
> with register_netdev(). Since register_netdev() drops the rtnl_lock(),
> userspace could react to the RTM_NEWLINK event of the first registered po=
rt
> and apply a tc flow offload rule.
>=20
> This would trigger the following call chain:
>   .ndo_setup_tc() -> airoha_ppe_setup_tc_block_cb() -> airoha_ppe_offload=
_setup()=20
>    -> airoha_ppe_hw_init()
>=20
> If airoha_ppe_hw_init() iterates over the array, it will find the subsequ=
ent
> port that has been allocated but not yet registered, meaning its port->qd=
ma
> is still NULL. The call to airoha_ppe_set_cpu_port(port, i) will then
> dereference the NULL port->qdma.
>=20
> Would it be better to check if (!port || !port->qdma) before calling
> airoha_ppe_set_cpu_port()?

Hi Jakub,

I agree there is a race between airoha_register_gdm_devices() and
airoha_ppe_setup_tc_block_cb(). Instead of not running
airoha_ppe_set_cpu_port() in airoha_ppe_hw_init() for a given port and not
configuring the hw correctly, I guess it would be better to grab
flow_offload_mutex mutex in airoha_register_gdm_devices routine and wait for
all devices to be properly registered before executing
airoha_ppe_setup_tc_block_cb(). Something like:

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/etherne=
t/airoha/airoha_eth.c
index 961325da833b..f5bb917f0f6e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2927,21 +2927,24 @@ static int airoha_alloc_gdm_port(struct airoha_eth =
*eth,
=20
 static int airoha_register_gdm_devices(struct airoha_eth *eth)
 {
-	int i;
+	int i, err =3D 0;
+
+	mutex_lock(&flow_offload_mutex);
=20
 	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port =3D eth->ports[i];
-		int err;
=20
 		if (!port)
 			continue;
=20
 		err =3D register_netdev(port->dev);
 		if (err)
-			return err;
+			break;
 	}
=20
-	return 0;
+	mutex_unlock(&flow_offload_mutex);
+
+	return err;
 }
=20
 static int airoha_probe(struct platform_device *pdev)
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/etherne=
t/airoha/airoha_eth.h
index 7df4dbcd8861..3330ee54e20e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -551,6 +551,8 @@ struct airoha_gdm_port {
 #define AIROHA_RXD4_PPE_CPU_REASON	GENMASK(20, 16)
 #define AIROHA_RXD4_FOE_ENTRY		GENMASK(15, 0)
=20
+extern struct mutex flow_offload_mutex;
+
 struct airoha_ppe {
 	struct airoha_ppe_dev dev;
 	struct airoha_eth *eth;
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/etherne=
t/airoha/airoha_ppe.c
index 7666b1d2f4f6..96d092f7214e 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -15,7 +15,7 @@
 #include "airoha_regs.h"
 #include "airoha_eth.h"
=20
-static DEFINE_MUTEX(flow_offload_mutex);
+DEFINE_MUTEX(flow_offload_mutex);
 static DEFINE_SPINLOCK(ppe_lock);
=20
 static const struct rhashtable_params airoha_flow_table_params =3D {


What do you think?
I noticed commit f44218cd5e6a is already applied to net-next. I will post a
follow-up patch, agree?

Regards,
Lorenzo

> --=20
> pw-bot: cr

--3sTRF6na1p3lBxUs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCab6R4gAKCRA6cBh0uS2t
rAo2AP0VgofFC019vKtsTfxIA2WGT+rQR//Zf0DpJyAuqtpUWAD9EsknoKEO2zlx
9aN6ois6lbevq4CS+K7KKEGrqFIfAAs=
=tUik
-----END PGP SIGNATURE-----

--3sTRF6na1p3lBxUs--

