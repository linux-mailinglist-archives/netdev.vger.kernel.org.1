Return-Path: <netdev+bounces-204487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBE8AFAD02
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257CF1889CB5
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1BF28641B;
	Mon,  7 Jul 2025 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYI6CPV2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D0285C8B;
	Mon,  7 Jul 2025 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873074; cv=none; b=PbEi+TWbKBxRnxzDG1GzEiHNPWfBykaHAB1imjwqLhTVZMUWZcped+RQg+I7YJ/27LoLM7QKEFfE15iFI8p+btiWFO04Kn+iIhC4Q8FQTB72LhqiojZvZbO48WJR+/cNjymo1nIzbm1v+UHlKI0RZQ8fytXRqrHo5Cab5CYNaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873074; c=relaxed/simple;
	bh=vAfI9Wzfd2UxcyYtb1q0p59LDd0HpdCjyQmUuTb6HKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNC1wxxN8SETKzezIS+6qzAyG0bjYT7/nL8XjKe4jSYfcwn+I94BW2Tlf+kZllVq6WirdO2xSVo0fHGhYgGbJ4pUGZPzTVB/LbciBr/hHC2eRLklPaL1uV7F2ziFEWE6NzgBMJHX5PX/TFe5ZPdQBbnXjTOwDNyhvtmmPdaEwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYI6CPV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09D7C4CEE3;
	Mon,  7 Jul 2025 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751873074;
	bh=vAfI9Wzfd2UxcyYtb1q0p59LDd0HpdCjyQmUuTb6HKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYI6CPV2hkyw7EsU1mgnmwJKkZ/4uzpTCwsqqMswAmUP8Pi3GSQcPS9e/tFukS7t5
	 dWi5olzbrTVSFCJv19R70GmujJn2hWuV1mpEj97fGLxnWjtGWeSRUvcRsEumMaDuwD
	 w2mgAPuCjJj9cFaMEygQFVWmlaujA8sNK/4B/X/WcIhgmOADjvRnuLXuHFhPtN1F9X
	 alWebXnGWNspziW3KTMpSPdgrCmWKMV1qGA60b8wBVuZuOfd92Wx4YZU+YTDsjWFJ7
	 XIiNlksTPFD/JJAYbFZlEDqMO68R39OJGQiC60BPe8XrEVyLIFScxIdCmix9JvHKnH
	 A5o136EeHBztA==
Date: Mon, 7 Jul 2025 09:24:31 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH net-next v2 2/7] net: airoha: npu: Add NPU wlan memory
 initialization commands
Message-ID: <aGt2L1e3xbWVoqOO@lore-desk>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
 <20250705-airoha-en7581-wlan-offlaod-v2-2-3cf32785e381@kernel.org>
 <20250707-agile-aardwolf-of-politeness-29fead@krzk-bin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W0USTkeDKBVNDBPv"
Content-Disposition: inline
In-Reply-To: <20250707-agile-aardwolf-of-politeness-29fead@krzk-bin>


--W0USTkeDKBVNDBPv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Jul 05, 2025 at 11:09:46PM +0200, Lorenzo Bianconi wrote:
> > +
> >  struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stat=
s_addr)
> >  {
> >  	struct platform_device *pdev;
> > @@ -493,6 +573,7 @@ static int airoha_npu_probe(struct platform_device =
*pdev)
> >  	npu->ops.ppe_deinit =3D airoha_npu_ppe_deinit;
> >  	npu->ops.ppe_flush_sram_entries =3D airoha_npu_ppe_flush_sram_entries;
> >  	npu->ops.ppe_foe_commit_entry =3D airoha_npu_foe_commit_entry;
> > +	npu->ops.wlan_init_reserved_memory =3D airoha_npu_wlan_init_memory;
>=20
> I cannot find in your code single place calling this (later you add a
> wrapper... which is not called either).
>=20
> All this looks like dead code...

As pointed out in the commit log, these callbacks will be used by MT76 driv=
er
to initialize the NPU reserved memory and registers during driver probe in
order to initialize the WiFi offloading. Since MT76 patches are going via
the wireless tree, I needed to add these callbacks first.

Regards,
Lorenzo

>=20
> Best regards,
> Krzysztof
>=20

--W0USTkeDKBVNDBPv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaGt2LwAKCRA6cBh0uS2t
rEqNAPwMOyfRSkdrks1eKCEqkTbnlkMiO4b/hvkixAvW+Qz7VAD/X8vv31rQ27pa
HzOWU62kGM7ToyWSw8D1Zvnc1cEe2ww=
=Y9hx
-----END PGP SIGNATURE-----

--W0USTkeDKBVNDBPv--

