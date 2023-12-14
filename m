Return-Path: <netdev+bounces-57554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B3813607
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBFF1F21E07
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15945F1E7;
	Thu, 14 Dec 2023 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2zoVI0T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3322411A
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:17:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso12081a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702570641; x=1703175441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7+F/AIQ+R4dXwbyX988J6IJeOe2kasVZsJeJ+ksKts=;
        b=S2zoVI0TXAmPBhx1RaWDBpgfI670+0Alh+SgRn0H4bz8VZqVDBeptmv6V2MfahuFVD
         ytCKWz992WjsDaEuBgGEakRwmOjQIHhJVbWd8CVDxiD/Jhb7iJePFoW2jwYTd+wmX08U
         /6LjVXWA9E8C0/ucmDdnLJwUE0qbsER6UGssMuK7v6QZ3nN7lA9WXnsR4h3Nip7Q7tlF
         Z7c8ChhNuEntPcVHscUohdUR4qkhRFYnLyxGKgchsdW/k7djsLzwytQbjvZORJJZg1lT
         sEGhT5KFB+EivMZYfjP/NiGKW6Sopg3I/eI81hUGxHjKfx32RZyAzz7/RHU1KeKUMF7i
         9Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570641; x=1703175441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7+F/AIQ+R4dXwbyX988J6IJeOe2kasVZsJeJ+ksKts=;
        b=jY7nM1i2Qkbg6BBxAm9uB1ifDHGjZOzGfkqBLCLkP0ziuP++D5K/T0ixlMNRHzRK4A
         aLdJZ8Y+E/uojGgKzZshq/4AfB6BYjm+VzNV1vJaj/G3eTUPAuOdmAZqLlEvJc1nQc59
         2Zonv82tdYkqyVTZipuXx5777pQMildH9ELZP6x3mGFFqMEH7zFfmoEOXa+0uIOnUnsV
         Hsa3wyX+XKpZYvvOcJZlssArBqEYmknQdFbrg4LE9reWOxpiizlt89TIxtT01H6atRk8
         Fub5Um7bv3v9JYf25sMJWFsb2Hiw7C+RiV8TRsozRzGbkgI3GYWjnVmJW59dmJpcm3X7
         8lJA==
X-Gm-Message-State: AOJu0YzYS1ntd7D5mP3XSdLl6tKVLTTbph5g8V21C5tkvWu8/37L4O5/
	sL72hov1O62JUYLFO6rejianlbNi+il5x0KMhfwWsQ==
X-Google-Smtp-Source: AGHT+IEGnuwqOSea+Mf1eP3VPlAGE0YQ+aLikfhX/prmeqXDuUPdkQrWtfK2RMweuitBluRbnpgt3lmL8at/6n228CQ=
X-Received: by 2002:a50:c192:0:b0:54c:f4fd:3427 with SMTP id
 m18-20020a50c192000000b0054cf4fd3427mr663327edf.7.1702570641361; Thu, 14 Dec
 2023 08:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214155424.67136-1-kuniyu@amazon.com> <20231214155424.67136-2-kuniyu@amazon.com>
In-Reply-To: <20231214155424.67136-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 17:17:10 +0100
Message-ID: <CANn89iJS+rGAWaDCsOXmyrXF0d_xSXqrFXpknAnPMZAQ5mi43g@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/6] tcp: Move tcp_ns_to_ts() to tcp.h
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will support arbitrary SYN Cookie with BPF.
>
> When BPF prog validates ACK and kfunc allocates a reqsk, we need
> to call tcp_ns_to_ts() to calculate an offset of TSval for later
> use:
>
>   time
>   t0 : Send SYN+ACK
>        -> tsval =3D Initial TSval (Random Number)
>
>   t1 : Recv ACK of 3WHS
>        -> tsoff =3D TSecr - tcp_ns_to_ts(usec_ts_ok, tcp_clock_ns())
>                 =3D Initial TSval - t1
>
>   t2 : Send ACK
>        -> tsval =3D t2 + tsoff
>                 =3D Initial TSval + (t2 - t1)
>                 =3D Initial TSval + Time Delta (x)
>
>   (x) Note that the time delta does not include the initial RTT
>       from t0 to t1.
>
> Let's move tcp_ns_to_ts() to tcp.h.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

