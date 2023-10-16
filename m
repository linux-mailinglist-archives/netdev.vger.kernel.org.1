Return-Path: <netdev+bounces-41595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782B67CB66C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B231C20B9E
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EC38F9C;
	Mon, 16 Oct 2023 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecZYTitz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606EE381D1;
	Mon, 16 Oct 2023 22:16:09 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCDE9B;
	Mon, 16 Oct 2023 15:16:07 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ae2896974bso3164116b6e.0;
        Mon, 16 Oct 2023 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697494567; x=1698099367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNNgKoZSkjH6Iffk08I1YNobqrTBvbaQzT2I8E5pYO0=;
        b=ecZYTitzLk/FUJq0eK0qZNCGRoa9Hns8+xGzdcTtqygCSyKMEahJf4EvyslTSz98wo
         5gFPeZhJg/zgWcMp1tHoi8wK76GElYfGqShmJ7PTneJyRoi/hPsjGHvLuVukcld1BMLK
         wuRwK+8jRRQVz+FYfYtGHjRRnwF7jc2KEhaAbkgOjsBES7ZsAm6oNIGmkUQU+lN38cv+
         wVFbolV/tnzWleHn4o4Z2LhWjzZBq1rWBuZ5MdDINKxH5RzpYIbu1jhjAoFPsAM1SxtX
         5dzHFAJYpRAi2hLOWwBtgeo/m4aeRRm4VidTSxfSoKV8uJmbDDkBmDqJNNwDPjkOQheH
         5PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697494567; x=1698099367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNNgKoZSkjH6Iffk08I1YNobqrTBvbaQzT2I8E5pYO0=;
        b=OLIbR9Fr3lwMCjaMuIDHpidQtAoAja9BQ2ATkvC03ZIta7grkawR1j2UEYNaw85IrC
         0MKUMV9kd4SXB4txZ6cZr8Z8lJcuw7cSAjrtIYsLZ0QWlpHboXgy3FYGwWpgneF3Nx8v
         GkOKcBUX7VY56zRJ6NdGKqPqO6cI4wl8xmzuDiNJcl7EGpOXANDh04hVSDjOODsTtQjv
         CV/Rbf8ARPGp3ifI7WCyMKUaPN5QTf+OwIH0MndCyNvGbzZy/Dr1tpFAcO8QSQhDh1ux
         iPO5FNOWIv8VeOm1ja0cn2bkewut3P7Qb0/TnLzl8olSZ6vs+69GMsukQIPlPymxlbRg
         LTvw==
X-Gm-Message-State: AOJu0YxzOtD7ahpss3eTh9rqGOoPv/B3d0c1pallXKTz2mTVFODQsTWH
	CUcE0QadH5za//ixZiuMVQctCkHwcj2SraVGdU4=
X-Google-Smtp-Source: AGHT+IER04AMh/hxpcsUOOiEyKf5SffVeKzOLSS0RHZdi93OkGb+nC4ui0U/MwZRuBX2F1cmmhrMITfVmT5mJ6VXMRM=
X-Received: by 2002:a05:6870:8a26:b0:1e9:c86f:4d72 with SMTP id
 p38-20020a0568708a2600b001e9c86f4d72mr546739oaq.45.1697494567159; Mon, 16 Oct
 2023 15:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016154937.41224-1-ahmed.zaki@intel.com> <20231016154937.41224-2-ahmed.zaki@intel.com>
 <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com> <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
In-Reply-To: <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 16 Oct 2023 15:15:30 -0700
Message-ID: <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, corbet@lwn.net, 
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org, mkubecek@suse.cz, 
	willemdebruijn.kernel@gmail.com, linux-doc@vger.kernel.org, 
	Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 2:09=E2=80=AFPM Ahmed Zaki <ahmed.zaki@intel.com> w=
rote:
>
>
>
> On 2023-10-16 14:17, Alexander H Duyck wrote:
> > On Mon, 2023-10-16 at 09:49 -0600, Ahmed Zaki wrote:
> >> Symmetric RSS hash functions are beneficial in applications that monit=
or
> >> both Tx and Rx packets of the same flow (IDS, software firewalls, ..et=
c).
> >> Getting all traffic of the same flow on the same RX queue results in
> >> higher CPU cache efficiency.
> >>
> >> A NIC that supports "symmetric-xor" can achieve this RSS hash symmetry
> >> by XORing the source and destination fields and pass the values to the
> >> RSS hash algorithm.
> >>
> >> Only fields that has counterparts in the other direction can be
> >> accepted; IP src/dst and L4 src/dst ports.
> >>
> >> The user may request RSS hash symmetry for a specific flow type, via:
> >>
> >>      # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric-x=
or
> >>
> >> or turn symmetry off (asymmetric) by:
> >>
> >>      # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
> >>
> >> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> >> ---
> >>   Documentation/networking/scaling.rst |  6 ++++++
> >>   include/uapi/linux/ethtool.h         | 21 +++++++++++++--------
> >>   net/ethtool/ioctl.c                  | 11 +++++++++++
> >>   3 files changed, 30 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/Documentation/networking/scaling.rst b/Documentation/netw=
orking/scaling.rst
> >> index 92c9fb46d6a2..64f3d7566407 100644
> >> --- a/Documentation/networking/scaling.rst
> >> +++ b/Documentation/networking/scaling.rst
> >> @@ -44,6 +44,12 @@ by masking out the low order seven bits of the comp=
uted hash for the
> >>   packet (usually a Toeplitz hash), taking this number as a key into t=
he
> >>   indirection table and reading the corresponding value.
> >>
> >> +Some NICs support symmetric RSS hashing where, if the IP (source addr=
ess,
> >> +destination address) and TCP/UDP (source port, destination port) tupl=
es
> >> +are swapped, the computed hash is the same. This is beneficial in som=
e
> >> +applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and n=
eed
> >> +both directions of the flow to land on the same Rx queue (and CPU).
> >> +
> >>   Some advanced NICs allow steering packets to queues based on
> >>   programmable filters. For example, webserver bound TCP port 80 packe=
ts
> >>   can be directed to their own receive queue. Such =E2=80=9Cn-tuple=E2=
=80=9D filters can
> >> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool=
.h
> >> index f7fba0dc87e5..4e8d38fb55ce 100644
> >> --- a/include/uapi/linux/ethtool.h
> >> +++ b/include/uapi/linux/ethtool.h
> >> @@ -2018,14 +2018,19 @@ static inline int ethtool_validate_duplex(__u8=
 duplex)
