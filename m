Return-Path: <netdev+bounces-63678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A7E82ECD3
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 11:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242EC1F23CCC
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1D11C81;
	Tue, 16 Jan 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJl8N1Ek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15F17563
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so20536a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 02:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705401540; x=1706006340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tITk/ZGjSBZGCJksKhiIln9Ix6Hhrz5/v8+QqVu3VE=;
        b=HJl8N1EkD5e6Nwd33PICR3I/hYvptLJ4yEifgQK7ZU5ERpiojBEqfW7FHWQiP4Ey6l
         CIrzZfpL44uM0R+Y6apAUcVnU3BPJJRf58frUFW/KKrA+KwqExXQkU+GLliKrZBxjNHy
         wmq5NL/QuhKqwTLsJPgztExjp8B34lO3xCjYEtP/p/WYhn/0FAKUeRq/I+1s0+NR2JkM
         Nd3oi2/HJQns8sboWOhMVG99NzTSX12hYYHax0uLqIQbekm4/m9y8M2jTv25Ju+Nu6ny
         gW7bqPBBatkPIZxIbJ6WBJZL/G5vUuWJ04yCWSUZ/JtJ5OvuBOUHa6GfRPMk0DRbjrCk
         hp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705401540; x=1706006340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tITk/ZGjSBZGCJksKhiIln9Ix6Hhrz5/v8+QqVu3VE=;
        b=RCTpfB8JOwNm1G5LJTjXs6KRSWsAU7cMKQLtydoM7pBBDkLSBCCnfKsdgwdQR0Huud
         EZRHPLA5RBt7x+DaHJ4OzXKs+d91Xx1qo5KVbWFWaELtr3MFEYGmSdHh5rdb/tqztu1R
         l15SAzE9JC1HNNnLZ4gmJrKimJEto6upm3ImyfbKLFN/S3tDrQrwIC+xesgSyqLRsw7v
         tAoJQg1akL/COnO+5Coj8Jl4wyf21T7DGfYXdyhQOOGE8nC+frKzq43nsPISaCcwoyrl
         lVqyWWemqVaOuQiOxZY3XxVWhgAlv3pRiQSS9kxbc6StecPeR02qpswLEw9WNQFwQYaF
         xx2Q==
X-Gm-Message-State: AOJu0YxChuN9iwYgGM8NBDIT7fR+TR8pOgCgfyclHQZI/1ecYk3Ufigp
	H+6K8jlmAOjDg/FpoKgR+VRkbLL8eOnTbt7nn+ZeLpqY4fDQ
X-Google-Smtp-Source: AGHT+IHxidEUFsGlChh4VpoIgY84Ts6G2DY/hfk/HOeW+b06AG94NJhhyi9ICh76bhdPJhntSt1E9UfKCjryBxO7H8U=
X-Received: by 2002:a50:ee17:0:b0:559:cd:9a with SMTP id g23-20020a50ee17000000b0055900cd009amr286896eds.6.1705401540351;
 Tue, 16 Jan 2024 02:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113030739.3446338-1-shaozhengchao@huawei.com>
In-Reply-To: <20240113030739.3446338-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jan 2024 11:38:47 +0100
Message-ID: <CANn89i+nmdm5aRNC0mvuVufyRq+fzvKMU9KtSdBMXjMBosgxTA@mail.gmail.com>
Subject: Re: [PATCH net,v2] tcp: make sure init the accept_queue's spinlocks once
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, hkchu@google.com, 
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 3:57=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawe=
i.com> wrote:
>
> When I run syz's reproduction C program locally, it causes the following
> issue:
> pvqspinlock: lock 0xffff9d181cd5c660 has corrupted value 0x0!
> WARNING: CPU: 19 PID: 21160 at __pv_queued_spin_unlock_slowpath (kernel/l=
ocking/qspinlock_paravirt.h:508)
> Ha


> When the socket receives the ACK packet during the three-way handshake,
> it will hold spinlock. And then the user actively shutdowns the socket
> and listens to the socket immediately, the spinlock will be initialized.
> When the socket is going to release the spinlock, a warning is generated.
> Also the same issue to fastopenq.lock.
>
> Add 'init_done' to make sure init the accept_queue's spinlocks once.
>
> Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_=
queue")
> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v2: Add 'init_done' to make sure init the accept_queue's spinlocks once.
> ---
>  include/net/request_sock.h | 1 +
>  net/core/request_sock.c    | 7 +++++--
>  net/ipv4/tcp.c             | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 144c39db9898..0054746fe92d 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -175,6 +175,7 @@ struct fastopen_queue {
>  struct request_sock_queue {
>         spinlock_t              rskq_lock;
>         u8                      rskq_defer_accept;
> +       bool                    init_done;
>

No, we should not add a new field for this.
The idea of having a conditional  spin_lock_init() is not very nice
for code readability.

Just always init request_sock_queue spinlocks for all inet sockets at
socket() and accept() time,
not at listen() time.

This structure is not dynamically allocated, and part of 'struct
inet_connection_sock'...

