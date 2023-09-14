Return-Path: <netdev+bounces-33730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 743DC79FB54
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 07:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09921C20ABB
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 05:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7564925119;
	Thu, 14 Sep 2023 05:51:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EC250FC
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 05:51:51 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C74C1
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 22:51:50 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77063481352so74195985a.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 22:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694670710; x=1695275510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnXq37vQcabvOU2/j00Ap3dvFQrJD1NEqCojVwG/sUQ=;
        b=kbjD0j0a6lY4xppW2GHXUhSSHrtBJhHYq+DkztJRkne3HEFbOP6M+pF/I/xCq3NhQu
         NIhzNJPuS3VQ2pE1BCmcU/9+wSt91PvuZBY1VxX4F92bio+VlO843wRGe32cr91n2ZHT
         Git4utauutP44rcoB7aeJXZooj3W4KiIbnV5r/0hsePlarSUO30DujjXpNWinY1uL35B
         UaLQsevG62WGV7jwlkIWseRlo5BMPuWu+mzzWsD2D2cnar3k9O8KgbcE7Zba+Pz+IwOT
         w6LosPpE/yQn90HsvchB7KdwgCg+3yv2L9ecOk/j/mDmTNxj1Cwnq7pEW8azEniwpWRs
         plYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694670710; x=1695275510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnXq37vQcabvOU2/j00Ap3dvFQrJD1NEqCojVwG/sUQ=;
        b=dvCvJbrQwr35TTACRJiEpQItGF8DIFWrHy8msGj+hoa62aIdkLxLlCD7nANMsMhvla
         z5izJI0flG3V2A+GalsttoQ2Sbu7HRt40KXO9CRh7uCdA12fsB5T6OgHmm4orueKDwhL
         Dqdmu7mhFciorNmDNEDKe4wd3e/HtRtR7JWw1hkv8/mW4Ea4P66fFVCAAvFeNRBDTK14
         VVNbKCyObFh+QHaqUGDzoNU7argeBN2EhAvYEdfQ0G5WiGzRnMSbNu3MiVOwlSw2mA+x
         tZF78irDjgZR9DqOnv/bqt0CzQ+rkW8U6mT1Cs2zVkDdyoV2Mn1K9f/BDXBncsFyNrL3
         BvJw==
X-Gm-Message-State: AOJu0YyhjEer/r0RHSWF18RVWNB4yGKlBt0f9mwp5gxm++5Qw3VUD5mf
	cydOS1cjQenqA9GJx6fTTZB2YzMW83uGYVfVN52TUCivAaJnY9yHgi7oiTym
X-Google-Smtp-Source: AGHT+IHTI7HNz1jYGGlnxGtkZqPMTbPhGyKWUP+/xler+WQXgk/54vdQVhc7fEGjqBOnnDgGNOFr4lzMvrJt1Y19Pf0=
X-Received: by 2002:a05:6214:412:b0:649:c12:35f7 with SMTP id
 z18-20020a056214041200b006490c1235f7mr1004738qvx.16.1694670709649; Wed, 13
 Sep 2023 22:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912134425.4083337-1-prohr@google.com> <ZQFu/SXXAhN10jNY@nanopsycho>
 <CAKD1Yr1hzYpAU1jMN964c5U+e2-bGcPBqZsHA7_Lg-rH1iNsow@mail.gmail.com> <CANP3RGc4q5zWLL_=f4-a1kvqxE2JbX+B=Q86SGQ22Xx9s0_XYQ@mail.gmail.com>
In-Reply-To: <CANP3RGc4q5zWLL_=f4-a1kvqxE2JbX+B=Q86SGQ22Xx9s0_XYQ@mail.gmail.com>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Thu, 14 Sep 2023 14:51:34 +0900
Message-ID: <CAKD1Yr1mimvtmKJTKCbnfMFAoYQ-=xzPb5b6JHz62n2k7KxZMw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Patrick Rohr <prohr@google.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, Jen Linkova <furry@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 2:20=E2=80=AFAM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> > Maybe accept_ra_pinfo_low_lifetime ? Consistent with the existing
> > accept_ra_pinfo which controls whether PIOs are accepted.
>
> accept_ra... is about whether to accept or drop/ignore an RA or
> portion there-of.

Not only. For example, accept_ra_rt_info_min_plen and
accept_ra_rt_info_max_plen control which prefix lengths will be
accepted in RIOs.

If we want to make it an integer, then we could call it
accept_ra_pinfo_min_valid_lft.

