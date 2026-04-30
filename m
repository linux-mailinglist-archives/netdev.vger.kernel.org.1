Return-Path: <netdev+bounces-282955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAQ3Hm6L82md4wEAu9opvQ
	(envelope-from <netdev+bounces-282955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:03:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 737D64A6298
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EB6330166F1
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D743637C;
	Thu, 30 Apr 2026 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfQJd0sC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC35406297
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568530; cv=pass; b=XfZZ8wTkKhEhIJmStM+solOufqNsGdcj7KxUOxcmKZdV0hYY43MZtcw2J9elt4uYcv9krh5X+3AxKRmyiCG1krYhjQyvOmTtW88ws6nzsUuTh30Ktergn2Jfiur1fZo/PjxY61iqeXtS0wwk4kKFojEIcM7XSMyzyn6ynvWgTPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568530; c=relaxed/simple;
	bh=kdkWT7Lj4mppb7ePDWP0ZDTnqJdUNyj1JX4iVP8CiOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZBrAPtnPrNeuvr6ypjIY0ExwftPmw1sRgl4e9egRkN0xf3YZO+KZO8aNk4dHcNcZFKcHEaT2mHtJhfZXg0m6yIe04OGj9dDE/jQKap1KjvnTX44u2xD2davELX5ek4aQruDhEotw6Zcsej2ZWq4o6cE58fT00KrEcm4LRpLhg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfQJd0sC; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c726ef332so1838007c88.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777568528; cv=none;
        d=google.com; s=arc-20240605;
        b=KE6rShdJ9Ai6IPXY0JwS83HgF7YeBa9nSVHDuz/fUUcYL2V8Zal2XcLRwaDyXuAPai
         vEsq8hlcoAe1Pll04Esp35304ijgUxwVrvgkwy4yrq5vMLHSUagEtIhyeI/IhvP5cITX
         9P1emSnkGtyP2IxfI9huMrPRU5n61lokOCiCk964RfRd0EHHUJ8ex1JfoZVKbGq8I066
         b9ZfnKraxUBcr8UuKErByRUTRpfDwcxxSw8+2ZWvpclWUH2CJvcUIpZwXOVx38f16PFC
         KfVpDznYHr9UGcLNjSJfvMtfo44bIh7tp2JqvWqjroAMQ69xnrnVKBrmjeIzBdGbM42k
         Bvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ysekql4Ul305BpiEGUXKj6pgyfyPE1wDivp5cN89gbM=;
        fh=i1Ya98jt95kCEuHZVPK0AJKXI74t72mO+Q0+77SrzPw=;
        b=U/9n39f+BCEdNx5Zbi0GBudtg5XWEBYd6XSm2O7WImygmBq2QFpV1zGx4A0DOmFWrK
         hqKGHcBLZOnIXrh95l5cbA0ZHaoPGnbpRN9Ui0VxKX+vKmUEq/Padf1aNlkIMS+WMU7J
         FBq5KmOcsrvdBDb6sfM8zlfXXVvHEd85yXlKMHuCHTK1ewPf5XYXFpKKT3yZ12SAFkXJ
         nmGUflSD9Uox3F1gvETV4FyEK91xqeDb9vGclnydva0ovdlXv8J87EIFTHH321dhQskr
         XuppgssQRaKugC0Rk2k2vE01aBoNysmjIVwqdOA8wQrnqQYPeLHjk0wOdFQTGBI+fjMp
         STng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777568528; x=1778173328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ysekql4Ul305BpiEGUXKj6pgyfyPE1wDivp5cN89gbM=;
        b=LfQJd0sCylnHBzkUGVjDl9tfbrEIw3KxBl75qZQkzHpaXc6C2gFwozk1l8JmfwrnVN
         JN83oXeJL2Cu8nTx2BzFhrWBHuf6j01HJUQx29gtw7tMfetdoO94K1Jcm+rjK/r375bM
         xoo4oIYtyOeWiPnPRJq5VVPWgWtUBpHP/5KRS3Bbnpyc1hVHOAngsHvldMPJuXNMy999
         m6tveefExDjX6kbYn+LVsm5pqD2zBiNj+D6e+RWjnDaMlK0WkTLr7QtYJJ9hQFlAKpRG
         yfDJM6R6wSnJFHfpU9Pv7XUTa3nlN2pe7GR3GjKHcHeQU/x4cJg61e4CCJX2oBwtUyJ8
         0dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777568528; x=1778173328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ysekql4Ul305BpiEGUXKj6pgyfyPE1wDivp5cN89gbM=;
        b=idlPe3UgjQEsapNWRIoofDRL6QlBvQ/psWE57lcNIfnRRxn9LqlZu6I7ChhczoB4WR
         BNRVCag6CGPSFJMxPllJ5trP+2dlL8c6+nbqeNSmZ8Y4YMVrbtyUJU2+cFyBBKgliB5x
         38kFJnLQ+p9kxCkWuKlukYG8oNhOAAk7Tfk06Y6RYFplLFk5R/ieNEUQbsKqA1m6amDL
         P+PUIRJ/xW+JTulZhjzSsd4t8ND/ZQyhvWwsFQ7df8IZ679QXvCR4WbxbcK26WAtWDa7
         GsJHcwVTsozzqmu5KT2tp7Jq5rNehHIQF3jXNG79y+OuJ+rJtWszFJpt0EdQaa9vIcY4
         fKGw==
X-Forwarded-Encrypted: i=1; AFNElJ+nGlxju6oFQxW0rTHm91jqvHha3HWHrhJMDyEwhZzt2JSPpZV3u6aKrbfIuVzG4vZJPVBPsSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvV2qNYEEXhfjblslSMce+LctuBbpFyMZnRoLjRK7VEg2gwFX+
	S8oZsPNBkKYt7RwnOcMkh34XjlySZ66NUhLp7GLDRgb8NrIbwwKZV3pT8Dsv6zUupm8Fg6L2jRd
	3tNQvCWteSNGU0B78VXogAiIWy+4BufM=
X-Gm-Gg: AeBDietSb2r6SsGtIaRKMoQb0Pajm4+DXXvxa0AsRSnJQgoVl9HJvz3r10vTNmFtxBq
	baEmYf+Z7dJBS4fAUcTrl6nqBWgP/RRtUF00LPJTLe/Q6uOIBnUFCw+gLLFGaTjccIoIdVzpPDi
	YimYmV6zS+rajEatwXTCBHl/b7WNTaJKF5Ou6F6vVHJw/H+dfa7lMr5uUKXRUP8XgFl3dtelKQN
	Tl8HaEemKUN+WaTGwRQtMoF2jxTiHGhWt81s3wftMiv8O2PpYgx1xjko+V+aQp/zTQLrxeTY/dH
	1Awo4BJbigi1q9u6J3Q+9z+RBpvceHWOL3d0eyj551rq9Sc6JFFZZNVacee/+J//QeRKV0I2nLb
	fSqqb8oCp5JnwgeSY/H2BHLombpQmKdGziMbEwboOArk=
X-Received: by 2002:a05:7300:5411:b0:2d1:e92c:f7ff with SMTP id
 5a478bee46e88-2ed3c5c9e16mr1826579eec.1.1777568527441; Thu, 30 Apr 2026
 10:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427172727.9310-1-ebiggers@kernel.org> <CAJwJo6Z9oJSMMBUL_pbYWN6ha3n4MRpKV_aVut8E+af3JUDFkw@mail.gmail.com>
 <20260427155538.2e1b8488@kernel.org> <CAJwJo6Zh_1V009JSBGwAmR7GWj=2HdG6f=uBxK8krE4B1YrGkA@mail.gmail.com>
 <a642b858-eea0-4b7a-aeb2-aa67c6cf0f64@redhat.com>
In-Reply-To: <a642b858-eea0-4b7a-aeb2-aa67c6cf0f64@redhat.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 30 Apr 2026 18:01:55 +0100
X-Gm-Features: AVHnY4J_afp8At_pOKi9BxqdfNCGc1QYGVwpMxIdJAzdWNmsjbxANmQ8MvQWChE
Message-ID: <CAJwJo6YDJ1h7Ry15BDArx9dQbWMt3xFY28Ecy2rb7HsKi-f-yQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] Reimplement TCP-AO using crypto library
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 737D64A6298
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282955-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0x7f454c46@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 at 08:38, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 4/28/26 2:00 AM, Dmitry Safonov wrote:
[..]
> > Yeah, that's not what I meant. I see value in Eric's contribution, and
> > I like getting rid of tcp-sigpool. So, anything but "nack" is not "no"
> > :-)
>
> I read the above as: "If there isn't any additional feedback soon,
> please apply".

Thanks, Paolo, that's exactly what I meant.

I think we addressed both concerns I had with the new RFC and BIRD
daemon, and Eric did a good job optimising the crypto layer here, so
we are better with his patches than with my sentimental attachment to
extendability that so far is not really required by BGP. And if we
need to extend the list of algorithms, we will be able to do it on top
later.

Thanks again,
             Dmitry

