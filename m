Return-Path: <netdev+bounces-14955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FFA7448E9
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 14:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28D32811B1
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 12:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1D8BFE;
	Sat,  1 Jul 2023 12:27:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C65CA1
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 12:27:22 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6443C07
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 05:27:20 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34292a63a13so102175ab.0
        for <netdev@vger.kernel.org>; Sat, 01 Jul 2023 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688214440; x=1690806440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1WPu2jpdGUuINahlPbFUh82vzwg+33OKtBjI9IhlKs=;
        b=Tw9lufbxMsNVebUT6Az5BhqC2OBddeJ0GCUu5Eo5ufhI9wsX0+0PkKw3FYG6yIdfcl
         07iCwhHVWltUg4HXKreXQup2ny5AZDbhLiTZsotWvfOp4a8NtipDNsP2MfBk/6xKKtsF
         FaZtPi0ukEHcJlzSo/7LX0ATX1fZHI+oXoYLL+ebKR9Id6FSADTIeYNbAp6yvudAU3CE
         k9G4Z4ZCNyioG2TaKNXFmyGaFvnvK/VSJWDpo3FllvUlg5qwo/xs7JCib5GfHyGPFZ9j
         CNJt0lmJS+ai1v3iFyT5Mp47kCHisi3iMu8NWE35MwAYPah4CAsJpCPUjJwD3749d5rz
         DmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688214440; x=1690806440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1WPu2jpdGUuINahlPbFUh82vzwg+33OKtBjI9IhlKs=;
        b=VbP8FT5C/NQdQTmGFFxbbDvoZCGg+MKcdzwG9Jb7p6XHJtVeYwTKhiWE/USVBmukvA
         DSnIWWdi4vIs6+l0PQt8t37T4Qud+H+lSbxYsnUF0DH+eFqGifPfIW0LLEPZl2cziSne
         bptH8n2f8KsmYsaJ9K+goNQGt+e+ICFHtUR8wdCRdl7ABJD8slg/GesCc3EwcrzcV+c7
         IYG/hYZk50yBbbcLyW7YV5Y9f6bbErL7n7NEnP/waKiMIEcwat8onQoLvwHHYRq5K+uE
         WAN3y2E8j1bXnIbof9Ks0ANvIm1izD+Z7p12us8of90IVk+JfPI+s9jWfAeyJ4p/wKZi
         seXg==
X-Gm-Message-State: ABy/qLbTHIqs5BAQMvy6Q1ABGOTEqUrrD9OeOvdniGnbWNf0mpc3iC93
	1uv/hT3Yfys5Wtz2L8PV+cfCr/h5RbWAMudhS988cA==
X-Google-Smtp-Source: APBJJlHP8esjNfuAhX2DQkavDNiGnMU5/2/No+IxpWFpUmzNNBlKWA20tx/ZRjYzsh9awvRcqg92GFEEEJ2BFErLjUs=
X-Received: by 2002:a05:6e02:1cab:b0:33d:8608:7596 with SMTP id
 x11-20020a056e021cab00b0033d86087596mr94385ill.15.1688214440009; Sat, 01 Jul
 2023 05:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630153759.3349299-1-maze@google.com> <ZJ/bAeYnpnhEPJXb@gondor.apana.org.au>
In-Reply-To: <ZJ/bAeYnpnhEPJXb@gondor.apana.org.au>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sat, 1 Jul 2023 14:27:07 +0200
Message-ID: <CANP3RGduOc4UgNoeHE+jcDw7ExrbCm64LX6zwgyh5FfyYzGSGA@mail.gmail.com>
Subject: Re: [PATCH] FYI 6.4 xfrm_prepare_input/xfrm_inner_mode_encap_remove
 WARN_ON hit - related to ESPinUDP
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Benedict Wong <benedictwong@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Yan Yan <evitayan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 1, 2023 at 9:51=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:
> > xfrm_prepare_input: XFRM_MODE_SKB_CB(skb)->protocol: 17
> > xfrm_inner_mode_encap_remove: x->props.mode: 1 XFRM_MODE_SKB_SB(skb)->p=
rotocol:17
>
> This seems to make no sense.  UDP encapsulation is supposed to sit
> on the outside of ESP.  So by the time we hit xfrm_input it should
> be lone gone.  On the inside of the packet, as it's tunnel mode we
> should have either IPIP or IPV6, definitely not UDP.

It's triggering in testIPv4UDPEncapRecvTunnel() in xfrm_test.py.
Specifically, it's the self.ReceivePacketOn(netid, input_pkt) a dozen
lines higher.

The packet we end up writing into the tap fd is
02 00 00 00 C8 01 02 00 00 00 C8 00 08 00
45 00 00 44 00 01 00 00 40 11 98 96 08 08 08 08 0A 00 C8 02
11 94 BF 12 00 30 1C D0
00 00 12 34 00 00 00 01
45 00 00 20 00 01 00 00 40 11 98 BA 08 08 08 08 0A 00 C8 02
01 BB 7D 7B 00 0C 9B 7A
01 02 02 11

You can decode this with https://hpd.gasmi.net/ or https://packetor.com/

You can decode the inner packet (this is null esp crypto) by passing in
00 00 00 00 00 00 00 00 00 00 00 00 08 00
45 00 00 20 00 01 00 00 40 11 98 BA 08 08 08 08 0A 00 C8 02
01 BB 7D 7B 00 0C 9B 7A
01 02 02 11
instead.

Note that the protocol the kernel's printk I added prints is the
*outer* encap UDP protocol, not the inner UDP.
ie. you can change the scapy.UDP to scapy.TCP in the 'inner_pkt =3D' assign=
ment,
and the warning still triggers.  The resulting packet is:
02 00 00 00 FA 01 02 00 00 00 FA 00 08 00
45 00 00 50 00 01 00 00 40 11 66 8A 08 08 08 08 0A 00 FA 02
11 94 A7 EB 00 3C 33 E0
00 00 12 34 00 00 00 01
45 00 00 2C 00 01 00 00 40 06 66 B9 08 08 08 08 0A 00 FA 02
01 BB 7D 7B 00 00 00 00 00 00 00 00 50 02 20 00 F9 82 00 00
01 02 02 11

ie. the inner packet is IPv4/TCP:
00 00 00 00 00 00 00 00 00 00 00 00 08 00
45 00 00 2C 00 01 00 00 40 06 66 B9 08 08 08 08 0A 00 FA 02
01 BB 7D 7B 00 00 00 00 00 00 00 00 50 02 20 00 F9 82 00 00
01 02 02 11

> Are you able to reduce this to a set of "ip xfrm" commands that I
> can use to reproduce this?

