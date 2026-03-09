Return-Path: <netdev+bounces-265781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIz6OMxKr2l9TgIAu9opvQ
	(envelope-from <netdev+bounces-265781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 23:33:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC12423FB
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 23:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 651F9308B419
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B307A38550C;
	Mon,  9 Mar 2026 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGJwRnfl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D033436A
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773095625; cv=pass; b=KOkd1VcV3oeNl4bEmKyra795d8OkjSG7Bv8R0l5iVgCRsm2Q5XZ0oom3hKZ21FTqy6Gi9aLCNttEOKOK8khAkuCwD6ar4zz6D5bFDkzCQIyDP/hmmv1q7xN/c1xrJMJyCI/90+Hr9smyvYMBDWLxw1I3l28FFjYusO+jsgNfBbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773095625; c=relaxed/simple;
	bh=HeCuT0qaD2Mz3WqutFMT+DaMPNeNHFoumbw+GPdvZOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myET5Jg4vKJI3BEn6e7h5bmiQ2KIIO4Yfl1G0ZIYMD4Xew+CxaUEd7bIEyxIztEJDq9n/cnLG/dMcWDTaO9rSSm+AUkdbe/z2ml/auwpROLBbKgjSLt1ePDOzklZL8/QeQrSAJNyiYMNviY3k7GqjrXHqP+NSiNPCdDJ8qrKGRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGJwRnfl; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1279eced0b9so11757597c88.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 15:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773095624; cv=none;
        d=google.com; s=arc-20240605;
        b=jXp90dcCUixcQeQHkzyGkCCBbwC3K6oWL0Z8ZFC9wiaGhmA/9GhqX5u0ZN/c3hJwZQ
         n8+OMxMK0F472AOp/aOxEljzPkJ1+73YaNGN8QJKk/USd+yha5udoFzH7owqI9v3kbcl
         jlzQDYDLpjySXKuEt5lhCyaorZPjTCuQPW4q2XYd61+tTSa+bp66Vv/sfO3w8ntwqr+j
         dQruXWz74WEmo27kxBBXponuDnQT0kIAcO5+u5WJJyxeLKX7oUJ6lFZ2QTwe2v/mCWhq
         x/2OfAf0PS1sWldSxPp9Wd0x0QYeZbRSY3WdAcIazZd7fFNV5lj8aRFhdhNlAszl79V9
         4czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z13FcCDa40AsQczoQ3KuiTGusPMfhLwXRIZQf4kS9Mc=;
        fh=KYxDninnan1YqzRvhyytvX4bvwX8pyhL0hMYeUjqNT0=;
        b=aiA2clK6GYMHOIfCNa6TIuNAf48RSwiseBLnmRLyx+xm/ojYZIEPZsNWj0o15BjByp
         hLKikN6PNfSubukYST35+C+QBw//jxE2N1nFgFOxbXAvGm6K9pD/daA/w8Ua/4aMQ22X
         xhHaoFSsji0cZdMezCjgB/oB/90Pd2oz0iKRLw/wNYf3EyWwKLyy3mWJ6r+BRQhL/toV
         fA5kZt/qpY7hwgTRXKi+hBZJhZL8rOWtzCLb95NDM5q/Z9BadlOA0UJluGSdFrK4pTfC
         jmTm8wubDSViKAtLxH5qfOg3a5tftkaxh6R82rzpe8M3Br98H91mJZqKzxnpvT7oKOrq
         Gifw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773095623; x=1773700423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z13FcCDa40AsQczoQ3KuiTGusPMfhLwXRIZQf4kS9Mc=;
        b=OGJwRnfltv7w3ugBl0Ur5n1uflh2kM1Fvd4abzcwTZVCCPJ6o+rc1avYcvrpz5B3aC
         4WT7lKbLuxyGrS7Dg7rhFpxrCoUrtLj/xnPmqrzmYC3VBNRrLyTtiHJlSi9Ts9UCKjDa
         hPsyfnARMf1d1N8LyoMnds5Qinnyft2OL0QNC7PuFz/aMMy5qLaujhSq7ElDu2Ra6dxP
         pJJO2Yuqhdu5Cb8lBmkyDndk35xdBXPzXrxwDGiRHoz0uSgQValflhWM3816ZT4oSw5Y
         w+XIKAWHU1n+Qo9VN90z8W0v61pnyJzDUjhLiQxSCMsIoURjCqO/mC9JA+mdZGc1Vq0H
         Kxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773095623; x=1773700423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z13FcCDa40AsQczoQ3KuiTGusPMfhLwXRIZQf4kS9Mc=;
        b=OOmhZJsBeDrH64K22SImwwUdkXbFbIjlh1njEgaXclaFJbVlulHfixSYW58sK1V8lS
         0i1WOXH234725Knl5bMwjw2H4pRegpKe6YC45jZ5jBsEoYX2UM2ppNPhNfSeb5T3fBFu
         WC0eES4Jr8R04foS6SYVi4Ea1DJOUGE/PYbqlCPEDu0bUWapVPUj1/OMfZGoIH+DZDlf
         CyLVCzRujuzz91lTp5K9AnWMso0OzURRIY8SebXuSuzSgH//jX2tD8Sx7KAvW20rySJ6
         R4HUCx5TF+gxfznpFzLaHsPY6bUvinb2zJQWklnBGqZ6L5i5TynY+dwaOJ8hqP/Z6wy9
         eMrA==
X-Gm-Message-State: AOJu0Yz3WR+dsrhbWR5ZqiUjId3ed+1gVC93o8oxDnIdWlFwgFc1h7jp
	U0DfkHpDJs0yTP/u9u/61+NS2VN0OEjDSHVkQkOFHgUuVYe8lCW652d1NX/isMvgkeLux7h3xuP
	LeFPzl+hXfAmdTQgty9EOCL9InUaZ9Ro=
X-Gm-Gg: ATEYQzwccXv2Ktwhw3RwlwQBI3cx5zbeff0zCPkRMy0kIB0j8bE4T5O0/aBfWtD99gb
	DDwemrYboGKetQZEZr+8GJeFv0oDneuVs7oDy9haVGz7AgtYhT9Bd/4fBftNyubjwTCeFLqsMiT
	zvouZjw8T/lxVNwzmZWWD2KXiONMHA+xkjLwKulzjKtGyh/n/jnv3cCCZOT2xRt1Sf8cekjeapp
	kHNlKEJwnjZXWKReVGH3QUijT9CAFMMYteBrO+GQzLbq+1OQdYPbdYI6pvBOtES3aVVHX58U08O
	zTdAK/pm33dgwbaAtiKbM/IYhH/Zsot7TRBs8/1o
X-Received: by 2002:a05:701b:260d:b0:128:cbc7:4c1d with SMTP id
 a92af1059eb24-128cbc74efbmr1834952c88.44.1773095623430; Mon, 09 Mar 2026
 15:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307224341.5644-1-ebiggers@kernel.org>
In-Reply-To: <20260307224341.5644-1-ebiggers@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Mon, 9 Mar 2026 22:33:32 +0000
X-Gm-Features: AaiRm50YZNa3BlkrQoNvVl8CLwjNIEvdQsMgwcFHWkf_GtPJxxRS7byEM1NSEyo
Message-ID: <CAJwJo6YhhK63tMQnMoN=9gsYcO4UCXovhK9S4GOdo8bw9B-49w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Reimplement TCP-AO using crypto library
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AAFC12423FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265781-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0x7f454c46@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Eric,

On Sat, 7 Mar 2026 at 22:46, Eric Biggers <ebiggers@kernel.org> wrote:
[..]
> This series refactors the TCP-AO (TCP Authentication Option) code to do
> MAC and KDF computations using lib/crypto/ instead of crypto_ahash.
> This greatly simplifies the code and makes it much more efficient.  The
> entire tcp_sigpool and crypto_ahash cloning mechanisms become
> unnecessary and are removed, as the problems they were designed to solve
> don't exist with the library APIs.
>
> To make this possible, this series also restricts the supported
> algorithms to a reasonable set, rather than supporting arbitrary
> algorithms that don't make sense and are very likely not being used.
> Specifically, this series leaves in place the support for AES-128-CMAC
> and HMAC-SHA1 which are the only algorithms that actually have an RFC
> specifying their use in TCP-AO, along with HMAC-SHA256 which is a
> reasonable algorithm to continue supporting as a Linux extension.
>
> This passes the tcp_ao selftests (tools/testing/selftests/net/tcp_ao).
>
> To get a sense for how much more efficient this makes the TCP-AO code,
> here's a microbenchmark for tcp_ao_hash_skb() with skb->len == 128:
>
>         Algorithm       Avg cycles (before)     Avg cycles (after)
>         ---------       -------------------     ------------------
>         HMAC-SHA1       3319                    1256
>         HMAC-SHA256     3311                    1344
>         AES-128-CMAC    2720                    1107

I like the numbers that you achieved here and tcp_sigpool riddance.
If you want to measure the throughput difference, there are iperf
hacks I made at the time of upstreaming TCP-AO:
https://github.com/0x7f454c46/iperf/tree/tcp-md5-ao

We certainly have to support AES-128-CMAC, HMAC-SHA1 and HMAC-SHA2.
For the last one, we specifically had an RFE from a customer.

It's a little pity to go from ">> Additional algorithms, beyond those
mandated for TCP-AO, MAY be supported." back to "The
mandatory-to-implement MAC algorithms for use with TCP-AO are
described in a separate RFC [RFC5926]." as I've always enjoyed Linux
(and opensource in general) that provides more flexibility than just
strict mandatory required options - that's why I originally
intentionally gave a user options to use not only mandatory
algorithms. Well, that's sentimental, and yet I see that other BGP
implementations already allow these optional algorithms.

I.e.:
"Of course, TCP-AO key contains a shared secret key. It is specified
by the option secret as a text string or as a sequence of hexadecimal
digit pairs (bytestring).
Used cryptographic algorithm can be specified for each key with the
option algorithm. Possible values are: hmac md5, hmac sha1, hmac
sha224, hmac sha256, hmac sha384, hmac sha512, and cmac aes128.
Default value is hmac sha1." [1][2]

I guess that may cause a regression for an existing config.
So, I don't know, could we get your big speedup and yet let the user
choose what algorithm they want to use? Basically, making
tcp_ao_hash_skb() a callback with optional algorithms implementation
and a faster mandatory algorithms that will use
hmac_sha1_init_usingrawkey(), hmac_sha256_init_usingrawkey(),
aes_cmac_preparekey()?

[1] https://bird.nic.cz/doc/bird-3.2.0.html
[2] https://github.com/CZ-NIC/bird/blob/0ee9f93bd076c5cc425ceaec9acedbbb7c9021ec/sysdep/linux/sysio.h#L246

Thanks,
             Dmitry

