Return-Path: <netdev+bounces-46849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5947E6A8A
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 13:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B6D280FCE
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AB1DA45;
	Thu,  9 Nov 2023 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HecThWgb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E91DA37
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 12:26:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD982D56
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 04:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699532782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/haom+yH9xLwnE9aURcVj9dx4YOUUdXMdvnVMAeYqM=;
	b=HecThWgbZ6C6ynnvaiA5u144VgmDj3hSFaWTn+bmjBw2kNcU6zE8tnR1MyIm4vBIuTvt7M
	I0yxU28PrYVHhwiFDUZOyZirXAGjduhcXuF+q6fHTPWQ1wccLWfWu6IaODU0z3aNdwrpU+
	qe9SwYxgdW9RN1gu9hnGBz5bDvdix1g=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-rexEU2_4NquTNliml9csbg-1; Thu, 09 Nov 2023 07:26:21 -0500
X-MC-Unique: rexEU2_4NquTNliml9csbg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a7af473da1so1532627b3.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 04:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699532781; x=1700137581;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/haom+yH9xLwnE9aURcVj9dx4YOUUdXMdvnVMAeYqM=;
        b=o1mqzXF72jVNMIiwjUBraEl+9yAfma11S0KJ2wDJt22pItwCOUlR1eOP8FZiD4v2Fs
         /EM9I3CfTw0dQry3C2nlNU3KVChBO/t3GSPMvXU8WMLkq4kDaP6jPeQ5Mebojxy2tC5S
         Yo70hS/s3ARrEbtzRp6oY7lmOiUbJ9bcN6biP0Q3+XYVBV9vroj2q2GKTOYy27NSWaou
         GZK2aZo3WKDpKBYEs3SevDQnwVJlyQx6COTPGL+AWn+ZNT85gkyg+8mWHpH1XmgVL+oz
         hM1e9HCMxhpXGHkbmPzxKSBsOhgO/rmmQxR4ivIUerk2lM5TQZ332UuI2ktcmjg0N8Cv
         BwGw==
X-Gm-Message-State: AOJu0Yzpo16iY+FlOhxJlDk7ex6U103GkbL+/QcqdMqLfK62D/y4+wFg
	cV8YSepYiAWMafJipi2L1sm5S2kr02S+p1Zfa9NtCmJ3L/9OaHe7KGWWeJUHdeoWScKmX29QIZv
	j79+XEuuWvr7ErJU+
X-Received: by 2002:a81:a941:0:b0:5a7:ba54:5127 with SMTP id g62-20020a81a941000000b005a7ba545127mr3971929ywh.3.1699532781105;
        Thu, 09 Nov 2023 04:26:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlXxTrprPZijY3/9XY14mMrwVZ8+lm8hhrgq8SG1ZGANmgzirEEjusP4RzmaSaOW2ShlenrA==
X-Received: by 2002:a81:a941:0:b0:5a7:ba54:5127 with SMTP id g62-20020a81a941000000b005a7ba545127mr3971916ywh.3.1699532780737;
        Thu, 09 Nov 2023 04:26:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id g24-20020ac84dd8000000b00417db2593bdsm1876925qtw.72.2023.11.09.04.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:26:20 -0800 (PST)
Message-ID: <ad66b532d1702c36adecd944e25f84e4497ef8b3.camel@redhat.com>
Subject: Re: [PATCH net v4 0/3] Fix large frames in the Gemini ethernet
 driver
From: Paolo Abeni <pabeni@redhat.com>
To: Vladimir Oltean <olteanv@gmail.com>, Linus Walleij
	 <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?=
	 <mirq-linux@rere.qmqm.pl>, Andrew Lunn <andrew@lunn.ch>, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 09 Nov 2023 13:26:17 +0100
In-Reply-To: <20231109105037.zppxrr3bptd7a7i6@skbuf>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
	 <20231109105037.zppxrr3bptd7a7i6@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-09 at 12:50 +0200, Vladimir Oltean wrote:
> On Thu, Nov 09, 2023 at 10:03:11AM +0100, Linus Walleij wrote:
> > This is the result of a bug hunt for a problem with the
> > RTL8366RB DSA switch leading me wrong all over the place.
> >=20
> > I am indebted to Vladimir Oltean who as usual pointed
> > out where the real problem was, many thanks!
> >=20
> > Tryig to actually use big ("jumbo") frames on this
> > hardware uncovered the real bugs. Then I tested it on
> > the DSA switch and it indeed fixes the issue.
> >=20
> > To make sure it also works fine with big frames on
> > non-DSA devices I also copied a large video file over
> > scp to a device with maximum frame size, the data
> > was transported in large TCP packets ending up in
> > 0x7ff sized frames using software checksumming at
> > ~2.0 MB/s.
> >=20
> > If I set down the MTU to the standard 1500 bytes so
> > that hardware checksumming is used, the scp transfer
> > of the same file was slightly lower, ~1.8-1.9 MB/s.
> >=20
> > Despite this not being the best test it shows that
> > we can now stress the hardware with large frames
> > and that software checksum works fine.
> >=20
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
>=20
> Thanks for being persistent with this! I hope we didn't miss today's
> "net" pull request :)

I fear this is a bit too late for today's PR. I hope it should not be a
big problem, since we are very early in the release cycle.

Cheers,

Paolo


