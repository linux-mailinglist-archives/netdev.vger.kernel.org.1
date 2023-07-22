Return-Path: <netdev+bounces-20053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6F75D807
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FE21C21850
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C27E;
	Sat, 22 Jul 2023 00:08:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928F7C
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:08:04 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF0A12F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:08:01 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a1e6022b93so1732715b6e.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689984481; x=1690589281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNbRoszOX00Y5Vkyqq2FIMf3+maY7HtNoM/rZH9xcMo=;
        b=Tcl0cRKOox4/q7uVgPclGBG/JseEPng7ICuJhgg6pWA9dqFD2UQ50jqJJ55QIDu0s7
         GI+8CvNcfEYR/Qb6lkrDr6Ox+wt1ZPEkuAEszEsUA18d80LP7or9bEGHQODhxYnRt7MQ
         w4S0QrI7jmbeF2wthmUeqZWBV4DYX+F1Wu41ZMsjYxJOBVrB5ULtn1brTjH37nwTB6zb
         4ly3l4b7oRG8ChlfEz5betssmeqH3sqjqkN/YKVQQT3C8CYwf2IDU1tviIumlF8nf0zF
         inDwp8a/U2jJEFG4cV4ouhW44x362SQ8FpaZXqJcTBO0PPDxTkmspJzitLEwEmhvGSrk
         uBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689984481; x=1690589281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNbRoszOX00Y5Vkyqq2FIMf3+maY7HtNoM/rZH9xcMo=;
        b=Hrkjw6ZpxzI3oqAajikJMrE5h72H8Df/X+7D4aRX46JfbGgI2t6p/1wQwlRQpKpxkn
         tT/dvbX5ufw9Lak+3Jblk+vRHdXrRUXLMF3exHVQ/8YbIL70qBNx7e8K5p6nGzDayCok
         +nzDsFyLacXEs87kxt1BhL0+/2lHlfRYZiZEW6YPs3Mcn8Vic8E9XRBoBuHPG7Xml+ps
         e+UNfmuXnLwWlgcYr3gwK8hflyKAG1g1xtH5Jh/gu6sPTVbTixqqF5mPXNYUQXctDtpo
         dm5XsCbTKW4b/YAyXru7/Z2MQDE2BYbGweH/ROAlhWFfgiCrvmZ8BLWJJQzWHyF5krSR
         8/Nw==
X-Gm-Message-State: ABy/qLZ5hqjlB0QXUodum7YQ4psczEzrSPueU/I+D46Me822Xqu9SBjv
	Jn9q2SEOSuvBYh3BR72DT0IUri5BAXOLp7oq+MY=
X-Google-Smtp-Source: APBJJlEKZldcZ0yN0iR7xhCvPD66e+8kFr/vSoGAYvdVoDlDgniywaHvMWEcDJ9TzVALNrYFcZuZON3Si8sjhvIB/9s=
X-Received: by 2002:a05:6808:144d:b0:3a3:6d2a:5c4a with SMTP id
 x13-20020a056808144d00b003a36d2a5c4amr4847449oiv.35.1689984480716; Fri, 21
 Jul 2023 17:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721222410.17914-1-kuniyu@amazon.com>
In-Reply-To: <20230721222410.17914-1-kuniyu@amazon.com>
From: Amit Klein <aksecurity@gmail.com>
Date: Sat, 22 Jul 2023 03:07:49 +0300
Message-ID: <CANEQ_+KSPSy3cQmVf_WdkdHMaNdCh-Qyo_7M8p+qFXXqbeZWgw@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: Reduce chance of collisions in inet6_hashfn().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Benjamin Herrenschmidt <benh@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Stewart Smith <trawets@amazon.com>, Samuel Mendoza-Jonas <samjonas@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Resending because some recipients require plaintext email. Sorry.
Original message:

This is certainly better than the original code.

Two remarks:

1. In general, using SipHash is more secure, even if only for its
longer key (128 bits, cf. jhash's 32 bits), which renders simple
enumeration attacks infeasible. I understand that in a different
context, switching from jhash to siphash incurred some overhead, but
maybe here it won't.

2. Taking a more holistic approach to __ipv6_addr_jhash(), I surveyed
where and how it's used. In most cases, it is used for hashing
together the IPv6 local address, foreign address and optionally some
more data (e.g. layer 4 protocol number, layer 4 ports).
Security-wise, it makes more sense to hash all data together once, and
not piecewise as it's done today (i.e. today it's
jhash(....,jhash(faddr),...), which cases the faddr into 32 bits,
whereas the recommended way is to hash all items in their entirety,
i.e. jhash(...,faddr,...)). This requires scrutinizing all 6
invocations of __ipv6_addr_jhash() one by one and modifying the
calling code accordingly.

Thanks,
-Amit

On Sat, Jul 22, 2023 at 1:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
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
>
> v1: https://lore.kernel.org/netdev/20230629015844.800280-1-samjonas@amazo=
n.com/
> ---
>  include/net/ipv6.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 7332296eca44..2acc4c808d45 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -752,12 +752,8 @@ static inline u32 ipv6_addr_hash(const struct in6_ad=
dr *a)
>  /* more secured version of ipv6_addr_hash() */
>  static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u32 =
initval)
>  {
> -       u32 v =3D (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr3=
2[1];
> -
> -       return jhash_3words(v,
> -                           (__force u32)a->s6_addr32[2],
> -                           (__force u32)a->s6_addr32[3],
> -                           initval);
> +       return jhash2((__force const u32 *)a->s6_addr32,
> +                     ARRAY_SIZE(a->s6_addr32), initval);
>  }
>
>  static inline bool ipv6_addr_loopback(const struct in6_addr *a)
> --
> 2.30.2
>

