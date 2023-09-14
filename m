Return-Path: <netdev+bounces-33790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F37A026C
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F928163B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069EE208D9;
	Thu, 14 Sep 2023 11:20:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8B208A9
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:20:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A720212A
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694690450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0w2UdLrJqdgdWs0sWpSDZ9frVymAgjA0Y7o5f5PauM=;
	b=KiPr14aJnMAvB4mguTfVN4xVs3RtgYuyidjjcdl8pk3pvRsWeam1T/9+93fKlsLhSL6VBT
	Ld2e+PMT/6rljkjRs/ghpsQ9bh6veUtgGXzCY/xkm6T6EKxxZu8SwHAJYtvcV6ffhaalpC
	khndJHudGzOo1XmXbG3q1GuTKu3afKU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-uPGVxxgWPgGorEvmJduPUw-1; Thu, 14 Sep 2023 07:20:46 -0400
X-MC-Unique: uPGVxxgWPgGorEvmJduPUw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-401bdff6bc5so6469875e9.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 04:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690445; x=1695295245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0w2UdLrJqdgdWs0sWpSDZ9frVymAgjA0Y7o5f5PauM=;
        b=p5DtvpRIff7+z/i5BYZjC6W6AmN76KpKTsqq1fvsktzRfkP6rBFmKTu1V3ZSihaA2v
         XTUwmoJoBO+TBotIqHXTdmQrYyAUkc7qoTH8XfLqeyNEecglr++bgRG4iOlTPdl3Ppl8
         YDaqU/NnaIObNZmzoIgdM51oc3LjdF1l+RFHcO2U+s4MgdLOrH2NvIkGSnq92JAB6kMi
         PkDfhrUcgcZxa9WHzhaA/EbKsmWJ+zD6qD2RCe/9F9tEwMd5zhbyC/KGZ6Wz8U2WAM24
         Kd/yCva92ANU1+lEI7bPwutH5aIZ2NICnIuhPmnPe4zx7xnkkMddZnpy3LFZTXTT/bVq
         z+sQ==
X-Gm-Message-State: AOJu0YxDP1CnbXyg16EylHNYU5MRiFrrUcVFHQiPXrITlWrCm5CyxDsk
	Qw9FzFuMEfPdwUL6RhOk1lTZF4kkFe2opf/jwyhQ67Rxg4r9ozWDiWuEovZUDz6K3NPCHm7cHCq
	F+6L9+patUbA9DhH4
X-Received: by 2002:a7b:c012:0:b0:402:906:1e87 with SMTP id c18-20020a7bc012000000b0040209061e87mr4378340wmb.31.1694690445695;
        Thu, 14 Sep 2023 04:20:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWxduDgMGX19KAnwNSVzvTq/m4iKUo2+HIfWIYmu4Bu/Kc8V9eqAD8oxcu6Zosz8DU6vq98A==
X-Received: by 2002:a7b:c012:0:b0:402:906:1e87 with SMTP id c18-20020a7bc012000000b0040209061e87mr4378326wmb.31.1694690445329;
        Thu, 14 Sep 2023 04:20:45 -0700 (PDT)
Received: from localhost (net-2-34-76-254.cust.vodafonedsl.it. [2.34.76.254])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b00401e32b25adsm1722392wmr.4.2023.09.14.04.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:20:44 -0700 (PDT)
Date: Thu, 14 Sep 2023 13:20:43 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
	jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org
Subject: Re: [PATCH v8 2/3] NFSD: introduce netlink rpc_status stubs
Message-ID: <ZQLsi7uJdIF4QZ41@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>
 <ZP9wrLXKWtvMt4mZ@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PlTJBGbvmNFQkrv5"
Content-Disposition: inline
In-Reply-To: <ZP9wrLXKWtvMt4mZ@tissot.1015granger.net>


--PlTJBGbvmNFQkrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Sep 11, 2023 at 02:49:45PM +0200, Lorenzo Bianconi wrote:
> > Generate empty netlink stubs and uAPI through nfsd_server.yaml specs:
> >=20
> > $./tools/net/ynl/ynl-gen-c.py --mode uapi \
> >  --spec Documentation/netlink/specs/nfsd_server.yaml \
> >  --header -o include/uapi/linux/nfsd_server.h
> > $./tools/net/ynl/ynl-gen-c.py --mode kernel \
> >  --spec Documentation/netlink/specs/nfsd_server.yaml \
> >  --header -o fs/nfsd/nfs_netlink_gen.h
> > $./tools/net/ynl/ynl-gen-c.py --mode kernel \
> >  --spec Documentation/netlink/specs/nfsd_server.yaml \
> >  --source -o fs/nfsd/nfs_netlink_gen.c
>=20
> Actually there's a tool that walks the whole kernel source tree
> and handles any files that contain the YNL-GEN tag:
>=20
> $ tools/net/ynl/ynl-regen.sh
>=20
>=20
> > Tested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  fs/nfsd/Makefile                 |  3 +-
> >  fs/nfsd/nfs_netlink_gen.c        | 32 +++++++++++++++++++++
> >  fs/nfsd/nfs_netlink_gen.h        | 22 ++++++++++++++
> >  fs/nfsd/nfsctl.c                 | 16 +++++++++++
> >  include/uapi/linux/nfsd_server.h | 49 ++++++++++++++++++++++++++++++++
> >  5 files changed, 121 insertions(+), 1 deletion(-)
> >  create mode 100644 fs/nfsd/nfs_netlink_gen.c
> >  create mode 100644 fs/nfsd/nfs_netlink_gen.h
> >  create mode 100644 include/uapi/linux/nfsd_server.h
> >=20
> > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > index 6fffc8f03f74..6ae1d5450bf6 100644
> > --- a/fs/nfsd/Makefile
> > +++ b/fs/nfsd/Makefile
> > @@ -12,7 +12,8 @@ nfsd-y			+=3D trace.o
> > =20
> >  nfsd-y 			+=3D nfssvc.o nfsctl.o nfsfh.o vfs.o \
> >  			   export.o auth.o lockd.o nfscache.o \
> > -			   stats.o filecache.o nfs3proc.o nfs3xdr.o
> > +			   stats.o filecache.o nfs3proc.o nfs3xdr.o \
> > +			   nfs_netlink_gen.o
> >  nfsd-$(CONFIG_NFSD_V2) +=3D nfsproc.o nfsxdr.o
> >  nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
> >  nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
> > diff --git a/fs/nfsd/nfs_netlink_gen.c b/fs/nfsd/nfs_netlink_gen.c
> > new file mode 100644
> > index 000000000000..4d71b80bf4a7
> > --- /dev/null
> > +++ b/fs/nfsd/nfs_netlink_gen.c
>=20
> I'd like a shorter file name. How about fs/nfsd/netlink.c
> (and below, netlink.h) ?

ack, fine

Regards,
Lorenzo

