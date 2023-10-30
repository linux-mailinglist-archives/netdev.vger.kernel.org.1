Return-Path: <netdev+bounces-45280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE277DBE44
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9E91C208C3
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 16:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A3218C23;
	Mon, 30 Oct 2023 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmKSY1ex"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6EA13AC5
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 16:52:40 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB5A9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:52:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so490a12.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698684757; x=1699289557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/BSsNWLspfthFQHwJtcXo2ADTyt8+cC4m6Msvhwdq4=;
        b=RmKSY1ex/z57HODjZlgWtUPt/mxKQbwD1EL/6r4UfBsrrT/QPdqYXOa8Ejw/uvPx/8
         LkjYdaWaP85xaCHnWmBWEfs+zGitrFdX4faCefuzYWYwkuluY7R7Pce8VcFbN3GhZ8eb
         LIv/n0DtluzSoDbg+9E1dlUuokdpbQrYIorPJ91qFnywciAJGUL+Px1Q2XZ0aLCUYmBR
         ZhBKncA9AWNUeqL2viiwDCttI3ZyIxv2FxzBU6saYExW69XaTeEGsOslPJzLdAPJa3YH
         MjzCOFr4HUhe2Lvl7ixs1un8F2MYAxJ7oIcIjbTZiqLbHRajmrK41vIqCFdlIWx2w/k8
         6fNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698684757; x=1699289557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/BSsNWLspfthFQHwJtcXo2ADTyt8+cC4m6Msvhwdq4=;
        b=LPS5LTMbFYSXsrT4UGSgfFh7PShJbFKDRZWHXGKy9mGKP8sw6SD24dm+FrwMgke58w
         trF3bfKEZfo8YAJOMQZA0wfaU3uocafVmVQCBSRU+WRa6oYoAPXmptAYUHdPjvBXQZPr
         b0dVRs2oF/5YloE+ORUQ2xqaLLUIWqzGyHkwkWuVbPBssZJI46gLf8frUWOXh7f5/uX3
         JiWOfgF2KUaY0IbeKMlBjln5ENMiot7fBXVur/Iua1CDF6zYjS+syu0cnSyg+2RRNIq2
         CjduPSffvIAr671rM0U2+fnrFmEUOGOlrW/+YStsHz31wxU4d1oTZSGsLDgJgc1DA+h+
         wPVA==
X-Gm-Message-State: AOJu0Yy+zuqN5umrx1DwyXL/mDdPfzwzHKEIWCS1s+5M+j6ODPhnk+w7
	cXO/dGfQvLUOfVvR/xAbVl+Cd858x1fzISy3GNQZMQ==
X-Google-Smtp-Source: AGHT+IF65SluPCi/VLGKwqVMoN830lGi2osimZ14H4dVF5gzTbHCeUGKZxc+REGpx/dAte8oKZK5ztGUNEnyr9Ekavg=
X-Received: by 2002:a05:6402:1a56:b0:543:5119:2853 with SMTP id
 bf22-20020a0564021a5600b0054351192853mr61455edb.6.1698684756998; Mon, 30 Oct
 2023 09:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027213059.3550747-1-ptf@google.com> <415e0355-7d71-4b82-b4fc-37dad22486a9@gmail.com>
In-Reply-To: <415e0355-7d71-4b82-b4fc-37dad22486a9@gmail.com>
From: Patrick Thompson <ptf@google.com>
Date: Mon, 30 Oct 2023 12:52:24 -0400
Message-ID: <CAJs+hrEi8oo1q5mMfNbaUi8x1H-sBGmYToTkRfVXs=ga9LPupQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, Chun-Hao Lin <hau@realtek.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I wouldn't trust the mc filter, the eap packet being filtered is not a
multicast packet so I wonder what else could be erroneously filtered.
I do agree that it would be nice to be able to override it for testing
purposes.

Would you like me to add MAC_VER_48 to the patch? I would not be able
to test and confirm that it affects it in the same way I have for
VER_46.

It is unfortunate that the naming doesn't quite line up.

On Sat, Oct 28, 2023 at 4:38=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 27.10.2023 23:30, Patrick Thompson wrote:
> > MAC_VER_46 ethernet adapters fail to detect eapol packets unless
> > allmulti is enabled. Add exception for VER_46 in the same way VER_35
> > has an exception.
> >
> MAC_VER_48 (RTL8107E) has the same MAC, just a different PHY.
> So I would expect that the same quirk is needed for MAC_VER_48.
>
> MAC_VER_xx is a little misleading, actually it should be NIC_VER_xx
>
> > Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> > Signed-off-by: Patrick Thompson <ptf@google.com>
> > ---
> >
> > Changes in v2:
> > - add Fixes tag
> > - add net annotation
> > - update description
> >
> >  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> > index 361b90007148b..a775090650e3a 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -2584,7 +2584,8 @@ static void rtl_set_rx_mode(struct net_device *de=
v)
> >               rx_mode |=3D AcceptAllPhys;
> >       } else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
> >                  dev->flags & IFF_ALLMULTI ||
> > -                tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35) {
> > +                tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35 ||
> > +                tp->mac_version =3D=3D RTL_GIGA_MAC_VER_46) {
> >               /* accept all multicasts */
> >       } else if (netdev_mc_empty(dev)) {
> >               rx_mode &=3D ~AcceptMulticast;
>

