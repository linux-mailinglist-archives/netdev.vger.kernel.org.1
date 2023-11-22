Return-Path: <netdev+bounces-49972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEF37F41C5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402811C20A06
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B7A29416;
	Wed, 22 Nov 2023 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yrBxN83U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA0FBD
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:35:43 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso7391a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700645741; x=1701250541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeMbzowYgFM9A2TeCBv4Y4V81oANPda7MU61ft6MGYI=;
        b=yrBxN83UHOsW0a0QLgcEpe0m5f8WgljD/6lcW9Uv8dS2a+yE2P7rLg8VPZQDtaId5A
         Ob7BRhVT5K4WXQvKOfMlc0KEBPP+LLcZq8Q36b2hJrvIvIuKNmAq5fd+ClVem9NJeZh5
         158wMxSud5Dpyr7SERSFb+wQ9tMn/wUl1XeSYRATQ/EVxbkH1YGFULi42D3msW0ynLNF
         oXnhyhWJl3EysGhRyV1JAaH8w02P6hLP6HJ2ZLJeFb57+y6ecb0QvEeXMkBBvdbF/hoM
         gYNHzA2K2jMSE/YUMLyTkt5FsPK6XvugnexvJTrfaXjtScuJSqmQGf1Wn3wrOXW4zcWw
         5h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700645741; x=1701250541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeMbzowYgFM9A2TeCBv4Y4V81oANPda7MU61ft6MGYI=;
        b=qaC6gJo9s7UVQ6douqNj1/yJuVvDvO5QIIv+8pCf0zu+UU0UH4FPUZHVa6l5dXSY2v
         O+nzeTkh/w0WiloSH5XJRmqvkOiIqlSxad7Y+v22D4D3V+AWJLbUHA9eWeLbAzqoew3m
         AnnbhB7fsoDkona79sCrGgr5BAwmaIGJlkiiQ/jcrRGdO8sCx/CjkAV0KJRVEynf9OR2
         NyWIKQVXFOhmF60lDfPzoL0FbXIPdz/r1bV3uIQ5aAINBnuAjqC5NFvEDInkg2lacweH
         UrN7JqF3TWWVXsbYQkSxoy/miUuoPhQ5ArUQKOAxqjBgDYzrcR9FowzeUsASx1LbjwBW
         NPCg==
X-Gm-Message-State: AOJu0YxEJKauEx7WLzjsvq5tEY3jV1lnNRlxTBu7+Xj+gGjqPTC46rTZ
	EkOFnmfbJJNJbyzrB1m+6T6j4+ZrP9FnewkK/5jpxQ==
X-Google-Smtp-Source: AGHT+IFEgMMZwInsS/8mZled7Ht1TiuvhG4Ivy2F1Iyugbe3uBrX4IikIgYZdfRH5Y/7c+TexYQDqHDhTUh7f/rDDDk=
X-Received: by 2002:a05:6402:27cd:b0:545:94c:862e with SMTP id
 c13-20020a05640227cd00b00545094c862emr135087ede.2.1700645741397; Wed, 22 Nov
 2023 01:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-8-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-8-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 10:35:28 +0100
Message-ID: <CANn89iKzHUDaOX9W-0n4obYCkQmtspCtp+j3hR+qootqu1+fUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/13] net: page_pool: implement GET in the
 netlink API
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Expose the very basic page pool information via netlink.
>
> Example using ynl-py for a system with 9 queues:
>
> $ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
>            --dump page-pool-get
> [{'id': 19, 'ifindex': 2, 'napi-id': 147},
>  {'id': 18, 'ifindex': 2, 'napi-id': 146},
>  {'id': 17, 'ifindex': 2, 'napi-id': 145},
>  {'id': 16, 'ifindex': 2, 'napi-id': 144},
>  {'id': 15, 'ifindex': 2, 'napi-id': 143},
>  {'id': 14, 'ifindex': 2, 'napi-id': 142},
>  {'id': 13, 'ifindex': 2, 'napi-id': 141},
>  {'id': 12, 'ifindex': 2, 'napi-id': 140},
>  {'id': 11, 'ifindex': 2, 'napi-id': 139},
>  {'id': 10, 'ifindex': 2, 'napi-id': 138}]
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

