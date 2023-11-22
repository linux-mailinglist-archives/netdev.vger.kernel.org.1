Return-Path: <netdev+bounces-50084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4652A7F48DE
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C3DB20FFB
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339834E1B0;
	Wed, 22 Nov 2023 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvZC/6wM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF29110
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 06:24:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so15796a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 06:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700663043; x=1701267843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZgPDvY+KeVw7fVACOjDQakBqp2WASIaXtZBe+tBzpc=;
        b=VvZC/6wMDEgT6+hlWZ1c5GDxzUqODqk64gkpmEltGFj4GTw27YT9vaXilzRy44vJr1
         Rpw9fKpcJM56tzCWHwFVhg83VvXT+5I7W29cLGMghVbXo0mT6JpmLIgdmXB49k0kIGrV
         2BUBWCoM8F3zurRnkNcsjiJ2Oq0IIU+kPd8X5RsfEOeby5yx/rbqEGmIzMpbSubcxcJo
         CUDuME4zyztutn+d9chFqDVicYzTnXiwLhcCwelLWRXSNhI9eWE4kNVfQeW+oEh6B3Fv
         /rjhvHp7QZJjkZP9JpqvqbfAUZsERIaap1e5P+ekJyhdW93JddP4QH4afdvqUqdCt0zm
         u0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700663043; x=1701267843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZgPDvY+KeVw7fVACOjDQakBqp2WASIaXtZBe+tBzpc=;
        b=Q76EUp+Utcdk7A00QZjer8in1pqD9/oUxROnBuXAkn6WkAUEgUzQU739G3Gsre1bOR
         UK88rNZltq0KHgtHfjyXoeJ8HlVDAi6Jygjkvjx9xGVFyCoDlw2ldKR00PtTs4m03SYV
         8YYVaAffj8tKl9RPkMrlI6CN00mGfhQjZpUcFu7AgQdbxfnMRx7JuiW+ku4zW1iPCIx8
         VLn2jI3n94+cpp5ye23fjBRHGurKnMcmhKxGv/ixfYRishOjylXJpQwX2yqCjh/SNvke
         uS6wjMpfZAy40Q/JKvMc4iu8ksw1pLMWWaI0/+bhJ8PUfySdCY1XG6XM0esvw1YWzpvA
         iT/Q==
X-Gm-Message-State: AOJu0YzDC4gecWLL9pCBHUH/FPz2z/Yu0j/JBN3Ox//+Xp7YAxA4Xk8N
	IGnvB/9v9/6NPuZASYPuq+RhjGAOKa/A3KoLxJQKow==
X-Google-Smtp-Source: AGHT+IH2nfCmJ2IkVovpjttw9mzVA1rawJFwJPFCAc6bnVjpVdK4tKSX7YKieFN/WmppUZFxJ1ZqC5CmOymKiFlvrA8=
X-Received: by 2002:a05:6402:540a:b0:545:279:d075 with SMTP id
 ev10-20020a056402540a00b005450279d075mr126373edb.1.1700663043310; Wed, 22 Nov
 2023 06:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121184245.69569-1-kuniyu@amazon.com> <20231121184245.69569-3-kuniyu@amazon.com>
In-Reply-To: <20231121184245.69569-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 15:23:51 +0100
Message-ID: <CANn89iLmpfo-ihMpZwgCqcvF+bKdJ6is9q3Bks-sckmDz+5YHw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 02/11] tcp: Cache sock_net(sk) in cookie_v[46]_check().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 7:44=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> sock_net(sk) is used repeatedly in cookie_v[46]_check().
> Let's cache it in a variable.
>

What about splitting this series in two ?

First one, doing refactoring/cleanups only could be sent without the
RFC tag right away for review.
( Directly sent to netdev$ and TCP maintainers, no BPF change yet)

Then the second one with functional changes would follow, sent to bpf
and TCP folks.

Thanks.

