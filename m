Return-Path: <netdev+bounces-57555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD08813610
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBB91C209EB
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C0A5F1ED;
	Thu, 14 Dec 2023 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nv/vsumd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4D910A
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:20:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso12126a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702570854; x=1703175654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9Tkbd+vgvPfQvmzFuw7EJp9AlY0xKXUe/iYI8xwtkc=;
        b=Nv/vsumdYBPzOmCTxniyEF/90Io4t7gYAP3d/4NoEm1xdnyIwvN5yb38J7YcFOQUtn
         M00la6P8kuQV9t9L/aUNWVCDGT5K+XX54o7NjnuCNLiWqoehZpHuSaA7sirz7R8o+344
         7N2AMW4sTE7Fq4mXdAwwwlmSTijUi+YjcWJM9wbMwFxb88KAz9RxIcYcffFOTR+2a1jA
         xCGnFEHWebdiJY27jioYQA8K32Q+NTywaFaPJXJW0eyKUplUkZeMoRUcdeqqHabfEeyE
         hIiUgCgoWRpODInveWdinYOmoOeJvAvgrzF2F9Murg6NWxobXun438+ViHbcfk/EWVCn
         ktVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570854; x=1703175654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9Tkbd+vgvPfQvmzFuw7EJp9AlY0xKXUe/iYI8xwtkc=;
        b=pMlGQOdDL3aY1oIdfA77CcmiVYbRqxlelvLBA01ArXW/Ntq0elQIA3SdZy74uvvT1f
         y7xP83NDMR7giqs71k1WJ/bqjZ1g9v7ywTmmjusyXl1jV+8UeTxY2L/geHvKhgUjQfmM
         6uYngPj6A7n12YpaF9GqQl0hBN3/wRVUINg+/jIzO7rcX2bmrgueDeQxiC3G3MScQXLv
         4WyBeePSsA5mUWnTkB6SopeWUIKXuezm+8oc7jZfJQRfFUPojg6ZuSOR54HI51q/gTEE
         Z58bGp5AX8Lcr45HDF5eB7Em0gFtOqGh3l0U2Or02xBv6AZ7I5pB0eUyRbzvLEJiuCs2
         CESQ==
X-Gm-Message-State: AOJu0YyhOSZ16LQvQMEuytte5ASBxLeNjV41lJ3WOgm0rPgjQfQmh3TX
	MovGwoen3gdHIV93LLTyoKPMDj9fRWjFUBTwR/zxiA==
X-Google-Smtp-Source: AGHT+IEccxJBJUVFiwQuPTLlWaecen1ncKNDDCSulEKeP/RqVKpMu+tXNpVr4FuJ6hf0D4Enp1tkHn7cV3bjYLMOsdY=
X-Received: by 2002:a50:bacf:0:b0:545:279:d075 with SMTP id
 x73-20020a50bacf000000b005450279d075mr648060ede.1.1702570854005; Thu, 14 Dec
 2023 08:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214155424.67136-1-kuniyu@amazon.com> <20231214155424.67136-3-kuniyu@amazon.com>
In-Reply-To: <20231214155424.67136-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 17:20:43 +0100
Message-ID: <CANn89iLo7xoB3NR-0goSH+buLZ2ekXPBUCGWLOSMWGLDfHL5ug@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/6] tcp: Move skb_steal_sock() to request_sock.h
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
> If BPF prog validates ACK and kfunc allocates a reqsk, it will
> be carried to TCP stack as skb->sk with req->syncookie 1.
>
> In skb_steal_sock(), we need to check inet_reqsk(sk)->syncookie
> to see if the reqsk is created by kfunc.  However, inet_reqsk()
> is not available in sock.h.
>
> Let's move skb_steal_sock() to request_sock.h.
>
> While at it, we refactor skb_steal_sock() so it returns early if
> skb->sk is NULL to minimise the following patch.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

