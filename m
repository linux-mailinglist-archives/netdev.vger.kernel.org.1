Return-Path: <netdev+bounces-267060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPrZMfC8smmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:17:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDC127267B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7681300D30A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C63C455C;
	Thu, 12 Mar 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVNQwuIO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06818344DBB
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321453; cv=pass; b=KXAOWaTU83nvff6vJZhZHDqqHA4lAo/yL/lpTfnuKzB9AIVC0nkHgtLLGfiuG43LhMiBTGulfFJVIoYi9zhbQmhs7ovROfS0vvwtLBW6wEjxnoFqgNCzUTTnjnsMoGQ6GAX4J2WWSV9C4LJTUFYAa7dzOXUtbvWP0B51QuZW+PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321453; c=relaxed/simple;
	bh=2CVfKLzEaWzJ6SOlRajph962S9thoJpcyvo/tNIs4cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJCfzow78n3N3G7RR3KtTVglcwZNGMaWDgIAHn1W3HD0cAPy046YHQxdRFNd7NCd5izZrgYV4MKD017XOUiw2TvSnDajchHXR0T54lgFNtZ6gzeN9DC8GgQsHBLZIW+zr4jMcLHx5pbcV8ptse8oDYEvxWvZGWUfWJFSVenPztM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVNQwuIO; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506a6cf8242so9031481cf.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773321449; cv=none;
        d=google.com; s=arc-20240605;
        b=d/fcvIRWENpWKZ6UTxoV7TbIG6Rm3EqUK706V2CDnNvBBpk0cnOqroYpDTZzLqQPmD
         qlJPLA5AU876JFbRTTVBBglnaurbNSJvrb/eqrXr3LI50sbYrJeH3FUcwSaevuoEf99g
         mrnbgrv7ka68//d+5075Qc8WW9vK8sEn8NtfyIAkPfw0ak1J5W420AIVr5RBe0wwIR+X
         4b0EGoZc7qE0se10zfe0b1LvPykOl8wIXIQlrI2z6xZDksquBc4n3WDXY5LvKhqqwBKs
         zzU824NU1hGi/G6Hs+RE+naydFBZONG8CCuhy990CCIMttUoDv1UUX3Ale9wZY/pNUiE
         EL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FPswTUN7MLesfdnks6XcGWJl+3PmdW/bBkNaMAxhxH8=;
        fh=b3og4FIW6NDbGHW/JYYoxdsClBljwR40dsRon0dO7dE=;
        b=hdMma/5udx0rQxHnmOMfpYgEopzQtjb0VypwlBs3eM/CTP/IO7lr2nwF+1axMaZ88V
         4w5bcYy2FXVUs0I6DSNDfZDdM+jkpk3i9rIvsPsyAMD40QmK0eTskvSk93LnH0RcdqR8
         483s49LHqfkEZ4jIv+mecuAz8uPZd9qA8WrgOHTrtfRoWxm6P6kbUXY4azWeBqoYu8og
         mn/srsRyAUrdFzjniBcd63f0HOOJSyYPF4PdE9re7VyAM4aJ2g9dK9vfrOlLCzEH7Y9E
         wgxylVmsF+9cFoYuXPjkYGZ/Ei5MlT1gY5RuEI8LeN+H+91WAEgbcqEoJkBOyCnkJ717
         NPuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773321449; x=1773926249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPswTUN7MLesfdnks6XcGWJl+3PmdW/bBkNaMAxhxH8=;
        b=MVNQwuIOTIvL8HDnk/IjtGZ9/7DMvkoiQTiRUZuh29mp5C6025kOAhGKjls1lg5OKo
         BZElZvzX/SedmCaYlWxzgefe+fggSpvl566BWYlKWaS0x0v1DdrVPBxkvEnVXImAvZDU
         jnTCVSUDZRMfuIeOel7aotv1ldnM36CS9yJ8XC2weRrXLx29SQUYkHYWbWDRAqPwPa/Q
         4FLOJ5yFzbBP2bwbeKYwPg00hSqgLljaqcWmXqIdWYPIDAske1bSnDAZBSvqA4nU4quJ
         v5nr6FTL5EH7fXa5y6suuJZOOmmrZRGxOOwk2Y4CrM1amb1j08hLvDXA53RQ6mVUjGX+
         3pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773321449; x=1773926249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FPswTUN7MLesfdnks6XcGWJl+3PmdW/bBkNaMAxhxH8=;
        b=qY9UrUIiEkSF4LkUhEHnYXoDjFLVtYSIpbWNROX+oXVOcMaN8IK/XaEc5m2cdJ7in8
         LjZSukM8LBhO0AkBjKnV3QCzpl6FxaLWjcvu0fb9SF8PUClfdwmLEVrwLgtkbJZY6dma
         Ifi4TVzcvyRIOZyDBm/3e/g1Go4XoIYs5nm86Ram+Oc/rGLRyLcaJXaXVc30NOtlZ33Z
         d2KzNnU1zL/skpMnvw428R4WN25d05BLujME52qAhjM/ygPbvo1d1DTX+Yp0tRkIJLtj
         LQU9G53eOHsBAftkwK2xHjNjLnK9Bounu1evjK+nkDPPGIOY5UQ4HSwGHeYBuKuaEgXS
         AeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq3JgMBXwrI/+1B0feChR7BINfBP3+5wSg7THbj/QGnsrbcQg2Ld9c4DnQbGlklC/uk5tz0Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnKP/hD6/f15Yzn+1VR9InTaA21J8FvBty5IQxq1dT/9l7yRP
	HDVvrw2DJ3IVI5aALR8bY5MzZ3h2C9eTB79f7UPlfkQhF8Jec2HDCrb83BTLowLhtqC1+Z5PLI/
	sngNebaW+aSA0ikHwWCxWwO50Ez4HaPiEG5wB2Iyq
