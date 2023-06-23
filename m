Return-Path: <netdev+bounces-13317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADF73B425
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB591C20AD4
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB7443D;
	Fri, 23 Jun 2023 09:52:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46782F25
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 09:52:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499F1E7D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687513962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1K8pf+Hfv6KUUo11ZRN0TVVBeFzPwTpw80csEV87fZg=;
	b=jVzt6EkxgUEq/luCw2+Cug/la+BUKzIS+at23tbz5dHAcIiwHBEclcOdA517z67qBwNJeo
	ypchUTQrDugBn45uwo1QFZ8XCfiULnLxlKWAqWrlgh/YIBPbRKpHNyWPbZpwFtc8TghnWh
	bWiKprYbJL5FREsvvyqV9Jr5zs2DX34=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-5RzLk2MzMW-vvy_2XA1ayw-1; Fri, 23 Jun 2023 05:52:37 -0400
X-MC-Unique: 5RzLk2MzMW-vvy_2XA1ayw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76077669a5aso11336485a.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687513957; x=1690105957;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1K8pf+Hfv6KUUo11ZRN0TVVBeFzPwTpw80csEV87fZg=;
        b=i5Jj4HIUFeUkmcxHsbzhx/msvEBKmp8LMPhRuvhIYDDppBqavYAGBcZ35dsLrSO8HJ
         501jXuCZW+Kezje67xrVu/rcr6mc7F/eABR4u2Ffu6JqyOIj8G1mW8/5YHHlt/gKvj5e
         EAoCw3/PTuKjS02NY0liSFBqL/JbkFdruaOJUXkm4aHMfk6fQ6WkRlo78mq07+/ZQ7kS
         1/q3mI2mekQhOPCzjeEjhTo3T2GfCzY9jwhDhHmc6qIdfA4VAsFaUILuavIWjnzNPeKQ
         z2tpCo99toib0n66GDBHrYYb8/AjYzv3W2AzC2zo+oFQPYzP/m3zApc8lExyF8mTwWRy
         juHA==
X-Gm-Message-State: AC+VfDyGuJjOkZ9f+PYV8FoeimnAfkeeWFPd2jkb1HvNqEQFSAplRz4t
	5cTeQYgS39NgRVdPW2KnZoGMckVXCA+0XrAF8VXG2vXBsNRM45JzzwAK2bG3mrxUVHyQ0J2uDjM
	SnLGtzZXkpyJiGo+5TJ2Qi9Q0
X-Received: by 2002:a05:620a:230:b0:763:de4e:2453 with SMTP id u16-20020a05620a023000b00763de4e2453mr6596295qkm.5.1687513957079;
        Fri, 23 Jun 2023 02:52:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5w+vAckkr1xPsoP/O7YpKV26OqjtuOf30RhWVF7lYD6UuLEXVG0LDzinwCuq9Y4qAX/3DXiw==
X-Received: by 2002:a05:620a:230:b0:763:de4e:2453 with SMTP id u16-20020a05620a023000b00763de4e2453mr6596277qkm.5.1687513956793;
        Fri, 23 Jun 2023 02:52:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id v22-20020a05620a123600b0075cc5e34e48sm4300471qkj.131.2023.06.23.02.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:52:36 -0700 (PDT)
Message-ID: <ccf93f92b2539c9dddd1c45fcfa037bb21ccd808.camel@redhat.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
From: Paolo Abeni <pabeni@redhat.com>
To: David Howells <dhowells@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Alexander
 Duyck <alexander.duyck@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern
 <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jens Axboe
 <axboe@kernel.dk>, linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
 Menglong Dong <imagedong@tencent.com>
Date: Fri, 23 Jun 2023 11:52:32 +0200
In-Reply-To: <1969749.1687511298@warthog.procyon.org.uk>
References: <20230622191134.54d5cb0b@kernel.org>
	 <20230622132835.3c4e38ea@kernel.org> <20230622111234.23aadd87@kernel.org>
	 <20230620145338.1300897-1-dhowells@redhat.com>
	 <20230620145338.1300897-2-dhowells@redhat.com>
	 <1952674.1687462843@warthog.procyon.org.uk>
	 <1958077.1687474471@warthog.procyon.org.uk>
	 <1969749.1687511298@warthog.procyon.org.uk>
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

On Fri, 2023-06-23 at 10:08 +0100, David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> > If we can't reach instant agreement --
> > can you strategically separate out the minimal set of changes required
> > to just kill MSG_SENDPAGE_NOTLAST. IMHO it's worth getting that into
> > 6.5.
>=20
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > Given all the above, and the late stage of the current devel cycle,
> > would you consider slicing down this series to just kill
> > MSG_SENDPAGE_NOTLAST, as Jakub suggested?
>=20
> I could do that.
>=20
> There is also another alternative.  I could just push the sendpage wrappe=
rs up
> the stack into the higher-level callers.  Basically this:
>=20
> int udp_sendpage(struct sock *sk, struct page *page, int offset,
> 		 size_t size, int flags)
> {
> 	struct bio_vec bvec;
> 	struct msghdr msg =3D { .msg_flags =3D flags | MSG_SPLICE_PAGES };
>=20
> 	if (flags & MSG_SENDPAGE_NOTLAST)
> 		msg.msg_flags |=3D MSG_MORE;
>=20
> 	bvec_set_page(&bvec, page, size, offset);
> 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> 	return udp_sendmsg(sk, &msg, size);
> }
>=20
> and kill off sendpage and MSG_SENDPAGE_NOTLAST.

I'm unsure I follow the above ?!? I *thought* sendpage could be killed
even without patch 1/18 and 2/18, leaving some patches in this series
unmodified, and mangling those explicitly leveraging 1/18 to use
multiple sendmsg()s with different flags?

I haven't tried to code the above, but my wild guess/hope is that the
delta should be doable - ideally less then the other option.

Introducing slab support should still be possible later, with hopefully
less work.

Cheers,

Paolo



