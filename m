Return-Path: <netdev+bounces-80974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27822885608
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5BE2820AF
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9995320312;
	Thu, 21 Mar 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INDYTehX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758B8199AD
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010940; cv=none; b=ogoguUASdSfOjf+Cz3XtseaU50deQSJvQRKUxdZT87+NzBBNZ20C6YKADnrVM5eNEPfNcNFyYbDuyzvIJOdYZVI4LSYi7MtuWLyA2v0Ve5MMSVCzESoIPWt521sVPuN1a9Wb3SKc2bNWgI7ePEMllydX0/AVVzHiRorSBEllb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010940; c=relaxed/simple;
	bh=A648/ivjaayAatNcA2V4iinwFgxH1OJvHbuOVG7H7E4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=HLtlenxxRGS+uRZFgNz6XJPjs46nReVuSOx2aiwRMJqggQpbfX0z9cL7w4CQFG8MeJVGRDPUrTIeP3O60aNwJLdmv9aZdNUz59zwjiA1K2Zvvf8/eoRTk9caQVyb1e11cv1sQYmPGp4H1+usiISVc9XwKHVAaP6i8NmRad6JkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INDYTehX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45E5C433C7;
	Thu, 21 Mar 2024 08:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711010940;
	bh=A648/ivjaayAatNcA2V4iinwFgxH1OJvHbuOVG7H7E4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=INDYTehXe4/x3uzXuk3vtQ6aZ74eEbFqTANivxCbU/3BrdcJF0+i4cBJy9h/oz+Vj
	 QRB/KGmDEeOKh7jJxK5gtCi9o9r1IQN6K0301S1VldviphHXft5/gezryP+Ai13hfb
	 /fBWtU4UBNNUGyUc4Pjuru6lU41oLUTSAQL+R7ZjFCedSQ5CrGzWe9a9dzSP2l4v6Z
	 nc6QG0UWDzeCaTWGgDh/NMAYIzGEiyG9l38RopzL6PEVKzrciY7xgipXxr92Vji07G
	 dOflPDQnBkQetpKcIdLwbLVFH7vFp0Ec6sjUalgO92LaKjLnAmCPt7mcXqMi2845aK
	 3FtHE+8aukpBw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65fb4a8b1389_1faab3294c8@willemb.c.googlers.com.notmuch>
References: <20240319093140.499123-1-atenart@kernel.org> <20240319093140.499123-4-atenart@kernel.org> <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch> <171086409633.4835.11427072260403202761@kwain> <65fade00e4c24_1c19b8294cf@willemb.c.googlers.com.notmuch> <171094732998.5492.6523626232845873652@kwain> <65fb4a8b1389_1faab3294c8@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v2 3/4] udp: do not transition UDP fraglist to unnecessary checksum
From: Antoine Tenart <atenart@kernel.org>
Cc: steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 21 Mar 2024 09:48:57 +0100
Message-ID: <171101093713.5492.11530876509254833591@kwain>

Quoting Willem de Bruijn (2024-03-20 21:43:55)
> Antoine Tenart wrote:
> > Quoting Willem de Bruijn (2024-03-20 14:00:48)
> > > Antoine Tenart wrote:
> > > > Quoting Willem de Bruijn (2024-03-19 14:38:20)
> > > > >=20
> > > > > The original patch converted to CHECKSUM_UNNECESSARY for a reason.
> > > > > The skb->csum of the main gso_skb is not valid?
> > > > >=20
> > > > > Should instead only the csum_level be adjusted, to always keep
> > > > > csum_level =3D=3D 0?
> > > >=20
> > > > The above trace is an ICMPv6 packet being tunneled and GROed at the=
 UDP
> > > > level, thus we have:
> > > >   UDP(CHECKSUM_PARTIAL)/Geneve/ICMPv6(was CHECKSUM_NONE)
> > > > csum_level would need to be 1 here; but we can't know that.
> > >=20
> > > Is this a packet looped internally? Else it is not CHECKSUM_PARTIAL.
> >=20
> > I'm not sure to follow, CHECKSUM_NONE packets going in a tunnel will be
> > encapsulated and the outer UDP header will be CHECKSUM_PARTIAL. The
> > packet can be looped internally or going to a remote host.
>=20
> That is on transmit. To come into contact with UDP_GRO while having
> CHECKSUM_PARTIAL the packet will have to loop into the receive path,
> in some way that triggers GRO. Perhaps through gro_cells, as other
> GRO paths are hardware NIC drivers.

I get what you meant now, thanks. Yes, those Tx packets loop into the Rx
path. One easy way is through veth pairs, eg. packet get tunneled in a
netns, connected to another one via a veth pair.

> > > > There is another issue (no kernel trace): if a packet has partial c=
sum
> > > > and is being GROed that information is lost and the packet ends up =
with
> > > > an invalid csum.
> > >=20
> > > CHECKSUM_PARTIAL should be converted to CHECKSUM_UNNECESSARY for this
> > > reason. CHECKSUM_PARTIAL implies the header is prepared with pseudo
> > > header checksum. Similarly CHECKSUM_COMPLETE implies skb csum is vali=
d.
> > > CHECKSUM_UNNECESSARY has neither expectations.
> >=20
> > But not if the packet is sent to a remote host. Otherwise an inner
> > partial csum is never fixed by the stack/NIC before going out.
>=20
> The stack will only offload a single checksum. With local checksum
> offload, this can be the inner checksum and the outer can be cheaply
> computed in software. udp_set_csum() handles this. It indeed sets lco
> if the inner packet has CHECKSUM_PARTIAL. Otherwise it sets ip_summed
> to CHECKSUM_PARTIAL, now pointing to the outer UDP header.
>=20
> You're right. Regardless of whether it points to the inner or outer
> checksum, a conversion of CHECKSUM_PARTIAL to CHECKSUM_UNNECESSARY
> will break checksum offload in the forwarding case.
>=20
> > > > Packets with CHECKSUM_UNNECESSARY should end up with the same info.=
 My
> > > > impression is this checksum conversion is at best setting the same =
info
> > > > and otherwise is overriding valuable csum information.
> > > >=20
> > > > Or would packets with CSUM_NONE being GROed would benefit from the
> > > > CHECKSUM_UNNECESSARY conversion?
> > >=20
> > > Definitely. If the packet has CHECKSUM_NONE and GRO checks its
> > > validity in software, converting it to CHECKSUM_UNNECESSARY avoids
> > > potential additional checks at later stages in the packet path.
> >=20
> > Makes sense. The current code really looks like
> > __skb_incr_checksum_unnecessary, w/o the CHECKSUM_NONE check to only
> > convert those packets.

If I sum up our discussion CHECKSUM_NONE conversion is wanted,
CHECKSUM_UNNECESSARY conversion is a no-op and CHECKSUM_PARTIAL
conversion breaks things. What about we just convert CHECKSUM_NONE to
CHECKSUM_UNNECESSARY?

diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 50a8a65fad23..44779d4c538b 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -174,7 +174,7 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk=
_buff *skb, int nhoff)
                if (skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY) {
                        if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
                                skb->csum_level++;
-               } else {
+               } else if (skb->ip_summed =3D=3D CHECKSUM_NONE) {
                        skb->ip_summed =3D CHECKSUM_UNNECESSARY;
                        skb->csum_level =3D 0;
                }

Or directly call __skb_incr_checksum_unnecessary.

Thanks,
Antoine

