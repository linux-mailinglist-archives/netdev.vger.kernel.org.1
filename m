Return-Path: <netdev+bounces-39613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655FE7C01E8
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C891C20BAF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764132FE1F;
	Tue, 10 Oct 2023 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNvsCsik"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19E82FE1D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:45:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3087297
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696956353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnYwLQ8kzLVEFsa734Nz5mzKYCDzjL5HTOUhixLQZUI=;
	b=eNvsCsikT8yFAlwi438pAz5I5KR+3YwSA0a+vE14evt5HVVKVqy+rQNInafxMc3m3HA4vv
	FfkaBenz4Ej9xvE2qo9RhbcMxy+WnPYDPLMdeA30kehl3ZPynBcDJjQigRXJ2l+J4UV0w+
	yk5vJP6EcuNEoq2E3tEZGddwA/Fh25E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-Roo5AgS1PwKM7IvpNRo3UA-1; Tue, 10 Oct 2023 12:45:52 -0400
X-MC-Unique: Roo5AgS1PwKM7IvpNRo3UA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50301e9e1f0so1484229e87.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696956350; x=1697561150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnYwLQ8kzLVEFsa734Nz5mzKYCDzjL5HTOUhixLQZUI=;
        b=X6CynCFzS+OANp0/r0RD+0y86FXGlAVU2do2MoRGY/Pi1yzROV0ZRCxgVUpek1ySeS
         hFPTbEvypN1c0jlkD8xFGnBslys+fQX2fulTiyKuDNRE3n0ox9rna28zaEJ9in+xyGB7
         ROyJHbdmQOSvOoQ9AKgRDnYz/csXkCc7m7m+nMBvH+DzEL/Wt/1hAmnt2cNbe2+sshxL
         sVSIrEIGTudo01RTYTitWroRzy1r1yAV0GryQ5elT/7GRIdfGb/5JY6pB07Mgxay0pSF
         S/Snp0SvFXXTmFHJYK+DdUt7dmgOqo98AE//dgfNMEq8ls0wSiOjItTjYCdxsMejcn7a
         cDMg==
X-Gm-Message-State: AOJu0YzMzvCSCzBe6JcSbUdM7J0Hywtf7aA1xIBU3jgWAAQ6jm9aq7tD
	Agu9eV9pQAwj9pQg3puz2cGlxSddMF1kUPCRdDc3kOG/H4MURCf56RBC6N79f39Z3uizadcsj8G
	7vjeDUAVK6Dj2R/0pq98CCK//
X-Received: by 2002:a05:651c:1685:b0:2bf:f52c:3918 with SMTP id bd5-20020a05651c168500b002bff52c3918mr12325526ljb.1.1696956350571;
        Tue, 10 Oct 2023 09:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9egh/WSegb4nTtfph83aCfYCKz0A/wcdfVHdp4Q6InDufZ+EIguxovMIHN9+J1kxDd7Wd3Q==
X-Received: by 2002:a05:651c:1685:b0:2bf:f52c:3918 with SMTP id bd5-20020a05651c168500b002bff52c3918mr12325511ljb.1.1696956350192;
        Tue, 10 Oct 2023 09:45:50 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id ks8-20020a170906f84800b00982a92a849asm8671281ejb.91.2023.10.10.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 09:45:49 -0700 (PDT)
Message-ID: <cdb77e7ecec83398ff7d92f7aeb20e0158146a28.camel@redhat.com>
Subject: Re: [PATCH net] tcp: allow again tcp_disconnect() when threads are
 waiting
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David
 Ahern <dsahern@kernel.org>,  mptcp@lists.linux.dev, Boris Pismenny
 <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Date: Tue, 10 Oct 2023 18:45:48 +0200
In-Reply-To: <CANn89iKOZ89xhAsgXyygENOfRzXPhbFn4_PNdA3LUL0a5EYktA@mail.gmail.com>
References: 
	<1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
	 <CANn89iKOZ89xhAsgXyygENOfRzXPhbFn4_PNdA3LUL0a5EYktA@mail.gmail.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Thank you for your review!

On Tue, 2023-10-10 at 18:21 +0200, Eric Dumazet wrote:
[...]
> > @@ -1585,7 +1596,11 @@ static int peekmsg(struct sock *sk, struct msghd=
r *msg,
> >                         release_sock(sk);
> >                         lock_sock(sk);
> >                 } else {
> > -                       sk_wait_data(sk, &timeo, NULL);
> > +                       ret =3D sk_wait_data(sk, &timeo, NULL);
> > +                       if (ret < 0) {
> > +                               copied =3D ret;
>=20
>    if (!copied)
>       copied =3D ret;

I think we can infer 'copied' is zero here, as a few lines before we
have:

	if (copied)
		break;

>=20
> > @@ -3092,6 +3092,7 @@ int tcp_disconnect(struct sock *sk, int flags)
> >                 sk->sk_frag.offset =3D 0;
> >         }
> >         sk_error_report(sk);
> > +       sk->sk_disconnects++;
>=20
> Should we perform this generically, from the caller ?

Ok, I'll do that in v2.

Thanks!

Paolo


