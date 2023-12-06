Return-Path: <netdev+bounces-54461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4A080721F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3B51C209F9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2D03DBA4;
	Wed,  6 Dec 2023 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7fRkS4e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412B1D47
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 06:18:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso9402a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 06:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701872290; x=1702477090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U31oXAWomzGj4NT1/sNTZ0Et5x0qxeZcKO4aUpM0Jrg=;
        b=B7fRkS4eH7986ejkeB/knbhtbFjw+G7e28kR9fogd1F0LyfL0PUSeumdpYZ1RLO9Gk
         13qAGLkzfjHi3RNnp5dJMm/Gcvbi7zGqPoXa/nPeafjWTF8df8WmjEAx4w3p0dgdtcdK
         17kTwPklLiiT3zmX2w2Ot/YaQv/s/X9z78OWlbwN7QOaRuySQlm/VKG1aMumjmnHRFoM
         pnq9JowPU7uhFoAGhxS5L6LCr96u6/umxNec2KcXZrKtTtziKurcFd65SRZUTEIhtPS2
         JPTuijgVRvnRpLkuSxDOhmWkpIpRaRC1qnmPaH4n0nd82d9TlqSqfCFRA5TZBZuvvvR6
         aszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872290; x=1702477090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U31oXAWomzGj4NT1/sNTZ0Et5x0qxeZcKO4aUpM0Jrg=;
        b=dbL8mZR1IzDphdwX7xwWWLuGHmgALKSwYdxq/RE0HPC1INtLS4Ko30a8V01NfC3NsR
         ZSmMbuMas2d5fIVSS8A/VAtOw42QAAY+Fm8l+ui5NVqvxPVscmGFOOPUG3JJFXRlqXx9
         8tVySVcI/omKq/vOYLuPK07eFHpJDnIYchuRpypPSsZ46FQzkMvVNCeZrEUDAD7BeR49
         HJzPiO56Y0KWIcluTCXB6x8OHs8oE2Nn625es9BwblvqujT+twxYYwqoTmkGQHTF8aly
         Qk4MSLct1K/0H2shSlomZ926Q+qh4vRHqscncAkwujraWz3R7PIo3uYfSOPt1u/mZKRf
         2EKg==
X-Gm-Message-State: AOJu0Yxcsq9F+zo6oIIYuNRoawGY2D5PblHvTRZdcQlBjKIcZIqEMjeQ
	wQI2oMVIdUbNFxVjwhFih4N6vSBTaReb0btx7vNfrA==
X-Google-Smtp-Source: AGHT+IEv6CsXashWLFY1377Q2VGDWuv9nEl2XO8ZtcWrcQsYib2YqnYHeuyNZ3mcg3d+Fjhp11+0oQLVqy01i/2c3to=
X-Received: by 2002:a50:c048:0:b0:544:e2b8:ba6a with SMTP id
 u8-20020a50c048000000b00544e2b8ba6amr83599edd.3.1701872289406; Wed, 06 Dec
 2023 06:18:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206141054.41736-1-maze@google.com>
In-Reply-To: <20231206141054.41736-1-maze@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Dec 2023 15:17:58 +0100
Message-ID: <CANn89iKwwfUzh23+dwS5iUCy1vybQ17TqNFbuKc_D2V-RD-i4g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv6: support reporting otherwise unknown
 prefix flags in RTM_NEWPREFIX
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shirley Ma <mashirle@us.ibm.com>, 
	David Ahern <dsahern@kernel.org>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 3:10=E2=80=AFPM Maciej =C5=BBenczykowski <maze@googl=
e.com> wrote:
>
> Lorenzo points out that we effectively clear all unknown
> flags from PIO when copying them to userspace in the netlink
> RTM_NEWPREFIX notification.
>
> We could fix this one at a time as new flags are defined,
> or in one fell swoop - I choose the latter.
>
> We could either define 6 new reserved flags (reserved1..6) and handle
> them individually (and rename them as new flags are defined), or we
> could simply copy the entire unmodified byte over - I choose the latter.
>
> This unfortunately requires some anonymous union/struct magic,
> so we add a static assert on the struct size for a little extra safety.
>
> Cc: Shirley Ma <mashirle@us.ibm.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Fixes: 60872d54d963 ("[IPV6]: Add notification for MIB:ipv6Prefix events.=
")
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> ---
>  include/net/addrconf.h | 12 ++++++++++--
>  include/net/if_inet6.h |  4 ----
>  net/ipv6/addrconf.c    |  6 +-----
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/addrconf.h b/include/net/addrconf.h
> index 82da55101b5a..8e308c2662d7 100644
> --- a/include/net/addrconf.h
> +++ b/include/net/addrconf.h
> @@ -31,17 +31,22 @@ struct prefix_info {
>         __u8                    length;
>         __u8                    prefix_len;
>
> +       union __attribute__((packed)) {
> +               __u8            flags;
> +               struct __attribute__((packed)) {

For non uapi, it is recommended to use __packed instead of
__attribute__((packed))

