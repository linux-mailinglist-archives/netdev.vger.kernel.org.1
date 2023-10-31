Return-Path: <netdev+bounces-45483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705387DD7B4
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 22:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257CE281898
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 21:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647B4208B8;
	Tue, 31 Oct 2023 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFXVbVmt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7112E57
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:22:22 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41031B9
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:22:19 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5af5b532d8fso56350567b3.2
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698787338; x=1699392138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4LrpsRV8LqgOH/k11ky5xw4VxQr9Kt5ptUpPAKGLd4=;
        b=VFXVbVmtEsAduIFm3C29S4LWKF0Zzc/9w1eewDJR5FUooAQ97/+HYMmj+DjFAgKmra
         oyYmj4MHlTeuW4I4IjJ+YYth+Vz9JIuoKfGK6qBTD/W2CegX+aZ2LZTZJwkKHu/KcxDr
         qR/O1ySVIS2FVcE79M9baNFnSoly3Ko1SJw9rhtChiYliKGSNvpHxdoiJ9c4FzENqBAL
         09H+D5O2HotBad004luMTw6yStgkL+Zge4c8PaDEjwRCqr8tl3qHvzzjnd1B7mMnTAn4
         n9/c16oLwQ0fMzAT5tJmW+5BS/G7kNwQNWNZ6flH4rpOZbXzPnbVjIm2Ly/FPHQr757c
         1PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698787338; x=1699392138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4LrpsRV8LqgOH/k11ky5xw4VxQr9Kt5ptUpPAKGLd4=;
        b=BlpQtx0UVgApnFuvyy/MKwc/BeiXxc8yZ9aAlXWIun72ttnjy2tjfqNUF/PjwSyUnB
         uuXN2zGmKW0w8/2mD+vXEUnEjjeM0qldhDwhApaFdUW+D+nFhDI12oavu/1djFBNsT6K
         lN1qzEETIYWn165zSd+mchtg0uOWVtIO+FJlSBH4b0ztDa83rdGg4im21354YpAqNwAl
         nCB3WG2lUoDe/TfLgm9CIzPOiHua3K2OqEzEoRMWk4h5IqLIaSjKxoavZufiSEECjl7f
         B3m6dipBTACW0ojtt8kHEtCZalla7s7zkNbxr74BcCIX3n/DjoYhZRO0hDjKwy3Cj+C3
         8kyg==
X-Gm-Message-State: AOJu0YyPZoWTKF6Jeo6eIb1bb1Xa7FP1IWr4t1ttWG1srjT5wmIt8n9V
	k+IkZYRujQtVanzrrgTi//7cWvbNyV/JGwLVaqQ8mw==
X-Google-Smtp-Source: AGHT+IFhjnINENOgvp+ur30oT8VgLRv2hYfVUqrUhgFZgkSxPiCmNSWtakRC0Zalo4j5RQG35LKTIklZoKg45DaBXrc=
X-Received: by 2002:a81:c704:0:b0:5a7:b81a:7f5d with SMTP id
 m4-20020a81c704000000b005a7b81a7f5dmr13974357ywi.18.1698787338056; Tue, 31
 Oct 2023 14:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>
 <20231030152325.qdpvv4nbczhal35c@skbuf> <20231030153057.3ofydbzh7q2um3os@skbuf>
In-Reply-To: <20231030153057.3ofydbzh7q2um3os@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Oct 2023 22:22:05 +0100
Message-ID: <CACRpkdYb6v6dpFFySSHdQ0H+KYRDNr2V4ShZTVA2A0ar_h9D=A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

I got around to testing this too:

On Mon, Oct 30, 2023 at 4:31=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> Could you please place these skb_dump() calls before and after the magic
> __skb_put_padto() call, for us to see if anything unexpected changes?
> Maybe the socket buffers have some unusual geometry which the conduit
> interface doesn't like, for some reason.
>
> The number of skb dumps that you provide back should be even, and
> ideally the first one should be the unaltered packet, to avoid confusion =
:)

I did a variant to just get one SKB dump and not tons of them;

@@ -37,22 +37,35 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *s=
kb,
                                      struct net_device *dev)
 {
        struct dsa_port *dp =3D dsa_slave_to_port(dev);
+       static int cnt =3D 0;
        __be16 *p;
        u8 *tag;
        u16 out;

-       /* Pad out to at least 60 bytes */
-       if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
-               return NULL;
-
        /* Packets over 1496 bytes get dropped unless they get padded
         * out to 1518 bytes. 1496 is ETH_DATA_LEN - tag which is hardly
         * a coinicidence, and 1518 is ETH_FRAME_LEN + FCS so we define
         * the threshold size and padding like this.
         */
        if (skb->len >=3D (ETH_DATA_LEN - RTL4_A_HDR_LEN)) {
+               cnt++;
+
+               if (cnt =3D=3D 1) {
+                       pr_info("SKB before padding:\n");
+                       skb_dump(KERN_INFO, skb, true);
+               }
+
                if (unlikely(__skb_put_padto(skb, ETH_FRAME_LEN +
ETH_FCS_LEN, false)))
                        return NULL;
+
+               if (cnt =3D=3D 1) {
+                       pr_info("SKB after padding:\n");
+                       skb_dump(KERN_INFO, skb, true);
+               }
+       } else {
+               /* Pad out to at least 60 bytes */
+               if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
+                       return NULL;
        }

# ping -s 1472 192.168.1.137

The result:

SKB before padding:
37 (192.168.1.13skb len=3D1514 headroom=3D18 headlen=3D1514 tailroom=3D260
mac=3D(18,14) net=3D(32,20) trans=3D52
shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
csum(0xd4ef2b1 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0)
hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D0 iif=3D0
7): 1472 data bydev name=3Dlan0 feat=3D0x0002000000005020
tes
sk family=3D2 type=3D3 proto=3D1
skb headroom: 00000000: 00 02 00 01 00 00 00 00 00 00 03 78 02 00 bc ae
skb headroom: 00000010: 00 00
skb linear:   00000000: bc ae c5 6b a8 3d c2 2f 0b dc cc b4 08 00 45 00
skb linear:   00000010: 05 dc 3b de 40 00 40 01 75 68 c0 a8 01 01 c0 a8
skb linear:   00000020: 01 89 08 00 16 d2 09 54 00 00 8a cc 4d 0d 00 00
skb linear:   00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005e0: 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000100: 00 00 00 00

SKB after padding:
skb len=3D1518 headroom=3D18 headlen=3D1518 tailroom=3D256
mac=3D(18,14) net=3D(32,20) trans=3D52
shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
csum(0xd4ef2b1 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0)
hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D0 iif=3D0
dev name=3Dlan0 feat=3D0x0002000000005020
sk family=3D2 type=3D3 proto=3D1
skb headroom: 00000000: 00 02 00 01 00 00 00 00 00 00 03 78 02 00 bc ae
skb headroom: 00000010: 00 00
skb linear:   00000000: bc ae c5 6b a8 3d c2 2f 0b dc cc b4 08 00 45 00
skb linear:   00000010: 05 dc 3b de 40 00 40 01 75 68 c0 a8 01 01 c0 a8
skb linear:   00000020: 01 89 08 00 16 d2 09 54 00 00 8a cc 4d 0d 00 00
skb linear:   00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000001f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000002f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000003f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000004f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   00000590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb linear:   000005e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb tailroom: 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

As expected the linear SKB is 4 bytes longer in this case.

Yours,
Linus Walleij

