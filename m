Return-Path: <netdev+bounces-57816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E267814476
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3135A1C20C96
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2116429;
	Fri, 15 Dec 2023 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrWMD5Ww"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD31802E
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so10121a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 01:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702632764; x=1703237564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksfZP38foq56lDtU7eYbsUT98dOQD2X3MtUgPiHDa24=;
        b=CrWMD5Wwe5wOjba4qcR6CJsQh3F99i/Evj+Ln5U1iNV/LIwTbOwMhxr9RYBmq1XcBI
         SnffjDFjRpEOjxLPTVnh6xsutlEm1PP4qwtK6xj9DVd4PTkvmxD9VGh9xbTdgAOJKEc9
         Km6wdg1ZAoPgnXiY6uUjXfXsHfq9EX3zFe0stGN/kdtpCK5iiNALX9a/E2UuIQ6eLK3D
         OfekPFWo4QHR8KpCJEbZosa+RWM5mvT4vHX8S7Hl4QldxJ9Pq+BGHNMq/ODITntValPx
         TgwE+YtEHmr9AiH18G4rMmfrmvEdJyhMozgbopXm8ht28BlHuNY/YqpmK8Q+tj717etG
         FcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702632764; x=1703237564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksfZP38foq56lDtU7eYbsUT98dOQD2X3MtUgPiHDa24=;
        b=Rv0q1l8725EBQFYss7tob63XA3TxUHT1F9xs0hmerpV8rfo6HCYqDDSNyyPuVf+5am
         RIptke1xCXL4cnV1CSalV4Bf/TyNHGRBlawCSE2gUl6bqBNLH587VzlO5OQ0HYegjv8k
         qno1Vb88aPfqZn/IsAeQ+7ewyeE9Owp12OY2svPA1ipq9AyQl0uDGPV73H3cVTfvedk0
         5BS4V4oxCmJmLokF76EiLj7v56XFxbWB7c2HVnCYYHGlGfB9TIcoV6H8vKewSyBAwi8A
         1D5YS8/DdR1fpdDqfX2Z4EqU2IwFX75e+RHkLNJY5Wjdpoq96m6scTWRAf0VVIwO2f/e
         ViSg==
X-Gm-Message-State: AOJu0YyhJ6KQv+WJ4xuhLtfJDgK/74suC+WUmqIjyM+WoabDe9+rVcJZ
	E3x+5eOdxco+LiM+hWCBL+V+2kGR5raIR12CH3LkJQ==
X-Google-Smtp-Source: AGHT+IG5yj5JZ8L7Ij9x2fWYLDBsH+Umvyzqugt+rLtsYddyxa2r9LJDCwpAU42CaU5p2Cy8J4+P8klFDyTEk/krqm4=
X-Received: by 2002:a50:bacf:0:b0:54d:6a88:507e with SMTP id
 x73-20020a50bacf000000b0054d6a88507emr822103ede.4.1702632764117; Fri, 15 Dec
 2023 01:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org>
 <20231215-new-gemini-ethernet-regression-v1-1-93033544be23@linaro.org>
In-Reply-To: <20231215-new-gemini-ethernet-regression-v1-1-93033544be23@linaro.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Dec 2023 10:32:30 +0100
Message-ID: <CANn89iJo8ER1kZYB7La1jx5p00FrHxzSLnSsWcMNdj8-iG9_Rw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: ethernet: cortina: Drop software checksumming
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 9:49=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
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
> Keeping the size check but removing the software checksum makes things
> work again. This was probably dubious to introduce in the first place.
>
> Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet=
/cortina/gemini.c
> index 78287cfcbf63..255fcffc1579 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1145,7 +1145,6 @@ static int gmac_map_tx_bufs(struct net_device *netd=
ev, struct sk_buff *skb,
>         dma_addr_t mapping;
>         unsigned short mtu;
>         void *buffer;
> -       int ret;
>
>         mtu  =3D ETH_HLEN;
>         mtu +=3D netdev->mtu;
> @@ -1166,14 +1165,7 @@ static int gmac_map_tx_bufs(struct net_device *net=
dev, struct sk_buff *skb,
>                  * checksum buffer is only 1518 bytes, so when the frames=
 get
>                  * bigger they get truncated, or the last few bytes get
>                  * overwritten by the FCS.
> -                *
> -                * Just use software checksumming and bypass on bigger fr=
ames.
>                  */
> -               if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> -                       ret =3D skb_checksum_help(skb);
> -                       if (ret)
> -                               return ret;
> -               }

If the hardware does not support checksumming for frames bigger than
ETH_FRAME_LEN,
then an appropriate mitigation would be to have an ndo_features_check() ?

Depending on packet being gso or not, you would have to check skb->len
or shinfo->gso_size

The ndo_features_check could then take a more appropriate action
(forcing GSO, and/or forcing software checksumming)

This driver claims to support TSO, but I do not see it using
shinfo->gso_size, something must be very wrong...

I would simply remove this TSO part, before the driver really supports
TSO properly.

diff --git a/drivers/net/ethernet/cortina/gemini.c
b/drivers/net/ethernet/cortina/gemini.c
index 78287cfcbf6388f01bfab417c264f41f3a1a16f2..829cb69982fe1caf99b56363e9e=
0565fbaecc82e
100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -79,8 +79,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=3Dnone,...,16=3Da=
ll)");
 #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)

 #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
-               NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
-               NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
+               NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM )

 /**
  * struct gmac_queue_page - page buffer per-page info

