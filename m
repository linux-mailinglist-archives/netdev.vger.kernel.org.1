Return-Path: <netdev+bounces-34454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E437A4399
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FCF280E26
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FC11426D;
	Mon, 18 Sep 2023 07:54:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EADE13AF7;
	Mon, 18 Sep 2023 07:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7D4C433CC;
	Mon, 18 Sep 2023 07:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695023664;
	bh=a3re9QgHeOZBxzT5bdJ5U4VTTN31mPT7AHtXRfmJaV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=moI/Gs7NvfV40COVsr1CU7NanXM6KqQR3MYY9K5GVkVb1+7T+hybfkstskwBIKfQE
	 oV0LzvIFSYuXEu/HGaAWJ6ruv2R4UqUtv/T++NgGCaJYD2PDmzhBbZQ+5lZ7GMV6qg
	 UNxAGuUREXkd6NYrP19SDx5Kmtlgiqv5+DeT+p0Re4kvuHLcTqluLEFtgvUQK8yUmH
	 pWSR4J5+GP66QMRcpaP7SJVi5DBw003QHNmweanr1xdT1m/6JyO1CY41vEMzJWlOcn
	 5fpyG2aJhe8H2kF4KAR7jZuszQL9FsaT1H7j0eLvHlnE0c+OCEaQDC6mlmY/CK4fQl
	 9w0iq/MLGVv4w==
Date: Mon, 18 Sep 2023 09:54:20 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org, sujuan.chen@mediatek.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 13/15] net: ethernet: mtk_wed: introduce hw_rro
 support for MT7988
Message-ID: <ZQgCLIUUbX51eV+R@lore-desk>
References: <cover.1694701767.git.lorenzo@kernel.org>
 <da27f7333fa31808ceae581d9bef5030c6072f33.1694701767.git.lorenzo@kernel.org>
 <20230917084728.GI1125562@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="STv4kEpNkY3aM+1s"
Content-Disposition: inline
In-Reply-To: <20230917084728.GI1125562@kernel.org>


--STv4kEpNkY3aM+1s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > +
> > +			buf +=3D MTK_WED_PAGE_BUF_SIZE;
>=20
> clang-16 W=3D1 warns that buf is set but otherwise unused in this functio=
n.

Hi Simon,

ack, I will fix it.

Regards,
Lorenzo

>=20
> > +			buf_phys +=3D MTK_WED_PAGE_BUF_SIZE;
> > +		}
> > +
> > +		dma_sync_single_for_device(dev->hw->dev, page_phys, PAGE_SIZE,
> > +					   DMA_BIDIRECTIONAL);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int
> >  mtk_wed_rx_buffer_alloc(struct mtk_wed_device *dev)
> >  {
>=20
> ...

--STv4kEpNkY3aM+1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQgCLAAKCRA6cBh0uS2t
rHLJAP9dn/+SX9tYlfHutMyHQJiV8Khmb/l/EFGbcIin4O+DtgD+LdGGInL4edXQ
VyKXBVc/lNBPzFUkLxDoUHUzmSJ4Cgw=
=B0aa
-----END PGP SIGNATURE-----

--STv4kEpNkY3aM+1s--

