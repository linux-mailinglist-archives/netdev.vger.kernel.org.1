Return-Path: <netdev+bounces-14266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035F373FD3C
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 15:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027821C20A44
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1BE182CE;
	Tue, 27 Jun 2023 13:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2F154B2
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 13:52:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD35A268C
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687873913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta/k6TaotDmcBq3Mo1N0tE9YWNUTNqotl8imK8b3vwY=;
	b=Tx6TPswE9E5BIL+kzKSp++Q1d4Oe28wbRvUZlHh37TMunsxXshSuuanMeEVdK1atiMar7F
	uJ2QaBtKph5N5Rvb21Koky43kYKD3CDAKdOtAVe12NY2N6ssg/mXh121gg9OX72eyBLM0W
	si2iNjx1enBDZSDJFwXGExA3+eJgmzg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-al_-RmGXOuyP_YAemrX9BQ-1; Tue, 27 Jun 2023 09:51:47 -0400
X-MC-Unique: al_-RmGXOuyP_YAemrX9BQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7655fffd637so95897685a.1
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873906; x=1690465906;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ta/k6TaotDmcBq3Mo1N0tE9YWNUTNqotl8imK8b3vwY=;
        b=F2MZjkVOImrQJR5qvVd4C+bOq4SevssnbQExN87TX7YTJIcmF2S7Hno/PJNQm4nPxp
         zaA3h2nQMHBXaL8+TP99tKBzbAsewsQzv6ACM4/7ho2ylergi/NGVOnHFrpwCRGHEO3r
         L6Q4neBejvFxVxnWBbvHRjpg863QTgq8jIlyktu92b6lRKc2Hq45MIx7wdRdi+Ypb86z
         u5ffBRaFwA0ZLMl9vEX8IjWPU/7X/lCrg8Tkmc745eeLFSOnfC7HoqhagIloD39YKTMk
         sLwnEWPl5j/n5Z8RmCiAELt3bgklrmk8cMALHUAJ8aSejDj7vDDlgON2nLQx5ROulpEp
         aeEA==
X-Gm-Message-State: AC+VfDyR3MF7kfTJrkD/yAKY15wdUADkq348gyJbSye1Q+zrhpbU948W
	cWK9uk4y1ueWVBnM/OmSf3uKY36hoqOQXrcEPUd/Ua33txhOn1gryfdAyQ/fwQ1sKa2/9d2qK6S
	AUZRPIwDXk+NyZrwz
X-Received: by 2002:a05:6214:5185:b0:634:cdae:9941 with SMTP id kl5-20020a056214518500b00634cdae9941mr11986656qvb.0.1687873906548;
        Tue, 27 Jun 2023 06:51:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TiZPx86iEnYv5fjmFQlvBx17Uw43aU9XIkdH3HNnpsUCIB9jdeHdTBsTv3eA6WUguqd8Htg==
X-Received: by 2002:a05:6214:5185:b0:634:cdae:9941 with SMTP id kl5-20020a056214518500b00634cdae9941mr11986633qvb.0.1687873906295;
        Tue, 27 Jun 2023 06:51:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-6.dyn.eolo.it. [146.241.239.6])
        by smtp.gmail.com with ESMTPSA id w5-20020a0cc705000000b0062df3d51de3sm4590180qvi.19.2023.06.27.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:51:45 -0700 (PDT)
Message-ID: <01595c2fa5958253f08c07e316435abe9f32e305.camel@redhat.com>
Subject: Re: Is ->sendmsg() allowed to change the msghdr struct it is given?
From: Paolo Abeni <pabeni@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, ceph-devel@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2023 15:51:43 +0200
In-Reply-To: <3132610.1687871361@warthog.procyon.org.uk>
References: <b0a0cb0fac4ebdc23f01d183a9de10731dc90093.camel@redhat.com>
	 <3112097.1687814081@warthog.procyon.org.uk>
	 <20230626142257.6e14a801@kernel.org>
	 <3132610.1687871361@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-27 at 14:09 +0100, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > udp_sendmsg() can set the MSG_TRUNC bit in msg->msg_flags, so I guess
