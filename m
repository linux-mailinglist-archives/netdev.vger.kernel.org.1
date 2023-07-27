Return-Path: <netdev+bounces-22000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94A8765A1F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631F32823C5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802C02714A;
	Thu, 27 Jul 2023 17:24:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748068BE8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 17:24:29 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25112D5D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:24:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so13290285e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690478666; x=1691083466;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3T+Ry8pHMBMKdInlPZpddtTwALu2jvYwQnwYi48X7Y=;
        b=CuxzZsbhIK1m9zpdoHKJ2jKU4AL4AmDF2yXCQ4gHqe/eiXejBo1kc7yvL7ZcM+JjwY
         eKTU9bP5lCW+rH7Nj/VJdN0yU9s+IHfPX24dr1Vtti+Cr24rzsiswisJALLc6TN6jnzH
         CPD64kWIChuL4TxcD16BcmfEPlBNvE7JGPfrRpf1ilpEUVnahpFSmlTlE9hiVkfwLORr
         XTHsZjcHXIRG63rjx2RHE1qNzBrvF9K6rTPHI0bT7+huRmQQD+iWB3OuYwIRKHXiEH8w
         zeANcckTk50fK/Ncc8jTmFexh04HRiiFD+BPnCgdHoQRZ9I/tqU2Jz0I6aVK2S956qw5
         0NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478666; x=1691083466;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W3T+Ry8pHMBMKdInlPZpddtTwALu2jvYwQnwYi48X7Y=;
        b=mEmS0nmoKZQtRJqpj/sLn0xS7AZcFWO8aPR72ucIO1+ZTmkUsVMSzeVevt2cEfnV7A
         pOfbjzG7LmnW362V5/F+1zSw85omPYnwyezyplqAUYB7Y8a0aRuUjsiNFlJGyrr4f9/0
         mZrlQ0Uxd9pfBrPRlULyCgMjvaG0kW2fEpkGCU4l4euOaG4ml18/UshIppdPsZqDG+RF
         nTNim1oqOPrs3qnHSvEHWi740CKEUX+xKyx8DMjTstBJkkhGl3uW7lEmdDGadaQ+YYdF
         JNF3KbLNFEseqS/Rq2lTvcs6J1agu/FZyUwTD4D4LxmnGRnHn+mtS0Cgl9bKB53Se74d
         f7JQ==
X-Gm-Message-State: ABy/qLYR+xBmyaOsXSQc9QYyQRF6U6BHCm/q0Oow4Z5sjc2aXR8VYkJA
	sOgxW7zYjDW4fzAfkulysY63nX6uBYM=
X-Google-Smtp-Source: APBJJlHfbi1lUFQ71Qt2P+YDHATfqv29FZEUpKVd4nXAldlEJFeD7MG8PCGrZ8VMOCu1UEA0a2fc8w==
X-Received: by 2002:a05:600c:2186:b0:3fd:2dcc:bc19 with SMTP id e6-20020a05600c218600b003fd2dccbc19mr2253045wme.15.1690478666304;
        Thu, 27 Jul 2023 10:24:26 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c378c00b003fc0062f0f8sm2373271wmr.9.2023.07.27.10.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 10:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Jul 2023 19:24:25 +0200
Message-Id: <CUD4O9Z0NDVQ.2QJHI6O0C35B9@syracuse>
Cc: <stephen@networkplumber.org>, <netdev@vger.kernel.org>
Subject: Re: [iproute2,v2] bridge: link: allow filtering on bridge name
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Ido Schimmel" <idosch@idosch.org>
X-Mailer: aerc 0.15.1
References: <20230726072507.4104996-1-nico.escande@gmail.com>
 <ZMJvirvFkyPWn1qr@shredder>
In-Reply-To: <ZMJvirvFkyPWn1qr@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu Jul 27, 2023 at 3:22 PM CEST, Ido Schimmel wrote:
> On Wed, Jul 26, 2023 at 09:25:07AM +0200, Nicolas Escande wrote:
> > When using 'brige link show' we can either dump all links enslaved to a=
ny bridge
> > (called without arg ) or display a single link (called with dev arg).
> > However there is no way to dummp all links of a single bridge.
> >=20
> > To do so, this adds new optional 'master XXX' arg to 'bridge link show'=
 command.
> > usage: bridge link show master br0
> >=20
> > Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> > ---
> >  bridge/link.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
>
> Please update the man page as well

I sure as hell forgot about man pages, sorry.
As the patch already got picked up in git I just sent a new patch for this.

