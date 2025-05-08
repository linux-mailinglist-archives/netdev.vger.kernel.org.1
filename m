Return-Path: <netdev+bounces-188964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C8AAAFA29
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0B43A7CDB
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D122577D;
	Thu,  8 May 2025 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b="Gfb7W9lW";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="s2IVMrVJ"
X-Original-To: netdev@vger.kernel.org
Received: from e240-10.smtp-out.eu-north-1.amazonses.com (e240-10.smtp-out.eu-north-1.amazonses.com [23.251.240.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049E22332B;
	Thu,  8 May 2025 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707866; cv=none; b=ULKBkWPCh3hoxhPKZXHysR8/Ryz1fJHcZWqKNh5/MhvlwzqQjkmT3jLmJ/SZjIB7OXuEed3goiKe7kQRatnXbHFJ5ConKCW19qGnIV4L5wmKenvzEFXwtaO5xyP2pe3kyCfyz3NOcPCf/Tc3P8/zrdm33ycrUOxzR8yRxyq/QWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707866; c=relaxed/simple;
	bh=sw/IM+DGe4wS2k7u4UL/F1KA0r8brXhwGqqYxpwVJ5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDxN1o4A76gwbRclwULxL60xs0Gx7zR9wByQVaqDFGQl55WLHKfxwfc4Yba+GgFOTbzPO0sy1cZdK79EsdPjfgN0+4Yn/I2E4tT4hYxqePw4IK2Ee4ilOqzNqBhDFPWmVsqoIHC56Uj8h0y2scVe+CDXIDY96/43Twwmn43BMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b=Gfb7W9lW; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=s2IVMrVJ; arc=none smtp.client-ip=23.251.240.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=iuunfi4kzpbzwuqjzrd5q2mr652n55fx; d=goosey.org; t=1746707861;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sw/IM+DGe4wS2k7u4UL/F1KA0r8brXhwGqqYxpwVJ5o=;
	b=Gfb7W9lWycYD9ahW1NZqzss4q9HkV3ARG1v2s1jerynNtocVWMlVu5pXlPDOtaO7
	k0iLGwnxupTdzJMnmjPJfnj22ZwVW0xvGc1pmtLbjBFApMrXcYWcJMjQn4j877HXBPz
	Iqqb4Y9gilbKQchkpiFmIC4Vx1YykDiZh781KevLuDCcYCWeKuyfw2sH4SnUI14cxZA
	NskrnYoCBfIQ2X88xrtg+uhQ4u8u5yWIItVlon3tW7J0NLBNsKcZeanBoT66Lul3+3k
	h8/ZCWKZEqMbSng4JNLnbgOtgpIdXk1ktlBXHt+ToSRwlHHF5Wopr01U5l5uSBXSPfD
	2de2cYFETA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bw45wyq3hkghdoq32obql4uyexcghmc7; d=amazonses.com; t=1746707861;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=sw/IM+DGe4wS2k7u4UL/F1KA0r8brXhwGqqYxpwVJ5o=;
	b=s2IVMrVJ/FLG1HVUsltaUZpCjQUrT16qkAIwcCBMLW+62J+TcqwguXWpm/elFLPX
	4Ya94y0BJ9xboLxg7z5156iWHsFAx9OjJzlfwhQ6Xo6jx7bk++Ve+Xw2SpqrQ3bp/Rc
	CefJvo4jj1mhUZLs093hOaDzuQimaNF1gbA+V94A=
X-Forwarded-Encrypted: i=1; AJvYcCUZYJXSFGpLA+CiaJrk6+j0tMvOQVZ4xZN2RGFn2Vo9yZ2IEGMsH7RlBnpupii7MdsHF60kEY+u@vger.kernel.org, AJvYcCXVJ0Zql1DsI4NiSYZn6JSBnONmg6SfPLOzOKiuYdLVd0+xI5xh7peY0eswHgb3BbLD4hwwk6CrA2Nv9oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHhdBcq1Y2E+6ZzxtwiDtiHEePUmBe6JG2E4VJXomFK58CINT
	bR8iReHwlOF/eW6LTfoh219pT59GJm7zvSvGp+kl6T4lVwCJqfXNCq9BpJm2ZEzGfrni1H9rrA3
	owglYxQY5ZAxeXNNCFAm5f2DYtgo=
X-Google-Smtp-Source: AGHT+IEua/nzvKFxLTo3aDzBURtaPlFt14umDlK/H+ypZTn/XRl9nhpJdxj7vVFrUZ4RezVUwAcez7c3GDbxZ8CrKS0=
X-Received: by 2002:a17:90b:1e08:b0:305:5f25:fd30 with SMTP id
 98e67ed59e1d1-30aac184aaamr10925497a91.4.1746707858598; Thu, 08 May 2025
 05:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01100196adabd0d2-24bf9783-b3d5-4566-9f98-9eda0c1f4833-000000@eu-north-1.amazonses.com>
 <c18ef0d0-d716-4d04-9a01-59defc8bb56e@lunn.ch>
In-Reply-To: <c18ef0d0-d716-4d04-9a01-59defc8bb56e@lunn.ch>
From: Ozgur Kara <ozgur@goosey.org>
Date: Thu, 8 May 2025 12:37:41 +0000
X-Gmail-Original-Message-ID: <CADvZ6EpS4n7W8z9X43J2ahVRzFrXg-MADUhGNRFbm4m6y-9jSw@mail.gmail.com>
X-Gm-Features: ATxdqUHniDJws00seF4GXFi7TIt1gTXUH4LZCyQmQFYjO7dTCsjdtOxRIUcmU6I
Message-ID: <01100196afe6ce73-82eaa239-15a5-48d0-bca7-f5870ec0569e-000000@eu-north-1.amazonses.com>
Subject: Re: [PATCH] net: ethernet: Fixe issue in nvmem_get_mac_address()
 where invalid mac addresses
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ozgur Kara <ozgur@goosey.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, 
	Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Feedback-ID: ::1.eu-north-1.jZlAFvO9+f8tc21Z4t7ANdAU3Nw/ALd5VHiFFAqIVOg=:AmazonSES
X-SES-Outgoing: 2025.05.08-23.251.240.10

Andrew Lunn <andrew@lunn.ch>, 8 May 2025 Per, 15:01 tarihinde =C5=9Funu yaz=
d=C4=B1:
>
> On Thu, May 08, 2025 at 02:14:00AM +0000, Ozgur Kara wrote:
> > From: Ozgur Karatas <ozgur@goosey.org>
> >
> > it's necessary to log error returned from
> > fwnode_property_read_u8_array because there is no detailed information
> > when addr returns an invalid mac address.
> >
> > kfree(mac) should actually be marked as kfree((void *)mac) because mac
> > pointer is of type const void * and type conversion is required so
> > data returned from nvmem_cell_read() is of same type.
>
> What warning do you see from the compiler?

Hello Andrew,

My compiler didnt give an error to this but we had to declare that
pointer would be used as a memory block not data and i added (void *)
because i was hoping that mac variable would use it to safely remove
const so expect a parameter of type void * avoid possible compiler
incompatibilities.
I guess, however if mac is a pointer of a different type (i guess)  we
use kfree(mac) without converting it to (void *) type compiler may
give an error.

For example will give error:

int mac =3D 10;
kfree(mac);

because pointer was of a type incompatible with const void * and i
think its not a compiler error, in this case it could be an error at
runtime bug and type of error could turn into a memory leak.
for example use clang i guess give error warning passing argument 1 of
kfree qualifier from pointer target type.

am i thinking wrong?

> > @@ -565,11 +565,16 @@ static int fwnode_get_mac_addr(struct
> > fwnode_handle *fwnode,
> >         int ret;
> >
> >         ret =3D fwnode_property_read_u8_array(fwnode, name, addr, ETH_A=
LEN);
> > -       if (ret)
> > +       if (ret) {
> > +               pr_err("Failed to read MAC address property %s\n", name=
);
> >                 return ret;
> > +        }
> >
> > -       if (!is_valid_ether_addr(addr))
> > +       if (!is_valid_ether_addr(addr)) {
> > +               pr_err("Invalid MAC address read for %s\n", name);
> >                 return -EINVAL;
> > +        }
> > +
> >         return 0;
> >  }
>
> Look at how it is used:
>
> int of_get_mac_address(struct device_node *np, u8 *addr)
> {
>         int ret;
>
>         if (!np)
>                 return -ENODEV;
>
>         ret =3D of_get_mac_addr(np, "mac-address", addr);
>         if (!ret)
>                 return 0;
>
>         ret =3D of_get_mac_addr(np, "local-mac-address", addr);
>         if (!ret)
>                 return 0;
>
>         ret =3D of_get_mac_addr(np, "address", addr);
>         if (!ret)
>                 return 0;
>
>         return of_get_mac_address_nvmem(np, addr);
> }
>
> We keep trying until we find a MAC address. It is not an error if a
> source does not have a MAC address, we just keep going and try the
> next.
>
> So you should not print an message if the property does not
> exist. Other errors, EIO, EINVAL, etc, are O.K. to print a warning.
>

ah, i understand that its already checked continuously via a loop so
it would be unnecessary if i printed an error message for
of_get_mac_addr.
hm this is an expected situation and device are just moving on to the
next property I understand thank you.
I will look at code again and understand it better.

Thanks for help,
Regards

Ozgur

>     Andrew
>
> ---
> pw-bot: cr
>
>