> >>   #define    FLOW_RSS        0x20000000
> >>
> >>   /* L3-L4 network traffic flow hash options */
> >> -#define     RXH_L2DA        (1 << 1)
> >> -#define     RXH_VLAN        (1 << 2)
> >> -#define     RXH_L3_PROTO    (1 << 3)
> >> -#define     RXH_IP_SRC      (1 << 4)
> >> -#define     RXH_IP_DST      (1 << 5)
> >> -#define     RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP/S=
CTP */
> >> -#define     RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP/S=
CTP */
> >> -#define     RXH_DISCARD     (1 << 31)
> >> +#define     RXH_L2DA                (1 << 1)
> >> +#define     RXH_VLAN                (1 << 2)
> >> +#define     RXH_L3_PROTO            (1 << 3)
> >> +#define     RXH_IP_SRC              (1 << 4)
> >> +#define     RXH_IP_DST              (1 << 5)
> >> +#define     RXH_L4_B_0_1            (1 << 6) /* src port in case of T=
CP/UDP/SCTP */
> >> +#define     RXH_L4_B_2_3            (1 << 7) /* dst port in case of T=
CP/UDP/SCTP */
> >> +/* XOR the corresponding source and destination fields of each specif=
ied
> >> + * protocol. Both copies of the XOR'ed fields are fed into the RSS an=
d RXHASH
> >> + * calculation.
> >> + */
> >> +#define     RXH_SYMMETRIC_XOR       (1 << 30)
> >> +#define     RXH_DISCARD             (1 << 31)
> >
> > I guess this has already been discussed but I am not a fan of long
> > names for defines. I would prefer to see this just be something like
> > RXH_SYMMETRIC or something like that. The XOR is just an implementation
> > detail. I have seen the same thing accomplished by just reordering the
> > fields by min/max approaches.
>
> Correct. We discussed this and the consensus was that the user needs to
> have complete control on which implementation/algorithm is used to
> provide this symmetry, because each will yield different hash and may be
> different performance.

I agree about the user having control over the algorithm, but this
interface isn't about selecting the algorithm. It is just about
setting up the inputs. Selecting the algorithm is handled via the
set/get_rxfh interface hfunc variable. If this is just a different
hash function it really belongs there rather than being made a part of
the input string.

> >
> >>
> >>   #define    RX_CLS_FLOW_DISC        0xffffffffffffffffULL
> >>   #define RX_CLS_FLOW_WAKE   0xfffffffffffffffeULL
> >> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> >> index 0b0ce4f81c01..b1bd0d4b48e8 100644
> >> --- a/net/ethtool/ioctl.c
> >> +++ b/net/ethtool/ioctl.c
> >> @@ -980,6 +980,17 @@ static noinline_for_stack int ethtool_set_rxnfc(s=
truct net_device *dev,
> >>      if (rc)
> >>              return rc;
> >>
> >> +    /* If a symmetric hash is requested, then:
> >> +     * 1 - no other fields besides IP src/dst and/or L4 src/dst
> >> +     * 2 - If src is set, dst must also be set
> >> +     */
> >> +    if ((info.data & RXH_SYMMETRIC_XOR) &&
> >> +        ((info.data & ~(RXH_SYMMETRIC_XOR | RXH_IP_SRC | RXH_IP_DST |
> >> +          RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
> >> +         (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
> >> +         (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3)=
)))
> >> +            return -EINVAL;
> >> +
> >>      rc =3D dev->ethtool_ops->set_rxnfc(dev, &info);
> >>      if (rc)
> >>              return rc;
> >
> > You are pushing implementation from your device into the interface
> > design here. You should probably push these requirements down into the
> > driver rather than making it a part of the generic implementation.
>
> This is the most basic check and should be applied in any symmetric RSS
> implementation. Nothing specific to the XOR method. It can also be
> extended to include other "RXH_SYMMETRIC_XXX" in the future.

You are partially correct. Your item 2 is accurate, however you are
excluding other fields in your item 1. Fields such as L2DA wouldn't be
symmetric, but VLAN and L3_PROTO would be. That is the implementation
specific detail I was referring to.

