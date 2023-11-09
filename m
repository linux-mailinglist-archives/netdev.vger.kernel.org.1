Return-Path: <netdev+bounces-46926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E16B7E718D
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 19:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B6C1C209FA
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF45B199AE;
	Thu,  9 Nov 2023 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inDStH7e"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7E36B05
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 18:31:50 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17BA2D44
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 10:31:49 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so15246a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699554708; x=1700159508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h//kCb37dZb7PolHGuErzbRJ0mNVKVZt1yNtcCz9sIM=;
        b=inDStH7e4FupRr5VRXtOdx7RPKjFckLE+/mOfIn/R9lJQ34c9juVgBomGCNIOeJhZ2
         rX/u/zqySXiIcFEvFC+jaUhp8zElB3WEpGeHgctupEV6MhjFKD/jwrmXmKhxk5V4m2dO
         fKX3sZqS2HPnsr3ShoSi/rBmlMN7zf+z43HjcL+0O7+JC6EYo/47oRG2YJD3QQMTdhmj
         1oCaqgM0IAqYrkVgG6WLWed9Td9NIDl0YA7G7xnZj5sohlYZKoN/DmtaseZ4lWhxrLiB
         fMrj6j505e1U4iKvXtGVLsgS/dMeQjqrBwzRL90L09Env40SuE9O2EroEtHYi2cLxo38
         r1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699554708; x=1700159508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h//kCb37dZb7PolHGuErzbRJ0mNVKVZt1yNtcCz9sIM=;
        b=FZDJ9hOZxYSiijuKN6bzavin5HbfNdCEeR6X+2yYiXnh6MbYFqidZLDaEM2UXfPp6H
         bgSoFuXTxFIc5ORTDllb0ZGU2EI3n1rUuFp2MKP6wPDxwa66m4aWi5H5df6tReVYD85+
         2jBWoC1mH9+RtVV5CBYUuRjrf00Mz5MV/w/cp5CEIdOtLCaB24/YT0ntgvct6a2WVeea
         pp7lzniAvpiPSAtAX/uO8Yw0Xnio8GD1Lvys1iTGGQXcoVhgx8NCOZvWces4glP6kbjD
         fMoKOv15w/FWiRfMQqM+8gear8ru1UqA2L+RTnD673ocD27tDaCvA4DLwXKMDA2y40RA
         bCJw==
X-Gm-Message-State: AOJu0YysXaqy4N8afC0hYgAhFWaM7R5cwGE/APFj0KGI9eV/kkMfO8Q1
	NOv34HSAJc9dalBm+4F7rnO5KCrqUmFWdu8bRRKXCw==
X-Google-Smtp-Source: AGHT+IErijKEY0QTQ1RNBECbgPtoO9xB9V4UDMkR2kxarDR3k5UZ1CRhoMIlvEb1AkLzJnVBF4scPmd5psk5wcMBVJA=
X-Received: by 2002:a05:6402:5017:b0:545:279:d075 with SMTP id
 p23-20020a056402501700b005450279d075mr258669eda.1.1699554708116; Thu, 09 Nov
 2023 10:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109152241.3754521-1-edumazet@google.com> <CAF=yD-KjqkVJ7G_=EpKNRcdvbTujf6E4p1S_mTVQNBt9enOs2w@mail.gmail.com>
In-Reply-To: <CAF=yD-KjqkVJ7G_=EpKNRcdvbTujf6E4p1S_mTVQNBt9enOs2w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Nov 2023 19:31:33 +0100
Message-ID: <CANn89i+BhRbK-HfmYzzr37N+E_-6kCeoZU0W8n7V35ERZR4A_A@mail.gmail.com>
Subject: Re: [PATCH net] ipvlan: add ipvlan_route_v6_outbound() helper
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Mahesh Bandewar <maheshb@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:29=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:

> Do you think that it is an oversight that this function mixes a return
> of NET_XMIT_DROP/NET_XMIT_SUCCESS with returning the error code
> received from deep in the routing stack?
>
> Either way, this patch preserves that existing behavior, so
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

I saw this indeed, and chose to leave this as is to ease code review.

We might send a stand alone patch to return NET_XMIT_DROP instead.

Thanks for the review !

