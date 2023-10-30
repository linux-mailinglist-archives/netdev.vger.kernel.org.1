Return-Path: <netdev+bounces-45344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A139A7DC2A7
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 23:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C8728151C
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 22:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4C6107AA;
	Mon, 30 Oct 2023 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ui07+5Qn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE410798
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 22:57:47 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA0DD3
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 15:57:46 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7fb84f6ceso41959247b3.1
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698706665; x=1699311465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOqpJwapvpRYXVNPTTKOLnjojsLqC4JocbtWhR4syPY=;
        b=ui07+5Qnn11jUW7iw8DX6C2Sl0WCdv7TQtNg8elsBjFWioSv2tmLFY4jHYqC7n1y+G
         YbRcEFkyElwmZPFzVSzVPrh/1xSd03krVZrA0j7J+vOeLlN0xeSQP3tMpTP5a6qXqnBD
         Zg1tbCBKbImExbW3g9Vz8jOblAAB+nVIvSl7n+4LhAPpw5+W80vsIxvpOSIycew4nOgV
         96gqtEQrSICD36I0rXYGq+EFQBel09i+kuvaKJRHwtcqd196z3oBmT4S/cgHJRl3bHIv
         na2zdZteWN3Gy/n3FpRMbwmKmOXQ4OAWv2qNkc5bYP+gP2OdsMK434I0CUn1XKpVDUri
         Cb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698706665; x=1699311465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOqpJwapvpRYXVNPTTKOLnjojsLqC4JocbtWhR4syPY=;
        b=Kga1rMg+OHgzq/Gvp5isHCPtN3w9fp5wxzjmrMZR0cFqork2rEe8ZkzbdvXWHcwzPr
         CN4dZjCVNOxoGorcDVm6MZYQWT/VyOuzbA21NMYHO/bdwgdLVWeFG/I7KtbPLlvH0Kyc
         JUjWgE57FPLUQizSEe1QTmuO3/+W2ss9Q7PW6mmMHdq0OKHiDEIwb7a7LeeHYSGsFO/Y
         fk9ZQqYmH9Or79mDaa45fFPJAeezCP5ahRyiU2Q5ErxJvZNfM3lbPhg83NcoAdwbXBpK
         sHleDaB+3Q6FIrSsHFPKUjyip/ZRxs+qgIv5lX5B8QRYtkPTJYXWcFbcJt1l0fo059jr
         xxQQ==
X-Gm-Message-State: AOJu0YyKwBFnEWFq1Q8XimRy5EURRtbGGFWk2hSarnrF+VQrFIpLLSxT
	0QCMD1OzXTSGo+t64eB7aSIy7NpFnT9Yk9LZ5687Eg==
X-Google-Smtp-Source: AGHT+IHHNd6xOi3tS5B9+YYG7Jz7GgDIxjgIhWzquOcABcL8hJSbxW/ZS0Ej1cU7ZBO0Cx0JuFY9j3Eo+5gTwJG5y2A=
X-Received: by 2002:a81:ca08:0:b0:5a8:1924:b7e7 with SMTP id
 p8-20020a81ca08000000b005a81924b7e7mr8194231ywi.27.1698706665480; Mon, 30 Oct
 2023 15:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
In-Reply-To: <20231030222035.oqos7v7sdq5u6mti@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Oct 2023 23:57:33 +0100
Message-ID: <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 11:20=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:

> I see commit 86dd9868b878 ("net: dsa: tag_rtl4_a: Support also egress tag=
s")
> also mentions: "Qingfang came up with the solution: we need to pad the
> ethernet frame to 60 bytes using eth_skb_pad(), then the switch will
> happily accept frames with custom tags.". So the __skb_put_padto() was
> something very empirical in the first place.
>
> Since it's all problematic, would you mind removing the __skb_put_padto()
> altogether from rtl4a_tag_xmit(), and let me know what is the output for
> the following sweep through packet sizes? I truly wonder if it's just
> for small and large packets that we see packet drops, or if it's somethin=
g
> repetitive throughout the range as well.
>
> for size in $(seq 0 1476); do if ping 10.0.0.56 -s $size -W 1 -c 1 -q >/d=
ev/null; then echo "$((size + 42)): OK"; else echo "$((size + 42)): NOK"; f=
i; done

The weird thing is that if I remove the __skb_put_padto()
call, ping doesn't work at all. Somehow the packets are
corrupted, because they sure get out of the switch and I
can see them arriving with tcpdump on the host.

root@OpenWrt:/# for size in $(seq 0 1476); do if ping 192.168.1.137 -s $siz=
e -W
1 -c 1 -q >/dev/null; then echo "$((size + 42)): OK"; else echo "$((size + =
42)):
 NOK"; fi; done
