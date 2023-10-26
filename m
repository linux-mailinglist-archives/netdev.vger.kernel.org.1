Return-Path: <netdev+bounces-44481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D157D83AE
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DF11C20DD2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615942E3E8;
	Thu, 26 Oct 2023 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKe1rGDF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B12DF87
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 13:35:36 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A791AA
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:35:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so13638a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698327330; x=1698932130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YBJVE8zmeu+K5IMj5twd4VUSAkPpHjjaxOhr4oKrFk=;
        b=fKe1rGDFdas1gYCUU6iXHDsqEp4yznLf0TZ5tVmeEQv0QD0ny3fm3aoZCkTNXuawpm
         W7XXA0VRrig9SEHlQgd98G0LlkBCubEBW8eZZaJBcg4peD+a1wLuSjav6NwShpqLzBLm
         2EoVGkyAwibGrjW/it2VBwqivhp5Xg79djFHrhqqJ5BUUCWVsZAOJ2EC28vmoLyHz04n
         odiIByHHklgEzP7+KAA9vho9gEEsxn6x2D6ITzP9+Ets3urWVR05i/MUq6+F8epWc49X
         PS/RbSg4+772NprHoeBwXl8cBxnBH85gh+jc0RqEaoGwLo3SSVKSLCZH4bPCaS72Eu84
         M7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698327330; x=1698932130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YBJVE8zmeu+K5IMj5twd4VUSAkPpHjjaxOhr4oKrFk=;
        b=os2p0ppAJJ+N2tJ0kxRCxVJ12/u3XBlFDyz1fXhukRc5dMjzY0DZA4CI+p/VgTo66D
         wbF23zcirinLl8waUDVm4atAFIRlVqV2PrgS6cIZRxxgK3kBV6yYRETupUFiZDoq9LJ2
         dUNq5HQ+9PDpmYy9zVwiizwRLGzcU32xlArYy0YEWGSkZxr8ZKJy6H9oE6fjiSGi6wAh
         wH83sdm/G1biGIWI8L9+ziz1CfwhlAAKVFj+2OS8PkMIWMBhmugxoI6i/YhKq5UasZwu
         aqSbnsk/ZXs3sjGc+v1LNJyMDpgnpEVH+St4a4YZFrn5hH5Vuewo78OOyCuT5/A8pNFo
         NnJg==
X-Gm-Message-State: AOJu0YwuIlASLesVzliWEV5wdecgArsOF9ZX1GT8qrvglrE4sCeHPs92
	L9SEowiOjQeqwKfTP5CnPtjVt3gnWNHz6jvWjzB44w==
X-Google-Smtp-Source: AGHT+IHQA6Btv8lbpi5C4/06b7KhCdMUNXkpvfCVi44yxHpLiT1dvOPVna3ON4DGdpB74d9rIvvmuRkapjfwRdnmd2U=
X-Received: by 2002:a05:6402:196:b0:540:e64c:f22d with SMTP id
 r22-20020a056402019600b00540e64cf22dmr219397edv.5.1698327329782; Thu, 26 Oct
 2023 06:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023190255.39190-1-kuniyu@amazon.com> <4d040834d0391cce77a333b3ea577cb130fdc72f.camel@redhat.com>
In-Reply-To: <4d040834d0391cce77a333b3ea577cb130fdc72f.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Oct 2023 15:35:15 +0200
Message-ID: <CANn89i+xS65_b3s8Q9GY76=x=geWKKpe-bFmqADdxyi5VN-LzA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 00/12] tcp: Refactor bhash2 and remove sk_bind2_node.
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, Coco Li <lixiaoyan@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 12:18=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Mon, 2023-10-23 at 12:02 -0700, Kuniyuki Iwashima wrote:
> > This series refactors code around bhash2 and remove some bhash2-specifi=
c
> > fields, sock.sk_bind2_node, and inet_timewait_sock.tw_bind2_node.
> >
> >   patch 1      : optimise bind() for non-wildcard v4-mapped-v6 address
> >   patch 2 -  4 : optimise bind() conflict tests
> >   patch 5 - 12 : Link bhash2 to bhash and unlink sk from bhash2 to
> >                  remove sk_bind2_node
> >
> > The patch 8 will trigger a false-positive error by checkpatch.
> >
> > This series will affect the recent work by Coco Li reorganising major
> > structs.
>
> Given the above implicit dependency, the fact the the struct reorg is
> almost in a ready state, that we are at the end of the cycle and that
> this series has the potential to bring some non trivial side effect, I
> think it would be better to post-pone this series to the next cycle.

I agree, I do not see an urgent need for this refactor yet.

