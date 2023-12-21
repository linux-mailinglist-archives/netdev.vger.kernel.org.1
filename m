Return-Path: <netdev+bounces-59488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E83E81B091
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 09:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E004A282F77
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EF217735;
	Thu, 21 Dec 2023 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYiqeU1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9218037
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d40fbd46cso5845e9.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703148446; x=1703753246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwRB4Aq8DX6U9rpIfnHBP3eqt8b31V+waJPNEupxC/w=;
        b=UYiqeU1oCFLwfaIRufSDMT7xZi/Go3cxneXCCSOQDXDKeujxuo/1Vga9IsHFkMGhNH
         zAxqmOym+9mweuZXEI8tc43MVlstosYXjMT1ehoSdkZ/vI9u329YhLN+PG2NmPBjgJqZ
         2spF6rEzRiShDdiIe60nlkRA4xTv3t0cE4RXSmbA+q1+FTjGMGF8zIr8mGHTmt1PxKhP
         P+3mweUflIPsT8YF/ywk0XI5Esx+5xpTa/ykz5Sz7cK0U2oPP5cLPsd8w3xs+K9pNbVL
         X1TDwV/KymNSgZDVUgDEAybvOlgAA3T5/RaBr78T6sSsw5nWwKAdHhW6dfF1m5df2Df+
         Bquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703148446; x=1703753246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwRB4Aq8DX6U9rpIfnHBP3eqt8b31V+waJPNEupxC/w=;
        b=PgoVyGXYA6ghiDPHhKXAh4jvU1i4Drk+xCcUrG4ngf9CuIQKEs5PZ2NQxUr/ECIlOC
         Je2d676+YZdl3dOkqHrPcUYKFbNQWHONEpLdG44HK4hS8HUMEmTNSQQDsT5Dt48Rhp3d
         01/pTw2oFLfF9/B2uyu6zgnFA6J7YrqcCnLwCKJaJnUbZcwOCFHgz5n+YA7imdm/XsNF
         /8KH1tRbPKXT+Z196cFcvo+627eyiAQYaP/+VYzlXY/OLEhCvBlbwEx7vPzUViSwkhkj
         jOLf8Vocrb+8PeWo/CUs22z5cpqNBwV0ytjQUYXRGD4nP7zHapGHHQRN39wCv6MjHEU1
         qfkw==
X-Gm-Message-State: AOJu0Yx0MGrv2/xxjGnqjoa5wy+rX7NzKstWebxALhYPVYXiijFnBRnT
	Rr7QjVRt3BJf/vJlc8ttbi4aDcYINNnZDNrHBNO55fQNBDVj
X-Google-Smtp-Source: AGHT+IHK/r7XvBloyjYUxqxmvpyDTECnQ+VHMvatq7NMOLeH0ckKDx0eXn8LgC4MGJ5syMoNgWtffGA4I5qVEqrhRKw=
X-Received: by 2002:a05:600c:5117:b0:40b:5972:f56b with SMTP id
 o23-20020a05600c511700b0040b5972f56bmr44647wms.3.1703148445446; Thu, 21 Dec
 2023 00:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org>
 <20231221-new-gemini-ethernet-regression-v3-1-a96b4374bfe8@linaro.org>
In-Reply-To: <20231221-new-gemini-ethernet-regression-v3-1-a96b4374bfe8@linaro.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Dec 2023 09:47:11 +0100
Message-ID: <CANn89iKycKiDXFeJZykA9ERR2exWpkCJtmYFdf+sVViuz==PMQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/3] net: ethernet: cortina: Drop software checksum
 and TSO
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 1:02=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> The recent change to allow large frames without hardware checksumming
> slotted in software checksumming in the driver if hardware could not
> do it.
>
> This will however upset TSO (TCP Segment Offloading). Typical
> error dumps includes this:
>
> skb len=3D2961 headroom=3D222 headlen=3D66 tailroom=3D0
> (...)
> WARNING: CPU: 0 PID: 956 at net/core/dev.c:3259 skb_warn_bad_offload+0x7c=
/0x108
> gemini-ethernet-port: caps=3D(0x0000010000154813, 0x00002007ffdd7889)
>
> And the packets do not go through.
>
> After investigating I drilled it down to the introduction of the
> software checksumming in the driver.
>
> Since the segmenting of packets will be done by the hardware this
> makes a bit of sense since in that case the hardware also needs to
> be keeping track of the checksumming.
>
> That begs the question why large TCP or UDP packets also have to
> bypass the checksumming (like e.g. ICMP does). If the hardware is
> splitting it into smaller packets per-MTU setting, and checksumming
> them, why is this happening then? I don't know. I know it is needed,
> from tests: the OpenWrt webserver uhttpd starts sending big skb:s (up
> to 2047 bytes, the max MTU) and above 1514 bytes it starts to fail
> and hang unless the bypass bit is set: the frames are not getting
> through.
>
> Drop the size check and the offloading features for now: this
> needs to be fixed up properly.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet=
/cortina/gemini.c
> index 78287cfcbf63..ecc247acac39 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -79,8 +79,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=3Dnone,...,16=
=3Dall)");
>  #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
>
>  #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
> -               NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
> -               NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
> +                              NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM)
>
>  /**
>   * struct gmac_queue_page - page buffer per-page info
> @@ -1145,7 +1144,6 @@ static int gmac_map_tx_bufs(struct net_device *netd=
ev, struct sk_buff *skb,
>         dma_addr_t mapping;
>         unsigned short mtu;
>         void *buffer;
> -       int ret;
>
>         mtu  =3D ETH_HLEN;
>         mtu +=3D netdev->mtu;

I suggested removing all this business with mtu.

A driver is not supposed to double check the upper layer is giving a
too big packet.

I think this code was 'trying' to implement TSO in a very wrong way.

If a patch removes TSO, it should also remove this dead code...

> @@ -1160,22 +1158,7 @@ static int gmac_map_tx_bufs(struct net_device *net=
dev, struct sk_buff *skb,
>                 word3 |=3D mtu;
>         }
>
> -       if (skb->len >=3D ETH_FRAME_LEN) {
> -               /* Hardware offloaded checksumming isn't working on frame=
s
> -                * bigger than 1514 bytes. A hypothesis about this is tha=
t the
> -                * checksum buffer is only 1518 bytes, so when the frames=
 get
> -                * bigger they get truncated, or the last few bytes get
> -                * overwritten by the FCS.
> -                *
> -                * Just use software checksumming and bypass on bigger fr=
ames.
> -                */
> -               if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> -                       ret =3D skb_checksum_help(skb);
> -                       if (ret)
> -                               return ret;
> -               }
> -               word1 |=3D TSS_BYPASS_BIT;
> -       } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
>                 int tcp =3D 0;
>
>                 /* We do not switch off the checksumming on non TCP/UDP
>
> --
> 2.34.1
>

