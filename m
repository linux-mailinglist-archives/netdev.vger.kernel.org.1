Return-Path: <netdev+bounces-45818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8627DFC24
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 23:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C630281D13
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031321A19;
	Thu,  2 Nov 2023 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LB67jMhc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB00E1F94C
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 22:02:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A196195
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698962560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJIex0iBPXEPEipoAN2zQv8ZN5dF+ogwUiK0fjM1zeY=;
	b=LB67jMhc3oKBo6Er5qkb4+gjOm8WwIVmVNwgnoLl68lMT2j6IBbov2FknOGUfTP+jd/byh
	KfMcUTbwpXO7GYBjmAhP9spqryphq7rMVNkkaw2CmTJeHfwf5na49XkeeuQTrzy/654hyj
	+9RUZQC0pdUcLq1y82/lB8bV1SSYh2k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-aKBEhsguOTqEqAnO094scQ-1; Thu, 02 Nov 2023 18:02:38 -0400
X-MC-Unique: aKBEhsguOTqEqAnO094scQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5435b614a0cso194673a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 15:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698962557; x=1699567357;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJIex0iBPXEPEipoAN2zQv8ZN5dF+ogwUiK0fjM1zeY=;
        b=Lenouw3JbwemIrVvRJxKgBbl7+SLsfAe/JkSsGCA2HCfgZtlqa6p5hGMa+1rd9kBNb
         SuqH7gftPABfOa7Ll/cCUcG3C2moD1ktiN+yioNw1RTUnaxKPwzrLw/NmI9vQuPsa3yR
         b/cUDfjqWoaZ2s6zAJrAtM82v9hDz7ok++Pc3mett7lEBE980bnc9BhxGOygIUzs3eeK
         qDl94qLA8+SRof2/l5HTytW4ujj6ELyrIe6j0j61E2ZPs4UacyIQPTXp3nPih3UykDNr
         MupuFXlgIwInm4N9YPOiv0p6H78P+yGmxWVMIz+oQAm+iTEFfUorKkhG0z/QR+5n5Lh9
         RHnQ==
X-Gm-Message-State: AOJu0YywlFMj68FP9JgUd4PCV7qDR3Tt0eUufvg/VfA4XW9grJ2SVrtH
	KkvP47lhL5FGjAAmpIseOliN8KBzM0eysQJhs+jZ2eS0RCkrb5lS2dn/9iXRD4UlBUcs89kC0F9
	8Q2tqS51trQyPctk5
X-Received: by 2002:a50:baef:0:b0:540:a181:f40b with SMTP id x102-20020a50baef000000b00540a181f40bmr14361457ede.4.1698962557138;
        Thu, 02 Nov 2023 15:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEPk0xaaUC0zu2hRz92pKvvlUi2VsYtlPFFB4YRq8WpOL59/CqvmCQ46OIEBuNHmV0iBU8Ug==
X-Received: by 2002:a50:baef:0:b0:540:a181:f40b with SMTP id x102-20020a50baef000000b00540a181f40bmr14361441ede.4.1698962556843;
        Thu, 02 Nov 2023 15:02:36 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id d26-20020a50cd5a000000b0053dab756073sm199543edj.84.2023.11.02.15.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:02:36 -0700 (PDT)
Message-ID: <7a26cd1bafb22b16eab3868255706d44fa4f255d.camel@redhat.com>
Subject: Re: [PATCH] drivers/net/ppp: copy userspace array safely
From: Philipp Stanner <pstanner@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Stanislav Fomichev <sdf@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org, Dave Airlie
 <airlied@redhat.com>
Date: Thu, 02 Nov 2023 23:02:35 +0100
In-Reply-To: <20231102200943.GK1957730@ZenIV>
References: <20231102191914.52957-2-pstanner@redhat.com>
	 <20231102200943.GK1957730@ZenIV>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hallo Al,

On Thu, 2023-11-02 at 20:09 +0000, Al Viro wrote:
> On Thu, Nov 02, 2023 at 08:19:15PM +0100, Philipp Stanner wrote:
> > In ppp_generic.c memdup_user() is utilized to copy a userspace
> > array.
> > This is done without an overflow check.
> >=20
> > Use the new wrapper memdup_array_user() to copy the array more
> > safely.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fprog.len =3D uprog->le=
n;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fprog.filter =3D memdup_user=
(uprog->filter,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uprog->len * sizeof(=
struct
> > sock_filter));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fprog.filter =3D memdup_arra=
y_user(uprog->filter,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 uprog->len, sizeof(struct
> > sock_filter));
>=20
> Far be it from me to discourage security theat^Whardening, but


a bit about the background here:
(tl;dr: No reason to worry, I am not one of those security fanatics. In
fact, I worked for 12 months with those people with some mixed
experiences ^^')

(btw, note that the commit says 'safety', not 'security')

We introduced those wrappers to string.h hoping they will be useful.
Now that they're merged, I quickly wanted to establish them as the
standard for copying user-arrays, ideally in the current merge window.
Because its convenient, easy to read and, at times, safer.

I just want to help out a bit in the kernel, clean up here and there;
it's not yet the primary task assigned to me by my employer. Thus, I
quickly prepared 13 patches today implementing the wrapper. You'll find
the others on LKML. Getting to:

>=20
> struct sock_fprog {=C2=A0=C2=A0=C2=A0=C2=A0 /* Required for SO_ATTACH_FIL=
TER. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned short=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len;=C2=A0=C2=A0=C2=A0 /* Number of=
 filter blocks */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sock_filter __user=
 *filter;
> };
>=20
> struct sock_filter {=C2=A0=C2=A0=C2=A0 /* Filter block */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u16=C2=A0=C2=A0 code;=C2=A0=
=C2=A0 /* Actual filter code */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 jt;=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Jump true */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 jf;=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Jump false */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32=C2=A0=C2=A0 k;=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Generic multiuse field */
> };
>=20
> so you might want to mention that overflow in question would have to
> be
> in multiplying an untrusted 16bit value by 8...
>=20

I indeed did not even look at that.
When it was obvious to me that fearing an overflow is ridiculous, I
actually adjusted the commit-message, see for example here: [1]

I just didn't see it in ppp. Maybe I should have looked more
intensively for all 13 patches. But we'll get there, that's what v2 and
v3 are for :)

P.


[1] https://lore.kernel.org/all/20231102192402.53721-2-pstanner@redhat.com/


PS: Security !=3D Safety


