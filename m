Return-Path: <netdev+bounces-45411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 023007DCBE9
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 12:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAEEDB20F01
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D326D1A736;
	Tue, 31 Oct 2023 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxpK2z8x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EBA156C1
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 11:36:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D0DB
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698752208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+lL+Q2dnjvFrizecz2Z0hUXkvjCaGk0oW8++C5Yujg=;
	b=DxpK2z8xgs4yiKr4QKzUKDVu567Fqd52FulwyWNz27DroFh6lz/IUMaIAKNS0YpuMfD/7o
	J43ggU77hzQe/lz9PRFtPaKgvdBy0eHQ9JuJRb+l56eV2mcrx0LtkyNTj+Yf9b77p3MqWV
	9FpYEnvDH2BBPgtRvsVEYe8uQW+3xxo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-I-pSAgyBOSev0J-snH1bSg-1; Tue, 31 Oct 2023 07:36:26 -0400
X-MC-Unique: I-pSAgyBOSev0J-snH1bSg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7788fa5f1b0so682131485a.2
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 04:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698752186; x=1699356986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+lL+Q2dnjvFrizecz2Z0hUXkvjCaGk0oW8++C5Yujg=;
        b=ZEra+KA+KGLrY3KIBVAd1d4VCeOlQVdk7gFVbdnessEWaDP3WbVG+qGVMw/C/dP2BX
         RflR5Z/k0VfpnUAh+Mr8DIX4u9N0tptOdTYVPCwFQSALPJhEfrqYoP2WEozmwF4rmkw8
         7/7v8jUP/qDK/eqsyh3u30WydQ80lUYkdoUj3/v6B/8r1h1GCjaa/Ar7ItfzZLNc+nPn
         wnkGem0wkVbNV9tFjVJZ6c0VC3LLwZi7Lkcv5RP2FPgCD9NDogYe2t2HXrASHGm5CkwM
         8FB+nkSPBPzVuJn2zmjhLA6YUCLB/91zteungbTqvVHK8l9Q6O3InSnmT40O05tYLk+y
         fy3A==
X-Gm-Message-State: AOJu0Yw9lnd/sGpjP20c+8gBhz/WX2AVLD8WvnWdc3AIX+751wLP2ojo
	FY3zTyFd1u3iSsHBOD+sW+5oJksFL820eFPy5GCdVy21OzJR1mEuzOVedhZEQ8Cw/kdI7AY8Lzv
	/x1VWCgat+Jt6ziLCJg2y8isOESnoCUP/
X-Received: by 2002:a05:622a:587:b0:41e:1dff:bed5 with SMTP id c7-20020a05622a058700b0041e1dffbed5mr14275934qtb.37.1698752186188;
        Tue, 31 Oct 2023 04:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8yZ+fxqoz8BLYpCiQtmPTJK1Gfi4emk9EK+fyGfYUrs1zHX9WUBWj45KuPPTBuKDsJ/teSu4Xv+EGBQDnRsI=
X-Received: by 2002:a05:622a:587:b0:41e:1dff:bed5 with SMTP id
 c7-20020a05622a058700b0041e1dffbed5mr14275925qtb.37.1698752185870; Tue, 31
 Oct 2023 04:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
 <20231004154609.6007f1a0@kernel.org> <20231007155957.aPo0ImuG@linutronix.de>
 <20231009180937.2afdc4c1@kernel.org> <20231016095321.4xzKQ5Cd@linutronix.de>
 <20231016071756.4ac5b865@kernel.org> <20231016145337.4ZIt_sqL@linutronix.de> <20231031101424.I2hTisNY@linutronix.de>
In-Reply-To: <20231031101424.I2hTisNY@linutronix.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 31 Oct 2023 08:36:14 -0300
Message-ID: <CAAq0SU=sWL8u5QwyzKS1osnRQDejx337HCz9kYLmiNeqPJvFXw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or optional).
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, juri.lelli@redhat.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Come On Now <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 7:14=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-10-16 16:53:39 [+0200], To Jakub Kicinski wrote:
> > On 2023-10-16 07:17:56 [-0700], Jakub Kicinski wrote:
> > > On Mon, 16 Oct 2023 11:53:21 +0200 Sebastian Andrzej Siewior wrote:
> > > > > Do we have reason to believe nobody uses RPS?
> > > >
> > > > Not sure what you relate to. I would assume that RPS is used in gen=
eral
> > > > on actual devices and not on loopback where backlog is used. But it=
 is
> > > > just an assumption.
> > > > The performance drop, which I observed with RPS and stress-ng --udp=
, is
> > > > within the same range with threads and IPIs (based on memory). I ca=
n
> > > > re-run the test and provide actual numbers if you want.
> > >
> > > I was asking about RPS because with your current series RPS processin=
g
> > > is forced into threads. IDK how well you can simulate the kind of
> > > workload which requires RPS. I've seen it used mostly on proxyies
> > > and gateways. For proxies Meta's experiments with threaded NAPI show
> > > regressions across the board. So "force-threading" RPS will most like=
ly
> > > also cause regressions.
> >
> > Understood.
> >
> > Wandere/ Juri: Do you have any benchmark/ workload where you would see
> > whether RPS with IPI (now) vs RPS (this patch) shows any regression?
>
> So I poked offlist other RH people and I've been told that they hardly
> ever test RPS since the NICs these days have RSS in hardware.

Sorry, Juri is in PTO and I am just back from sick leave and still
catching up. I've been contacting some QE people, but so far it is
like you said, no stress test for RPS. If I have some news, I let you
know.


>
> Sebastian
>


