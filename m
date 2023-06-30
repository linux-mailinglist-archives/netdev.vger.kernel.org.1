Return-Path: <netdev+bounces-14842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40427440D3
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BB428107A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB6171A4;
	Fri, 30 Jun 2023 17:06:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CD14ABE
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 17:06:17 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948744B5
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 10:06:01 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401d1d967beso12581cf.0
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688144761; x=1690736761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riTO/grPDZ55sJUFtDGs5IWfkc5C+Aycg7bgbdVos2Y=;
        b=J+xjce26LqPHzQlJe9gjYeRpnYUWDRWXYT8KsGJNQhnUTvq+j9TGe14XcPRzeYl8xL
         8s/K8PdnRY+nvBc5sHNxYdeh092trMHegb/RezXScKwk6ie35Vnld2Y1EqOKj3+1HcVz
         HYXkfZFl5BSQx9OYkI2bifbyc2qT3DsOFB6rZKQfpFUEjkROxKtu4E5FOb9kU84/9pIw
         wZQMMA17RtfMY0KqHDw0+n3Q0FUuUmwWOpBTA69kq7V4Ysr8DATAA36rh2g0sglemSLW
         NLVRhxa98EHsZ2f54ry2UCtSTgKq6Mmjm50kUunMcsg2wRdeEcxyX5olKlEQHkoeY01P
         5Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144761; x=1690736761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riTO/grPDZ55sJUFtDGs5IWfkc5C+Aycg7bgbdVos2Y=;
        b=a0p2cnZWMMA70O1qVe3mBgQDXto+cHeu0pe93Krvf0GCsHWF4JwCtGD3jdy0jKA4QW
         m8iz3RYHfW3mK66dVF8ucC+SztdySLKrMqtT3GzTCdw6GfN4BqELAnxiA/x2w8sEwfuN
         M4EqbMx9hRf/3KanyNdypnrEEwW5uSL1EXd4nC5yEX/MAYRlyfYW4gyzDfowbta2zq95
         JYrOhMayqnqocv/zm/5/8AopJl/FW9wntDM90KyzkFp44ePleX4Pvp9WSk+N54P5/T9h
         3GzucZwjlpBksfDbn7vPvJn7pk0hpgP/wq/sgOD7BaOmzYeGB+7kjSvrzumraH0L+zaj
         Cxyw==
X-Gm-Message-State: AC+VfDyW/x6rtCWxXg8h1ZyH11SEXDlXzYl5RKAI4rQrFAS6mrzJH/IZ
	eGQSQaBy+SxZPv7scsUkPIv1ROKZR0X799DEp6+hNw==
X-Google-Smtp-Source: ACHHUZ7EBR/F2cUDeM6l6y75iwLl3JZ2XTNrUHGID7YOV5/wjDUKmLuM0lqYNotZGcjFUcGk2mu1lV3y2BRvJu1sbX8=
X-Received: by 2002:a05:622a:ca:b0:3d6:5f1b:1e7c with SMTP id
 p10-20020a05622a00ca00b003d65f1b1e7cmr796100qtw.9.1688144760712; Fri, 30 Jun
 2023 10:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630153759.3349299-1-maze@google.com>
In-Reply-To: <20230630153759.3349299-1-maze@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Fri, 30 Jun 2023 19:05:48 +0200
Message-ID: <CANP3RGdLCJjx1bfk=dBh_rgVH_6RpxoUukM+UgYF5E8rrkVF9A@mail.gmail.com>
Subject: Re: [PATCH] FYI 6.4 xfrm_prepare_input/xfrm_inner_mode_encap_remove
 WARN_ON hit - related to ESPinUDP
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Benedict Wong <benedictwong@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Yan Yan <evitayan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_SPF_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 5:38=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
> Steffan, this isn't of course a patch meant for inclusion, instead just a=
 WARN_ON hit report.

Sorry for the name typo (it's Stefan in Polish).

> The patch is simply what prints the following extra info:
>
> xfrm_prepare_input: XFRM_MODE_SKB_CB(skb)->protocol: 17
> xfrm_inner_mode_encap_remove: x->props.mode: 1 XFRM_MODE_SKB_SB(skb)->pro=
tocol:17
>
> (note: XFRM_MODE_TUNNEL=3D1 IPPROTO_UDP=3D17)
>
> Hit on Linux 6.4 by:
>   https://cs.android.com/android/platform/superproject/+/master:kernel/te=
sts/net/test/xfrm_test.py
>
> likely related to line 230:
>   encap_sock.setsockopt(IPPROTO_UDP, xfrm.UDP_ENCAP, xfrm.UDP_ENCAP_ESPIN=
UDP)
>
> I'm not the author of these tests, and I know very little about XFRM.
> As such, I'm not sure if there isn't a bug in the tests themselves...
> maybe we're generating invalid packets that aren't meant to be decapsulat=
ed???
>
> Or are we missing some sort of assignment inside of the ESP in UDP decap =
codepath?
>
> Somewhere in the vicinity of xfrm4_udp_encap_rcv / xfrm4_rcv_encap
> (and the v6 equivalents)

I've done some bisection (well more like educated guesswork)
and the regression (if one should call it that?) is caused by 6.4

commit 5f24f41e8ea62a6a9095f9bbafb8b3aebe265c68
Author: Herbert Xu <herbert@gondor.apana.org.au>
    xfrm: Remove inner/outer modes from input path

The xfrm tests pass either way, but with the above reverted it no
longer triggers the WARN_ON.

$ git log --decorate --oneline --graph -n 3
* da7dc0870b19 (HEAD) Revert "xfrm: Remove inner/outer modes from
input path"  <-- passes, doesn't warn
* 51d5381c5809 ANDROID: net: xfrm: make PF_KEY SHA256 use
RFC-compliant truncation.  <-- passes, does warn
* 5f24f41e8ea6 xfrm: Remove inner/outer modes from input path  <--
passes xfrm, fails pf_key, warns

