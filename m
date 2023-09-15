Return-Path: <netdev+bounces-34198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E537A295F
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 23:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C6F28214F
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C041B294;
	Fri, 15 Sep 2023 21:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C501B280
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 21:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADBBC433C7;
	Fri, 15 Sep 2023 21:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694813422;
	bh=IE5p4JSNZrnyQ5NkdKwOkBCLR+K9s6w7E8lMOvmGkbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1NeY9/8VUQSHYDjJBNn8tCXWgerij/LLyG3APed862kRhI4C1xLMJlh+UTkqaBvR
	 0SRSr94DRfSHke09mcE1ttBDzbNPkzSUfCAJe5/jTOmOxufcshb9yb/MUViDU5ETxH
	 db0NzEoNEH+iiirOXn4jo1A5IEJo32yG8vR4te9pyA3Zdb05HqpZOWqjkwgEBDN5wj
	 LwI5uAuPqHUrL4sLxBCnj9rYhEOwR5vUf//bYOrqYsVhe0xow3oJG22m93M3O9C8zw
	 zcaNep4e6VQYUXj791AFheQP4F/sHR8ojwkoXCC9b+fpV2k16eY3W3LBsEEjGzieCh
	 FCVcjyLDCgR1Q==
Date: Fri, 15 Sep 2023 23:30:18 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
	jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org
Subject: Re: [PATCH v8 0/3] add rpc_status netlink support for NFSD
Message-ID: <ZQTM6l7NrsVHFoR5@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ZQSvV/eZOohnQulw@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3NQQk77BtSnZXGh"
Content-Disposition: inline
In-Reply-To: <ZQSvV/eZOohnQulw@tissot.1015granger.net>


--j3NQQk77BtSnZXGh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> >  Documentation/netlink/specs/nfsd_server.yaml |  97 +++++++++
> >  fs/nfsd/Makefile                             |   3 +-
> >  fs/nfsd/nfs_netlink_gen.c                    |  32 +++
> >  fs/nfsd/nfs_netlink_gen.h                    |  22 ++
> >  fs/nfsd/nfsctl.c                             | 204 +++++++++++++++++++
> >  fs/nfsd/nfsd.h                               |  16 ++
> >  fs/nfsd/nfssvc.c                             |  15 ++
> >  fs/nfsd/state.h                              |   2 -
> >  include/linux/sunrpc/svc.h                   |   1 +
> >  include/uapi/linux/nfsd_server.h             |  49 +++++
> >  10 files changed, 438 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/netlink/specs/nfsd_server.yaml
> >  create mode 100644 fs/nfsd/nfs_netlink_gen.c
> >  create mode 100644 fs/nfsd/nfs_netlink_gen.h
> >  create mode 100644 include/uapi/linux/nfsd_server.h
>=20
> Hi Lorenzo -
>=20
> I've applied these three to nfsd-next with the following changes:
>=20
> - Renaming as we discussed
> - Replaced the nested compound_op attribute -- may require some user
>   space tooling changes
> - Simon's Smatch bug fixed
> - Squashed 1/3 and 2/3 into one patch
> - Added Closes/Acked-by etc

Hi Chuck,

Thanks for addressing the points above.

>=20
> If you spot a bug, send patches against nfsd-next and I can squash
> them in.

ack, I will do

>=20
> I was wondering if you have a little more time to try adding one or
> two control cmds. write_threads and v4_end_grace might be simple
> ones to start with. No problem if you are "done" with this project,
> I can add these over time.

sure, no worries. I will look into them soon :)

Regards,
Lorenzo

>=20
> --=20
> Chuck Lever

--j3NQQk77BtSnZXGh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQTM6gAKCRA6cBh0uS2t
rOHrAQCVFojQGWe8/TmloGIv2WM6LrjFK5Ah0jd13B7EX4mYkgEA66jlWMccoFRN
O1vvSPGzoln8cUd0NrEQ5f0l5xZe2g0=
=kiJ0
-----END PGP SIGNATURE-----

--j3NQQk77BtSnZXGh--

