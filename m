Return-Path: <netdev+bounces-53616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57733803EE5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195492810F5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0F633096;
	Mon,  4 Dec 2023 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Th5CH+bl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B41CCE
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:01:13 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso2377a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701720071; x=1702324871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4qUKdBMoTlxHYFiskzAv8nyrsjpTSREfKpRVBZmhZs=;
        b=Th5CH+blKchcjlPg5H0iQyaw1E0Dc6XFMO2YZGfDy/gegzdrJV9MY8HsyBFSbVjkWz
         xIvwuBOxwzs4NCh1XZsISIxN6XSp/hwQ/yNkKH5ZzIa3P6OqFmKeR0AXsH81/VticX6q
         ebKskBIOZYmDj2stBTe5yvR/Df2u2U2Y+5fZJ7ekCrll2c7pFe1xnMSB7NeEfFBC9a+i
         CxcNx2DzT5xhZ/0dpNcALRJUAspvjlEto6HOiYiVy3NZtfIz9vVRo5Qn8rDv2Qjc6uzG
         51g4/5VW6vzAeY0+VWfJD+bJe6RMgYiZB2YcDn+IGedSlNmdGSHpBdlJAJY1fWjaSJAk
         9Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720071; x=1702324871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4qUKdBMoTlxHYFiskzAv8nyrsjpTSREfKpRVBZmhZs=;
        b=i8p7zqM25yZInShLgqUsQszG7Jprw8hAoG+9M9w5Hs9hqdT915iIPqjUNOtQP6gVsr
         hFzxL0fp8UnsMjPkclCp8E74H6Ibkec4ra83oUsjqQ5YLCATeYNuttr1Ugv0r+w47LkS
         cIVTpLuSNz4sbq9wU8j48x9k0LObUAcM6tLkunh34trbe9lMLlMzWla9G2XGTMnZW0re
         i1UpYcfxdOFU9hnMu9B4R+0DsBFH/v63EVbRA7mRniTMPm4e+wR56yESn4ft+rWXUWwb
         WDwQCz6JqUzt2tk2lPZCI+X0T7qFbc2fSJCGHCxInUtG4AYpWI4jCsFK52hTsvtLB6nc
         DgGQ==
X-Gm-Message-State: AOJu0Yxm0e0sWbKy6hS1nSm7WO+r8cXPzx1qsEzekrC6Yyp0F2IALNnp
	wlIHPm5n7lLMNn+t2JFIGPauD2B63+GtA3oaBvKTgg==
X-Google-Smtp-Source: AGHT+IGCev6DWYvqpogCA90ucI81NLgaEa0nJpCTgU96onBY6t9QMetZ9gl1hjVPETCRlrC77Ev8Q3QIKkavLVKHwOQ=
X-Received: by 2002:a50:99de:0:b0:54a:ee8b:7a99 with SMTP id
 n30-20020a5099de000000b0054aee8b7a99mr332954edb.0.1701720071324; Mon, 04 Dec
 2023 12:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW4piNbx3IenYnuw@debian.debian>
In-Reply-To: <ZW4piNbx3IenYnuw@debian.debian>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Dec 2023 21:01:00 +0100
Message-ID: <CANn89iLww-JGAuyD4XFvpn1gy52hgHQwHE1o-UvHu6sU3-6ygw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] packet: add a generic drop reason for receive
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 8:33=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote:
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
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

