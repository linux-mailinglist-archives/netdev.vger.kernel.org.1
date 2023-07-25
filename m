Return-Path: <netdev+bounces-21067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3314762490
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0A8281380
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0897526B93;
	Tue, 25 Jul 2023 21:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BE1F188
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 21:36:26 +0000 (UTC)
Received: from mail-lj1-x263.google.com (mail-lj1-x263.google.com [IPv6:2a00:1450:4864:20::263])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC01FDD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:36:24 -0700 (PDT)
Received: by mail-lj1-x263.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so86740691fa.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valis-email.20221208.gappssmtp.com; s=20221208; t=1690320983; x=1690925783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwS4GX0mfalc+kp126daECekP9wGUm6cMHbkcjkgKn0=;
        b=qzqocM+8zGCd2SsW2v8/8zqaI7iWgFx/B71n3z0+B2mXVbo4TkxwPSfwsEq/qgwqYm
         f6Wo94zdRdEcnv4fyapvaCZ+ybkXkOy5K9cWps5ASHEMlPF2Zhmas+JeLq+wLyANtE5O
         Giarwj/wvK7GOz4W6mtR9tYdOl3K9upYElO4j36Bon+wZFB83Qjh2dXUk7PgcIpoyE2d
         gzcCNvZWKp0KMOSnQb6RcDt6/YkdZxcRYDuzcm92Jbjjs6zDYhLNZzvxuU5g3ONkCeAt
         7Yw44LLonJQVu8uYF9ICCmCnD4Wl+wz1B3nEFurEga/ujGbR/AdXmyo1HHIHwDxZr8rs
         1esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320983; x=1690925783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwS4GX0mfalc+kp126daECekP9wGUm6cMHbkcjkgKn0=;
        b=lg+ta/H/TchlF/TGh1zNZg4L3tFGMEiiMFbbQ8A0LXMI6vPoGnb0H8sVhbSJay/Juj
         /i0xKd3HNJ9rrTz/kJfXPRLksQXxO2/BnrJqihSWCcEIf5c9F5Cg6HLwuXOMBSyv2/fp
         azOjGYhTAKZA1NwhyGpwXXWrWMyjOwEVMECje+ImD2QSK2sXdqTuCMs2hLdv28lEm78O
         ug0l+d5AQMN85R/HR9Ped6nrIa8X4yeZrKUIE2LGQl4IgNDeaIpOmPXOAbYjYCwmRiry
         Li3XgOuEYmggxV34wmjzdjqHclRpTBFmU2V4v5R2/7hBc8NiK9dA4aGqddcM/Uxp2HHm
         7YMQ==
X-Gm-Message-State: ABy/qLYuFhzm3Wm2IiBZu6Y76MI938gC+P8Cy0nxRWy1qyiWkqMHrjMq
	86ZMnpezHcnor9z1tVPGD4IrebBZj0n5UZUO41nfk/ptYCVBmk3VXpki
X-Google-Smtp-Source: APBJJlFjj2XIL29P0AHC1q5RNqSFnJeYGK0ZdSMXr0WhfmD1iff9vQZXkf6dkxqwIsu/zcxuD+Dj9d/Kz8uX
X-Received: by 2002:a2e:8607:0:b0:2b5:89a6:c12b with SMTP id a7-20020a2e8607000000b002b589a6c12bmr33563lji.10.1690320982821;
        Tue, 25 Jul 2023 14:36:22 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp-relay.gmail.com with ESMTPS id i23-20020a2e8657000000b002b6aa437f9dsm1663260ljj.59.2023.07.25.14.36.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 14:36:22 -0700 (PDT)
X-Relaying-Domain: valis.email
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99b9421aaebso383928666b.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:36:22 -0700 (PDT)
X-Received: by 2002:a17:907:2ccb:b0:988:6e75:6b3d with SMTP id
 hg11-20020a1709072ccb00b009886e756b3dmr81785ejc.33.1690320982053; Tue, 25 Jul
 2023 14:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721174856.3045-1-sec@valis.email> <8a707435884e18ccb92e1e91e474f7662d4f9365.camel@redhat.com>
 <CAEBa_SB6KCa787D3y4ozBczbHfZrsscBMmD9PS1RjcC=375jog@mail.gmail.com> <20230725130917.36658b63@kernel.org>
In-Reply-To: <20230725130917.36658b63@kernel.org>
From: valis <sec@valis.email>
Date: Tue, 25 Jul 2023 23:36:14 +0200
X-Gmail-Original-Message-ID: <CAEBa_SASfBCb8TCS=qzNw90ZNE+wzADmY1_VtJiBnmixXgt6NQ@mail.gmail.com>
Message-ID: <CAEBa_SASfBCb8TCS=qzNw90ZNE+wzADmY1_VtJiBnmixXgt6NQ@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, pctammela@mojatatu.com, victor@mojatatu.com, 
	ramdhan@starlabs.sg, billy@starlabs.sg, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 10:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 25 Jul 2023 21:05:23 +0200 valis wrote:
> > The document you quoted does not forbid pseudonyms.
> > In fact, it was recently updated to clarify that very fact.

Hi Jakub!

>
> We don't know who you are. To my understanding the adjustment means
> that you are not obligated to use the name on your birth certificate
> but we need to know who you are.

I could start a discussion about what makes a name valid, but I'm
pretty sure netdev is not the right place for it.

>
> Why is it always "security" people who try act like this is some make
> believe metaverse. We're working on a real project with real licenses
> and real legal implications.
>
> Your S-o-b is pretty much meaningless. If a "real" person can vouch for
> who you are or put their own S-o-b on your code that's fine.

I posted my patches to this mailing list per maintainer's request and
according to the published rules of the patch submission process as I
understood them.
Sorry if I misinterpreted something and wasted anybody's time.

I'm not going to resubmit the patches under a different name.

Please feel free to use them if someone is willing to sign off on them.

Best regards,

valis