> > that kind of actions are sort of allowed. Still, AFAICS, the kernel
> > based msghdr is not copied back to the user-space, so such change
> > should be almost a no-op in practice.
> >=20
> > @David: which would be the end goal for such action?
>=20
> Various places in the kernel use sock_sendmsg() - and I've added a bunch =
more
> with the MSG_SPLICE_PAGES patches.  For some of the things I've added, th=
ere's
> a loop which used to call ->sendpage() and now calls sock_sendmsg().  In =
most
> of those places, msghdr will get reset each time round the loop - but not=
 in
> all cases.
>=20
> Of particular immediate interest is net/ceph/messenger_v2.c.  If you go t=
o:
>=20
> 	https://lore.kernel.org/r/3111635.1687813501@warthog.procyon.org.uk/
>=20
> and look at the resultant code:
>=20
> 	static int do_sendmsg(struct socket *sock, struct iov_iter *it)
> 	{
> 		struct msghdr msg =3D { .msg_flags =3D CEPH_MSG_FLAGS };
> 		int ret;
>=20
> 		msg.msg_iter =3D *it;
> 		while (iov_iter_count(it)) {
> 			ret =3D sock_sendmsg(sock, &msg);
> 			if (ret <=3D 0) {
> 				if (ret =3D=3D -EAGAIN)
> 					ret =3D 0;
> 				return ret;
> 			}
>=20
> 			iov_iter_advance(it, ret);
> 		}
>=20
> 		WARN_ON(msg_data_left(&msg));
> 		return 1;
> 	}
>=20
> for example.  It could/would malfunction if sendmsg() is allowed to modif=
y
> msghdr - or if it doesn't update msg_iter.  Likewise:
>=20
> 	static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
> 	{
> 		struct msghdr msg =3D { .msg_flags =3D CEPH_MSG_FLAGS };
> 		struct bio_vec bv;
> 		int ret;
>=20
> 		if (WARN_ON(!iov_iter_is_bvec(it)))
> 			return -EINVAL;
>=20
> 		while (iov_iter_count(it)) {
> 			/* iov_iter_iovec() for ITER_BVEC */
> 			bvec_set_page(&bv, it->bvec->bv_page,
> 				      min(iov_iter_count(it),
> 					  it->bvec->bv_len - it->iov_offset),
> 				      it->bvec->bv_offset + it->iov_offset);
>=20
> 			/*
> 			 * MSG_SPLICE_PAGES cannot properly handle pages with
> 			 * page_count =3D=3D 0, we need to fall back to sendmsg if
> 			 * that's the case.
> 			 *
> 			 * Same goes for slab pages: skb_can_coalesce() allows
> 			 * coalescing neighboring slab objects into a single frag
> 			 * which triggers one of hardened usercopy checks.
> 			 */
> 			if (sendpage_ok(bv.bv_page))
> 				msg.msg_flags |=3D MSG_SPLICE_PAGES;
> 			else
> 				msg.msg_flags &=3D ~MSG_SPLICE_PAGES;
>=20
> 			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, bv.bv_len);
> 			ret =3D sock_sendmsg(sock, &msg);
> 			if (ret <=3D 0) {
> 				if (ret =3D=3D -EAGAIN)
> 					ret =3D 0;
> 				return ret;
> 			}
>=20
> 			iov_iter_advance(it, ret);
> 		}
>=20
> 		return 1;
> 	}
>=20
> could be similarly affected if ->sendmsg() mucks about with msg_flags.

With some help from the compiler - locally changing the proto_ops and
proto sendmsg definition and handling the fallout - I found the
following:

- mptcp_sendmsg() is clearing unsupported msg_flags=20
  (I should have recalled this one even without much testing ;)

- udpv4_sendmsg() is setting msg_name/msg_namelen
- tls_device_sendmsg() is clearing MSG_SPLICE_PAGE when zerocopy is not
supported
- unix_seqpacket_sendmsg() is clearing msg_namelen

I could have missed something, but the above looks safe for the use-
case you mentioned.

Cheers,

Paolo


