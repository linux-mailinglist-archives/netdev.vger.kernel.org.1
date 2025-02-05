Return-Path: <netdev+bounces-162905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86CAA2862C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BDC161853
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75922A4DF;
	Wed,  5 Feb 2025 09:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123122A4D3
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746527; cv=none; b=WK8+6P2cKbUNtnJ6ITGkf/l7Fu5AdqtmtY7Ddrus6x8aM3OeIB7LIcREmi3BSvizWpccm9MJDJl2HoxgyaQpUsjdff9GzYEl8ClT8A4nTVW329amHAvpni/nmlmFyw2S5dC8jB8xQ0BWYqMPLP2phMVJ5gIaoLIYQXq3yLolChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746527; c=relaxed/simple;
	bh=eyjwSYL6CHbXEnYtbrhgqV9Nj0bQSbv15fevYa1u4po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALglS+TAanEzRXf5vQ+3lHOBFZYL5r9D+vZSPJ1eA/kDTHsRFKA8DF2ax8ZCfx8hUFDDCjDDmTI7IXchp2vmtCxlIqQIHKXp1JBxVmwnjP5cCFAJ5VqvrDNeXPcY3SUpP4X3mfVzkKvqYJfVarf0Fr/YQSq3puwLx/YcfEIyGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 9t/rlZf1TleT2iiKV3LsQg==
X-CSE-MsgGUID: ofUtRyAHT/yTp1bZV5XZEg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2025 18:08:41 +0900
Received: from [10.24.0.173] (unknown [10.24.0.173])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6A44F4017963;
	Wed,  5 Feb 2025 18:08:24 +0900 (JST)
Message-ID: <ec6e53a9-8d3e-4b83-b4d9-1f089920fe84@bp.renesas.com>
Date: Wed, 5 Feb 2025 09:08:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/4] Extend napi threaded polling to allow
 kthread based busy polling
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com
Cc: netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <20250205001052.2590140-4-skhawaja@google.com>
Content-Language: en-GB
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250205001052.2590140-4-skhawaja@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1kpSb298BunWTlYxHAN3qMpe"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1kpSb298BunWTlYxHAN3qMpe
Content-Type: multipart/mixed; boundary="------------l02xccWfJ0nA5JQRtJQ00pBR";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com
Cc: netdev@vger.kernel.org
Message-ID: <ec6e53a9-8d3e-4b83-b4d9-1f089920fe84@bp.renesas.com>
Subject: Re: [PATCH net-next v3 3/4] Extend napi threaded polling to allow
 kthread based busy polling
References: <20250205001052.2590140-1-skhawaja@google.com>
 <20250205001052.2590140-4-skhawaja@google.com>
In-Reply-To: <20250205001052.2590140-4-skhawaja@google.com>

--------------l02xccWfJ0nA5JQRtJQ00pBR
Content-Type: multipart/mixed; boundary="------------oXeR6Z2an66MZ0vDJUc7ftVa"

--------------oXeR6Z2an66MZ0vDJUc7ftVa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2025 00:10, Samiullah Khawaja wrote:
> Add a new state to napi state enum:
>=20
> - STATE_THREADED_BUSY_POLL
>   Threaded busy poll is enabled/running for this napi.
>=20
> Following changes are introduced in the napi scheduling and state logic=
:
>=20
> - When threaded busy poll is enabled through sysfs it also enables
>   NAPI_STATE_THREADED so a kthread is created per napi. It also sets
>   NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that we ar=
e
>   supposed to busy poll for each napi.
>=20
> - When napi is scheduled with STATE_SCHED_THREADED and associated
>   kthread is woken up, the kthread owns the context. If
>   NAPI_STATE_THREADED_BUSY_POLL and NAPI_SCHED_THREADED both are set
>   then it means that we can busy poll.
>=20
> - To keep busy polling and to avoid scheduling of the interrupts, the
>   napi_complete_done returns false when both SCHED_THREADED and
>   THREADED_BUSY_POLL flags are set. Also napi_complete_done returns
>   early to avoid the STATE_SCHED_THREADED being unset.
>=20
> - If at any point STATE_THREADED_BUSY_POLL is unset, the
>   napi_complete_done will run and unset the SCHED_THREADED bit also.
>   This will make the associated kthread go to sleep as per existing
>   logic.
>=20
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  Documentation/ABI/testing/sysfs-class-net     |  3 +-
>  Documentation/netlink/specs/netdev.yaml       | 12 ++--
>  Documentation/networking/napi.rst             | 67 ++++++++++++++++-
>  .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
>  drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
>  drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
>  drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
>  include/linux/netdevice.h                     | 20 ++++--
>  include/uapi/linux/netdev.h                   |  6 ++
>  net/core/dev.c                                | 72 ++++++++++++++++---=

>  net/core/net-sysfs.c                          |  2 +-
>  net/core/netdev-genl-gen.c                    |  2 +-
>  net/core/netdev-genl.c                        |  2 +-
>  tools/include/uapi/linux/netdev.h             |  6 ++
>  14 files changed, 171 insertions(+), 29 deletions(-)

Please copy in the maintainers of the network drivers which have been cha=
nged.

For ravb,
Acked-by: Paul Barker <paul.barker.ct@bp.renesas.com>

--=20
Paul Barker
--------------oXeR6Z2an66MZ0vDJUc7ftVa
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------oXeR6Z2an66MZ0vDJUc7ftVa--

--------------l02xccWfJ0nA5JQRtJQ00pBR--

--------------1kpSb298BunWTlYxHAN3qMpe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ6MqhwUDAAAAAAAKCRDbaV4Vf/JGvVgg
AQCbAO5s/EKoR46bSjmpFU6/A7aciTYTJXxSnvuQkNyrbQD/UalBuQLPMQYS5ZKhxwoL+662EeKJ
0KRi7lazDRWxAQY=
=dRyP
-----END PGP SIGNATURE-----

--------------1kpSb298BunWTlYxHAN3qMpe--

