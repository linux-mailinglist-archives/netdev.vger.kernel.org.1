Return-Path: <netdev+bounces-46821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFC87E691F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D627DB20BB4
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261116408;
	Thu,  9 Nov 2023 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OS361Xut"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E438182AF
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 11:05:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8F2590
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 03:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699527946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtRUDPzty4xk6G3YrueIs/2p0T2ePc3PiZweAufe498=;
	b=OS361Xut6gEBwI75pkHK1P6BpZbEaeTNv1/Ogh97N9vzFF5xKsJZ6nsEjoXEx3MO0YeOGh
	PWq/xBNT1V+Ph7tmez+pYsmB+cuoGHj9jS3YdbxQzC3tOn+J9rwiO8qShzQHCx3wmYeAV7
	Rt4O0a/rq/k+iYg+8vfGBGuZdtoN+uQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-2uoK89PwMSijqGoQYF_WaQ-1; Thu, 09 Nov 2023 06:05:44 -0500
X-MC-Unique: 2uoK89PwMSijqGoQYF_WaQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-da37e78401aso151701276.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 03:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699527944; x=1700132744;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtRUDPzty4xk6G3YrueIs/2p0T2ePc3PiZweAufe498=;
        b=Q+dhxLlQYAHhDvgBFWTn9UvWGEdLHMRZR+7PMcLsUOpAMjWd2m3wjiic25kerk10yW
         6n/xGVrOCpokXppnJiqXXaJZj5hiALvvq2L0svYyS2F1UtArnHWHH0W9+HQ4HC45FfSQ
         soEqiTfoyPtupLgsjGarAxPUN6xerKGxlHrR0Bc5KMGtAmKmDMrn+kqjJGx/HrxnnelA
         w5BCdvPTMmugVxzkTa8kRxasb0ADBHllDUSi6M8j4KCIv9ayY7RKyUjhiDc4oEFt/2zD
         uk2NgdcGH1Q+af/3CaZDt3KCTgKMnLTg2E582PUvkAhSq0l/NRROpujxKK2K+gn4zhE5
         oimw==
X-Gm-Message-State: AOJu0YzAHvCPBSw5TnLFhsKal7eMEodcbBG5UEhwABW02dk2legkIt5Z
	j2RKFK1R5tXgkvZRx/W3tyGqaAH7VgcswwwXvpblx97+K7Y5mfnCaxzr8wFd8Cq7VGL92SYaysC
	QaZgb7OLi6p9OTjkO
X-Received: by 2002:a25:9346:0:b0:dae:e380:3afa with SMTP id g6-20020a259346000000b00daee3803afamr1116255ybo.2.1699527944398;
        Thu, 09 Nov 2023 03:05:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOFSam8Y2WZfjs6lyrCBJqDmNWulDFM0w0FKUbNkESWMi4P7ZtSYxs4i3pcukjOXBjSX6POg==
X-Received: by 2002:a25:9346:0:b0:dae:e380:3afa with SMTP id g6-20020a259346000000b00daee3803afamr1116194ybo.2.1699527942695;
        Thu, 09 Nov 2023 03:05:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id g23-20020ac870d7000000b004181e5a724csm1813782qtp.88.2023.11.09.03.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:05:42 -0800 (PST)
Message-ID: <3a1b5412bee202affc6a7cc74cd939e182b9a18e.camel@redhat.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Stanislav Fomichev
	 <sdf@google.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,  Shakeel Butt
 <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn
 <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Date: Thu, 09 Nov 2023 12:05:37 +0100
In-Reply-To: <CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	 <20231106024413.2801438-11-almasrymina@google.com>
	 <ZUk0FGuJ28s1d9OX@google.com>
	 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
	 <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
	 <ZUlp8XutSAScKs_0@google.com>
	 <CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-06 at 14:55 -0800, Willem de Bruijn wrote:
> On Mon, Nov 6, 2023 at 2:34=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >=20
> > On 11/06, Willem de Bruijn wrote:
> > > > > IMHO, we need a better UAPI to receive the tokens and give them b=
ack to
> > > > > the kernel. CMSG + setsockopt(SO_DEVMEM_DONTNEED) get the job don=
e,
> > > > > but look dated and hacky :-(
> > > > >=20
> > > > > We should either do some kind of user/kernel shared memory queue =
to
> > > > > receive/return the tokens (similar to what Jonathan was doing in =
his
> > > > > proposal?)
> > > >=20
> > > > I'll take a look at Jonathan's proposal, sorry, I'm not immediately
> > > > familiar but I wanted to respond :-) But is the suggestion here to
> > > > build a new kernel-user communication channel primitive for the
> > > > purpose of passing the information in the devmem cmsg? IMHO that se=
ems
> > > > like an overkill. Why add 100-200 lines of code to the kernel to ad=
d
> > > > something that can already be done with existing primitives? I don'=
t
> > > > see anything concretely wrong with cmsg & setsockopt approach, and =
if
> > > > we switch to something I'd prefer to switch to an existing primitiv=
e
> > > > for simplicity?
> > > >=20
> > > > The only other existing primitive to pass data outside of the linea=
r
> > > > buffer is the MSG_ERRQUEUE that is used for zerocopy. Is that
> > > > preferred? Any other suggestions or existing primitives I'm not awa=
re
> > > > of?
> > > >=20
> > > > > or bite the bullet and switch to io_uring.
> > > > >=20
> > > >=20
> > > > IMO io_uring & socket support are orthogonal, and one doesn't precl=
ude
> > > > the other. As you know we like to use sockets and I believe there a=
re
> > > > issues with io_uring adoption at Google that I'm not familiar with
> > > > (and could be wrong). I'm interested in exploring io_uring support =
as
> > > > a follow up but I think David Wei will be interested in io_uring
> > > > support as well anyway.
> > >=20
> > > I also disagree that we need to replace a standard socket interface
> > > with something "faster", in quotes.
> > >=20
> > > This interface is not the bottleneck to the target workload.
> > >=20
> > > Replacing the synchronous sockets interface with something more
> > > performant for workloads where it is, is an orthogonal challenge.
> > > However we do that, I think that traditional sockets should continue
> > > to be supported.
> > >=20
> > > The feature may already even work with io_uring, as both recvmsg with
> > > cmsg and setsockopt have io_uring support now.
> >=20
> > I'm not really concerned with faster. I would prefer something cleaner =
:-)
> >=20
> > Or maybe we should just have it documented. With some kind of path
> > towards beautiful world where we can create dynamic queues..
>=20
> I suppose we just disagree on the elegance of the API.
>=20
> The concise notification API returns tokens as a range for
> compression, encoding as two 32-bit unsigned integers start + length.
> It allows for even further batching by returning multiple such ranges
> in a single call.
>=20
> This is analogous to the MSG_ZEROCOPY notification mechanism from
> kernel to user.
>=20
> The synchronous socket syscall interface can be replaced by something
> asynchronous like io_uring. This already works today? Whatever
> asynchronous ring-based API would be selected, io_uring or otherwise,
> I think the concise notification encoding would remain as is.
>=20
> Since this is an operation on a socket, I find a setsockopt the
> fitting interface.

FWIW, I think sockopt +cmsg is the right API. It would deserve some
explicit addition to the documentation, both in the kernel and in the
man-pages.

Cheers,

Paolo