>=20
>=20
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-=
3-Clause)
> > +/* Do not edit directly, auto-generated from: */
> > +/*	Documentation/netlink/specs/nfsd_server.yaml */
> > +/* YNL-GEN kernel source */
> > +
> > +#include <net/netlink.h>
> > +#include <net/genetlink.h>
> > +
> > +#include "nfs_netlink_gen.h"
> > +
> > +#include <uapi/linux/nfsd_server.h>
> > +
> > +/* Ops table for nfsd_server */
> > +static const struct genl_split_ops nfsd_server_nl_ops[] =3D {
> > +	{
> > +		.cmd	=3D NFSD_CMD_RPC_STATUS_GET,
> > +		.start	=3D nfsd_server_nl_rpc_status_get_start,
> > +		.dumpit	=3D nfsd_server_nl_rpc_status_get_dumpit,
> > +		.done	=3D nfsd_server_nl_rpc_status_get_done,
> > +		.flags	=3D GENL_CMD_CAP_DUMP,
> > +	},
> > +};
> > +
> > +struct genl_family nfsd_server_nl_family __ro_after_init =3D {
> > +	.name		=3D NFSD_SERVER_FAMILY_NAME,
> > +	.version	=3D NFSD_SERVER_FAMILY_VERSION,
> > +	.netnsok	=3D true,
> > +	.parallel_ops	=3D true,
> > +	.module		=3D THIS_MODULE,
> > +	.split_ops	=3D nfsd_server_nl_ops,
> > +	.n_split_ops	=3D ARRAY_SIZE(nfsd_server_nl_ops),
> > +};
> > diff --git a/fs/nfsd/nfs_netlink_gen.h b/fs/nfsd/nfs_netlink_gen.h
> > new file mode 100644
> > index 000000000000..f66b29e528c1
> > --- /dev/null
> > +++ b/fs/nfsd/nfs_netlink_gen.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-=
3-Clause) */
> > +/* Do not edit directly, auto-generated from: */
> > +/*	Documentation/netlink/specs/nfsd_server.yaml */
> > +/* YNL-GEN kernel header */
> > +
> > +#ifndef _LINUX_NFSD_SERVER_GEN_H
> > +#define _LINUX_NFSD_SERVER_GEN_H
> > +
> > +#include <net/netlink.h>
> > +#include <net/genetlink.h>
> > +
> > +#include <uapi/linux/nfsd_server.h>
> > +
> > +int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb);
> > +int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb);
> > +
> > +int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> > +					 struct netlink_callback *cb);
> > +
> > +extern struct genl_family nfsd_server_nl_family;
> > +
> > +#endif /* _LINUX_NFSD_SERVER_GEN_H */
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 33f80d289d63..1be66088849c 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1495,6 +1495,22 @@ static int create_proc_exports_entry(void)
> > =20
> >  unsigned int nfsd_net_id;
> > =20
> > +int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb)
> > +{
> > +	return 0;
> > +}
> > +
> > +int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
> > +{
> > +	return 0;
> > +}
> > +
> > +int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> > +					 struct netlink_callback *cb)
> > +{
> > +	return 0;
> > +}
> > +
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
> > diff --git a/include/uapi/linux/nfsd_server.h b/include/uapi/linux/nfsd=
_server.h
> > new file mode 100644
> > index 000000000000..c9ee00ceca3b
> > --- /dev/null
> > +++ b/include/uapi/linux/nfsd_server.h
> > @@ -0,0 +1,49 @@
> > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-=
3-Clause) */
> > +/* Do not edit directly, auto-generated from: */
> > +/*	Documentation/netlink/specs/nfsd_server.yaml */
> > +/* YNL-GEN uapi header */
> > +
> > +#ifndef _UAPI_LINUX_NFSD_SERVER_H
> > +#define _UAPI_LINUX_NFSD_SERVER_H
> > +
> > +#define NFSD_SERVER_FAMILY_NAME		"nfsd_server"
> > +#define NFSD_SERVER_FAMILY_VERSION	1
> > +
> > +enum nfsd_rpc_status_comp_attr {
> > +	NFSD_ATTR_RPC_STATUS_COMP_UNSPEC,
> > +	NFSD_ATTR_RPC_STATUS_COMP_OP,
> > +
> > +	__NFSD_ATTR_RPC_STATUS_COMP_MAX,
> > +	NFSD_ATTR_RPC_STATUS_COMP_MAX =3D (__NFSD_ATTR_RPC_STATUS_COMP_MAX - =
1)
> > +};
> > +
> > +enum nfsd_rpc_status_attr {
> > +	NFSD_ATTR_RPC_STATUS_UNSPEC,
> > +	NFSD_ATTR_RPC_STATUS_XID,
> > +	NFSD_ATTR_RPC_STATUS_FLAGS,
> > +	NFSD_ATTR_RPC_STATUS_PROG,
> > +	NFSD_ATTR_RPC_STATUS_VERSION,
> > +	NFSD_ATTR_RPC_STATUS_PROC,
> > +	NFSD_ATTR_RPC_STATUS_SERVICE_TIME,
> > +	NFSD_ATTR_RPC_STATUS_PAD,
> > +	NFSD_ATTR_RPC_STATUS_SADDR4,
> > +	NFSD_ATTR_RPC_STATUS_DADDR4,
> > +	NFSD_ATTR_RPC_STATUS_SADDR6,
> > +	NFSD_ATTR_RPC_STATUS_DADDR6,
> > +	NFSD_ATTR_RPC_STATUS_SPORT,
> > +	NFSD_ATTR_RPC_STATUS_DPORT,
> > +	NFSD_ATTR_RPC_STATUS_COMPOND_OP,
> > +
> > +	__NFSD_ATTR_RPC_STATUS_MAX,
> > +	NFSD_ATTR_RPC_STATUS_MAX =3D (__NFSD_ATTR_RPC_STATUS_MAX - 1)
> > +};
> > +
> > +enum nfsd_commands {
> > +	NFSD_CMD_UNSPEC,
> > +	NFSD_CMD_RPC_STATUS_GET,
> > +
> > +	__NFSD_CMD_MAX,
> > +	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > +};
> > +
> > +#endif /* _UAPI_LINUX_NFSD_SERVER_H */
> > --=20
> > 2.41.0
> >=20
>=20
> --=20
> Chuck Lever
>=20

--PlTJBGbvmNFQkrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQLsigAKCRA6cBh0uS2t
rC5MAP9CsNitmKH8nOzjRn/XTFSM6YbzBCiinM8+wHPgjA7fLwD+NANNphT4ixjD
S/XwhuiqOqq+JmMSkMeUKwltf/7uQwM=
=SAmZ
-----END PGP SIGNATURE-----

--PlTJBGbvmNFQkrv5--


