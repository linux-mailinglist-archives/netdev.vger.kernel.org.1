Return-Path: <netdev+bounces-100088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B148D7CDC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7932B1F2167D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFB14F213;
	Mon,  3 Jun 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCyDg4K+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B974EB45;
	Mon,  3 Jun 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401216; cv=none; b=EY7usFri3pkZkGnaeVFsg1S2tKnOgHk3/ed9Ee8cqlj64CHAUQ8fiSynAmtUUFRnPAdlzuYi/0q/XeUCN+4uuwxWt6vF6qIiBPNd4ZLdRw7bK/99u4aVkehUTxIY91fR51vnfQTog2tqEbg48aNsjRXuQaZ9ztPB2g9iEYu7fn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401216; c=relaxed/simple;
	bh=OUw0iTREKZQj9XWGrzozbBwR9IvvahgQX/H3qNpX+30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q04bvMSff5Pn1EddhDR49Vj7Mzw67c+iBJoWsmrjs2iXYFTO05/gbsRVihEC4cEcG4LSPWQIeG+1Tco5kYT5Bqa4I5lMvPuplxxhIEVINOP4istR8q461j4XRozEDz9E50bxHKOWBx+gxvWh1lJt8I6yT9rULVLqBZofMQ7gpzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCyDg4K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCBDC2BD10;
	Mon,  3 Jun 2024 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717401214;
	bh=OUw0iTREKZQj9XWGrzozbBwR9IvvahgQX/H3qNpX+30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCyDg4K+s+YOv1rXqx6PJ/1ogPkktiLka+s+ESRulIXfPVJvJCg+oIOAtIU76653s
	 SO9izDFlA9/et8Q6ARwZEJU6qqyDTbCGK0Uok6g4VaDAn1WDgkyu5hSkIRfLnyQ6jx
	 tJK9O4wmzdR/FscB5aEXnftXdtY4HDTnTsegIbG6CJKHRh2/Niksdu7E+Bz1RHJwU+
	 xC+PhOzUY2WNXEkTsZMBrQO6COGAWiO0WJY78RZdWTJ9CQO79Fjc71dvAtzXhfCZbo
	 JgX3z08KIGy93itwvXknbYuIQxunr4aRCfvUPE5CJx4BaiTBeL8U2KxOulcHmFFje9
	 lthsgFK2b/W1w==
Date: Mon, 3 Jun 2024 09:53:31 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>,
	"lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"conor@kernel.org" <conor@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"upstream@airoha.com" <upstream@airoha.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"benjamin.larsson@genexis.eu" <benjamin.larsson@genexis.eu>
Subject: Re: [EXTERNAL] [PATCH net-next 3/3] net: airoha: Introduce ethernet
 support for EN7581 SoC
Message-ID: <Zl12e1LjSqf-M7cb@lore-desk>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>
 <BY3PR18MB4737F74D6674C04CAFDCD9C9C6FF2@BY3PR18MB4737.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="My9euhtWkGFeYwU6"
Content-Disposition: inline
In-Reply-To: <BY3PR18MB4737F74D6674C04CAFDCD9C9C6FF2@BY3PR18MB4737.namprd18.prod.outlook.com>


--My9euhtWkGFeYwU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> >-----Original Message-----
> >From: Lorenzo Bianconi <lorenzo@kernel.org>
> >Sent: Friday, May 31, 2024 3:52 PM
> >To: netdev@vger.kernel.org
> >Cc: nbd@nbd.name; lorenzo.bianconi83@gmail.com; davem@davemloft.net;
> >edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> >conor@kernel.org; linux-arm-kernel@lists.infradead.org; robh+dt@kernel.o=
rg;
> >krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> >devicetree@vger.kernel.org; catalin.marinas@arm.com; will@kernel.org;
> >upstream@airoha.com; angelogioacchino.delregno@collabora.com;
> >benjamin.larsson@genexis.eu
> >Subject: [EXTERNAL] [PATCH net-next 3/3] net: airoha: Introduce ethernet
> >support for EN7581 SoC
> >
> >Prioritize security for external emails: Confirm sender and content safe=
ty before
> >clicking links or opening attachments
> >
> >----------------------------------------------------------------------
> >Add airoha_eth driver in order to introduce ethernet support for
> >Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> >en7581-evb networking architecture is composed by airoha_eth as mac
> >controller (cpu port) and a mt7530 dsa based switch.
> >EN7581 mac controller is mainly composed by Frame Engine (FE) and
> >QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> >functionalities are supported now) while QDMA is used for DMA operation
> >and QOS functionalities between mac layer and the dsa switch (hw QoS is
> >not available yet and it will be added in the future).
> >Currently only hw lan features are available, hw wan will be added with
> >subsequent patches.
> >
> >Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> >Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >---
> ......
> >+
> >+static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
> >+{
> >+	struct airoha_eth *eth =3D q->eth;
> >+	struct device *dev =3D eth->net_dev->dev.parent;
> >+	int done =3D 0, qid =3D q - &eth->q_rx[0];
> >+
> >+	spin_lock_bh(&q->lock);
>=20
> There is one napi per queue, why lock ?

we can get rid of it for rx queues (I will do in v2) but not for xmit ones
since airoha_qdma_tx_napi_poll() can run in parallel with airoha_dev_xmit()

>=20
> ...........................
> >+
> >+	q =3D &eth->q_tx[qid];
> >+	spin_lock_bh(&q->lock);
>=20
> Same here, is this lock needed ?
> If yes, can you please elaborate why.

ndo_start_xmit callback can run in parallel with airoha_qdma_tx_napi_poll()

>=20
> >+
> >+	if (q->queued + nr_frags > q->ndesc) {
> >+		/* not enough space in the queue */
> >+		spin_unlock_bh(&q->lock);
> >+		return NETDEV_TX_BUSY;
> >+	}
> >+
>=20
> I do not see netif_set_tso_max_segs() being set, so HW doesn't have any l=
imit wrt
> number of TSO segs and number of fragments in skb, is it ??

I do not think there is any specific limitation for it

>=20
> ...........
> >+static int airoha_probe(struct platform_device *pdev)
> >+{
> >+	struct device_node *np =3D pdev->dev.of_node;
> >+	struct net_device *dev;
> >+	struct airoha_eth *eth;
> >+	int err;
> >+
> >+	dev =3D devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*eth),
> >+				      AIROHA_NUM_TX_RING,
> >AIROHA_NUM_RX_RING);
>=20
> Always 32 queues, even if kernel is booted with less number cores ?

ethtool is not supported yet, I will add it with followup patches

>=20
>=20
> Overall this is a big patch deserving to be split, probably separate patc=
hes for init and datapath logic.

I guess specific parts (initialization, tx or rx code) are not big enough t=
o deserve a dedicated patches.

> Also I do not see basic functionality like BQL not being supported, is th=
at intentional ?

ack, I will add it in v2.

Regards,
Lorenzo

>=20
> Thanks,
> Sunil.
>=20

--My9euhtWkGFeYwU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZl12ewAKCRA6cBh0uS2t
rDRAAP46ZBEFk+YyM7J9tirrICqDRyz7T2FO1kdVLyt4hVV4mAEAq0e8JL55GKq2
Jtv3riDZQdk6AuvSpeUQMxthGrcSeQM=
=vlvP
-----END PGP SIGNATURE-----

--My9euhtWkGFeYwU6--

