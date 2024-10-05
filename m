Return-Path: <netdev+bounces-132353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FD79915F1
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 12:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9E01C21723
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 10:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EB7132139;
	Sat,  5 Oct 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzWxAMeQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020F8F70
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728123888; cv=none; b=IKuPL7y6BcCVqclBfBPtCcL1IbhKP6LfxBweMIx6wq9e24p3uZwtxFYVdfJekASysDinRDHJT10kJAVvyWc/g/mA39S1BWbqzNzji8bXtr+uP33q9UdqMZzRf0LHDnIAyJGgzGp5FD/G3ryOrh0voLhl7r3AIbjm4BBZuVuUCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728123888; c=relaxed/simple;
	bh=VSkUhuEZREzVaWXtWS+SMpiGA9jxfyNvXOGjetZNpPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8PR4uXOsBLqDXCbaMga/F7SVSs6QCAK306MBL6PGyASBYFvwISnH6sC8L7wB/y8tqvgH6NczX8k7E2sRWo2mtQnFHqnEYqERcZOcbCxj94iD5Y6kYxjJDjaKAb2hn6fDWq4z21LH1N53fGffUwdTksiBxOST9oBoeT/17KBMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzWxAMeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CF8C4CEC2;
	Sat,  5 Oct 2024 10:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728123887;
	bh=VSkUhuEZREzVaWXtWS+SMpiGA9jxfyNvXOGjetZNpPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzWxAMeQjIQtJyh4emAWIbjZEEYZdHkQcfbP54FNlXJbq69VeMRdHXKxrVkwzReiU
	 BLQSA9EEVJumWqxvLl98I5xuPfOG3j/zCoV/lWq20a+nyszvmQUfPAlBgh7XLq2sMD
	 6qoC/JCl8OMqmw215qP5eL2xKEAmhUaaT2AERVN7BWgXRytAi8Pozpnx8OqkKNErBM
	 YaniEHEIyQDGfsWYzRpjYeGeqg4UeeDPkmcvA7LtGRz0rC5tpeaF8NK/2jd1dnVQiw
	 RXLhXrePhAHq2p/mUIce7zPYpfpLvuykWQCJOIMjNqReg+5w7MdsOA7JZ4Sj7DGY4N
	 AmoTKaSBYkvWA==
Date: Sat, 5 Oct 2024 12:24:44 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix EGRESS_RATE_METER_EN_MASK
 definition
Message-ID: <ZwET7MzCGVoDjIqt@lore-desk>
References: <20241004-airoha-fixes-v1-1-2b7a01efc727@kernel.org>
 <e4574a97-8e34-49be-9ec6-bb787104e6db@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="In29TbajZU6IMjK1"
Content-Disposition: inline
In-Reply-To: <e4574a97-8e34-49be-9ec6-bb787104e6db@intel.com>


--In29TbajZU6IMjK1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 10/4/2024 2:51 PM, Lorenzo Bianconi wrote:
> > Fix typo in EGRESS_RATE_METER_EN_MASK mask definition. This bus was not
> > introducing any user visible problem.
> >=20
>=20
> I'm not sure I follow. This bit is used by airoha_qdma_init_qos which
> sets the REG_EGRESS_RATE_METER_CFG register?
>=20
> How does this not provide any user visible issues? It seems like an
> incorrect enable bit likely means that QOS is not enabled? I'm guessing
> bit 29 is reserved?

Hi Jacob,

even if we are setting EGRESS_RATE_METER_EN_MASK bit (with a wrong value) in
REG_EGRESS_RATE_METER_CFG register, egress QoS metering will not be support=
ed
yet since we are missing some other configuration (token bucket rate, token
bucket size. Airoha folks please correct me if I am wrong). This is why I do
not think it is important to backport this patch and I did not added any Fi=
xes
tag.
QoS hw ingress/egress metering is in my ToDo list. Here I have ported the b=
asic
qos configuration I found in the vendor sdk. I will add more info in the co=
mmit
log in v2. Sorry for the confusion.

Regards,
Lorenzo

>=20
> It would be good to understand why this is not considered a fix?  The
> offending commit is in the net branch already.
>=20
> > Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet sup=
port
> > for EN7581 SoC")
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/mediatek/airoha_eth.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/e=
thernet/mediatek/airoha_eth.c
> > index 2e01abc70c170f32f4206b34e116b441c14c628e..a1cfdc146a41610a3a6b060=
bfdc6e1d9aad97d5d 100644
> > --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> > +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> > @@ -554,7 +554,7 @@
> >  #define FWD_DSCP_LOW_THR_MASK		GENMASK(17, 0)
> > =20
> >  #define REG_EGRESS_RATE_METER_CFG		0x100c
> > -#define EGRESS_RATE_METER_EN_MASK		BIT(29)
> > +#define EGRESS_RATE_METER_EN_MASK		BIT(31)
> >  #define EGRESS_RATE_METER_EQ_RATE_EN_MASK	BIT(17)
> >  #define EGRESS_RATE_METER_WINDOW_SZ_MASK	GENMASK(16, 12)
> >  #define EGRESS_RATE_METER_TIMESLICE_MASK	GENMASK(10, 0)
> >=20
> > ---
> > base-commit: c55ff46aeebed1704a9a6861777b799f15ce594d
> > change-id: 20241004-airoha-fixes-8aaa8177b234
> >=20
> > Best regards,
>=20

--In29TbajZU6IMjK1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZwET7AAKCRA6cBh0uS2t
rNNyAP9uDDos8SDJ2XegHnssVx4dyQpUj5EHw09nl48HbC9uQgD/fVCCfhSiR0ps
qxVMUSjlIMCF114O3DrDR89LdwBSgwg=
=TQox
-----END PGP SIGNATURE-----

--In29TbajZU6IMjK1--

