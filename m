Return-Path: <netdev+bounces-40350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F67C6DC5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A72F1C20BA4
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949F25118;
	Thu, 12 Oct 2023 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuGjX5kU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6824A0B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:16:14 +0000 (UTC)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51EDB8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:16:12 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4a40d304601so228386e0c.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697112972; x=1697717772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8CFtpdJY9x4AMGD4NYIIYnrhOv8kFHE+uBeuokZ2AA=;
        b=JuGjX5kUx1gDK7QwsWQye6dyWKHc+PeFeOFOwdP0YPmdHoJ5KGQWR+hrKN+CqFCcAr
         HSIHKJwvJEou2NjEV8CFTV60buxC+N/DruipjMWIwR70lzWfJasMIDRUpzCvM+fHAfqE
         nK1ra+gT4xMCncNBp0FdZ7FS/jKiZiuU6DuCRUntMpeqWrFVE545tywR3NqccgAM25en
         LZ1cp7yEzbOZgrpgE3yD5kW/gDP4tNkpqeexPZI4hFqNAixde7SZwAXq6vXn7WJpko1l
         1khi67eQdPUP3uYKRX4gfCq98fk4QBLSuQ5CU3O17LtKK6+zWDLN5zdh1pOlT7A7/tKl
         Jrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697112972; x=1697717772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8CFtpdJY9x4AMGD4NYIIYnrhOv8kFHE+uBeuokZ2AA=;
        b=qfSvq0IBsb1D8MtSTFriJmpo89ZGaIkQ313Ie6ebAAjnkLwCwMPVtrzmjoF+Bk8D8E
         ZgYEaGGAHs/ZY1sj0fUwrB/EItYXgSswQnOUnYgF3VMecexkGZs8t6GVuNPcfMcBZCWf
         Mxofz27me38egs5D4ucp+3z98SO7XjYZMqjZBRqmZTttoHoQ48EZ9mRuPotP+YTDvCHS
         8NsUlFZSbMx9FB0leWUp4SsfTl4n8weQN3/ivcbG2PQX+zi/6zq9CNC8wc2fIR1Vh+NR
         o2zfkhb3ivcq+Fs8qLS3lx2h/GePbk8H68QRVGhsp95qbVazApdJ8AFUefgNCHhwJRaZ
         /LLA==
X-Gm-Message-State: AOJu0YzMQrbcRjCJJ3595wt6bFoGRfkZa6uTDWqj2rWtEYAzAPz6w8gS
	jiYk6OLrsdICpmHmyMThGuCxpd35GdkhLPDoniM=
X-Google-Smtp-Source: AGHT+IFz9OodBKF0v9yxjXa+ym9ON0/koSsAYXn4LhCHi6T85kzOvT7RPYOZmdyjKZeVzCJyaMRPlkpifjAazLTs8UQ=
X-Received: by 2002:a1f:d3c1:0:b0:49d:120c:3c2b with SMTP id
 k184-20020a1fd3c1000000b0049d120c3c2bmr2598542vkg.8.1697112971770; Thu, 12
 Oct 2023 05:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012120901.10765-1-fw@strlen.de>
In-Reply-To: <20231012120901.10765-1-fw@strlen.de>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 12 Oct 2023 08:15:34 -0400
Message-ID: <CAF=yD-K2NmgM=kVFWNgJHahkjXnTF7HdfAEneM5vNLqiuUVU0g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: gso_test: fix build with gcc-12 and earlier
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 8:09=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> gcc 12 errors out with:
> net/core/gso_test.c:58:48: error: initializer element is not constant
>    58 |                 .segs =3D (const unsigned int[]) { gso_size },
>
> This version isn't old (2022), so switch to preprocessor-bsaed constant
> instead of 'static const int'.
>
> Cc: Willem de Bruijn <willemb@google.com>
> Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
> Closes: https://lore.kernel.org/netdev/79fbe35c-4dd1-4f27-acb2-7a60794bc3=
48@linux.vnet.ibm.com/
> Fixes: 1b4fa28a8b07 ("net: parametrize skb_segment unit test to expand co=
verage")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for the fix, Florian!

Note to self to not only rely on my default compiler.

