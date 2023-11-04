Return-Path: <netdev+bounces-46020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3AE7E0E97
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 10:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6F31C209A2
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F8E79F5;
	Sat,  4 Nov 2023 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3133C1
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 09:24:16 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC43B8
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 02:24:14 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1cc131e52f1so31201635ad.0
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 02:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089853; x=1699694653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cjn2RyeE7N10PxF57KifyI5Qy4viqy4gXk2NkxoPZKw=;
        b=IPNz0wpwHr4Ba3MFihQVGRzr0PByN6yiZUoroCSLmseWsG7NqAa6JiG0D5TEGa1VEo
         VMjOSXB0bcBeSjtscAFg2ZP31Hbgn7OCagEO2QtyuFJlR7U9nMCZ2GwziLoNDwssFEuy
         PYRuj6QQwOFzOx4n9Az0ZPDi8/bOSDBJe6oEl7z184Hm0oLdStHkzitTqJ2Jn/Ns92eB
         Pma55RYRU3SOTOI39pVKIxHxtOtG/b5fLxZkJb6LXiCYFPNXP8rUNlItbodgwkk/GjLL
         nnFdhF5l4V1SiBD9M8HuI0K4rLNzhi697fikse6K60liIxfnWJe7mM3SKZudTDzlytBG
         8lUQ==
X-Gm-Message-State: AOJu0YzPFsaH+tTxwN/FcSPLTD6NwGdT1OYlcg5wySImjmlfgR2sMtbt
	Znu8wJtoNdl8wHNDCFJSUYHOcY0TVt7IiczV8Mo=
X-Google-Smtp-Source: AGHT+IHm5uCTbQEZ0fNlpS+wtOFaFs4bchqd9kWiehP8fJgiUNELNtG9Wd/B56/mhZ2u4bGPfBcu4g==
X-Received: by 2002:a17:902:d512:b0:1cc:644a:2129 with SMTP id b18-20020a170902d51200b001cc644a2129mr7100410plg.32.1699089853216;
        Sat, 04 Nov 2023 02:24:13 -0700 (PDT)
Received: from ?IPv6:2001:67c:370:128:83f0:32c0:f09d:82fa? ([2001:67c:370:128:83f0:32c0:f09d:82fa])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001b7f40a8959sm2620359plh.76.2023.11.04.02.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:24:12 -0700 (PDT)
Message-ID: <56f87c0304f8e4398d314992d1d872a7772eec9a.camel@inf.elte.hu>
Subject: Re: Bypass qdiscs?
From: Ferenc Fejes <fejes@inf.elte.hu>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Date: Sat, 04 Nov 2023 10:24:10 +0100
In-Reply-To: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
References: 
	<CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

On Fri, 2023-11-03 at 16:55 -0700, John Ousterhout wrote:
> Is there a way to mark an skb (or its socket) before invoking
> ip_queue_xmit/ip6_xmit so that the packet will bypass the qdiscs and
> be transmitted immediately? Is doing such a thing considered bad
> practice?

I'm not aware if we have such thing aside from the AF_PACKET's flag=20
PACKET_QDISC_BYPASS [1,2]. I think the function packet_xmit [3]
utilizing that flag can be reused for your needs as well.

>=20
> (Homa has its own packet scheduling mechanism so the qdiscs are just
> getting in the way and adding delays)
>=20
> -John-

Best,
Ferenc

[1] https://man7.org/linux/man-pages/man7/packet.7.html
[2]
https://elixir.bootlin.com/linux/v6.6/source/net/packet/af_packet.c#L4026
[3]
https://elixir.bootlin.com/linux/v6.6/source/net/packet/af_packet.c#L273

