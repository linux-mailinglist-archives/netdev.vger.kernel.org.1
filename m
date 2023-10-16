Return-Path: <netdev+bounces-41603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103737CB6BE
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC841C2094A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322AE374EC;
	Mon, 16 Oct 2023 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X97L7Ii6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E219341B2;
	Mon, 16 Oct 2023 22:56:01 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1CD83;
	Mon, 16 Oct 2023 15:55:59 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1e19cb7829bso3173135fac.1;
        Mon, 16 Oct 2023 15:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697496959; x=1698101759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66VMhz4YvG0zrDM4wtnkG8dCucRcCRplU8kQxf5ZY3U=;
        b=X97L7Ii6KxYxUKKqdZihlPLVBV3OCvibFpuT5Q5PG5o9YPSk63xKftFvEAhco9xKZd
         KM2hRnnYzIKGZ1WCr9ukLn0BbKFhdf8Gi+6zTnZFNrUCaZp9lI5FIE8K0S6Y1Fa8qDQF
         DjemZExZ46TOxE/SAJJsA8jA+V1Oop1aPYPTT/D2q4cK6oAU9K8GW484QpW5eCLZ8LFL
         VZVs0e9P/CQjpyBxOxmpDKBONhZ5oKnQ+G/LDAdHQNs77YQFQl9+hH1IyI0JLjYyXcZJ
         iEsy706bbSvLQw1GHkxRq0a3heCmgp7OWDhuJ4kxZHuEmjUY2Q6KGAVGLIajDmpqYC9t
         mEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697496959; x=1698101759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66VMhz4YvG0zrDM4wtnkG8dCucRcCRplU8kQxf5ZY3U=;
        b=VrztpmxYdQRQECqqCc5N2gxJaP/Ouu3kn/KdrBYhU7fQ0dFVLzwkUnqHgw/dyFw7GQ
         Goj1ZN5KnvUUA0/oZJQw4dGSUoXOkUXCZUl4ZUt7arKZiXQufwFE+euyvXoUxZB34HG0
         Dyvvs8gjWmt0j3xumcEO8KA/qYtoRcsT9Ge8ZAJWLixBtj3NRgMyjXaUvLNq3trT5Xc9
         Qcv0/YQftRZNb8PgjNZoj2S8htap4YUMwVPyFstXgNpLtp6U/CmIW1DYn2BdHzx1yE9+
         tj7ImoauTVaqJ8RpFBL4WYqWIqVM9PTUa9TjjdA7j5KXCwvpLJR9bbRPGj2CN0ctNzAW
         Nmgw==
X-Gm-Message-State: AOJu0YznKmejcLq76kF6wJPE6Wd4oQDNaysWJRv3QAOX2vZwDzHYkL9L
	f2TWehleuzbsS0R/7l/0usvpL7VjSJJL6X9rGYg=
X-Google-Smtp-Source: AGHT+IHjZTJ8BTHhyNuNEhx65G+JsUpVBZ3GjxgtnCMlEgwUe4Sxd1bw0bh5po+SggYcJzLr1RdP1fmFMrcxyOcKFHI=
X-Received: by 2002:a05:6870:d3c3:b0:1e9:cd89:433b with SMTP id
 l3-20020a056870d3c300b001e9cd89433bmr571270oag.45.1697496958700; Mon, 16 Oct
 2023 15:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016154937.41224-1-ahmed.zaki@intel.com> <20231016154937.41224-2-ahmed.zaki@intel.com>
 <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
 <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com> <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
 <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
In-Reply-To: <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 16 Oct 2023 15:55:21 -0700
Message-ID: <CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
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

