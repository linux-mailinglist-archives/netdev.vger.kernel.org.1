Return-Path: <netdev+bounces-16793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8011574EB73
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F189F2812A4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672C182AF;
	Tue, 11 Jul 2023 10:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F34174E5
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:06:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB46A9
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689070003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TPO/FGU+Mk707Xj0q9XxQIOD+qFso8ut3H7Imu4kbE=;
	b=chtgGb+lGHfQYdWF39eTNYeeMrukjYywLsX4xTiLUoYt0pH7iPEewjeRAEv/hVu2I4uuTv
	AWpszfsPbl6MhRXyCW/dZFnzrq23uF4Uotv4BQ7W8QbXY9dvns7H7n25bIlT+mlmTwZhv3
	D3Cf6mk9L/rW3bA8nxOTyoCupvmJmWY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-f4DQhBK3P5CZToVfIlj2sQ-1; Tue, 11 Jul 2023 06:06:41 -0400
X-MC-Unique: f4DQhBK3P5CZToVfIlj2sQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7672918d8a4so142935685a.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070001; x=1691662001;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TPO/FGU+Mk707Xj0q9XxQIOD+qFso8ut3H7Imu4kbE=;
        b=Z/U4g/5s/zFPTeX9X8EOoh15Qmhw2Jluw3vLO5mKMdJJMPoEANL4oeRKdLz5VGy2S6
         vQT+fnDbqyyXx1XjeeeEx2DikJMa0z5RaNLiMRS3bQfIm+GQVbWmeK7VuvZRt3gZHbEU
         8U7AbAikQAmsLFm1jceMQmzUZfp9331/5G275baGbPOw2/phhCGTFIa+ZVcCIfMESTlk
         W7S+63AOo1zXjSQHfuRiTgm/z6jqIWPLQxCJ9ODDPpm6hLRjdi2phkAuSL/lwx8ZC1r5
         BaQOok+qBVUxUpj2++mzVyH+f7NNPzY2YeiQom5EU7ZSzh09mAG5AynDaG+TmWgOtEzp
         uBJA==
X-Gm-Message-State: ABy/qLbiX+tOJHzRhB3RFsd4U1JJ5f+I6DWAQdRAQxZ9K9Xx/2hCqQJ+
	nh5bsxoLSr/aLC5npZe/fkgmJ2j5E6Sy/1vJ1WcJ+UiKIFUYffX7dRIwdlkt/CkBbxmc9145Gmi
	PVDhEe+j1y1Aqm1Qx
X-Received: by 2002:a05:620a:4712:b0:766:f972:73da with SMTP id bs18-20020a05620a471200b00766f97273damr15420020qkb.1.1689070001268;
        Tue, 11 Jul 2023 03:06:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKrjDQ/0JCKjdt4Y/ASekfonypXOA8dCTTcevQrHl2uYE0Np3ZdFY3oYabtGolKXcdV91H1g==
X-Received: by 2002:a05:620a:4712:b0:766:f972:73da with SMTP id bs18-20020a05620a471200b00766f97273damr15420001qkb.1.1689070001010;
        Tue, 11 Jul 2023 03:06:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a136700b00767c961eb47sm821091qkl.43.2023.07.11.03.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 03:06:40 -0700 (PDT)
Message-ID: <0cb1b68794529c4d4493b5891f6dc0e9a3a03331.camel@redhat.com>
Subject: Re: DCCP Deprecation
From: Paolo Abeni <pabeni@redhat.com>
To: "Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk>, Kuniyuki Iwashima
	 <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Florian Westphal <fw@strlen.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Stephen Hemminger
 <stephen@networkplumber.org>, "Rakocevic, Veselin"
 <Veselin.Rakocevic.1@city.ac.uk>,  "Markus.Amend@telekom.de"
 <Markus.Amend@telekom.de>, "nathalie.romo-moreno@telekom.de"
 <nathalie.romo-moreno@telekom.de>
Date: Tue, 11 Jul 2023 12:06:36 +0200
In-Reply-To: <CWLP265MB6449543ADBE7B64F5FE1D9F8C931A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
References: 
	<CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	 <20230710182253.81446-1-kuniyu@amazon.com>
	 <20230710133132.7c6ada3a@hermes.local>
	 <CWLP265MB6449543ADBE7B64F5FE1D9F8C931A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Please send plain text messages, and do proper quoting.

On Tue, 2023-07-11 at 09:31 +0000, Maglione, Gregorio wrote:
> The IETF marks MP-DCCP as EXP and is set to mark is as PS soon.
> Removing DCCP from the kernel would likely impact PS standardisation
> or better. If the reason for removal is the lack of a maintainers,
> then I have sufficient time for bug fixing and syzbot testing.

As Kuniyuki noted, a relevant record of contributions to netdev would
help/be appreciated/customary before proposing stepping-in as
maintainer of some networking components.

> If, as Jakub suggests, DCCP has no users other than MP-DCCP, and as
> such shouldn't be maintained,=C2=A0

FWIW, I agree that in kernel user would help DCCP "de-deprecation"

> then are you suggesting that we investigate this license concern to
> allow for MP-DCCP to move upstream, or did you have a patch in mind?

IMHO solving the license concerns and move MP-DCCP upstream (in this
order) would be the better solution. That would allow creating the
contributions record mentioned above.

FTR MPTCP is already there, perhaps there is some possible convergence
between the 2 protocols.

Cheers,

Paolo


