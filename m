Return-Path: <netdev+bounces-40173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179C97C6086
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F32282447
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1375412E76;
	Wed, 11 Oct 2023 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPPaYzKF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB54249E5;
	Wed, 11 Oct 2023 22:46:33 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1DC9D;
	Wed, 11 Oct 2023 15:46:31 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-45766b79b14so169582137.1;
        Wed, 11 Oct 2023 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064390; x=1697669190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOOGj4FT+5gX1rlvqGHMOmPnG2/tINaWmHLr2bpYqtI=;
        b=BPPaYzKFtVxwi3e0lnP8JtYzytPdYuEharxvbMZMMz2uw4hUK5hhT5inOH2ZXW8CJe
         MTo9oXkYmifFwgTOkid8nd6w5s5IGLahe8/sO0T9AJdOCyc9ByJL5hwoK8e+LAuxlq+9
         5gs+h/VuTz3D3Uh8T+bor1aEGpaFuja9995IEYiOlBAeJuSL5dUk4q8U5ow15Oizuim/
         Ily1IP1oeTmHKoPEWepo7WkYsJ/zKURCO5z3D6WkKVkKo7geZa3oZBZogcesyWHBoIX5
         qWhZzz07v5oXwWnfUNuVIfcGwJSkmUE1F2R482JulNyC78eIT4LmOdP3TR/wkp47HScM
         47rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064390; x=1697669190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOOGj4FT+5gX1rlvqGHMOmPnG2/tINaWmHLr2bpYqtI=;
        b=wuCZkZPfYXvyAp3kBOU8jkyKOBRFiMmqOxZ7o2fPSgM1P4DXSFBWhnbyce8Fwb0n9V
         ElhUrsKLDYjiaEYf2Y9lfCdjaTMirbR3/aPRzpf5rR6JAIV2JpzNiBo3xthG4ypNWz6u
         O0OUZ71ZwrKYT7mdbEWfJikI46HgSrzbf2WKLvuGu3Km6ub8AvC30Dxa19TtKaFLip7E
         YsGq5HguVsmgtdhgZ5FQtXUjsNdvysBwv3gELYDy5BPt8oX2PO37zx/hRJqmYxQs5sOv
         tdMNDiRMz6sH6tTDNrOaTlLOkl1FnBAs8Rw5Rcg6460PvcFRmnEMWAo8lcz17NOpaJey
         yvQw==
X-Gm-Message-State: AOJu0YyNymcx+JPzhJKC2x72UIZVGtZm8My7pH6lWWrbASxc5/KnJg4e
	CoEHCbCDlJEh1+GfGjOv2VdhCXCeAesQlH+Wd4A=
X-Google-Smtp-Source: AGHT+IHpruLFHbdkRHSTdD5JP6c6RcKHxFe6sib6nIIXZZro91ynBkGQjPpLhL4IviLRmfE7p24ElSW5cpdJKq9Uym0=
X-Received: by 2002:a05:6102:3169:b0:44d:48bf:591c with SMTP id
 l9-20020a056102316900b0044d48bf591cmr20190061vsm.30.1697064390554; Wed, 11
 Oct 2023 15:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010200437.9794-1-ahmed.zaki@intel.com> <20231010200437.9794-2-ahmed.zaki@intel.com>
 <CAF=yD-+=3=MqqsHESPsgD0yCQSCA9qBe1mB1OVhSYuB_GhZK6g@mail.gmail.com> <8d205051-d04c-42ff-a2c5-98fcd8545ecb@intel.com>
In-Reply-To: <8d205051-d04c-42ff-a2c5-98fcd8545ecb@intel.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 11 Oct 2023 18:45:54 -0400
Message-ID: <CAF=yD-J=6atRuyhx+a9dvYkr3_Ydzqwwp0Pd1HkFsgNzzk01DQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, corbet@lwn.net, 
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org, mkubecek@suse.cz, 
	linux-doc@vger.kernel.org, Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 5:34=E2=80=AFPM Ahmed Zaki <ahmed.zaki@intel.com> w=
