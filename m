Return-Path: <netdev+bounces-264674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1teSAKdlqmk1QwEAu9opvQ
	(envelope-from <netdev+bounces-264674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:27:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1D321BB33
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D52303388D
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 05:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D633970F;
	Fri,  6 Mar 2026 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRmKxER9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E331AAA8
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 05:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774819; cv=pass; b=iPVtSMy6JiGP4ekAE5p6tAgiIvUxGaw5US12QkQjfSwws6Kyjj76ii6uu0A8kzTAW/a+qYpwXhavyfOsKGdB5xW0Nz2Q/w0gs30IwxRQr8gMLjuFewUe/9+kvDlS9Ufriu9MoR4pT+w/cuO7VVO5ki4Qyk/iGv5KaGbwwfJBvGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774819; c=relaxed/simple;
	bh=OLXRZcfXVoihNfVSJB2QHt3BWRs5a9/iqX58YMJrWA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHydzC1+MdJBIV6wOifuzX6nD5ewkXTXty9N/Kfa7Otfu/yj6yvKr061rvHNJXXY7WSMgo4Ul1wlm5fofdhOtbOxCKq8bnn151iQirxYTByfOQOI0VCjiim+SAtk/1QGVoEEu+p1paB1lWWEb0SWdrjwY7HXl22KZ3tRpYPxkY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRmKxER9; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12713e56abdso5502624c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 21:26:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772774817; cv=none;
        d=google.com; s=arc-20240605;
        b=b2PY4K53Ea1gCqZAFtZY+1IQZN5DBqmX2OyOOkYGAX3vHIbsKD+JFQp8ytekRTGaUA
         ty/KU9GEtpsrjwCsZWb2mwVkLRH+eB9UXMDb62M02jdp/kF4y7k690uVEoZ//u970PU3
         WZPVdHqax2c6ndtyAuaNtRaejvTUF7X/9G6+OLa/dVTq7638nhXmZ3WvRoJN4FffHrLz
         tKYqR+VlaMFbFEqyVYDLjuvJlJU85x8cE2l1m30JJMOIxK2Uzw0DLy3Hl2CbQKcMZcO6
         81PJoUeC56Z0+5ww/7YpEAGKoWP/yxhL2AA1UmosAfXJC3SnDpboY2F7IIHnQ+jfJrH7
         xWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHqY2c9voLqeKgMRIxJI5b6z7T8BHVQmgzjnor5i9HA=;
        fh=zh6YVX8ubJAUGiHZIeMW3aSul9QAN28GMN4VVv8sF7Q=;
        b=kIc2utp35PFgM6NFVfj1X+V9grkNK0NBTeOFCOegQVRI4sXFVNes1lXpa4zGh6VDPX
         v9Ng0SaKSP0lbdPhDM6tisi83jbhKIFNgEqgncWWTbOY7gXYtnG4ir4GnXcJLIgc6QDq
         7NFBlWnhi1jBT/RxyhncWev5aZzaAJRpeUI0P91l3xY+epcbp9gaTsBoC+wWefOPAwHl
         lAlPCrOofV8A8VTwspL6SaI391fsvLMOBfR8uk++ZQn3ppyXLyrpLKaYvQt+lqZTDtOI
         jkf/DPf0npjs5iWVSuqUAVnDnXHxonYpoLLOEpKTCXJ9lM1zje3xPgjpqcu8MIViLoXc
         huCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772774817; x=1773379617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHqY2c9voLqeKgMRIxJI5b6z7T8BHVQmgzjnor5i9HA=;
        b=cRmKxER9uYSAW7CybOuPpP1LNItZVoYt1F7N7GOagoXK3VnMHS4/vyO8lbhMGvcZrM
         g12alUI8n16lg9RYMKLGfU5mnsz0LqZnXJ1AAN/Qd+7//hsqnBKmerLvzgp17ZjQY1X1
         T5ivgRY068e9RNv4+Gxz0YlexSgE2y12d4IVzFoZfbE+BzG94ERc9orS/dVsPrF/hTuB
         UW9GFa53yG2lhRNF3TDrz1bA0waDRIowyTHZg/COBkbiqzudzTsM2fCYtEUoRP0WazVM
         8ZjPvY1PE2PJl/ZC914g9OjEP5q3QOlCXTusMiT0UjiLETTrDa/P2a1hS7mRvyYJF/1r
         Z38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772774817; x=1773379617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHqY2c9voLqeKgMRIxJI5b6z7T8BHVQmgzjnor5i9HA=;
        b=MvkP9Bu022D/mduM9JSCa6T80ttcDcNFo5SZFVOa8mERbvYHmsIMkiF2KXolhCGUBn
         NxgaMu2R0/gaHSYhfUcLmxm8tMV39EnXDoO71sySYoZIo207Qelo2v0RYMNIH83va1jN
         2cSbnc+NgHr0e+paGKkiDSA/q1am8UlXdEL7FD7sNiet8dPofTQuAJBUqTgwhs24uxwN
         MRpN0ov9qlcrd7VbDADEJUCikog57u6lDVOaw5h2YeK4vtGJ9KpOC4WGqKjz+e8aVSHm
         inUUVCmrKbVOV6pVlrp4qqSvPv66tK5bZrRa0P1AkSvHIO/Qq/g/Wij+29NC9w6hLa8q
         qhIg==
X-Forwarded-Encrypted: i=1; AJvYcCVycB+5w0Gfsf3rvJrp+ObwCjQ147kBwaiZVUmbi7XLQGfFnrX6Y4lgZ4mZbH1bndpM43AC/LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrYDeM79pjDI60oiK7lvCVJak4atyk6fnG2vlE3oT3DjymdKF
	aeRVXfKAmZIYUDS676ZQY+GP5ukXqiT6VZ/WIN2bRFp1X9MpSIfSqFd0MdNKSZBmhcoajonOJ8G
	SRb2z6I+JN6ysWIVn/N0uXsvZfKz4qOEyPYunUqAh
X-Gm-Gg: ATEYQzw4mFjvFqTQn7o/K+ft+KHo5ib6WJi9ao2s6UtBoHgMAaDsUPof+Hk1930X65O
	x/EMz1NZJMD+EMFyWQN2XdeX/OO3ii5xs20uUmBhqyIHAvPusIjPyOyfsMkFvLYKFMkXAfVDItZ
	04csYojhEFmEyC5VNaePtXVpX6o5NO2AzxgL9ReeCjJT6WmRi9G8S3xg7yUhFg0C+8vW4omNQJY
	gpplDmR7QUoUbwtGMayQ03J8A8RZcWXg+9RlKPy1B9ecYNYW0AVB7KCToRZUcRarwO1YCKf9Wbw
	XkXkLOkGeYsHnBQC9HdahJHU8UmFnl72868ZqbOy+P2s7FRpr/26BN7Y9hvQUC4kRy5uc2z1
X-Received: by 2002:a05:7022:23aa:b0:119:e569:f874 with SMTP id
 a92af1059eb24-128c315e7a0mr357995c88.17.1772774816491; Thu, 05 Mar 2026
 21:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305070525.184945-1-the.latticeheart@gmail.com>
In-Reply-To: <20260305070525.184945-1-the.latticeheart@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 21:26:45 -0800
X-Gm-Features: AaiRm53sItMDOl-qvAuyshpf-DuzuNbF9VniBkP8YNq5BCZ5mpxHPmhyZbwjntg
Message-ID: <CAAVpQUCoPoMPruAetG8zt=o=iZuqUKs-xaVxtf9HSrh=hi2jLw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] selftests: af_unix: validate SO_PEEK_OFF
 advancement and reset
