Return-Path: <netdev+bounces-263029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DibIrFYpmmJOQAAu9opvQ
	(envelope-from <netdev+bounces-263029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:42:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD471E8875
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0D33305A437
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4337CD25;
	Tue,  3 Mar 2026 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9jJ5N9o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AF279917
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772509359; cv=pass; b=MmPSVpK7B+qhNBWdkDnbw88TJHA/ybUBNSs4BKDjiNM5WJXuoa/uHHPNg5gschk+/d7/RFE9yxmfjBxWMg40r/XKYcEekFpP+BdKMrzxw24pBPqpwDXy+fSTA3fbxf4Dlpn9WhfLciqcH50m4N5Xq+f1yjF0h82H7Ulka/Mqp88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772509359; c=relaxed/simple;
	bh=ZVUB3wC73Wr2MuOVBaapP/i3oiFMYOER/R+aajNTd6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GozBxY0biLrIMuDmxISQKBJ3oW33je3wXstvdGz9x/w0ZxwGnGxVNQgHpPCN4aXuJ2MmxVCREMAhvS4SEGOHE+IsdNmdymC5jIZirnlbe2APd1I4Q+05OC4gh1PnB3mvTVfvK5sdeVRNFMIAEoDuhO7w1KxKb04ubdTC0tbIdBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9jJ5N9o; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-503347e8715so65106311cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 19:42:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772509356; cv=none;
        d=google.com; s=arc-20240605;
        b=kVGsiAHfDDRm3oTXy5l8OBQhQ+Uhwr+fPrTgP1KP/u6J718ry1eqDsBozS5c/CDSKT
         4wah39WfQSxqtkly8QjnXHEl953Eizf8ba4J8JOPaz6VneMGza5CPG4SnQQERiysA5UH
         IPpTUV6eCb7POiA0PFUOyNaDL7kRvxC8tG+kASE9Ti3jqst7tBGfFU7NX+B2ztccZ9tk
         pCVuq1n1ZAPg7Y8cTrquEyYOUjRCrzUCBKO/Zu7CoREMc7mbCZN6jQtvp5JvosKSpV4t
         5LHwZ+ahfAto3ppzqP/kQqK5Wz90nWBux/kmLAT1yKr0tN3cpYG3ziAF7NEnTU5ITKfP
         ATLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jM5Sv380XGPgNQlH+xzbk/R1aBRRcKgA4UxlgomEWiM=;
        fh=WCtIeRLGJ+375wtaHZlVgVl4NPlUpmkpULBIrXLCx98=;
        b=U7tiwJESN4HaLr9p8Np0hD4BzEmuCnESNraCeVHnhUqaADuVWhh8a463xt/8rDALm6
         UtqsV44pxqyikAYku8Ko7l1UeKTHeOvT0xVs9n9K0NMTUDZs4bZiNLl/Ju+KVkO2AZ8C
         jgtYf+6P44dXUws3TQRopuxPyi3vzzeJrtid2V8j4ecfPMTuzTHRlrYs/TS8+UwFxQeU
         A59bBBRTFzfQaHzCBA7i3PzzpcEHVdxL6k2TYbZUxbJdADhuujPEZzTgLICQNyBU0JU1
         uTIB59ZXspvq1h1Qv26wi79xBvg7YI1wU5TRb+62XfYXkkJjZsy+rUR1V0VjVI1ugdDJ
         Nb2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772509356; x=1773114156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM5Sv380XGPgNQlH+xzbk/R1aBRRcKgA4UxlgomEWiM=;
        b=l9jJ5N9o0QFhtQlXgnqkh+1iiklkD0hCAQkWVjWmX/GYtXKWu/pRxvJU3QDzHLHvee
         BCP3MnP8sKXiRZ8OLfA8DzkLDIwDOKYdarnJRTEQkDQ7BxkD2fJUqmJ6YDerTpoomAuy
         vHPvJxHYQ0UTkXLba5XqHfZmBSghq/qYQYxV/mEUwL3L3lcAiPbbJ3e/Ob5HYIWa0Xzv
         VhKtXRHVVkFNXovj+DHiUcPzz8K3xVF5rzrV/XFj8j3PYRlc9XK0P15G8onv1I4AndaW
         8cVSLAc3web0hjBEUD1djDeUYlROWE+0vnmUlMfXmXQhPwaXval1lgaJud12siIRs/Tg
         nhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772509356; x=1773114156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jM5Sv380XGPgNQlH+xzbk/R1aBRRcKgA4UxlgomEWiM=;
        b=Ulm9l3Iv//eozHGb6TUaCcl5Ocelk53sbbBFjuFp5T4UJVQsbE1E7KcoNJjhz/ucsu
         RuPsDR1H4NuEHAoXfDkENGqoTiZScrGrqstoOTepltaDKNJVNWDISDalamse/+LCADVs
         xyMkFJvlb1tueKAV1HvnOYm0oVGsPLRiOMr09RGPlpJEzfRwIlxj4a5sKfcLqrrzhdYs
         LjwgKkRdfZlSl5n3wOB4MJEOUl4B73r2vsIv+FiDA81tKEyvQM1iQVpiLz4iN4RUWXBQ
         CbV9hxm0wQvwpUvA/VZvZzipZqT+OV2L+rDAYPq65RJfBNFI0AZjAkLkiuUAo7Cl9Nbs
         rckA==
X-Forwarded-Encrypted: i=1; AJvYcCUbuIIa9zLvc6SWa8Yn12ul6tSqa8KDJ6Fm+/4clE741AceHM9vzwbniB7decZccpc7UTh0+30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zf8yLqk692A6iiHiEpdkuIcMPKmqgwi4PAbCefzAn+6R3mSw
	fjSJSedCjS7xAWB38SHFZWbZsCVbcendVol2p883u1uK3IxTOum0+NKJDBk3bHlrPMibY/DJ+W1
	jpAPXXixUNDtVCC2vpr7/mG/TbBPbOhjUgIkxizEtZOZYskeQ+ZrrE6Ld+cc=
X-Gm-Gg: ATEYQzy5D/qw0IchAzAbsxkTdaSLHIIH/iaoH6Fiq2Z3cQmTPAfBya4YMwcFZleqBfo
	5clEe3q4ffKmjhzi9ki6vdTH/tENvNCXWQ8Udekp8zYbftUlzeF1d8ZuTK8pl69rebpvc69pRYd
	7k6/si9yrq4cQohxWEoNJkocKyW6VvQWAz4pXWTeFR9Z8WiCFhIssFfS6JBqu2mi5h4Ka30ed29
	C79UJZCtlj+noZxWOp2dgoTInihq6e/IAJOqz61aw7Da5sEgVzJ3oDaA4AoWtj2sYXBm1y78dUh
	hO8BRx56LXYtKf57
X-Received: by 2002:ac8:7dc7:0:b0:506:9d3e:67e3 with SMTP id
 d75a77b69052e-50752923a15mr186396371cf.70.1772509356200; Mon, 02 Mar 2026
 19:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302205156.1213225-1-kuniyu@google.com>
In-Reply-To: <20260302205156.1213225-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 04:42:24 +0100
X-Gm-Features: AaiRm50jMWb1CgnvJFeTi-TGJHCTU3g-zkFnX_yIogUSyL-Roq2QNQYBXMUFImY
Message-ID: <CANn89i+5gC3Wr2jAOG0=Sp1H2tJ7_ZufHcp1B7t7SdfgY+JmeA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] tcp: Initialise ehash secrets during
 connect() and listen().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EBD471E8875
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263029-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 9:51=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> inet_ehashfn() and inet6_ehashfn() initialise random secrets
> on the first call by net_get_random_once().
>
> While the init part is patched out using static keys, with
> CONFIG_STACKPROTECTOR_STRONG=3Dy, this causes a compiler to
> generate a stack canary due to an automatic variable,
> unsigned long ___flags, in the DO_ONCE() macro being passed
> to __do_once_start().
>
> With FDO, this is visible in __inet_lookup_established() and
> __inet6_lookup_established() too.
>
> Let's move net_get_random_once() to the slow paths: inet_hash()
> for listen(), and inet_hash_connect() and inet6_hash_connect()
> for connect().
>
> Note that IPv6 listener will initialise both IPv4 & IPv6 secrets
> in inet_hash() for IPv4-mapped IPv6 address.
>
> With the patch, the stack size is reduced by 16 bytes (___flags
>  + a stack canary) and NOPs for the static key go away.
>
> Before: __inet6_lookup_established()
>
>
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/inet6_hashtables.h |  2 ++
>  net/ipv4/inet_hashtables.c     | 16 ++++++++++++++--
>  net/ipv6/inet6_hashtables.c    | 11 ++++++++---
>  3 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtable=
s.h
> index 282e29237d93..c17e0d874808 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -24,6 +24,8 @@
>
>  struct inet_hashinfo;
>
> +void inet6_init_ehash_secret(void);
> +
>  static inline unsigned int __inet6_ehashfn(const u32 lhash,
>                                     const u16 lport,
>                                     const u32 fhash,
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index fca980772c81..2c2cac5b0f1a 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -30,12 +30,15 @@
>  #include <net/sock_reuseport.h>
>  #include <net/tcp.h>
>
> +static void inet_init_ehash_secret(void)
> +{
> +       net_get_random_once(&inet_ehash_secret, sizeof(inet_ehash_secret)=
);
> +}

Could this use get_random_sleepable_once()?
We are running in process context here.
Same remark for  inet6_init_ehash_secret()

Thanks.

