Return-Path: <netdev+bounces-90116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11DF8ACD4E
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 14:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8F71C20D62
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C4414A09D;
	Mon, 22 Apr 2024 12:49:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4A14A08D
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790196; cv=none; b=fj8OeM6liinhuU4YcruuVyl0iWjm+O8kWixMPQonYi/hpybRhFLJdLiq16px6UrjFTwNRNHIt57NnZScesNw9jtk3ESwgWPOwlYjFFIny5i0xqCqTiG/lUD+EedFyFbl5/zhfpzVQO3Ly8PNMhtur8U2JHBIOPZEFNwLjY/Xj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790196; c=relaxed/simple;
	bh=J1qs4OtQ3EUqHG2y1IZiUT6xQ9dEJDRPWh2AmAIBqIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Db8btsirwoKFaPADVQlrpTw4ZDmdqFH/cojiI+Z6upQlledfONCQ8vWErSTfQ3ozgMivv5OSW0ZQCTFccUP+I9Ww3RORaGQ/dl1NGNQwDl2uazMeayveEya2eRK/AGinZfKG9vxUkEhG7ACPBicfLNsG7DUr2803k72Xuy4xMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-o-6D2PikPrqeVoNYz8-oTg-1; Mon, 22 Apr 2024 08:49:48 -0400
X-MC-Unique: o-6D2PikPrqeVoNYz8-oTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1830B834FBE;
	Mon, 22 Apr 2024 12:49:48 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F973200AE7F;
	Mon, 22 Apr 2024 12:49:46 +0000 (UTC)
Date: Mon, 22 Apr 2024 14:49:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Paul Davey <paul.davey@alliedtelesis.co.nz>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH net] xfrm: Preserve vlan tags for transport mode software
 GRO
Message-ID: <ZiZc6ApkxivqaILg@hog>
References: <20240422025711.145577-1-paul.davey@alliedtelesis.co.nz>
 <ZiY0Of0QuDOCPXHg@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZiY0Of0QuDOCPXHg@gauss3.secunet.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-22, 11:56:09 +0200, Steffen Klassert wrote:
> On Mon, Apr 22, 2024 at 02:56:20PM +1200, Paul Davey wrote:
> > The software GRO path for esp transport mode uses skb_mac_header_rebuil=
d
> > prior to re-injecting the packet via the xfrm_napi_dev.  This only
> > copies skb->mac_len bytes of header which may not be sufficient if the
> > packet contains 802.1Q tags or other VLAN tags.  Worse copying only the
> > initial header will leave a packet marked as being VLAN tagged but
> > without the corresponding tag leading to mangling when it is later
> > untagged.
> >=20
> > The VLAN tags are important when receiving the decrypted esp transport
> > mode packet after GRO processing to ensure it is received on the correc=
t
> > interface.
> >=20
> > Therefore record the full mac header length in xfrm*_transport_input fo=
r
> > later use in correpsonding xfrm*_transport_finish to copy the entire ma=
c
> > header when rebuilding the mac header for GRO.  The skb->data pointer i=
s
> > left pointing skb->mac_header bytes after the start of the mac header a=
s
> > is expected by the network stack and network and transport header
> > offsets reset to this location.
> >=20
> > Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
>=20
> Please add a 'Fixes:' tag so it can be backported to stable.
>=20
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index 57c743b7e4fe..0331cfecb28b 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -675,6 +675,9 @@ struct xfrm_mode_skb_cb {
> > =20
> >  =09/* Used by IPv6 only, zero for IPv4. */
> >  =09u8 flow_lbl[3];
> > +
> > +=09/* Used to keep whole l2 header for transport mode GRO */
> > +=09u32 orig_mac_len;
>=20
> xfrm_mode_skb_cb has already reached the maximum size of 48 bytes.
> Adding more will overwrite data in the 'struct sk_buff'.

I thought we already had a BUILD_BUG_ON(sizeof(struct
xfrm_mode_skb_cb) > sizeof_field(struct sk_buff, cb)) somewhere, but
apparently not. I guess it's time to add one? (and xfrm_spi_skb_cb, xfrm_sk=
b_cb)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 161f535c8b94..afc8b3c881e2 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -793,6 +793,8 @@ void __init xfrm_input_init(void)
 =09int err;
 =09int i;
=20
+=09BUILD_BUG_ON(sizeof(struct xfrm_mode_skb_cb) > sizeof_field(struct sk_b=
uff, cb));
+
 =09init_dummy_netdev(&xfrm_napi_dev);
 =09err =3D gro_cells_init(&gro_cells, &xfrm_napi_dev);
 =09if (err)


Actually it looks like we still have 4B in xfrm_mode_skb_cb:

struct xfrm_mode_skb_cb {
=09struct xfrm_tunnel_skb_cb  header;               /*     0    32 */
=09__be16                     id;                   /*    32     2 */
=09__be16                     frag_off;             /*    34     2 */
=09u8                         ihl;                  /*    36     1 */
=09u8                         tos;                  /*    37     1 */
=09u8                         ttl;                  /*    38     1 */
=09u8                         protocol;             /*    39     1 */
=09u8                         optlen;               /*    40     1 */
=09u8                         flow_lbl[3];          /*    41     3 */

=09/* size: 48, cachelines: 1, members: 9 */
=09/* padding: 4 */
=09/* last cacheline: 48 bytes */
};

flow_lbl ends at 44, so adding orig_mac_len should be fine. I don't
see any config options that would increase the size of
xfrm_mode_skb_cb compared to what I already have.

--=20
Sabrina