X-Gm-Gg: ATEYQzytsMLu6pg17ih/kaf1gsvoyIQY2aqjK+78TOy1XuxQptCyiFpy6LG1Aq6xGN9
	bBRFnlS6lM0LqOtQWhybzEAMi4Am1jcBJpDXqTTvGowuH3ubFjf6wNgQH2WVhAEuDKj78am3nD9
	MyurkueZb7W9YNuVVEc6HBc71KcWn9iz/rCImTPfmR5RqhRXvtnKJc/3II/g/j9zIIv3icWyLgG
	lBCXYqclFaLTvDYfqYnCuLeDBcsjjGR2DdsN5wKcYDlRZ0sOWp4PguhUYj7lJmnuYJJgoJVJs+X
	Y3hzTlQ0
X-Received: by 2002:a05:622a:20a:b0:509:1ee2:69e4 with SMTP id
 d75a77b69052e-50939f83b2emr83671071cf.11.1773321448260; Thu, 12 Mar 2026
 06:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de> <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 14:17:16 +0100
X-Gm-Features: AaiRm50cn_rRH55eJvQqDxobMz7O5_lfuBZOF6UtHjJez3Nx18K8yQR7QqLR9ME
Message-ID: <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/4] ptr_ring: move free-space check into
 separate helper
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267060-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FDC127267B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 2:06=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This patch moves the check for available free space for a new entry into
> a separate function. As a result, __ptr_ring_produce() remains logically
> unchanged, while the new helper allows callers to determine in advance
> whether subsequent __ptr_ring_produce() calls will succeed. This
> information can, for example, be used to temporarily stop producing until
> __ptr_ring_peek() indicates that space is available again.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 534531807d95..a5a3fa4916d3 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r=
)
>         return ret;
>  }
>
> +static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
> +{
> +       if (unlikely(!r->size) || r->queue[r->producer])

I think this should be

       if (unlikely(!r->size) || READ_ONCE(r->queue[r->producer]))

And of course:

@@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring *r)
 static inline bool __ptr_ring_empty(struct ptr_ring *r)
 {
        if (likely(r->size))
-               return !r->queue[READ_ONCE(r->consumer_head)];
+               return !READ_ONCE(r->queue[READ_ONCE(r->consumer_head)]);
        return true;
 }

@@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct
ptr_ring *r, int consumer_head)
         * besides the first one until we write out all entries.
         */
        while (likely(head > r->consumer_tail))
-               r->queue[--head] =3D NULL;
+               WRITE_ONCE(r->queue[--head], NULL);

        r->consumer_tail =3D consumer_head;
 }


Presumably we should fix this in net tree first.

