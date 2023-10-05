Return-Path: <netdev+bounces-38293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981F97BA0BC
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 177D71F233D4
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF082AB4F;
	Thu,  5 Oct 2023 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9PhZ/m+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480F2AB41
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:43:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2192067A
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696516984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHM0xHF2kv3BLjLoSwriKAoHSAm/JAv+ui/sTdWa+9U=;
	b=T9PhZ/m+s7jLKFTBAvB6Q4+6ChGyzBdclVHrm8M5tpvf5T4paiQ9j0QvCZhlmWLlV98x46
	7A1H2e42FIk3VSqxEIYJWN+Nac5FwB3eNuyQDL+jLLxSvR6KYh0NB97qrY+K+TIABuPc+l
	efD+HmZu154zyHV6s2K5nmj76BqKRdQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-S61onmmZNIWqMHx6X_rBTA-1; Thu, 05 Oct 2023 03:37:25 -0400
X-MC-Unique: S61onmmZNIWqMHx6X_rBTA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b295d163fdso17179466b.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 00:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696491444; x=1697096244;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHM0xHF2kv3BLjLoSwriKAoHSAm/JAv+ui/sTdWa+9U=;
        b=wzgz3CGMrrvWoFcXv4DAxr7KSLMcDXxXo4pCYX7JiAFhkUd1zufP0z/CDMtAXxHqvJ
         J6PiFPScuV0jmI1yc4uz3aaHoImBeJrBWlDwRrPsljiYFwbnW4u4F9Gxh9U25RoYsrvH
         qqNgUZAUdtiv16srt9JUTLXtWE6EVqbO3BBXVCQvcpGN+Cb1RME0QamWvYW24O8Aoru1
         j7PIB4SYR1shmsQKWGPWmSdyGEofUCHIlUB31HkExeAmnZULcCHUgD+25VjkLKI3FaU/
         w4QGPBgc5dTRHVZD4FRlXpHVbbSK7IkvSjMbDTecUHBypefHuhy8CfXBfCqfX9ANXNhW
         pGuA==
X-Gm-Message-State: AOJu0Yzda6Zhh+N3pvYm51nwe7Hq3ygROTrskNpi53moRRs3AsFAHhOE
	A5bYz436cP7KDXlcVjadfUo/7pNQ2QGMLKplQekMOl8b39onRj6YZwbz5yWEaBkPkcNt2kxuUbS
	Mslgke0Ipgaq3paWq
X-Received: by 2002:a17:906:7389:b0:9ae:2f35:442a with SMTP id f9-20020a170906738900b009ae2f35442amr4002371ejl.5.1696491444122;
        Thu, 05 Oct 2023 00:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGdFCAAdCKfZyRjyhsGRK+djz3pK0cRwljeBcUUAtdaOoJFV7XbegYiGlFskH2Ho7U/h+CKg==
X-Received: by 2002:a17:906:7389:b0:9ae:2f35:442a with SMTP id f9-20020a170906738900b009ae2f35442amr4002357ejl.5.1696491443781;
        Thu, 05 Oct 2023 00:37:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-55.dyn.eolo.it. [146.241.237.55])
        by smtp.gmail.com with ESMTPSA id lr5-20020a170906fb8500b009adcb6c0f0esm689732ejb.193.2023.10.05.00.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:37:23 -0700 (PDT)
Message-ID: <0c0b0fade091a701624379d91813cfb9f30a5111.camel@redhat.com>
Subject: Re: [PATCH net-next] net: ixp4xx_eth: Specify min/max MTU
From: Paolo Abeni <pabeni@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
	patchwork-bot+netdevbpf@kernel.org
Cc: khalasa@piap.pl, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 09:37:21 +0200
In-Reply-To: <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com>
References: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org>
	 <169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
	 <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-03 at 23:54 +0200, Linus Walleij wrote:
> On Tue, Oct 3, 2023 at 11:40=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
>=20
> > This patch was applied to netdev/net-next.git (main)
> > by Paolo Abeni <pabeni@redhat.com>:
>=20
> Sorry Paolo, this is the latest version of this patch, which sadly change=
d
> Subject in the process:
> https://lore.kernel.org/netdev/20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb9@=
linaro.org/

Ouch, my bad :(

The change of subject baffled both me and patchwork. As I process the
backlog fifo, and was unable to reach the most recent versions due to
the backlog size, I missed the newer revisions.

In the future, please try to avoid subject change. If the subject chane
is needed, please explicitly mark the old version as superseded, it
will help us a lot, thanks!

Paolo


