Return-Path: <netdev+bounces-44868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1BD7DA2A8
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B019C1C210CB
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6863FE47;
	Fri, 27 Oct 2023 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L62DnYLR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378823FE49
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 21:51:03 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE60D47
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 14:51:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so3946a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698443458; x=1699048258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZFjePgLMvsDi/m2Cvy7/csb6I6R8sktPrrPN2yhQIc=;
        b=L62DnYLROg1LEFU894TOeY/x8bKihLFZAecXxreDhRHsbxrhYdBsxX/BurV0inW0Fp
         UOx9gUsaZQ+2sBdIvMdy3ietIyeEVPayQcHuEWpKDNkoonww3vtn3Y7bPoaxislTZc5j
         9GFpJqilTXmk9UQLYgVS7Ic0HyboEKP2hvVN6FGbkSiyqrnLu/4eQ8LAGobpy5qYzt++
         jqjS6uPr9ArJOGUfcn86VbPzx561nx2jmuD6Na/g4So++TmmhgYEMkK/iLECp/FvzOmP
         g2Ct7B6Rr/eEFj9PRudCI/Y6VdLIb4Q3hBjuUf6kDdV6IjIjU2pNxXEKojCar70Van1N
         IPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698443458; x=1699048258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZFjePgLMvsDi/m2Cvy7/csb6I6R8sktPrrPN2yhQIc=;
        b=ck4q3LQgXZKo2uiA9oeePetzxaU9eaAw2Y5uybWqkZB9As8Zfa/+zVT+gOFWz/r18y
         gxK1E+qNZC+8Tb4N01hJjBhj91IRVHmq8WOTfNb/H18X9KCPDd0wX36AaOrGuwmtKyHl
         0j+vJOyrOuHknyo19wCwurztkjnEPbwh1MmSIPIetED++RmOHPdp3+5oYZXSJdnCzUxD
         DpnzlJnSpozHq38n5YjrrKSgLY0Cv0Y9qzQj+YyJ1eWt00HBtamwicU6iVGT4fwe5vlJ
         W6Hks9DHBRxpOagQxi2GFGr+5TcjbPExHwqv4c+x+kj6UyqZ6dWWpWnF/ojZebbcqGMZ
         LgGQ==
X-Gm-Message-State: AOJu0YwMZ/T2o3xuJ1PPevwwQMPNDL7ftuASkFmtl8igbhfhIFNcBtS2
	osiDg6bXalZdGk9g+yWm3gzqaO6uNdQm5SS6t2OF/nVPJRWek4zSRGg=
X-Google-Smtp-Source: AGHT+IFpkC5O4eKmioGaKAkjC0iU3Y2gulHxH7Zju+sJDBFTxtsSUkD5OnKsAiu0TQaxmCHiTR3GlZ+FQ0a+KKzcM4U=
X-Received: by 2002:a50:9552:0:b0:540:9dbd:4b8 with SMTP id
 v18-20020a509552000000b005409dbd04b8mr37083eda.2.1698443458524; Fri, 27 Oct
 2023 14:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027213059.3550747-1-ptf@google.com>
In-Reply-To: <20231027213059.3550747-1-ptf@google.com>
From: Patrick Thompson <ptf@google.com>
Date: Fri, 27 Oct 2023 17:50:46 -0400
Message-ID: <CAJs+hrEXfk82+WyYSsPvs=qk-_JOsBHdWzgnFuy692eJsP=whQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To: netdev@vger.kernel.org
Cc: Chun-Hao Lin <hau@realtek.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	nic_swsd@realtek.com, Jeffery Miller <jefferymiller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Heiner,

I haven't heard back from realtek about the possibility that this
affects other MAC_VERs. Do you think it's acceptable to merge this
patch for now and if/when we hear back from realtek I can adjust the
function again?

Thank you,
Patrick

On Fri, Oct 27, 2023 at 5:31=E2=80=AFPM Patrick Thompson <ptf@google.com> w=
rote:
>
> MAC_VER_46 ethernet adapters fail to detect eapol packets unless
> allmulti is enabled. Add exception for VER_46 in the same way VER_35
> has an exception.
>
> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> Signed-off-by: Patrick Thompson <ptf@google.com>
> ---
>
> Changes in v2:
> - add Fixes tag
> - add net annotation
> - update description
>
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 361b90007148b..a775090650e3a 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2584,7 +2584,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
>                 rx_mode |=3D AcceptAllPhys;
>         } else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
>                    dev->flags & IFF_ALLMULTI ||
> -                  tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35) {
> +                  tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35 ||
> +                  tp->mac_version =3D=3D RTL_GIGA_MAC_VER_46) {
>                 /* accept all multicasts */
>         } else if (netdev_mc_empty(dev)) {
>                 rx_mode &=3D ~AcceptMulticast;
> --
> 2.42.0.820.g83a721a137-goog
>

