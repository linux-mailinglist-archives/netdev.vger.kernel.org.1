Return-Path: <netdev+bounces-41175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1187CA114
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368A8281477
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270D1775E;
	Mon, 16 Oct 2023 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khz17ag3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355CA2D
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 07:57:35 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1381CA2
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 00:57:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so2049a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697443052; x=1698047852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+sl9PX6kdt8RqR7y0x6gHM4u3u4eMyuWu9rmEcATII=;
        b=khz17ag3dgKqfSspc2LfxE32aKOmRsyQf3VdGhbFCPV/ZpUJL+apDDDA7VXaqSScRg
         Uhe9+drcYnEjrnYn/4rJAnuQbfBQRAX36lBkDMbTFRhL2Fq52C+mhsG5VS8AG1qkyXwM
         VMSb7AgETMii0MKtUfkNel64t6RTcAMIatd7k0eEeYOa3tgSyXKPsNeeuJkCQmm7dx7v
         hVRsplg7RVdRkaGzvFwmPrZoWfU3X5iNGU95PhprfTzFFgfC4monElFIraOKH662VpM3
         wTzV4t5Wzf9xv4DphKHclF2kER/RyD+F74my7+v/vMPJrA/sbSuP9yW1ZB+zgweVVA3T
         f8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697443052; x=1698047852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+sl9PX6kdt8RqR7y0x6gHM4u3u4eMyuWu9rmEcATII=;
        b=YtgzlrbV/Pu6GoEXdyRYrtN4phdunP9GjhRA4gD0a433o38/6t9WY3Jdj9CjZTF/h3
         gdjMopT8gJBHXA4voFsPi2RFCj9L8HsrrE8vRtSGF2kvbz65PQ8cRtGgvUpTXMTBN/nE
         KhOROUs4FdfJ3Z5QDs+OhhbN4cwKXP+CShEerP1HPHoZz8/MhmvnOo4fEaELtXTnos75
         ylBNUmJwQkvkaF4JkHVjkB8RLegIukl0i1WgGmfTfGBsvEFokCqQlNJpb9mXX/p8vmGy
         LtEIhsocX5T8/DT7qz5etOONcDoJTKammGhM/a9iWJ9Z3VH4IrmN8LBc+Lr5VVJWGKAd
         Aifw==
X-Gm-Message-State: AOJu0YzugFgQsHcSi8h+loB7P+FHDvNbYgHMrGAG3BUgSzTDWpR38nkI
	JdD7gOKFoxAyzItoudg2B1a2JOPwevcrDb0VGwcIZrKZQA/krubWzHwhSA==
X-Google-Smtp-Source: AGHT+IFbKxMMQdpukTRp29PbFa7JP6Trr1yUNIAxpXdgMno4Fxr+URtk5qNfBOG67fAeA8LDIgDeFG+YWB3LYHtGA9I=
X-Received: by 2002:a50:fa99:0:b0:53e:7ad7:6d47 with SMTP id
 w25-20020a50fa99000000b0053e7ad76d47mr120665edr.5.1697443052314; Mon, 16 Oct
 2023 00:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231015174700.2206872-1-ncardwell.sw@gmail.com>
In-Reply-To: <20231015174700.2206872-1-ncardwell.sw@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 09:57:18 +0200
Message-ID: <CANn89iJRCaZzzdWedQ1uEyiW3CgxFA2sEi=BCjOscLj8s6YjXQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix excessive TLP and RACK timeouts from HZ rounding
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 15, 2023 at 7:47=E2=80=AFPM Neal Cardwell <ncardwell.sw@gmail.c=
om> wrote:
>
> From: Neal Cardwell <ncardwell@google.com>
>
> We discovered from packet traces of slow loss recovery on kernels with
> the default HZ=3D250 setting (and min_rtt < 1ms) that after reordering,
> when receiving a SACKed sequence range, the RACK reordering timer was
> firing after about 16ms rather than the desired value of roughly
> min_rtt/4 + 2ms. The problem is largely due to the RACK reorder timer
> calculation adding in TCP_TIMEOUT_MIN, which is 2 jiffies. On kernels
> with HZ=3D250, this is 2*4ms =3D 8ms. The TLP timer calculation has the
> exact same issue.
>
> This commit fixes the TLP transmit timer and RACK reordering timer
> floor calculation to more closely match the intended 2ms floor even on
> kernels with HZ=3D250. It does this by adding in a new
> TCP_TIMEOUT_MIN_US floor of 2000 us and then converting to jiffies,
> instead of the current approach of converting to jiffies and then
> adding th TCP_TIMEOUT_MIN value of 2 jiffies.
>
> Our testing has verified that on kernels with HZ=3D1000, as expected,
> this does not produce significant changes in behavior, but on kernels
> with the default HZ=3D250 the latency improvement can be large. For
> example, our tests show that for HZ=3D250 kernels at low RTTs this fix
> roughly halves the latency for the RACK reorder timer: instead of
> mostly firing at 16ms it mostly fires at 8ms.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Yuchung Cheng <ycheng@google.com>
> Fixes: bb4d991a28cc ("tcp: adjust tail loss probe timeout")

Reviewed-by: Eric Dumazet <edumazet@google.com>

It is a bit sad that some distros are still using HZ=3D250 in 2023.

Thanks Neal !