rote:
>
>
> On 2023-10-10 14:40, Willem de Bruijn wrote:
>
> On Tue, Oct 10, 2023 at 4:05=E2=80=AFPM Ahmed Zaki <ahmed.zaki@intel.com>=
 wrote:
>
> Symmetric RSS hash functions are beneficial in applications that monitor
> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
> Getting all traffic of the same flow on the same RX queue results in
> higher CPU cache efficiency.
>
> A NIC that supports "symmetric-xor" can achieve this RSS hash symmetry
> by XORing the source and destination fields and pass the values to the
> RSS hash algorithm.
>
> Only fields that has counterparts in the other direction can be
> accepted; IP src/dst and L4 src/dst ports.
>
> The user may request RSS hash symmetry for a specific flow type, via:
>
>     # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric-xor
>
> or turn symmetry off (asymmetric) by:
>
>     # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  Documentation/networking/scaling.rst |  6 ++++++
>  include/uapi/linux/ethtool.h         | 17 +++++++++--------
>  net/ethtool/ioctl.c                  | 11 +++++++++++
>  3 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/networking/scaling.rst b/Documentation/network=
ing/scaling.rst
> index 92c9fb46d6a2..64f3d7566407 100644
> --- a/Documentation/networking/scaling.rst
> +++ b/Documentation/networking/scaling.rst
> @@ -44,6 +44,12 @@ by masking out the low order seven bits of the compute=
d hash for the
>  packet (usually a Toeplitz hash), taking this number as a key into the
>  indirection table and reading the corresponding value.
>
> +Some NICs support symmetric RSS hashing where, if the IP (source address=
,
> +destination address) and TCP/UDP (source port, destination port) tuples
> +are swapped, the computed hash is the same. This is beneficial in some
> +applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
> +both directions of the flow to land on the same Rx queue (and CPU).
> +
>
> Maybe add a short ethtool example?
>
> Same example as in commit message is OK?
>
> AFAIK, the "ethtool" patch has to be sent after this series is accepted. =
So I am not 100% sure of how the ethtool side will look like, but I can add=
 the line above to Doc.

Good point. Then let's not if the API is not final yet.
>
>
>  Some advanced NICs allow steering packets to queues based on
>  programmable filters. For example, webserver bound TCP port 80 packets
>  can be directed to their own receive queue. Such =E2=80=9Cn-tuple=E2=80=
=9D filters can
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index f7fba0dc87e5..b9ee667ad7e5 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2018,14 +2018,15 @@ static inline int ethtool_validate_duplex(__u8 du=
plex)
>  #define        FLOW_RSS        0x20000000
>
>  /* L3-L4 network traffic flow hash options */
> -#define        RXH_L2DA        (1 << 1)
> -#define        RXH_VLAN        (1 << 2)
> -#define        RXH_L3_PROTO    (1 << 3)
> -#define        RXH_IP_SRC      (1 << 4)
> -#define        RXH_IP_DST      (1 << 5)
> -#define        RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP/S=
CTP */
> -#define        RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP/S=
CTP */
> -#define        RXH_DISCARD     (1 << 31)
> +#define        RXH_L2DA                (1 << 1)
> +#define        RXH_VLAN                (1 << 2)
> +#define        RXH_L3_PROTO            (1 << 3)
> +#define        RXH_IP_SRC              (1 << 4)
> +#define        RXH_IP_DST              (1 << 5)
> +#define        RXH_L4_B_0_1            (1 << 6) /* src port in case of T=
CP/UDP/SCTP */
> +#define        RXH_L4_B_2_3            (1 << 7) /* dst port in case of T=
CP/UDP/SCTP */
> +#define        RXH_SYMMETRIC_XOR       (1 << 30)
> +#define        RXH_DISCARD             (1 << 31)
>
> Are these indentation changes intentional?
>
>
> Yes, for alignment ("RXH_SYMMETRIC_XOR" is too long).

I think it's preferable to not touch other lines. Among others, that
messes up git blame. But it's subjective. Follow your preference if no
one else chimes in.