On Mon, Oct 16, 2023 at 3:44=E2=80=AFPM Ahmed Zaki <ahmed.zaki@intel.com> w=
rote:
>
>
>
> On 2023-10-16 16:15, Alexander Duyck wrote:
> > On Mon, Oct 16, 2023 at 2:09=E2=80=AFPM Ahmed Zaki <ahmed.zaki@intel.co=
m> wrote:
> >>
> >>
> >>
> >> On 2023-10-16 14:17, Alexander H Duyck wrote:
> >>> On Mon, 2023-10-16 at 09:49 -0600, Ahmed Zaki wrote:
> >>>> Symmetric RSS hash functions are beneficial in applications that mon=
itor
> >>>> both Tx and Rx packets of the same flow (IDS, software firewalls, ..=
etc).
> >>>> Getting all traffic of the same flow on the same RX queue results in
> >>>> higher CPU cache efficiency.
> >>>>
> >>>> A NIC that supports "symmetric-xor" can achieve this RSS hash symmet=
ry
> >>>> by XORing the source and destination fields and pass the values to t=
he
> >>>> RSS hash algorithm.
> >>>>
> >>>> Only fields that has counterparts in the other direction can be
> >>>> accepted; IP src/dst and L4 src/dst ports.
> >>>>
> >>>> The user may request RSS hash symmetry for a specific flow type, via=
:
> >>>>
> >>>>       # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetri=
c-xor
> >>>>
> >>>> or turn symmetry off (asymmetric) by:
> >>>>
> >>>>       # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
> >>>>
> >>>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >>>> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> >>>> ---
> >>>>    Documentation/networking/scaling.rst |  6 ++++++
> >>>>    include/uapi/linux/ethtool.h         | 21 +++++++++++++--------
> >>>>    net/ethtool/ioctl.c                  | 11 +++++++++++
> >>>>    3 files changed, 30 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/networking/scaling.rst b/Documentation/ne=
tworking/scaling.rst
> >>>> index 92c9fb46d6a2..64f3d7566407 100644
> >>>> --- a/Documentation/networking/scaling.rst
> >>>> +++ b/Documentation/networking/scaling.rst
> >>>> @@ -44,6 +44,12 @@ by masking out the low order seven bits of the co=
mputed hash for the
> >>>>    packet (usually a Toeplitz hash), taking this number as a key int=
o the
> >>>>    indirection table and reading the corresponding value.
> >>>>
> >>>> +Some NICs support symmetric RSS hashing where, if the IP (source ad=
dress,
> >>>> +destination address) and TCP/UDP (source port, destination port) tu=
ples
> >>>> +are swapped, the computed hash is the same. This is beneficial in s=
ome
> >>>> +applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and=
 need
> >>>> +both directions of the flow to land on the same Rx queue (and CPU).
> >>>> +
> >>>>    Some advanced NICs allow steering packets to queues based on
> >>>>    programmable filters. For example, webserver bound TCP port 80 pa=
ckets
> >>>>    can be directed to their own receive queue. Such =E2=80=9Cn-tuple=
=E2=80=9D filters can
> >>>> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethto=
ol.h
> >>>> index f7fba0dc87e5..4e8d38fb55ce 100644
> >>>> --- a/include/uapi/linux/ethtool.h
> >>>> +++ b/include/uapi/linux/ethtool.h
> >>>> @@ -2018,14 +2018,19 @@ static inline int ethtool_validate_duplex(__=
u8 duplex)
> >>>>    #define    FLOW_RSS        0x20000000
> >>>>
> >>>>    /* L3-L4 network traffic flow hash options */
> >>>> -#define     RXH_L2DA        (1 << 1)
> >>>> -#define     RXH_VLAN        (1 << 2)
> >>>> -#define     RXH_L3_PROTO    (1 << 3)
> >>>> -#define     RXH_IP_SRC      (1 << 4)
> >>>> -#define     RXH_IP_DST      (1 << 5)
> >>>> -#define     RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP=
/SCTP */
> >>>> -#define     RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP=
/SCTP */
> >>>> -#define     RXH_DISCARD     (1 << 31)
> >>>> +#define     RXH_L2DA                (1 << 1)
> >>>> +#define     RXH_VLAN                (1 << 2)
> >>>> +#define     RXH_L3_PROTO            (1 << 3)
> >>>> +#define     RXH_IP_SRC              (1 << 4)
> >>>> +#define     RXH_IP_DST              (1 << 5)
> >>>> +#define     RXH_L4_B_0_1            (1 << 6) /* src port in case of=
 TCP/UDP/SCTP */
> >>>> +#define     RXH_L4_B_2_3            (1 << 7) /* dst port in case of=
 TCP/UDP/SCTP */
