Return-Path: <netdev+bounces-27619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFD77C90D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90E0280DE9
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675ABA26;
	Tue, 15 Aug 2023 08:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99A23C0
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:01:49 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F11984;
	Tue, 15 Aug 2023 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1692086504;
	bh=ZX+DKBNcQQA96+iZBsOLmnrHPJfNYbnO+Mt+UG52F6I=;
	h=Date:From:To:Cc:Subject:From;
	b=SKkHT2uyEY221tuT5QZFJBWGZt+mb58bqyouVZUAUyqgjrSvtpTLafA5c4dD/DUVz
	 83tGkHZeBbywBhGedT0pUIe/yZgcI/mKffqUNhkQKAGbqPWxNdE4sV9nKU6OU+XmEL
	 N21YFL8gnTkui9r7F8oqksuw1h5NL4eQDQui8m2TYS1dAoE/1HVrX+8AN3jawFnpXQ
	 kimMVLatr6YS43vyFZcBhmTetREmsrAPrKjjiIP7pc1oHCSbg5kG2TqKLM6hO1fB5E
	 PPwHWgCJBvXwMJ3d2iJEg+tikIIgu/G4CAP7uayCEjYBDTa9ZExOM+auCmkgElRMSJ
	 KPBUhifQZVrYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ3d32YJQz4wbP;
	Tue, 15 Aug 2023 18:01:43 +1000 (AEST)
Date: Tue, 15 Aug 2023 18:01:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Gavin Li <gavinl@nvidia.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: linux-next: manual merge of the vhost tree with the net-next tree
Message-ID: <20230815180142.07a89703@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u_Dq3HKYyRlWpZq3vluuvn4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/u_Dq3HKYyRlWpZq3vluuvn4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/net/virtio_net.c

between commit:

  308d7982dcdc ("virtio_net: extract interrupt coalescing settings to a str=
ucture")

from the net-next tree and commit:

  1a08d66726dc ("virtio_net: merge dma operations when filling mergeable bu=
ffers")

from the vhost tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/virtio_net.c
index edfd5d8833e4,c9cab3f966db..000000000000
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@@ -127,11 -126,14 +127,19 @@@ static const struct virtnet_stat_desc v
  #define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
  #define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
 =20
 +struct virtnet_interrupt_coalesce {
 +	u32 max_packets;
 +	u32 max_usecs;
 +};
 +
+ /* The dma information of pages allocated at a time. */
+ struct virtnet_rq_dma {
+ 	dma_addr_t addr;
+ 	u32 ref;
+ 	u16 len;
+ 	u16 need_sync;
+ };
+=20
  /* Internal representation of a send virtqueue */
  struct send_queue {
  	/* Virtqueue associated with this send _queue */

--Sig_/u_Dq3HKYyRlWpZq3vluuvn4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbMOYACgkQAVBC80lX
0GzvYgf5AR9fianxz6eRpHoXvFZXzXlDJhXOfJBRsXWIRDpKRtzhDVDFtVZY2VYE
d8CQCx3GRLv0WtoN3MMX3bGyZwBVA4AFwxQAEqjbUvOsfVoupzajc4BGGEcM8Mja
HX2aRO7NVZ/JEFhC38pKz4RqmDfdju9ziVSLVVLtPvCNpXde1oQrTXT75wnrpD4n
dcRHtkY13HrCp+72zOGExQnpvSXC5Q5VGxG2TnwQaCxdXVCPZAhwGmrGlhH7sYFE
yETSHDL8J/FMP6Itpgk6kLrJcXCSWQHGCICma9Hmv1HkceFW2mxk5e+cQpZSraK+
BtjkX4dFiXz4WBVPtubJCuYMhNi9PA==
=IAI9
-----END PGP SIGNATURE-----

--Sig_/u_Dq3HKYyRlWpZq3vluuvn4--

