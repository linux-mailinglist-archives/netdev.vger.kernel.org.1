Return-Path: <netdev+bounces-190943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0546AB95FA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D443A557F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 06:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50913223DC7;
	Fri, 16 May 2025 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jru3G860"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E421C9ED
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747376972; cv=none; b=WrUxiYpkbqmgtFuRkTikc0FsO16vMAVo/2bzBj1Tg5OXLu1/OnuZ75IfyzwiKaLguP5XYCYEOPteJXICXHzpshxCDrYz5m+0L+lBo1tUCDsFn2XCD4sfBBphnqstad0WUb+RmBTC8jc1oEQlCgoQyrRuPfKchbwqtEiCIvU2FmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747376972; c=relaxed/simple;
	bh=GMpG59QzFjmQJhyXn36tq9RZEy3QQClR9qhP+5osv34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm8IaUx+HCNM2hzRKR0e1DwbBBXEvIG8XU7dCSnbW6ryNAnh02BSu4lGnuhP5QHWpI/vUEURvnRL+RqjVfXiK7jvJzYj/ai24sjFu9vT5JHYB4AJnDpw8o7G+sPyq6f7ebzhyjMn5GvYZCjtNvjIKNTKht+RcztKkzlCSNC/B1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jru3G860; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44775C4CEE4;
	Fri, 16 May 2025 06:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747376970;
	bh=GMpG59QzFjmQJhyXn36tq9RZEy3QQClR9qhP+5osv34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jru3G860j4OrQ4sjJuJZ0V6IPrStGqsvRShuUKn0qHp7+4y3rDiPqD3+FzUuriZw0
	 Q+gIyBrHOELmci6CLOrj6PyuESjaqph2HgcOUBeZ4hmQgllP34bPOCgf4sEv6kkN7j
	 SEgpor1514gSclkNRx9i0R1O4emrqo54fJgCQBOea8wJGPq1fM3X6ARCV8E0U1XtSt
	 j4roUgnArhLE3hfTvr9FcqQeKOUmWbjT/oqSTLw0hINqa/GjtyWMxb5Fv5fRACO67X
	 FWYDXtZ9JAo3HCB0+56ViYRVGDgSzru7/nSug1xMry2aswKCZLPb0RRdhQZj5MoLtp
	 9uaz9tGuyJQBw==
Date: Fri, 16 May 2025 08:29:28 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: airoha: Add FLOW_CLS_STATS callback
 support
Message-ID: <aCbbSHkBRrm4yM1f@lore-desk>
References: <20250514-airoha-en7581-flowstats-v1-0-c00ede12a2ca@kernel.org>
 <20250514-airoha-en7581-flowstats-v1-2-c00ede12a2ca@kernel.org>
 <20250515181357.73f98a18@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JVIPhaKnT2FG04Av"
Content-Disposition: inline
In-Reply-To: <20250515181357.73f98a18@kernel.org>


--JVIPhaKnT2FG04Av
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 15, Jakub Kicinski wrote:
> On Wed, 14 May 2025 19:09:58 +0200 Lorenzo Bianconi wrote:
> > Introduce per-flow stats accounting to the flowtable hw offload in
> > the airoha_eth driver. Flow stats are split in the PPE and NPU modules:
> > - PPE: accounts for high 32bit of per-flow stats
> > - NPU: accounts for low 32bit of per-flow stats
> >=20
> > FLOW_CLS_STATS can be enabled or disabled at compile time.
>=20
> sparse isn't happy:
>=20
> drivers/net/ethernet/airoha/airoha_npu.c:382:15: warning: incorrect type =
in assignment (different address spaces)
> drivers/net/ethernet/airoha/airoha_npu.c:382:15:    expected void *stats
> drivers/net/ethernet/airoha/airoha_npu.c:382:15:    got void [noderef] __=
iomem *

ack, I will fix it in v2.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--JVIPhaKnT2FG04Av
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaCbbRwAKCRA6cBh0uS2t
rBb6AQCU1LBy3I0ss9c5I93glLBLPtNpVMYzqWkulMBHE1cEyQD8D9hfs9GxwKEZ
kcYzMMelMHCuvgw1JYcHYp0OLAWalQY=
=6am5
-----END PGP SIGNATURE-----

--JVIPhaKnT2FG04Av--