42: NOK
43: NOK
44: NOK
45: NOK
46: NOK
47: NOK
48: NOK
49: NOK
50: NOK
51: NOK
(...)
1509: NOK
1510: NOK
1511: NOK
1512: NOK
1513: NOK
1514: NOK
1515: NOK
1516: NOK
1517: NOK
1518: NOK

This of course make no sense, since the padding function should do nothing
when the packet is bigger than 60 bytes.

So what we are seeing is some kind of side effect from the usage of
__skb_put_padto() I suppose? But I have no idea what that is, I looked
at the function and what it calls down to __skb_pad().

I'm testing skb_linearize(), which seems to be called on this path...

TCPdump on the host looks like this:
# tcpdump -i enp7s0
dropped privs to tcpdump
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on enp7s0, link-type EN10MB (Ethernet), snapshot length 262144 by=
tes
23:28:55.184019 IP _gateway > fedora: ICMP echo request, id 2461, seq
0, length 27
23:28:56.205294 IP _gateway > fedora: ICMP echo request, id 2462, seq
0, length 28
23:28:57.226495 IP _gateway > fedora: ICMP echo request, id 2463, seq
0, length 29
23:28:58.248013 IP _gateway > fedora: ICMP echo request, id 2464, seq
0, length 30
23:28:59.269157 IP _gateway > fedora: ICMP echo request, id 2465, seq
0, length 31
23:29:00.290443 IP _gateway > fedora: ICMP echo request, id 2466, seq
0, length 32
23:29:01.698700 IP _gateway > fedora: ICMP echo request, id 2467, seq
0, length 33
23:29:02.332131 IP _gateway > fedora: ICMP echo request, id 2468, seq
0, length 34
23:29:03.352442 IP _gateway > fedora: ICMP echo request, id 2469, seq
0, length 35
(...)
23:53:33.834706 IP _gateway > fedora: ICMP echo request, id 4000, seq
0, length 1475
23:53:34.854946 IP _gateway > fedora: ICMP echo request, id 4001, seq
0, length 1476
23:53:36.258777 IP truncated-ip - 1 bytes missing! _gateway > fedora:
ICMP echo request, id 4002, seq 0, length 1477
23:53:36.896654 IP truncated-ip - 2 bytes missing! _gateway > fedora:
ICMP echo request, id 4003, seq 0, length 1478
23:53:37.918022 IP truncated-ip - 3 bytes missing! _gateway > fedora:
ICMP echo request, id 4004, seq 0, length 1479
23:53:38.938355 IP truncated-ip - 4 bytes missing! _gateway > fedora:
ICMP echo request, id 4005, seq 0, length 1480
23:53:39.958451 IP truncated-ip - 4 bytes missing! _gateway > fedora:
ICMP echo request, id 4006, seq 0, length 1480
23:53:40.978598 IP truncated-ip - 4 bytes missing! _gateway > fedora:
ICMP echo request, id 4007, seq 0, length 1480
23:53:41.998991 IP truncated-ip - 4 bytes missing! _gateway > fedora:
ICMP echo request, id 4008, seq 0, length 1480
23:53:43.020309 IP truncated-ip - 4 bytes missing! _gateway > fedora:
ICMP echo request, id 4010, seq 0, length 1480

Here you can incidentally also see what happens if we don't pad the big pac=
kets:
the packet gets truncated.

Yours,
Linus Walleij

