Return-Path: <netdev+bounces-252874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MzYtEz2Zc2nNxQAAu9opvQ
	(envelope-from <netdev+bounces-252874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:52:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42677FCC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC01A3005317
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27212D46DD;
	Fri, 23 Jan 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzMTeOvu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B41FE46D
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183543; cv=pass; b=cWJSLviBVBdGJGOT2JxhOAfvLuN4hTOzcIYsLR9W88h6d836JPfhcSMsoXq9vKf1zRN6jbAx9biVzyhOQ2qi8aMZ9CResDevgvl/VsJ/dPW1xBc/xk1gHxW4Fb/S3PnZthGCj4oSmje0MydYdZg4gJAQbgdCnTIa70bJ1VaiHbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183543; c=relaxed/simple;
	bh=ql/RQGoc76bY/oZLmJVc2vk9Ua+kou/DMlalhjXfQ3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYO4QxTTdaqFc3PTX2cSZ22fGqvqz2ZNCqHracJrEwqj2pbiShBoEoDzzcMHhnSgjSLLa0RFba5R+WjS+ah8k0P2S9MKXK1S8QcfcRWsUuJDc2YCEpTnTP1VCglRM/b98DwCu4quX8kwHWqp5C8cw8fX/dsBnVFr0PtSR7nN9N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yzMTeOvu; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014acad6f2so538891cf.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:52:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769183541; cv=none;
        d=google.com; s=arc-20240605;
        b=UJAyh7ijvoSuWbE/ufr9eFb5je53pYfbcvy2H1aT1LJbMRwTZfu+C+SbuJwAvIamTd
         CFDVdB4ivaSiZ6RJkxLAHubeUFTeeyS1MUpil3lOeV7qrDgLXJ9OXkn9OtupfD5MXgCU
         b2S4vkmt2FxnqpvPoPdjqHiGWglfXBCEpPkZhDevjASwIDcgZQaSPixaxGGSeopi0oyT
         b0SaEeE/eU0R5odtu6p9ovQ+2VKIDGnFfbrhZys5b4zNwTHt8r0T0k8xLeq4zQa0K66T
         TusHoObWiC/CCLOtVT930rXVQrka8DLBjZmgORDDIPK86mTj8rLF3zU/ST+FJE8AJJsi
         vVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5yycnALwvLMeCFHLoPy9bWxl6QJeCjfuwEf4EZJzq8=;
        fh=DvkhIG8HCgftRwjXWqcCdDXYfhxEYDLz5ahe/FXMKXk=;
        b=BN7EIiFMWAD/Cm3seN60R3pD0n5AMaXV/3hJZc8NFth3Qix2MrmgvnMIdcZKngNX+0
         veQPfSHGgrMHRPn9ZQrtaJp+OL1JYLOrmtXszEj3BrdB1wqu6U+/1Gw0oOtJKSAtjVi/
         ZiBxHVuH+drLjGlBLCvrC5Zl2mTtodHl4Hn+SgKwNbAwcHSCV/KbIo0GhYKmJDNzr8RJ
         SEmlG7wE0ugal38G0YPJ4vwJagBmCGCbkN3/olwUoJ7CdrmocqDwb8TDB0Osa1j+hDHT
         ZkkeagyG/TgyKOqoKQj2euBbwH8gstv9tKbFZnEKrfuP2GqGDdTAIrH77x790T+rL/G9
         QFTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769183541; x=1769788341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5yycnALwvLMeCFHLoPy9bWxl6QJeCjfuwEf4EZJzq8=;
        b=yzMTeOvu2t+i87AEB23j2WmeYFIWPgGzjE7BEMOXvuEpgzDhDH4JKtgeuY+dkOf9YA
         xKkDxxBCdxySUiOT56nXUjCA0gZcgnA5eTqvGhSDN7ewvXk3R0IExwWCTtVyQCNk0cvH
         Q9GAlYmz0NwPSPAqtvKxgUSApZyPharJ8sn/gm6A+8GPhRG+/BKaXLN26v3zCAJwSU8y
         uEUT2R3RZyiideU3XZ1loWH+9sNsk5jVaI2HdwGnTTsAyIZnEeyXLvR4bFEq8+2a1/KH
         F/KdJeQghtbKn7fXSOeYl19scCmcy2UtmdeCcSLWt238ihFnI5s/dtY85rivEWKjT/lY
         7blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769183541; x=1769788341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N5yycnALwvLMeCFHLoPy9bWxl6QJeCjfuwEf4EZJzq8=;
        b=BmboK42ii28ZjDghWx9gSVLaOrOa01nz0atfjeSjljvxcmu0Aevn3yJGUNdbmkB9dh
         2y4FO02peczxaMSyAVrACRAPctvu51NpwM/LZ6NUeZ0yIzxKcwf6BxmsAzT93hfepheM
         LSeCO7eMSbx+V4vBO7Ox0huFhgDL3blAVhf8crSJTsJn2zfBmnVCOzfrRAtuiEpwLKiv
         UriklkQLc5D9+TNccqM7wgJIJ31GjodDxWpeWuTccMPMHk0JiM2jxL2bstWdrgINAhJz
         cCbHOpRk4s138adCbIKiFNFB6bZ+TFabAvmrCxw/P1wNYDNXDg2g4Z93PBAxPHzipXZ9
         U5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWWMv4vSmzCIuahp/ytLt8s1rOCCGD0Nw7Jy5+gz2NFSoeYrSfsg8l9zPlSKdFi6xzqCC/xcL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv46L7TyUFwD0WVVQIdT09Oue7gRgtUeawfe36srWqwg1xgszh
	ImNn4tFoesnOlO/7nXvSvg1l6AAYOtRISvIW6Z2gXOg7E6Q+qdWxR/636q8aP9SYi1ZzlXpn3X9
	eYQJofYMRWRJrZQjGgvRGiW9WH3FPKRXEz3d6hWYS
X-Gm-Gg: AZuq6aJZFDRZ0gJ0boT9ImvsLgZRLvxTYn9E/mg91CT7kw35iLMmJ4Wg3k3KSLfxwXQ
	d9rUz3jiLfMb0PmuhpGQeZT9EidglwmjjNKsvdsdo/6Ff/7xpNHC+XdTz9jeH1dwADL7SmXYsYU
	MW+RVGDLrXqWQoOqT8vU0ZCCA5/ahKFIduQauSx56fBMZAXo5BoeQ9f2REY2QJMJqMBSVFaEs1Z
	2Hs/y9zSR7WsFwHocTd2LaLoUtWZCxkB17BXqX15dzaAcbzCfhaEiCllzuVHslny7Oe03YtvzY3
	JhVeRyC5+p66jDKsxIzN2y0DWK+Hfbi+sm2p059anCcYcUImP2CLsz0iAuJL
X-Received: by 2002:ac8:7c46:0:b0:501:4539:c81 with SMTP id
 d75a77b69052e-502f800ce65mr12904101cf.2.1769183540908; Fri, 23 Jan 2026
 07:52:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123111605.4089200-1-edumazet@google.com>
In-Reply-To: <20260123111605.4089200-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 23 Jan 2026 10:52:04 -0500
X-Gm-Features: AZwV_Qi6mop3rKjjjw5r6nbvcIoFoXoBSiqZWQtM0n-hygoVnMcjAjySnARcU4E
Message-ID: <CADVnQyktV_z9=SoT7yhkT6mBQKRjaJgpwLhR2SdWGQS3iKD3Tw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move sk_forced_mem_schedule() to tcp.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-252874-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2A42677FCC
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 6:16=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> TCP fast path can (auto)inline this helper, instead
> of (auto)inling it from tcp_send_fin().
>
> No change of overall code size, but tcp_sendmsg() is faster.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/1 up/down: 141/-140 (1)
> Function                                     old     new   delta
> tcp_stream_alloc_skb                         216     357    +141
> tcp_send_fin                                 688     548    -140
> Total: Before=3D22236729, After=3D22236730, chg +0.00%
>
> BTW, we might change tcp_send_fin() to use tcp_stream_alloc_skb().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

