Return-Path: <netdev+bounces-61728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D4824BFC
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 01:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A776D1F2143A
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 00:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23020F1;
	Fri,  5 Jan 2024 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kp/z1nIP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A427447
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f2aab1c0c5so771557b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 16:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704412850; x=1705017650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiNmY8n2RqqVzlTLbuX2cKiUEhuYFXEYaWAD9j1qPLQ=;
        b=Kp/z1nIPHFvPCL8/3Be3OZ74dsGLATjvEbZT2fkIcxBpIh0K2s7Ml5EUq4IEKCrb6C
         x9KJ+oWsN9nN3GRmFfKoxZadW7OSxI4ajhQi5RqW/0mjSHHdT/FqxfU91rGztj3Hcjit
         adA2gzY1D6mh6ywAQklWtOfnxSYOFsJmOrSD9KrP0N+gjiqg2lSTejOkkgRyvVJs6iAK
         9goE3RnmIwqntYw5IgFjogpE2Mo5uLzCSXYl1v5coz0TWNMeR//rbNk4Hce2CiY4rOXU
         cFt3HjSlzhkCi3jNa5oLVbYO9e9UUJiJjQ0Se9zZreKnzVmlavL4gFngExW/N+vqt71T
         +jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704412850; x=1705017650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiNmY8n2RqqVzlTLbuX2cKiUEhuYFXEYaWAD9j1qPLQ=;
        b=aGE3Wt4lqAnODDb6C2uo2kpJvANe6qUBxVRnB4u110IkqLiNC450oQoVIMI9hfHhaI
         ysPU8Js6NJQqa/t/hixl07gAhyH95wYxDm6JyYQcYxTMB4L28uXx1KlevjrEtMtCxlp/
         ao7OFD5ClbnCi3AiI7loPlVbMgM0hZhCUrtDxNekhL/o+z/mT+gMIiGWHoRcraPjp5lE
         7Melnct1DXAT1xg6qpkAUUb1fkG76NUu1vOCBF/3TmXRc+s2yqrHRHRUvGqMoSP0fOU5
         dy9mbfFhOcLUOfl3DmmqtFmiuDM8RLdE2W2+uEUzi4hPcyG3GFN1zWqis0ESdLvK/Q/A
         XHVA==
X-Gm-Message-State: AOJu0Yw7bA+dvcV4Hp6xap1wIwv38sh9+Dlh4eBTN3UnFsxLmbQ+bNQT
	Sh9wVVDDIIBy1TB+uwUcLnstIBuda8rE9sfvfvJO0j5QCji7B85JsGha9bkj
X-Google-Smtp-Source: AGHT+IF9xL5qxooPk9FV2ZOmpuScNx+syfGxURZLZm9Jj4hUBPloAoFowvmPncuNINUME87hzJkXSp8Z5tv0rT4F0Lw=
X-Received: by 2002:a0d:e4c2:0:b0:5f6:117c:a3f9 with SMTP id
 n185-20020a0de4c2000000b005f6117ca3f9mr32709ywe.30.1704412850487; Thu, 04 Jan
 2024 16:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org> <20240104002449.yx43fvp2ylbxs3wz@skbuf>
In-Reply-To: <20240104002449.yx43fvp2ylbxs3wz@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Jan 2024 01:00:38 +0100
Message-ID: <CACRpkdZD2tbNLuWXnCbo+L-bqLdF1-FpFjSGsjSjifqxD-Py=A@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] net: ethernet: cortina: Drop software checksum
 and TSO
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Household Cang <canghousehold@aol.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:24=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com> =
wrote:
> On Tue, Jan 02, 2024 at 09:34:25PM +0100, Linus Walleij wrote:

> > That begs the question why large TCP or UDP packets also have to
> > bypass the checksumming (like e.g. ICMP does). If the hardware is
> > splitting it into smaller packets per-MTU setting, and checksumming
> > them, why is this happening then? I don't know. I know it is needed,
> > from tests: the OpenWrt webserver uhttpd starts sending big skb:s (up
> > to 2047 bytes, the max MTU) and above 1514 bytes it starts to fail
> > and hang unless the bypass bit is set: the frames are not getting
> > through.
>
> This uhttpd traffic is plain TCP, or TCP wrapped in DSA?

Wrapped in DSA, rtl_a_4.

Yours,
Linus Walleij

