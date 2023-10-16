Return-Path: <netdev+bounces-41549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE2C7CB47D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEF228184D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365CA37161;
	Mon, 16 Oct 2023 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBkzzI/i"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593034CE3;
	Mon, 16 Oct 2023 20:17:54 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB53EB;
	Mon, 16 Oct 2023 13:17:52 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57b9231e91dso3026183eaf.2;
        Mon, 16 Oct 2023 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487472; x=1698092272; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wFKSeSUN3bGShyHUQ53uFiMZLTFl+8zWBRg9JWuw83k=;
        b=RBkzzI/iF8jYnYC8YhredkAkWNSdBbMyIEdk53Li3w+lYeoyvStxBfGW2me80oadj5
         5OANxf6XL4ssTV8QkpChIfqio1H1yvOG0UaanxQCU/JR3K2i2CdNLeLKlp6mu47y4F6g
         955MMToGoGmMQsSLEmndYC6Wt6unlronBLhCxi1NRdqsv0qJD1qYo2VPtZTNb50tlAeq
         kn2qhzCcVxjVZ3bZOMoSphPEgU0yKgMNkEdSxBNAvMUpqAVy1yurzA3W/MhlT4esu+eI
         7YjKY2SAdyVtsbEaK7f86Y2gEJCeYP9uD7lYmOAzuklvvECRTkW6vyIoIMCD8xmtsi6c
         WsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487472; x=1698092272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFKSeSUN3bGShyHUQ53uFiMZLTFl+8zWBRg9JWuw83k=;
        b=gB7laQXa62JylsF8usGZHYJKh72j8Rxfi2cZ4/U9IxXMtO3xmVrxUxH8sAqwrNGToA
         yt5O+nZyykJETSa73RgT9PiyfpKwkeNkqUyGmt2dK29Hl+udbvcXgh8x/ck/x7PDDPBO
         VqieLIFr20XMp7eP2SJkBWMACDsgfFbhPGNdKLaXNUzj9mgwcGjd6l7SKTLXmfVr7D73
         0lkCxWrMc9sfhLtVbEapOSu0tjMPHofUXNnK/pQANdiDb9fZRMx6SzDLo6zHilCELGPm
         jmxjZ3BXhEwgMnEIezKTkdD/SazPVp1O1zoOs5uoZV6HnzigocVTha878dS2B2O3HobJ
         /Vzw==
X-Gm-Message-State: AOJu0YzWhlLEchzb3fU913u0yy2ZRgda7JmBTp04CJAIwsawoHrNKPvZ
	jlckD+zb35XHivPxRbGxBPA=
X-Google-Smtp-Source: AGHT+IFkKMXvu2nOHGXJjqSGSbnEu4MlQ5Dy/g3yHy0zu1+2lVWxvsrjtB4EiH8q5NNOacZHa5gPug==
X-Received: by 2002:a05:6358:7056:b0:13a:a85b:ce00 with SMTP id 22-20020a056358705600b0013aa85bce00mr431629rwp.31.1697487471789;
        Mon, 16 Oct 2023 13:17:51 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id w1-20020a626201000000b006be2f94e92asm328907pfb.84.2023.10.16.13.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:17:51 -0700 (PDT)
Message-ID: <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, corbet@lwn.net, 
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladimir.oltean@nxp.com,  andrew@lunn.ch,
 horms@kernel.org, mkubecek@suse.cz,  willemdebruijn.kernel@gmail.com,
 linux-doc@vger.kernel.org, Wojciech Drewek <wojciech.drewek@intel.com>
Date: Mon, 16 Oct 2023 13:17:49 -0700
In-Reply-To: <20231016154937.41224-2-ahmed.zaki@intel.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
	 <20231016154937.41224-2-ahmed.zaki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-10-16 at 09:49 -0600, Ahmed Zaki wrote:
