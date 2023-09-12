Return-Path: <netdev+bounces-33240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D7C79D1DF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D1E1C20DCF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C05179A1;
	Tue, 12 Sep 2023 13:15:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF118048
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:15:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 147B510D7
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694524526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWsMrk8S3AdARhadonzU2euvUr4BAe4nM+TAGYfUsdc=;
	b=g++PfAZ9G4kmvXlt1CIRKlUJAuWKtO0MkZRP8DWdW3iS6mFmtzZkk+UXFR6KXwNAKmM1CA
	+pFaR9vYWtqI/LgBUptlCQBz2eswfSVRi4tf5knTlE78SwOnYTtD5rHHbAdcY3C0U8SQG3
	lmcLvXZaQMaip5l4RiYL3bJa1u5zRPU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-vFgk-7mDNyeoBefdTpByxg-1; Tue, 12 Sep 2023 09:15:23 -0400
X-MC-Unique: vFgk-7mDNyeoBefdTpByxg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31f84d00c0aso2845176f8f.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694524522; x=1695129322;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWsMrk8S3AdARhadonzU2euvUr4BAe4nM+TAGYfUsdc=;
        b=lLQZgLfWAPlF8Qh2OTK95GLYttGHg+2hx5rT4gPOrSwFf93RpFVh64Ye7y6N2thoI0
         kPO65qWyo/dC5syZpYMWJtvivY4VxH8CLXlb11ATn4q0jgflwfqGU0dpIY7pTLkiZiCY
         FhoU1vDw0Nm8oPias7tg8EiCn9bM5CMbZ+vyaNaOpnMKCk45liQQQeCb4ODGfxjlKMw2
         aqp5MRY+Y2F+mvBPciBSzLpHGuATFSQeSu/NSKd6dQGdhK/dhB2hbuS9Jw780IJvZemn
         vAjIB62jpu7YONNa4uIF1Lf3SDrtRNav1H6kXHHSVPm/UIE0E6/cqRDiBxr7LyR8Tqml
         cW3w==
X-Gm-Message-State: AOJu0YxQghm1776P6QmzV8Yn8lSAgiCG2ZhXeMPQ7Vqt9dW1HgCHOkbK
	v7iHRtuNdRWr9dEM2Oe4cHpIa+q5tdqIzkn+/RnfkiVTLSvwCUehzceYKRQ8IhY6NFISB12NPts
	scsPCY7Yx8U/ZxFxV
X-Received: by 2002:a5d:6952:0:b0:319:854f:7b02 with SMTP id r18-20020a5d6952000000b00319854f7b02mr10716285wrw.51.1694524522670;
        Tue, 12 Sep 2023 06:15:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOHBONCODOhK0jkBQ4sPgwMPDS6pNtOjTdPKUV/gtyzbrGfzGR0pm+g7PsUOMHi7WIOhF9Jw==
X-Received: by 2002:a5d:6952:0:b0:319:854f:7b02 with SMTP id r18-20020a5d6952000000b00319854f7b02mr10716264wrw.51.1694524522215;
        Tue, 12 Sep 2023 06:15:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u7-20020aa7d887000000b00528922bb53bsm5979653edq.76.2023.09.12.06.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:15:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 25A96DC7324; Tue, 12 Sep 2023 15:15:21 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Gerhard Engleder
 <gerhard@engleder-embedded.com>, Simon Horman <horms@kernel.org>
Cc: Marek Majtyka <alardam@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net] veth: Update XDP feature set when bringing up device
In-Reply-To: <05c3dcacfd80076bcb09bb701eab88769818c80f.camel@redhat.com>
References: <20230911135826.722295-1-toke@redhat.com>
 <155aabf8b873bb8cdcafbd6139c42b08513e5fe6.camel@redhat.com>
 <8734zjlfg9.fsf@toke.dk>
 <05c3dcacfd80076bcb09bb701eab88769818c80f.camel@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 12 Sep 2023 15:15:21 +0200
Message-ID: <87zg1rjzx2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> On Tue, 2023-09-12 at 14:54 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Paolo Abeni <pabeni@redhat.com> writes:
>>=20
>> > Hi,
>> >=20
>> > On Mon, 2023-09-11 at 15:58 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> > > There's an early return in veth_set_features() if the device is in a=
 down
>> > > state, which leads to the XDP feature flags not being updated when e=
nabling
>> > > GRO while the device is down. Which in turn leads to XDP_REDIRECT not
>> > > working, because the redirect code now checks the flags.
>> > >=20
>> > > Fix this by updating the feature flags after bringing the device up.
>> > >=20
>> > > Before this patch:
>> > >=20
>> > > NETDEV_XDP_ACT_BASIC:		yes
>> > > NETDEV_XDP_ACT_REDIRECT:	yes
>> > > NETDEV_XDP_ACT_NDO_XMIT:	no
>> > > NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
>> > > NETDEV_XDP_ACT_HW_OFFLOAD:	no
>> > > NETDEV_XDP_ACT_RX_SG:		yes
>> > > NETDEV_XDP_ACT_NDO_XMIT_SG:	no
>> > >=20
>> > > After this patch:
>> > >=20
>> > > NETDEV_XDP_ACT_BASIC:		yes
>> > > NETDEV_XDP_ACT_REDIRECT:	yes
>> > > NETDEV_XDP_ACT_NDO_XMIT:	yes
>> > > NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
>> > > NETDEV_XDP_ACT_HW_OFFLOAD:	no
>> > > NETDEV_XDP_ACT_RX_SG:		yes
>> > > NETDEV_XDP_ACT_NDO_XMIT_SG:	yes
>> > >=20
>> > > Fixes: fccca038f300 ("veth: take into account device reconfiguration=
 for xdp_features flag")
>> > > Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
>> > > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> > > ---
>> > >  drivers/net/veth.c | 2 ++
>> > >  1 file changed, 2 insertions(+)
>> > >=20
>> > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> > > index 9c6f4f83f22b..0deefd1573cf 100644
>> > > --- a/drivers/net/veth.c
>> > > +++ b/drivers/net/veth.c
>> > > @@ -1446,6 +1446,8 @@ static int veth_open(struct net_device *dev)
>> > >  		netif_carrier_on(peer);
>> > >  	}
>> > >=20=20
>> > > +	veth_set_xdp_features(dev);
>> > > +
>> > >  	return 0;
>> > >  }
>> >=20
>> > The patch LGTM, thanks!
>> >=20
>> > I think it would be nice to add some specific self-tests here. Could
>> > you please consider following-up with them?
>>=20
>> Sure! Do you want me to resubmit this as well, or are you just going to
>> apply it as-is and do the selftest as a follow-up?
>
> I think the latter is simpler and works for me. The self-test could
> target net-next, the fix is going to land there shortly after -net.

ACK, SGTM!

-Toke


