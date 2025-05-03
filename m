Return-Path: <netdev+bounces-187593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ABCAA7F76
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 10:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7889A570C
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A59D1B4227;
	Sat,  3 May 2025 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Unjgx5MI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0E13DDBD
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746261585; cv=none; b=mAtjhufBxYthIopUDZyLMU0UlZ3OZegInrk92r4zhTrt5tfAnjihNfOLYKM9eri4/ncxISmAucvun28BG29xn4SBhe2gTpt7r2Q7hi8Xy80K+2mmWR3nvVxXqxW7BDwfj0Ldj9pvq+nfqwhSBd7bWRR13MQn8mcTMsmhFu4fqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746261585; c=relaxed/simple;
	bh=i5FOVUCAfzhUiL5+qj1DqVRPU16eaHDjm6csdpB97ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo88ZpoDRK83z7zGRDEWucXv0uQzhMuJQicelyvUYodj6jM36bu4EZGF7UzNoL13rJEeF0CA4L4W5EeMhCszfPrgOVOOZA34PE+CQw5K6R6HM3scFjZLw8uT/OnTL/54LJeRP5dS8iqMZekM9cwJlgka1XVIchKYcyms3uPncAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Unjgx5MI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCCEC4CEE3;
	Sat,  3 May 2025 08:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746261582;
	bh=i5FOVUCAfzhUiL5+qj1DqVRPU16eaHDjm6csdpB97ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Unjgx5MIQTxUHG418oA+jnqH3i1Zrh9fFbdSLO94GD72QW3dXL0+fMsSfKE6d98Wq
	 pzl5SKC2w0bFROpbJcud5lteK/aoDloRPxpsmUC+zE46hgkyFdA8tx/4FTtHwmccE0
	 53mena/emJYl/pysVf1HWTJJJSQzpV9b6JEkbw3YAtwSh6aQ8BnS7ItFy3rJ6ulRDd
	 20WYorocJkvvtQkCgtyu14rX+fgCHOPMdsnYmyw05dAQg/875dkq7TnptbaYOmgt1B
	 /rDsWf4MQSHP0Qghpv5uDJMLVPkeRS8dJzut2Wk5dQiR3JboRg5J5CefXpiwPjBK1S
	 ll8O7rAXaMJfA==
Date: Sat, 3 May 2025 10:39:39 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v4] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <aBXWSzhXv9RDiJ5L@lore-desk>
References: <20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org>
 <20250501071518.50c92e8c@kernel.org>
 <aBPdyn580lxUMJKz@lore-desk>
 <20250501174140.6dc31b36@kernel.org>
 <aBRzQaonAK0IyAsu@lore-desk>
 <20250502181210.75b9d144@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QLwI2zKfFYdqK9h6"
Content-Disposition: inline
In-Reply-To: <20250502181210.75b9d144@kernel.org>


--QLwI2zKfFYdqK9h6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 02, Jakub Kicinski wrote:
> On Fri, 2 May 2025 09:24:49 +0200 Lorenzo Bianconi wrote:
> > > > What I mean here is the padding in the ppe_mbox_data struct used by=
 the fw running
> > > > on the NPU, not in the version used by the airoha_eth driver, got m=
y point?
> > > > Sorry, re-reading it, it was not so clear, I agree. =20
> > >=20
> > > You mean adding the "u8 rsv[3];" ? that is fine.
> > > I don't get why we also need to add the 3 __packed =20
> >=20
> > I agree the __packed attributes are not mandatory at the moment, we jus=
t agreed
> > with Jacob that is fine to add them. Do you prefer to get rid of them?
>=20
> Yes, they also imply the structure may not be aligned, AFAIU.
> __packed used to be one of DaveM's big no-nos back in the day.
> Especially in vendor drivers it gets sprinkled everywhere without
> thinking. So maybe it's all school of me, but yes, please remove.

ack, fine. I will get rid of them in v5.

Regards,
Lorenzo

--QLwI2zKfFYdqK9h6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaBXWSwAKCRA6cBh0uS2t
rJ49AP97SkyT5VODR7TjKICm1usEvbppaoJ/fwgd0LLsaGXbLAEAkuWgcEM3KyVy
USXxT7N7DP5w+hvwEChv7l3i+tbAwAY=
=U93f
-----END PGP SIGNATURE-----

--QLwI2zKfFYdqK9h6--

