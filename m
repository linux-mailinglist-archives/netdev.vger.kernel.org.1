Return-Path: <netdev+bounces-52228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6987FDEF7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1341C20B8D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FD55AB81;
	Wed, 29 Nov 2023 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PH46EBt/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019790
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 09:59:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so555a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 09:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701280772; x=1701885572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/jSiKm5mFkB2ZNc7YYsPmOJjp6MJIABZm4Gv8dPzkk=;
        b=PH46EBt/ap/QWNe506pDAOitZBC8BKClHJLixqd45kpMk+oeWEcx3AXcfvfFjxRJC+
         ptbVAWs5mI+ugyVbBm9ILXXTbFbSx2NF6OP5WxFWSpuj+tsZopqj6sYB3qdNIJeZwtJr
         Z1gLUAQYms0/WClHZQZzdt2L5+r0vLt+hac/iwJrYD1YZbumJhSOewhyADdHfcwVtLbV
         eHfz5lvUSVjvWmWZiIfzda6g1dSPK7s7odMzF36gJvPvU1om9RqfuyChZdnnJnisSGp+
         rW76K2BjwAAWsfCq+eYQITl5P5h65pGrZEzDO786+jmdfhhIwhtBEyv5RH0Ve9vduH02
         iwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701280772; x=1701885572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/jSiKm5mFkB2ZNc7YYsPmOJjp6MJIABZm4Gv8dPzkk=;
        b=oxIn8QAx1ReGAkul29ikANVyYuzENz0oSvbAudYjxqoqN9Y6X+norbKHmywLaWNoZP
         ckoNRsIr4jkDVzw+36moqy608SpOrht/LU93K7TMSVOhDM8JrMEimHLmkxIQnnCLngnA
         kaXun28mBQOb3LxoDt+w8xP0Limd9yAzj5TiEgnDaSLOeFcqgdlfFko/zc9LRJJwUIOJ
         LE1eV57qn6SYyQIuPK2AGkphGAC8tjZQG0zcLzEyc31yNIkdLOlVtVvewxx8lMMG1TbJ
         8WQ1KJkT74mSh6EQUZhVAdV+jhVw5aC0oaSFmqunZw9kHAVVwnPpcDf1X3X+kBxffGJA
         onSw==
X-Gm-Message-State: AOJu0Yz1YTdMtjCdheg7qVkI1a+ThhdliFT7CxOafI/VwHb9O3CsIk8Z
	QmiJ9RGB0+mJ+vCGyqPZXz2WsaD6DJb9HoSiCeHUwA==
X-Google-Smtp-Source: AGHT+IFubBI3AdUyh37+c03u4Vq4LdQHkQzxaQl5Tp48/hIuT++8ht4v/IrYluW4g2LWpq9S4266Hf8CDfRrNFtOrTY=
X-Received: by 2002:a05:6402:430e:b0:54b:67da:b2f with SMTP id
 m14-20020a056402430e00b0054b67da0b2fmr632179edc.7.1701280771486; Wed, 29 Nov
 2023 09:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-6-dima@arista.com>
In-Reply-To: <20231129165721.337302-6-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 18:59:20 +0100
Message-ID: <CANn89iLLsTUu1k0pBDYNX8LX0z+JGr12OaC-zu94WcR8WbErUA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] net/tcp: Don't add key with non-matching VRF on
 connected sockets
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> If the connection was established, don't allow adding TCP-AO keys that
> don't match the peer. Currently, there are checks for ip-address
> matching, but L3 index check is missing. Add it to restrict userspace
> shooting itself somewhere.
>
> Yet, nothing restricts the CAP_NET_RAW user from trying to shoot
> themselves by performing setsockopt(SO_BINDTODEVICE) or
> setsockopt(SO_BINDTOIFINDEX) over an established TCP-AO connection.
> So, this is just "minimum effort" to potentially save someone's
> debugging time, rather than a full restriction on doing weird things.
>
> Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

