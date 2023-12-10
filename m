Return-Path: <netdev+bounces-55648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F7D80BCB3
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 20:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119901C2040F
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D51B294;
	Sun, 10 Dec 2023 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giBxzg71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDD2E8
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 11:14:38 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7c55a04cd9eso1128941241.0
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 11:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702235677; x=1702840477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuDB5uzBIoiIip2ZzMOO9KIb+yDv5R6/LVMx5NZqR+I=;
        b=giBxzg715n8fxwUISUGie5tau0Ij8y5Q1yYNokxv8uE1JX1XQEuGyXLx6G2330DC66
         Jw93HDZvVKHHkEy0P/i6ENcZiUrCS2dB68ZvS0+v9lfUUUFahGhT+9fEPOM7pGAk9e9q
         9gJmPvkmYwpXPtzSsJ4YtfpUbQajLyfcsNoB/BDEU0P9Q5x+u1XI96ez107j+6LxuhDr
         NruhLDv8eQhORU5d5+Nk8T4O36yUYv0UoyPlUjM5xqzjBKUnikcFyatBz9NhbJl8nCYM
         8+3MWIrHuMr4HrbRS00Dylu9dgLySFIifaA81xxBYLnxoflRYOWDAXlTqze2pBwfOxE7
         jWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702235677; x=1702840477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuDB5uzBIoiIip2ZzMOO9KIb+yDv5R6/LVMx5NZqR+I=;
        b=fYK8+KPP+DfH6Fer9JKZWDg2hHg7vsfR0DLdl0fVvGcjJTV//8Z9icGwFc6V3wAX2J
         sExFB39T02M+X1C49nShavwZJ8/RovaaLALZbX584uJmiQDT0+WPGukKcYkHYYK6IUlQ
         RKawLGCWKWxAoIMVEqqDiHQFpiqMgNhevs6ltQWIXZKHHI7kulD4ObnjXPCQ6Pdb1qjq
         Rs7ieROJ63OXaniLet2HP0TX0eyJlop+yD+bQQdEqE8g06COjkFm0esCEsVZYzE4zLN1
         KrcJSoSaxKHBJ0/90ThsKub7marJqw0XwMI2BTo5KCvftZNToQeadrmDMTH2IR3Llqjg
         XwVw==
X-Gm-Message-State: AOJu0Yy2uCBN4+M+aFOMgEqo206s5GoDWkIVo6s4XApod9Fh7mdlZDI7
	k7tGG9Z7JFE9OtbZW0Uk+Rmlx42v/tbP1gw0E/I=
X-Google-Smtp-Source: AGHT+IGfJUXpPeuGEY8KfOYdt+egaMNDMgi2w9WpzkZCJVIF0n6O0Y1R7757cQQLL2HxnzB5bDcQxrZLzeg5bbIBQiE=
X-Received: by 2002:a05:6102:38c7:b0:464:7eeb:107f with SMTP id
 k7-20020a05610238c700b004647eeb107fmr1773876vst.12.1702235676989; Sun, 10 Dec
 2023 11:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231210180116.1737411-1-eyal.birger@gmail.com> <15709.1702234055@localhost>
In-Reply-To: <15709.1702234055@localhost>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Sun, 10 Dec 2023 11:14:25 -0800
Message-ID: <CAHsH6GtmOjHK-504JSvGeTLxct3JQjzDGq5nr9GO8fm=pjmU-A@mail.gmail.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next, v2] xfrm: support sending NAT
 keepalives in ESP in UDP states
To: Michael Richardson <mcr@sandelman.ca>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, pablo@netfilter.org, paul@nohats.ca, 
	nharold@google.com, devel@linux-ipsec.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Sun, Dec 10, 2023 at 10:47=E2=80=AFAM Michael Richardson <mcr@sandelman.=
ca> wrote:
>
>
> +               BUILD_BUG_ON(XFRMA_MAX !=3D XFRMA_NAT_KEEPALIVE_INTERVAL)=
;
>
> This code was there before, and you are just updating it, but I gotta won=
der
> about it.  It feels very not-DRY.
> It seems to be testing that XFRMA_MAX was updated correctly in the header
> file, and I guess I'm dubious about where it is being done.
>
> I said last year at the workshop that I'd start a tree on documentation f=
or
> XFRM stuff, and I've managed to actually start that, and I'll attempt to =
use
> this new addition as template.

I'd definitely appreciate any documentation merged into the code.

>
> As a general comment, until this work is RCU'ed I'm wondering how it will
> perform on systems with thousands of SAs. As you say: this is a place for
> improvement.  If no keepalives are set, does the code need to walk the xf=
rm
> states at all.  I wonder if that might mitigate the situation for bigger
> systems that have not yet adapted.  I don't see a way to not include this
> code.

The work isn't scheduled unless there are states with a defined
interval, so afaict this shouldn't affect systems not using this
feature. Or maybe I didn't understand your point?

Thanks,
Eyal.

