Return-Path: <netdev+bounces-37971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1347B81AB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3D9F528141A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99A15EAE;
	Wed,  4 Oct 2023 14:04:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27013AF9
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 14:04:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46A4BD
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696428271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pZEXGbcluSLqzFo6PmnGkojVQIfEFQeyk3xrlLkTJA=;
	b=K7vgVyTATInXPOjNPyAUqKS7Q9dK22SvW84u7XRVLaL6/pGEavomLVj4fnQAHDSYtE5w3P
	0NZl2eBoFFvcvRePohLV36raYJAMj0HlDi91S96AJTjLbv+H/EsDITfyrs/OmIxOHQwiDk
	sjFL6wecIZL3ej4vPQJ03apVf7FH3yA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Wn-N3n0XPaCedOMl6bUMzA-1; Wed, 04 Oct 2023 10:04:09 -0400
X-MC-Unique: Wn-N3n0XPaCedOMl6bUMzA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3251bc06680so1647055f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 07:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696428246; x=1697033046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pZEXGbcluSLqzFo6PmnGkojVQIfEFQeyk3xrlLkTJA=;
        b=jVeWC/ETC8d0EZdngMJwAcq10ta4rBpIoon/E3xdszccvVBjE29livml2JpbC+LboX
         Bj6UGmUwuGr8klQKEZGRkIgYytlLcYbHF2Vi+7Ojb/0UUf4HigsjkrkrXi6GwZKJhbpz
         3wnBGd9z5rUDJHO/piYIdJ0kSN5lpWvIw9MXOmveYY/ZN2tbdYweRztya1Ty9zKQ2Uy8
         MbTIihx9guWNnkJUl4awTVYpv8NEUJR+0S02iTyn1oexKowlnno4tAxMUsnx4skuZHW6
         +9Rl2qypo8JyH04YpPQfD5XvOqQD5dFasu42UMrYVslOOX2kCAngL7QQ2nmw4g5WQN0s
         x1tQ==
X-Gm-Message-State: AOJu0YwKJvoMjzAc0iyM3NVqxE7y2tGsGSXuW7aPQNYcKwX9Br7HBA15
	ElJ6kWDOTYsF5wQfVBPWPDCkgyYY3wUPtGUcWPFrLZUIZxx8I2I+xr/OOKKQaq1qn05yvQesTTB
	yb4GZ/PtmMV0QuwR4o5hCoTRF
X-Received: by 2002:a5d:56d0:0:b0:31c:5c77:48ec with SMTP id m16-20020a5d56d0000000b0031c5c7748ecmr2026021wrw.62.1696428246362;
        Wed, 04 Oct 2023 07:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE1M+7GeyXmeaGNZrXpsVT71x2daZCozpe3MsxCvwocq6wYYVq3AVRRrfUhKRME4pyBf6urw==
X-Received: by 2002:a5d:56d0:0:b0:31c:5c77:48ec with SMTP id m16-20020a5d56d0000000b0031c5c7748ecmr2025948wrw.62.1696428244699;
        Wed, 04 Oct 2023 07:04:04 -0700 (PDT)
Received: from localhost (net-93-66-52-16.cust.vodafonedsl.it. [93.66.52.16])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d424c000000b00327cd5e5ac1sm4154775wrr.1.2023.10.04.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:04:02 -0700 (PDT)
Date: Wed, 4 Oct 2023 16:04:00 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Message-ID: <ZR1w0GDC6hoKc5pp@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
 <20231003110358.4a08b826@kernel.org>
 <ZR07CYtL8GwMQQPV@lore-desk>
 <6A47BDC7-FB73-4799-BC6A-9C0C020E424D@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UpQxkXKt6aynY9NM"
Content-Disposition: inline
In-Reply-To: <6A47BDC7-FB73-4799-BC6A-9C0C020E424D@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--UpQxkXKt6aynY9NM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> > On Oct 4, 2023, at 6:14 AM, Lorenzo Bianconi <lorenzo.bianconi@redhat.c=
om> wrote:
> >=20
> >> On Mon, 11 Sep 2023 14:49:46 +0200 Lorenzo Bianconi wrote:
> >>> + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg=
_seq,
> >>> +  &nfsd_server_nl_family, NLM_F_MULTI,
> >>> +  NFSD_CMD_RPC_STATUS_GET);
> >>> + if (!hdr)
> >>> + return -ENOBUFS;
> >>=20
> >> Why NLM_F_MULTI? AFAIU that means "I'm splitting one object over
> >> multiple messages". 99% of the time the right thing to do is change=20
> >> what we consider to be "an object" rather than do F_MULTI. In theory
> >> user space should re-constitute all the NLM_F_MULTI messages into as
> >> single object, which none of YNL does today :(
> >>=20
> > ack, fine. I think we can get rid of it.
> > @chuck: do you want me to send a patch or are you taking care of it?
>=20
> Send a (tested) patch and I can squash it into this one.

ack, I will do.

Regards,
Lorenzo

>=20
>=20
> --
> Chuck Lever
>=20
>=20

--UpQxkXKt6aynY9NM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZR1w0AAKCRA6cBh0uS2t
rFGuAP9VNlDiCwRTl3OHCTw/BUl4C623JTX9cR0PzWjU4vIMcwD/ZIxSBwzQYjVd
SBjr94Fmtx2Sj0qsPMOdTchEZhLW1Qg=
=kwxV
-----END PGP SIGNATURE-----

--UpQxkXKt6aynY9NM--


