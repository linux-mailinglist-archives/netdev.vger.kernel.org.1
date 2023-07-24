Return-Path: <netdev+bounces-20288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A117175EF4A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0D72813BD
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E36B6FCD;
	Mon, 24 Jul 2023 09:41:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB87460
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:41:26 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9741A1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:41:25 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40550136e54so492531cf.0
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690191684; x=1690796484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgQCLvMpvyW6f+GmCUNJh1u069+gXt093XbItedR5zQ=;
        b=c9y/c5AaiYg7Fa9NEnrTY0jD1fl80Y4h+EZTotSDFzg3dmUzleWyW2ZnwQ62LxAgJr
         B8GfM/MQj5RveAE23zxNkDiXN6q6votLvq8iJneDKdLGxCLogIerNXUYdI5OUDFqOoKG
         ZbO6wiigHRv/HVdcguSAmga8C9praPlFPrfy4KRGvOPdpfmJ2lHu8jmtQRMeC+uFCCkW
         iax2al7cyg7rwdg1BYqbtfMrpkBsLXLu53MLdDVdEkZHHj89lDqbK2Mo7IT59ZYKvOB4
         hCfS1+PYr3YORNo7H3Rb1DV04pUO4i6OZzkM7Vo4BcuYJXF4M+FSEIDL/WPH/2pjXQs+
         CECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690191684; x=1690796484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgQCLvMpvyW6f+GmCUNJh1u069+gXt093XbItedR5zQ=;
        b=CZWkD6Y7zyRC820x8NC8MirMyDvDqoQIYVgjOW9NqOep8z6NJBUlWCICNfpR3M7RDo
         vdLkBrU1i3QH04s3/SFAe0Mn//bWKm6OvaqXIx4+wjEZ5qPQ1wwZlZFpxHg8zg8i0RCa
         RZog/XuYQWMDAtcNOpiDwt8mHjXOOkQPwEoC2L6r63uoUHzkfEzsOjVT1WI7M1LuqoyP
         DpPC//Az7vRg6huT/izbfzRuAyn/IP4XtewtQTi5qUzBf/TTvQC9nLx6xdSi2zxWNk2V
         Z9euQ/aGcfOu7wCYHZ9QPfZVqwXaEZ/r/se99a4vy5T28sC8Rfj5hhbFoamcITRaobzY
         /f7g==
X-Gm-Message-State: ABy/qLYEvrsUQ7zB1NAzs0L6Mjf1VtQusgQNOQddwIpGxd0CLkvHYIv3
	oienWGitjucv5mQoAsjRBGCqMZnw95eAHWR3PyIj6Q==
X-Google-Smtp-Source: APBJJlHrP2O8u7XmwqAga3fZfE1iRfKqIZjp3+U2vI+uQdMs26Z2fQqhqqCQdWVp7SAEtH3pYbE8BGzLqthyA05M0Lg=
X-Received: by 2002:ac8:7c47:0:b0:403:b3ab:393e with SMTP id
 o7-20020ac87c47000000b00403b3ab393emr449897qtv.18.1690191684081; Mon, 24 Jul
 2023 02:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721222410.17914-1-kuniyu@amazon.com>
In-Reply-To: <20230721222410.17914-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Jul 2023 11:41:12 +0200
Message-ID: <CANn89iKo9h6fFg4BbYBZeWH1qdZKS4SDn1ufcKbSmRiviXvfTg@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: Reduce chance of collisions in inet6_hashfn().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Amit Klein <aksecurity@gmail.com>, Benjamin Herrenschmidt <benh@amazon.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Stewart Smith <trawets@amazon.com>, Samuel Mendoza-Jonas <samjonas@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 22, 2023 at 12:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Stewart Smith <trawets@amazon.com>
>
> For both IPv4 and IPv6 incoming TCP connections are tracked in a hash
> table with a hash over the source & destination addresses and ports.
> However, the IPv6 hash is insufficient and can lead to a high rate of
> collisions.
>
> The IPv6 hash used an XOR to fit everything into the 96 bits for the
> fast jenkins hash, meaning it is possible for an external entity to
> ensure the hash collides, thus falling back to a linear search in the
> bucket, which is slow.
>
> We take the approach of hash the full length of IPv6 address in
> __ipv6_addr_jhash() so that all users can benefit from a more secure
> version.
>
> While this may look like it adds overhead, the reality of modern CPUs
> means that this is unmeasurable in real world scenarios.
>
> In simulating with llvm-mca, the increase in cycles for the hashing
> code was ~16 cycles on Skylake (from a base of ~155), and an extra ~9
> on Nehalem (base of ~173).
>
> In commit dd6d2910c5e0 ("netfilter: conntrack: switch to siphash")
> netfilter switched from a jenkins hash to a siphash, but even the faster
> hsiphash is a more significant overhead (~20-30%) in some preliminary
> testing.  So, in this patch, we keep to the more conservative approach to
> ensure we don't add much overhead per SYN.
>
> In testing, this results in a consistently even spread across the
> connection buckets.  In both testing and real-world scenarios, we have
> not found any measurable performance impact.
>
> Fixes: 08dcdbf6a7b9 ("ipv6: use a stronger hash for tcp")
> Signed-off-by: Stewart Smith <trawets@amazon.com>
> Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v2:
>   * Hash all IPv6 bytes once in __ipv6_addr_jhash() instead of reusing
>     some bytes twice.

Thanks, I think we should merge this patch as is, and think about
further improvements later.

Reviewed-by: Eric Dumazet <edumazet@google.com>

