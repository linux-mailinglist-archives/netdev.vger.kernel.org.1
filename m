Return-Path: <netdev+bounces-53247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E28801C3F
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 11:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196F2281C25
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5D1549E;
	Sat,  2 Dec 2023 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfr6mqAT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D412D
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 02:39:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso3220a12.1
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 02:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701513558; x=1702118358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/WnMXxklSY059GayMJ+VSslOmBX953aAVO/IsJZMxg=;
        b=dfr6mqATDtY8AR/5BrrNyhhcpWeoNBl+xc2D4SA7mJxkUkKn8FoMHcyrUm4uYVGyCl
         RHhNRtcYx/aXN443mNHfoVhzs+FlGM1CmdkxCYsviaYM/ygtuHqJQj+d9COVybxYoGu+
         xA2wPfSHTYnkn1ALAbI5Rtc0o7m0KyzFN4QPC1U+7d+fZcwTUS3AzsGReiFMBDBD1LoM
         QNy6P0dHErKWVmNKsRbbIqkUh+fVyYFFNg5oz9OX6Yq7OW068gwnGbiyqlmPl2p38HHz
         of9FNlYdr+8CHt2ovR5VCnSjBEHzPgBZHfM/RRw6j0hXRyIDjcBVgQCdomwObaxVXFtv
         rcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701513558; x=1702118358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/WnMXxklSY059GayMJ+VSslOmBX953aAVO/IsJZMxg=;
        b=gQVu2FAp+9c4jxdnUcNUs1Gt8C67NLleuuoi94JGIRfe74EezNQmKvnAQx4jQRhj6C
         FKwYV0QJSduiL32WlU/aJZxX9CUqw7z9S84wpDtk6TmbnxL0IoFiCc7zsZdyU0rIiCFC
         yN1/+OXuLU1c/8//lzYyeuJdyTym3Y9AEOArW2iAqALEIO/GBf5Xtq2gxg6CV5uhSvH/
         /V3KJwjytuNUdpBd1MljwdoV8rRXv61N0kNcgHNAh+Bppk9U93O6HIf6IbSrWCG39yFo
         ldQBX+NOhffXbZsDC7oV9429AwEAbog46uLQO0ma4eUKvbzyWb4pF9LXvkPptQ84MtRO
         TJZg==
X-Gm-Message-State: AOJu0YyUJgokZ4eVwF4wk78L+S4X4WUtzcqAXRZZCiHNR7u4cyTh0+5d
	tE8pTLLekQPu1xMFH77J2TQ0tT27CMDaTL32tyGKmulDfyMv/h7oW1M=
X-Google-Smtp-Source: AGHT+IEi5OTrtVEcDkGkIvxkbNSaIkzFJXWwFDWd22ponu8vPgDwbmKd5sM0/nrKNfd41vaJZ6ufOmz1cWb5r01HaH8=
X-Received: by 2002:a50:d7c1:0:b0:545:279:d075 with SMTP id
 m1-20020a50d7c1000000b005450279d075mr221900edj.1.1701513557906; Sat, 02 Dec
 2023 02:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZWomqO8m4vVcW+ro@debian.debian>
In-Reply-To: <ZWomqO8m4vVcW+ro@debian.debian>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 2 Dec 2023 11:39:06 +0100
Message-ID: <CANn89iJ-xLq8Ug1FqKn_Jp_VRXRdAB9mb3nhEjm4tDV251jeMw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] packet: add a generic drop reason for receive
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Weongyo Jeong <weongyo.linux@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 7:32=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote:
>
> Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> from consume_skb to kfree_skb to improve error handling. However, this
> could bring a lot of noises when we monitor real packet drops in
> kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> can be freed, not actual packets.
>
> Adding a generic drop reason to allow distinguish these "clone drops".
>
> [1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-xcxLFU=
K2Zj08A8MrLk9jzg@mail.gmail.com/
> Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

