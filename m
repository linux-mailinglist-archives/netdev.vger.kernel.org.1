Return-Path: <netdev+bounces-52462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0318A7FECF7
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51251B20E55
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ECF249EC;
	Thu, 30 Nov 2023 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeKfLged"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D33C10DB
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:37:59 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so9198a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701340677; x=1701945477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+ua4EZvZ/9nQhfanPRxNPC6qkUPzDxe5oRDz7dH0qU=;
        b=LeKfLged604lD8PYnbI1rUg/ypd1RYCKDtuKDzbU7A3Iven3v6y22NjvE7BWQYJlls
         dcA7As9D/RFTI5jUOowGoy/uOQpW/0hkss9nPWzpvrdzkKN+4YxCJCVbyTZ8bAv6Gctd
         Su8jCc7wQnZuqbCXowqnvjluGaMGuRoAB8y6vU5xZ43/QeWp6/PgnPfJWbVFjixIlHUF
         KRil/8dR+4/EiPY3apbm+KpOW7TLKKXZOvbkE8GgM1lfK/ALf0u8neZ16oultWljnQX7
         qOqWNGmSmRII2kYIdmXADh31KRabVAvSRiIqybpj9LpsM3pJmuivWWKs2H0+w27IuiQN
         MKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340677; x=1701945477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+ua4EZvZ/9nQhfanPRxNPC6qkUPzDxe5oRDz7dH0qU=;
        b=iK7It8aI0NrbMaZM4YbPGIn/Esh5LGokP0sCK9jOC9SYZT6HoAaTytdlCJ8nrzvZqI
         nZPlnef6P54vpImgWrW3zzJ4VbBtSiMgZEal3zyA1ohW9ym/lRTTLr/AsrzLMQiNV39J
         tMQcAnl0/Km6PCVwvTdeLSaOvmCjXdoqa0hpJqfqluSNCmVO2i3r+fhoFKMqpQFzDNgm
         utI5KjCmgNmPpRnTZp1TPtc3S4wxeAWAjJK9eSgvNG3VRz8Qh3zBoa09qq8BhMutBl96
         lgS7BDqIjWbr4xhInVB12UklKsPILAYMc9FoT4REdcbglqiJ3mLlxptgZp1to0UmqJHA
         h6Ig==
X-Gm-Message-State: AOJu0YyDMS9IOR318QSXh1u5qlz8FI5LO2ICE3SC2EX9KvkM4oBIeHaX
	S1Qj6ABgcBw0F59ljEFsk4lBvYGc0lwZHw6DIO+xpA==
X-Google-Smtp-Source: AGHT+IF7J+OGkmukLz3x4zQWmnjsp3zFoDeSu6s5D8gIUZF3CIXWW1ngDN5UubSTYTZdMg/dKDGB8jETZ/lItEUV1ek=
X-Received: by 2002:a50:998c:0:b0:545:279:d075 with SMTP id
 m12-20020a50998c000000b005450279d075mr97479edb.1.1701340677304; Thu, 30 Nov
 2023 02:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <20231129072756.3684495-2-lixiaoyan@google.com>
In-Reply-To: <20231129072756.3684495-2-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 11:37:42 +0100
Message-ID: <CANn89i+A4xfqz-Tr920p3iNQu9dU4UsyAFY_sEqZwns=SyHXTw@mail.gmail.com>
Subject: Re: [PATCH v8 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:28=E2=80=AFAM Coco Li <lixiaoyan@google.com> wrot=
e:
>
> Analyzed a few structs in the networking stack by looking at variables
> within them that are used in the TCP/IP fast path.
>
> Fast path is defined as TCP path where data is transferred from sender to
> receiver unidirectionally. It doesn't include phases other than
> TCP_ESTABLISHED, nor does it look at error paths.
>
> We hope to re-organizing variables that span many cachelines whose fast
> path variables are also spread out, and this document can help future
> developers keep networking fast path cachelines small.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

