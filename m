Return-Path: <netdev+bounces-50668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101ED7F6996
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3417F1C20752
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 23:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAEE22F12;
	Thu, 23 Nov 2023 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZHf75NC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536FCD6E
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 15:48:13 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d12b53293so748858eaf.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 15:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700783292; x=1701388092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spVCDZuUTyD3E5XOD5V7ruyilndxjuX+URaR0E+3KLw=;
        b=eZHf75NCSkePmExf6LP2XmxD8nKyW+yYm2n62oH8r6/JvJ4mn/vl2YGcWrD9FBuA9F
         j0D+CK8t5EdzXWJpVbDgZ4y/UOi1Hof1BJzxqgUMIfJMrW+IC45lP6H1Ejdd9ROIZ5IN
         tkAf0SPE4mCfMshAq2Ccr3JVsxUtTGH5VSWYN6yH2AMGDO3XNm8HBXUQYyt3EgahKgxK
         Z56dQhASAXsJVhTEwItwsvHSMrp9A+Khh9ZajaLOEaSJG58o5s/DwhNUf4niY39EQUtH
         lZvHg3dAh1WgYmaNKkSMOyzNeOWdgf4eWVzwsaqcDyxFZILI5eygLA605c3PYS1xAohc
         X2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700783292; x=1701388092;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=spVCDZuUTyD3E5XOD5V7ruyilndxjuX+URaR0E+3KLw=;
        b=OT4x4glWRFVK1sxZgfyCum5DZl0EidEDg3MAYH55wvslu5FzMtxjEQbRuaugy+mOFv
         Usg2Fo5jez+2qZffOZJupjxpfMfpSVIgPEOakFEMKf9ArYCgUlKKCXUPdslyRX/FP671
         KKik0rnCHtJWsqAFU9L+QAWVCrWh8MGTVokEal1GWIgZKxIKq4ywUade5p6cHyMam5J7
         gjIVB5QoWA7+XbAgdweeZnBzYHGN4ymvKN31xLl4VMyxE46NSbeY5lEF8XU+rNdbB1qe
         xJcb9fX9v/sE2/w7gThkS/7jr4D0O8RmTJfI0uzUX+B6fyxLH+NEFWcpIesdK3D8LAxJ
         wObA==
X-Gm-Message-State: AOJu0YxnOdkESh1oh7BN4Ga+uwe5vGILGnNYL1VdMHoDMHAB7KmAMH0H
	r0sHbbpA1YcLWAaFy3tvSDM=
X-Google-Smtp-Source: AGHT+IEa5mH6O364Ei4DK3oqTPF8yoDeAEs/C61WgEPsLL43iB4FCM15dIRAlviMY64IjFGcmJ2eyQ==
X-Received: by 2002:a05:6359:1781:b0:16b:c8cd:1f05 with SMTP id mb1-20020a056359178100b0016bc8cd1f05mr697415rwb.17.1700783292460;
        Thu, 23 Nov 2023 15:48:12 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id d5-20020ac85345000000b00417f330026bsm830354qto.49.2023.11.23.15.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 15:48:11 -0800 (PST)
Date: Thu, 23 Nov 2023 18:48:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 syzbot <syzkaller@googlegroups.com>, 
 Mahesh Bandewar <maheshb@google.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <655fe4bb89846_d847b294b1@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89i+BhRbK-HfmYzzr37N+E_-6kCeoZU0W8n7V35ERZR4A_A@mail.gmail.com>
References: <20231109152241.3754521-1-edumazet@google.com>
 <CAF=yD-KjqkVJ7G_=EpKNRcdvbTujf6E4p1S_mTVQNBt9enOs2w@mail.gmail.com>
 <CANn89i+BhRbK-HfmYzzr37N+E_-6kCeoZU0W8n7V35ERZR4A_A@mail.gmail.com>
Subject: Re: [PATCH net] ipvlan: add ipvlan_route_v6_outbound() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Thu, Nov 9, 2023 at 7:29=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> =

> > Do you think that it is an oversight that this function mixes a retur=
n
> > of NET_XMIT_DROP/NET_XMIT_SUCCESS with returning the error code
> > received from deep in the routing stack?
> >
> > Either way, this patch preserves that existing behavior, so
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> =

> I saw this indeed, and chose to leave this as is to ease code review.
> =

> We might send a stand alone patch to return NET_XMIT_DROP instead.
> =

> Thanks for the review !

I took a closer look at this. The short version is that returning
errno, including this dst->error, from ipvlan_start_xmit is apparently
valid, to my surprise. If so, there is nothing to do here.

The various callees of ipvlan_start_xmit return a mixture of
NET_XMIT_SUCCESS, NET_XMIT_DROP, errno (as in this instance, and
whatever __dev_queue_xmit may return, which is documented as

   Return:      =

   * 0                          - buffer successfully transmitted
   * positive qdisc return code - NET_XMIT_DROP etc.
   * negative errno             - other errors

Since in all cases the skb is consumed, I thought a simple fix for
this driver might be:

    @@ -232,7 +232,7 @@ static netdev_tx_t ipvlan_start_xmit(struct sk_bu=
ff *skb,
            } else {
                    this_cpu_inc(ipvlan->pcpu_stats->tx_drps);
            }
    -       return ret;
    +       return NETDEV_TX_OK;

Given that the return type of ndo_start_xmit is pretty clear:

    enum netdev_tx {
            __NETDEV_TX_MIN  =3D INT_MIN,     /* make sure enum is signed=
 */
            NETDEV_TX_OK     =3D 0x00,        /* driver took care of pack=
et */
            NETDEV_TX_BUSY   =3D 0x10,        /* driver tx path was busy*=
/
    };
    typedef enum netdev_tx netdev_tx_t;

But, the comment above that in netdevice.h states that drivers may
indeed return other values. There is no strict type checking for enums.

    /*
     * Transmit return codes: transmit return codes originate from three =
different
     * namespaces:
     *
     * - qdisc return codes
     * - driver transmit return codes
     * - errno values
     *
     * Drivers are allowed to return any one of those in their hard_start=
_xmit()
     * function. Real network devices commonly used with qdiscs should on=
ly return
     * the driver transmit return codes though - when qdiscs are used, th=
e actual
     * transmission happens asynchronously, so the value is not propagate=
d to
     * higher layers. Virtual network devices transmit synchronously; in =
this case
     * the driver transmit return codes are consumed by dev_queue_xmit(),=
 and all
     * others are propagated to higher layers.
     */

The "real network devices" part is implemented by dev_xmit_complete:

    /*
     * Current order: NETDEV_TX_MASK > NET_XMIT_MASK >=3D 0 is significan=
t;
     * hard_start_xmit() return < NET_XMIT_MASK means skb was consumed.
     */     =

    static inline bool dev_xmit_complete(int rc)
    {       =

    	/*
    	 * Positive cases with an skb consumed by a driver:
    	 * - successful transmission (rc =3D=3D NETDEV_TX_OK)
    	 * - error while transmitting (rc < 0)
    	 * - error while queueing to a different device (rc & NET_XMIT_MASK)=

    	 */                      =

    	if (likely(rc < NET_XMIT_MASK))
    		return true;
    		=

    	return false;
    }               =


Note that NETDEV_TX_BUSY is > NET_XMIT_MASK.

I suppose the second part refers to the if (q->enqueue) =3D=3D false fall=
-through
in __dev_queue_xmit, where __dev_queue_xmit indeed returns rc to its call=
er.=