> >>>> +/* XOR the corresponding source and destination fields of each spec=
ified
> >>>> + * protocol. Both copies of the XOR'ed fields are fed into the RSS =
and RXHASH
> >>>> + * calculation.
> >>>> + */
> >>>> +#define     RXH_SYMMETRIC_XOR       (1 << 30)
> >>>> +#define     RXH_DISCARD             (1 << 31)
> >>>
> >>> I guess this has already been discussed but I am not a fan of long
> >>> names for defines. I would prefer to see this just be something like
> >>> RXH_SYMMETRIC or something like that. The XOR is just an implementati=
on
> >>> detail. I have seen the same thing accomplished by just reordering th=
e
> >>> fields by min/max approaches.
> >>
> >> Correct. We discussed this and the consensus was that the user needs t=
o
> >> have complete control on which implementation/algorithm is used to
> >> provide this symmetry, because each will yield different hash and may =
be
> >> different performance.
> >
> > I agree about the user having control over the algorithm, but this
> > interface isn't about selecting the algorithm. It is just about
> > setting up the inputs. Selecting the algorithm is handled via the
> > set/get_rxfh interface hfunc variable. If this is just a different
> > hash function it really belongs there rather than being made a part of
> > the input string.
>
> My bad. It is the same RSS algorithm (Toeplitz in our case). Still the
> user needs to be able to manipulate the inputs. The point is, a generic
> define like "RXH_SYMETRIC" was rejected (that was actually v1).

No it is not. That is the point and you made it quite clear. The hash
you are using is a variant of Toeplitz, but it is also hybridized with
XOR. Why would it make sense to add it as an input mask bit when what
you are doing is using a different algorithm.

It would make more sense to just add it as a variant hash function of
toeplitz. If you did it right you could probably make the formatting
pretty, something like:
RSS hash function:
    toeplitz: on
        symmetric xor: on
    xor: off
    crc32: off

It doesn't make sense to place it in the input flags and will just
cause quick congestion as things get added there. This is an algorithm
change so it makes more sense to place it there.

> >
> >>>
> >>>>
> >>>>    #define    RX_CLS_FLOW_DISC        0xffffffffffffffffULL
> >>>>    #define RX_CLS_FLOW_WAKE   0xfffffffffffffffeULL
> >>>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> >>>> index 0b0ce4f81c01..b1bd0d4b48e8 100644
> >>>> --- a/net/ethtool/ioctl.c
> >>>> +++ b/net/ethtool/ioctl.c
> >>>> @@ -980,6 +980,17 @@ static noinline_for_stack int ethtool_set_rxnfc=
(struct net_device *dev,
> >>>>       if (rc)
> >>>>               return rc;
> >>>>
> >>>> +    /* If a symmetric hash is requested, then:
> >>>> +     * 1 - no other fields besides IP src/dst and/or L4 src/dst
> >>>> +     * 2 - If src is set, dst must also be set
> >>>> +     */
> >>>> +    if ((info.data & RXH_SYMMETRIC_XOR) &&
> >>>> +        ((info.data & ~(RXH_SYMMETRIC_XOR | RXH_IP_SRC | RXH_IP_DST=
 |
> >>>> +          RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
> >>>> +         (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) =
||
> >>>> +         (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_=
3))))
> >>>> +            return -EINVAL;
> >>>> +
> >>>>       rc =3D dev->ethtool_ops->set_rxnfc(dev, &info);
> >>>>       if (rc)
> >>>>               return rc;
> >>>
> >>> You are pushing implementation from your device into the interface
> >>> design here. You should probably push these requirements down into th=
e
> >>> driver rather than making it a part of the generic implementation.
> >>
> >> This is the most basic check and should be applied in any symmetric RS=
S
> >> implementation. Nothing specific to the XOR method. It can also be
> >> extended to include other "RXH_SYMMETRIC_XXX" in the future.
> >
> > You are partially correct. Your item 2 is accurate, however you are
> > excluding other fields in your item 1. Fields such as L2DA wouldn't be
> > symmetric, but VLAN and L3_PROTO would be. That is the implementation
> > specific detail I was referring to.
>
> hmm.. not sure how VLAN tag would be used in this case. But moving this
> into ice_ethtool is trivial. We can start there and unify when/if other
> vendors push similar functionalities.
>
> How does that sound?

I still think this might be something best handled in your set_rxnfc
function rather than generically here. I would be okay with adding a
helper though since this seems like something that could probably be
handled via an inline. As it stands with the suggestion to move this
out as a separate hash type it would make more sense to not have this
as a part of the ethtool_set_rxnfc itself.