To: Soichiro Ueda <the.latticeheart@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Miao Wang <shankerwangmiao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4C1D321BB33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264674-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 11:05=E2=80=AFPM Soichiro Ueda
<the.latticeheart@gmail.com> wrote:
>
> Extend the so_peek_off selftest to ensure the socket peek offset is handl=
ed
> correctly after both MSG_PEEK and actual data consumption.
>
> Verify that the peek offset advances by the same amount as the number of
> bytes read when performing a read with MSG_PEEK.
>
> After exercising SO_PEEK_OFF via MSG_PEEK, drain the receive queue with a
> non-peek recv() and verify that it can receive all the content in the
> buffer and SO_PEEK_OFF returns back to 0.
>
> The verification after actual data consumption was suggested by Miao Wang
> when the original so_peek_off selftest was introduced.
>
> Link: https://lore.kernel.org/all/7B657CC7-B5CA-46D2-8A4B-8AB5FB83C6DA@gm=
ail.com/
> Suggested-by: Miao Wang <shankerwangmiao@gmail.com>
> Signed-off-by: Soichiro Ueda <the.latticeheart@gmail.com>
> ---
> v1 -> v2:
> - Add peekoffeq checks after MSG_PEEK to verify offset advancement
> - Unify the length in the non-peek read
>
> v1: https://lore.kernel.org/netdev/20260122033605.148626-1-the.latticehea=
rt@gmail.com/
>
>  .../selftests/net/af_unix/so_peek_off.c       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/tools/testing/selftests/net/af_unix/so_peek_off.c b/tools/te=
sting/selftests/net/af_unix/so_peek_off.c
> index 86e7b0fb522d..9640a3975aee 100644
> --- a/tools/testing/selftests/net/af_unix/so_peek_off.c
> +++ b/tools/testing/selftests/net/af_unix/so_peek_off.c
> @@ -76,6 +76,19 @@ FIXTURE_TEARDOWN(so_peek_off)
>                 ASSERT_STREQ(str, buf);                         \
>         } while (0)
>
> +#define peekoffeq(fd, expected)                                        \
> +       do {                                                    \
> +               int off =3D -1;                                   \
> +               socklen_t optlen =3D sizeof(off);         \

nit: Can you insert one more tab before \ here ?

While at it, please sort variables in reverse xmas tree order.

socklen_t optlen =3D sizeof(off);
int ret, off =3D -1;

Otherwise looks good, thanks !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