> Symmetric RSS hash functions are beneficial in applications that monitor
> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
> Getting all traffic of the same flow on the same RX queue results in
> higher CPU cache efficiency.
>=20
> A NIC that supports "symmetric-xor" can achieve this RSS hash symmetry
> by XORing the source and destination fields and pass the values to the
> RSS hash algorithm.
>=20
> Only fields that has counterparts in the other direction can be
> accepted; IP src/dst and L4 src/dst ports.
>=20
> The user may request RSS hash symmetry for a specific flow type, via:
>=20
>     # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric-xor
>=20
> or turn symmetry off (asymmetric) by:
>=20
>     # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>=20
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  Documentation/networking/scaling.rst |  6 ++++++
>  include/uapi/linux/ethtool.h         | 21 +++++++++++++--------
>  net/ethtool/ioctl.c                  | 11 +++++++++++
>  3 files changed, 30 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/networking/scaling.rst b/Documentation/network=
ing/scaling.rst
> index 92c9fb46d6a2..64f3d7566407 100644
> --- a/Documentation/networking/scaling.rst
> +++ b/Documentation/networking/scaling.rst
> @@ -44,6 +44,12 @@ by masking out the low order seven bits of the compute=
d hash for the
>  packet (usually a Toeplitz hash), taking this number as a key into the
>  indirection table and reading the corresponding value.
> =20
> +Some NICs support symmetric RSS hashing where, if the IP (source address=
,
> +destination address) and TCP/UDP (source port, destination port) tuples
> +are swapped, the computed hash is the same. This is beneficial in some
> +applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
> +both directions of the flow to land on the same Rx queue (and CPU).
> +
>  Some advanced NICs allow steering packets to queues based on
>  programmable filters. For example, webserver bound TCP port 80 packets
>  can be directed to their own receive queue. Such =E2=80=9Cn-tuple=E2=80=
=9D filters can
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index f7fba0dc87e5..4e8d38fb55ce 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2018,14 +2018,19 @@ static inline int ethtool_validate_duplex(__u8 du=
plex)
>  #define	FLOW_RSS	0x20000000
> =20
>  /* L3-L4 network traffic flow hash options */
> -#define	RXH_L2DA	(1 << 1)
> -#define	RXH_VLAN	(1 << 2)
> -#define	RXH_L3_PROTO	(1 << 3)
> -#define	RXH_IP_SRC	(1 << 4)
> -#define	RXH_IP_DST	(1 << 5)
> -#define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
> -#define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
> -#define	RXH_DISCARD	(1 << 31)
> +#define	RXH_L2DA		(1 << 1)
> +#define	RXH_VLAN		(1 << 2)
> +#define	RXH_L3_PROTO		(1 << 3)
> +#define	RXH_IP_SRC		(1 << 4)
> +#define	RXH_IP_DST		(1 << 5)
> +#define	RXH_L4_B_0_1		(1 << 6) /* src port in case of TCP/UDP/SCTP */
> +#define	RXH_L4_B_2_3		(1 << 7) /* dst port in case of TCP/UDP/SCTP */
> +/* XOR the corresponding source and destination fields of each specified
> + * protocol. Both copies of the XOR'ed fields are fed into the RSS and R=
XHASH
> + * calculation.
> + */
> +#define	RXH_SYMMETRIC_XOR	(1 << 30)
> +#define	RXH_DISCARD		(1 << 31)

I guess this has already been discussed but I am not a fan of long
names for defines. I would prefer to see this just be something like
RXH_SYMMETRIC or something like that. The XOR is just an implementation
detail. I have seen the same thing accomplished by just reordering the
fields by min/max approaches.

> =20
>  #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
>  #define RX_CLS_FLOW_WAKE	0xfffffffffffffffeULL
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 0b0ce4f81c01..b1bd0d4b48e8 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -980,6 +980,17 @@ static noinline_for_stack int ethtool_set_rxnfc(stru=
ct net_device *dev,
>  	if (rc)
>  		return rc;
> =20
> +	/* If a symmetric hash is requested, then:
> +	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
> +	 * 2 - If src is set, dst must also be set
> +	 */
> +	if ((info.data & RXH_SYMMETRIC_XOR) &&
> +	    ((info.data & ~(RXH_SYMMETRIC_XOR | RXH_IP_SRC | RXH_IP_DST |
> +	      RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
> +	     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
> +	     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
> +		return -EINVAL;
> +
>  	rc =3D dev->ethtool_ops->set_rxnfc(dev, &info);
>  	if (rc)
>  		return rc;

You are pushing implementation from your device into the interface
design here. You should probably push these requirements down into the
driver rather than making it a part of the generic implementation.

It would be nice to see input from other NIC vendors on this as I
suspect they probably have similar functionality available to them.

